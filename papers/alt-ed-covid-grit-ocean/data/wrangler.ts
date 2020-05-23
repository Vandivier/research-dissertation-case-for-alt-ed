import * as fs from "fs";
import { EOL } from "os";
import * as path from "path";
import * as util from "util";

import { columnDefinitions } from "./column-transforms";
import { CSVToArray, ColumnTransformer } from "./wrangle-lib";

const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

const wranglerPrefix = "wrangled-";

// TODO: script input arg regex to make this more flexible
function fGetInputFileLocations() {
  const sDataFolderPath = path.join(__dirname, ".");

  return fs
    .readdirSync(sDataFolderPath)
    .map((sFileName: string) => {
      const sFilePath = path.join(sDataFolderPath, sFileName);

      if (sFileName.includes(".csv")) {
        return sFilePath;
      }
    })
    .filter((s) => s && !s.includes(wranglerPrefix));
}

function fGetColumnTransformers(arrarrsCsvCells): ColumnTransformer[] {
  let iLargestColumnIndex = 0;
  const arrsFirstRow = arrarrsCsvCells[0];
  // currently arroTransformers is mutated byRef bc bMarkedForDeletion children can come before or after their parent
  const arroTransformers = JSON.parse(JSON.stringify(columnDefinitions));

  return arroTransformers
    .reduce((acc, columnDefinition) => {
      let iColumn = arrsFirstRow.findIndex((sColumnText) =>
        fiGetMatchingColumn(oTransformer, sColumnText)
      );
      const oTransformer: ColumnTransformer = { ...columnDefinition };

      if (iColumn !== -1) {
        oTransformer.iColumn = iColumn;
        iLargestColumnIndex = Math.max(iLargestColumnIndex, iColumn);
      }

      const bKeepColumn =
        (Number.isInteger(oTransformer.iColumn) && oTransformer.iColumn > -1) ||
        oTransformer.bGeneratedColumn;

      // if we don't keep a column, don't keep it's generated children either
      if (oTransformer.arrsGeneratedChildMatchers && !bKeepColumn) {
        oTransformer.arrsGeneratedChildMatchers.forEach((sMatcher) => {
          const oRelevantTransformer = arroTransformers.find(
            (oTransformer) => oTransformer.sOutputColumnName === sMatcher
          );
          oRelevantTransformer.bMarkedForDeletion = true;
        });
      }

      if (bKeepColumn && !oTransformer.bMarkedForDeletion) {
        acc.push(oTransformer);
      }

      return acc;
    }, [])
    .filter((o) => !o.bMarkedForDeletion)
    .map((oTransformer) => {
      if (oTransformer.bGeneratedColumn) {
        iLargestColumnIndex++;
        oTransformer.iColumn = iLargestColumnIndex;
      }

      return oTransformer;
    });
}

function fiGetMatchingColumn(oTransformer, sColumnText) {
  if (!sColumnText || oTransformer.bGeneratedColumn) return;

  if (oTransformer.bExactMatch) {
    return sColumnText === oTransformer.sMatcher;
  }

  return sColumnText
    .toLowerCase()
    .includes(oTransformer.sMatcher.toLowerCase());
}

const fpWrangleCsv = async (sLocation) => {
  const sOriginalFileContent = await fpReadFile(sLocation);
  const sOutputFileContent = fsTransformCsvContent(sOriginalFileContent);
  const arrsPath = sLocation.split(path.sep);
  const sOutputFileLocation = path.join(
    __dirname,
    wranglerPrefix + arrsPath[arrsPath.length - 1]
  );

  return fpWriteFile(sOutputFileLocation, sOutputFileContent, "utf8");
};

function fsObservationRowsContent(arrarrsCsvCells, arroTransformersWithIndex) {
  return arrarrsCsvCells
    .slice(2, arrarrsCsvCells.length)
    .map((arrsSurveyResponse) => {
      const arroTransformedCells = arroTransformersWithIndex.reduce(
        (arroAcc, oTransformer) => {
          let arroNewDataForThisCell = [];
          const sCellValue = arrsSurveyResponse[oTransformer.iColumn];

          if (oTransformer.farroTransformer) {
            arroNewDataForThisCell = oTransformer.farroTransformer(
              sCellValue,
              oTransformer,
              arroTransformersWithIndex,
              arrsSurveyResponse,
              arroAcc
            );
          } else if (!oTransformer.bGeneratedColumn) {
            arroNewDataForThisCell = [
              Object.assign({}, oTransformer, { value: sCellValue }),
            ];
          }

          return arroAcc.concat(...arroNewDataForThisCell);
        },
        []
      );

      const arrsTransformedCells = arroTransformedCells
        .sort((oa, ob) => (oa.iColumn > ob.iColumn ? 1 : -1))
        .map((oTransformer) => oTransformer.value);

      return arrsTransformedCells.join(",");
    })
    .join(EOL);
}

function fsTitleLineContent(arroTransformersWithIndex) {
  return arroTransformersWithIndex
    .sort((oa, ob) => (oa.iColumn > ob.iColumn ? 1 : -1))
    .filter((oTransformer) => !oTransformer.bTransientColumn)
    .map(
      (oTransformer) => oTransformer.sOutputColumnName || oTransformer.sMatcher
    );
}

function fsTransformCsvContent(sOriginalFileContent) {
  const arrarrsCsvCells = CSVToArray(sOriginalFileContent);
  const csvWithUpdatedTitleRow = handleBlankTitleCells(arrarrsCsvCells);
  const arroTransformersWithIndex = fGetColumnTransformers(
    csvWithUpdatedTitleRow
  );
  const sNewFileContent =
    fsTitleLineContent(arroTransformersWithIndex) +
    EOL +
    fsObservationRowsContent(arrarrsCsvCells, arroTransformersWithIndex);

  return sNewFileContent;
}

function handleBlankTitleCells(csv: string[][]) {
  const initialLastFilledCellIndex = 2;
  let lastValidColumnText = "";
  let lastFilledCellIndex = initialLastFilledCellIndex;

  const updatedTitleRow = csv[0].reduce((acc, sCellValue) => {
    if (sCellValue) {
      acc.push(sCellValue);
      lastValidColumnText = sCellValue;
      lastFilledCellIndex = initialLastFilledCellIndex;
    } else {
      if (!lastValidColumnText) {
        throw new Error(
          "it appears the first column of your spreadsheet has not title. This is not chill."
        );
      }

      acc.push(`${lastValidColumnText}-${lastFilledCellIndex}`);
      lastFilledCellIndex++;
    }

    return acc;
  }, []);

  return [updatedTitleRow].concat(csv.slice(1, csv.length));
}

async function main() {
  const arrpFileOperations = fGetInputFileLocations().map(fpWrangleCsv);
  await Promise.all(arrpFileOperations);
}

main();
