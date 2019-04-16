const EOL = require('os').EOL;
const fs = require('fs');
const path = require('path');
const util = require('util');

const arroColumnTransforms = require('./column-transforms');
const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

const arrsSurveyMonkeyCsvConventionalLocation = ['CSV', 'Survey on Alternative Credentials.csv'];

// ref: https://stackoverflow.com/a/35759360/3931488
const farrsGetSubfolderPathsByFolderPath = sPath =>
  fs
    .readdirSync(sPath)
    .map(sFileName => {
      const sFilePath = path.join(sPath, sFileName);

      if (fs.statSync(sFilePath).isDirectory()) {
        return sFilePath;
      }
    })
    .filter(s => s);

function fGetInputFileLocations() {
  const sDataFolderPath = path.join(__dirname, '..');
  return farrsGetSubfolderPathsByFolderPath(sDataFolderPath)
    .filter(sPath => sPath !== __dirname)
    .map(sSubfolder => path.join(sSubfolder, ...arrsSurveyMonkeyCsvConventionalLocation));
}

function fGetTransformersWithIndex(arrarrsCsvCells) {
  let iLargestColumnIndex = 0;
  const arrsFirstRow = arrarrsCsvCells[0];
  const arrsSecondRow = arrarrsCsvCells[1]; // survey monkey does this thing where the second row is also basically a title row
  const arroColumnTransformsClone = JSON.parse(JSON.stringify(arroColumnTransforms)); // clone it so column numbers and other info for one spreadsheet don't propagate across sheets.

  return arroColumnTransformsClone
    .filter((oTransformer, iTransformerIndex) => {
      let iColumn = arrsFirstRow.findIndex(sColumnText => fiGetMatchingColumn(oTransformer, sColumnText));
      if (iColumn === -1) iColumn = arrsSecondRow.findIndex(sColumnText => fiGetMatchingColumn(oTransformer, sColumnText));
      if (iColumn !== -1) {
        oTransformer.iColumn = iColumn;
        iLargestColumnIndex = Math.max(iLargestColumnIndex, iColumn);
      }

      // reference the transformer function if it exists
      // this is lost during clone step
      if (arroColumnTransforms[iTransformerIndex].farroTransformer) {
        oTransformer.farroTransformer = arroColumnTransforms[iTransformerIndex].farroTransformer
      }

      return Number.isInteger(oTransformer.iColumn) && oTransformer.iColumn > -1 || oTransformer.bGeneratedColumn;
    })
    .map(oTransformer => {
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

  return sColumnText.toLowerCase().includes(oTransformer.sMatcher.toLowerCase());
}

const fpWrangleSurveyMonkeyFile = async sLocation => {
  const sNewFileName = fsGetNewSurveyMonkeyFileName(sLocation);
  const sOriginalFileContent = await fpReadFile(sLocation);
  const sOutputFileContent = fsTransformSurveyMonkeyCsvContent(sOriginalFileContent);
  const sOutputFileLocation = path.join(__dirname, sNewFileName);

  return fpWriteFile(sOutputFileLocation, sOutputFileContent, 'utf8');
};

const fsGetNewSurveyMonkeyFileName = sLocation => {
  const arrsPath = sLocation.split(path.sep);
  const sDataFolderName = arrsPath[arrsPath.length - 3];

  return (sDataFolderName + ' ' + path.basename(sLocation)).toLowerCase().replace(/[^\w.]/g, '-');
};

function fsObservationRowsContent(arrarrsCsvCells, arroTransformersWithIndex) {
  return arrarrsCsvCells
    .slice(2, arrarrsCsvCells.length)
    .map(arrsSurveyResponse => {
      const arroTransformedCells = arroTransformersWithIndex.reduce((arroAcc, oTransformer) => {
        let arroDataForThisCell = [];
        const sCellValue = arrsSurveyResponse[oTransformer.iColumn];

        if (oTransformer.farroTransformer) {
          arroDataForThisCell = oTransformer.farroTransformer(sCellValue, oTransformer, arroTransformersWithIndex);
        } else if (!oTransformer.bGeneratedColumn) {
          arroDataForThisCell = [Object.assign({}, oTransformer, { value: sCellValue })];
        }

        return arroAcc.concat(...arroDataForThisCell);
      }, []);

      const arrsTransformedCells = arroTransformedCells
        .sort((oa, ob) => (oa.iColumn > ob.iColumn ? 1 : -1))
        .map(oTransformer => oTransformer.value);

      return arrsTransformedCells.join(',');
    })
    .join(EOL);
}

function fsTitleLineContent(arroTransformersWithIndex) {
  return arroTransformersWithIndex
    .filter(oTransformer => !oTransformer.bTransientColumn)
    .map(oTransformer => oTransformer.sOutputColumnName || oTransformer.sMatcher);
}

function fsTransformSurveyMonkeyCsvContent(sOriginalFileContent) {
  const arrarrsCsvCells = CSVToArray(sOriginalFileContent);
  const arroTransformersWithIndex = fGetTransformersWithIndex(arrarrsCsvCells);
  const sNewFileContent =
    fsTitleLineContent(arroTransformersWithIndex) + EOL + fsObservationRowsContent(arrarrsCsvCells, arroTransformersWithIndex);

  return sNewFileContent;
}

async function main() {
  const arrsInputFileLocations = fGetInputFileLocations();
  const arrpFileOperations = arrsInputFileLocations.map(fpWrangleSurveyMonkeyFile);
  await Promise.all(arrpFileOperations);
}

// TODO: duplicate of unwrite-csv.js
// ref: https://stackoverflow.com/questions/1293147/javascript-code-to-parse-csv-data
function CSVToArray(strData, strDelimiter) {
  // Check to see if the delimiter is defined. If not,
  // then default to comma.
  strDelimiter = strDelimiter || ',';

  // Create a regular expression to parse the CSV values.
  var objPattern = new RegExp(
    // Delimiters.
    '(\\' +
      strDelimiter +
      '|\\r?\\n|\\r|^)' +
      // Quoted fields.
      '(?:"([^"]*(?:""[^"]*)*)"|' +
      // Standard fields.
      '([^"\\' +
      strDelimiter +
      '\\r\\n]*))',
    'gi'
  );

  // Create an array to hold our data. Give the array
  // a default empty first row.
  var arrData = [[]];

  // Create an array to hold our individual pattern
  // matching groups.
  var arrMatches = null;

  // Keep looping over the regular expression matches
  // until we can no longer find a match.
  while ((arrMatches = objPattern.exec(strData))) {
    // Get the delimiter that was found.
    var strMatchedDelimiter = arrMatches[1];

    // Check to see if the given delimiter has a length
    // (is not the start of string) and if it matches
    // field delimiter. If id does not, then we know
    // that this delimiter is a row delimiter.
    if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
      // Since we have reached a new row of data,
      // add an empty row to our data array.
      arrData.push([]);
    }

    var strMatchedValue;

    // Now that we have our delimiter out of the way,
    // let's check to see which kind of value we
    // captured (quoted or unquoted).
    if (arrMatches[2]) {
      // We found a quoted value. When we capture
      // this value, unescape any double quotes.
      strMatchedValue = arrMatches[2].replace(new RegExp('""', 'g'), '"');
    } else {
      // We found a non-quoted value.
      strMatchedValue = arrMatches[3];
    }

    // Now that we have our value string, let's add
    // it to the data array.
    arrData[arrData.length - 1].push(strMatchedValue);
  }

  // Return the parsed data.
  return arrData;
}

main();
