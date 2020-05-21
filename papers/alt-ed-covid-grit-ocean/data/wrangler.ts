import * as fs from "fs";
import { EOL } from "os";
import * as path from "path";
import * as util from "util";

import { arroColumnTransforms } from "./column-transforms";
import { CSVToArray } from "./wrangle-lib";

const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

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
    .filter((s) => s);
}

function fGetTransformersWithIndex(arrarrsCsvCells) {
  let iLargestColumnIndex = 0;
  const arrsFirstRow = arrarrsCsvCells[0];
  const arrsSecondRow = arrarrsCsvCells[1]; // survey monkey does this thing where the second row is also basically a title row
  const arroColumnTransformsClone = JSON.parse(
    JSON.stringify(arroColumnTransforms)
  ); // clone it so column numbers and other info for one spreadsheet don't propagate across sheets.

  return arroColumnTransformsClone
    .filter((oTransformer, iTransformerIndex) => {
      let iColumn = arrsFirstRow.findIndex((sColumnText) =>
        fiGetMatchingColumn(oTransformer, sColumnText)
      );
      if (iColumn === -1)
        iColumn = arrsSecondRow.findIndex((sColumnText) =>
          fiGetMatchingColumn(oTransformer, sColumnText)
        );
      if (iColumn !== -1) {
        oTransformer.iColumn = iColumn;
        iLargestColumnIndex = Math.max(iLargestColumnIndex, iColumn);
      }

      // reference the transformer function if it exists
      // this is lost during clone step
      if (arroColumnTransforms[iTransformerIndex].farroTransformer) {
        oTransformer.farroTransformer =
          arroColumnTransforms[iTransformerIndex].farroTransformer;
      }

      const bKeepColumn =
        (Number.isInteger(oTransformer.iColumn) && oTransformer.iColumn > -1) ||
        oTransformer.bGeneratedColumn;

      // if we don't keep a column, don't keep it's generated children either
      if (oTransformer.arrsGeneratedChildMatchers && !bKeepColumn) {
        oTransformer.arrsGeneratedChildMatchers.forEach((sMatcher) => {
          const oRelevantTransformer = arroColumnTransformsClone.find(
            (oTransformer) => oTransformer.sOutputColumnName === sMatcher
          );
          oRelevantTransformer.bMarkedForDeletion = true;
        });
      }

      return bKeepColumn;
    })
    .filter((oTransformer) => !oTransformer.bMarkedForDeletion)
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

const fpWrangleSurveyMonkeyFile = async (sLocation) => {
  const sOriginalFileContent = await fpReadFile(sLocation);
  const sOutputFileContent = fsTransformSurveyMonkeyCsvContent(
    sOriginalFileContent
  );
  const arrsPath = sLocation.split(path.sep);
  const sOutputFileLocation = path.join(
    __dirname,
    "wrangled-" + arrsPath[arrsPath.length - 1]
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

function fsTransformSurveyMonkeyCsvContent(sOriginalFileContent) {
  const arrarrsCsvCells = CSVToArray(sOriginalFileContent);
  const arroTransformersWithIndex = fGetTransformersWithIndex(arrarrsCsvCells);
  const sNewFileContent =
    fsTitleLineContent(arroTransformersWithIndex) +
    EOL +
    fsObservationRowsContent(arrarrsCsvCells, arroTransformersWithIndex);

  return sNewFileContent;
}

async function main() {
  const arrpFileOperations = fGetInputFileLocations().map(
    fpWrangleSurveyMonkeyFile
  );
  await Promise.all(arrpFileOperations);
}

main();
