const beautify = require('js-beautify').js_beautify;
const EOL = require('os').EOL;
const fs = require('fs');
const util = require('util');

const arrsOutputFiles = []; // currently only 1 at a time is supported

const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

// TODO: prob don't need all of these options
const oOptions = {
  mergeFiles: false,
  mergeDuplicates: false,
  uniquifyDuplicates: false,
  sUniqueKey: '',
};

async function main() {
  fParseOptions();

  try {
    // TODO: fix below
    const arrpReadFiles = arrsOutputFiles.map(async sFile => {
      const sCacheFile = await fpReadFile(sFile + '.csv', 'utf8');
      return foParseCsvToJson(sCacheFile);
    });

    arroCaches = await Promise.all(arrpReadFiles);
  } catch (e) {
    console.error('Error reading one of the files you specified. Are you sure you ran that command correctly?', e);
    process.exit();
  }

  if (oOptions.mergeFiles) fMergeCaches();

  // write json file outputs
  const arrp = arroCaches.map(async (oCache, i) => {
    const sOutputFileName = arrsOutputFiles[i] + '.json';
    return fpWriteCache(sOutputFileName, oCache);
  });

  await Promise.all(arrp);
}

// TODO: duplicate block in /github-email-scraper-node/index.js
function fpWriteCache(sOutputFileName, oCache) {
  let sBeautifiedData = JSON.stringify(oCache);
  sBeautifiedData = beautify(sBeautifiedData, { indent_size: 4 });
  return fpWriteFile(sOutputFileName, sBeautifiedData, 'utf8', err => {}); // silence errors...honestly idk why those happen and output is fine so...
}

function foParseCsvToJson(sUnparsedCsvFile) {
  const arrarrsParsed = CSVToArray(sUnparsedCsvFile);
  const arrsTitleLine = arrarrsParsed[0];
  const arrsHungarianizedTitleLine = arrsTitleLine.map(fsCreateHungarianNameFromColumnTitleString);
  const arrarrsParsedWithoutTitleLine = arrarrsParsed.slice(1);
  const iUniqueKeyIndex = arrsHungarianizedTitleLine.findIndex(s => s === oOptions.sUniqueKey);
  const oParsedFile = {};

  if (iUniqueKeyIndex === -1) {
    console.log('spreadsheet unexpectedly did not have unique key / column. exiting.');
    process.exit();
  }

  arrarrsParsedWithoutTitleLine.forEach(arrsRow => {
    const sRecordKey = arrsRow[iUniqueKeyIndex];
    const oRecord = arrsRow.reduce((oAcc, sCellValue, iColumnIndex) => {
      const sHungarianColumnName = arrsHungarianizedTitleLine[iColumnIndex];
      oAcc[sHungarianColumnName] = sCellValue;
      return oAcc;
    }, {});

    if (!sRecordKey) {
      // do nothing
    } else if (oParsedFile[sRecordKey]) {
      // TODO: explore other reconciliation strategies besides just skipping.
      console.log('duplicate record found. skipping: ', arrsRow);
    } else {
      oParsedFile[sRecordKey] = Object.assign({}, oRecord);
    }
  });

  return oParsedFile;
}

// yargs === overengineering
function fParseOptions() {
  function _fCleanValue(s) {
    return s && s.trim().replace(/[^\w ]/g, '');
  }

  process.argv.slice(2).forEach(s => {
    const sLowered = s.toLowerCase();
    const sCleanedValue = _fCleanValue(s.split('=')[1]);

    if (sLowered.includes('uniquekey')) {
      oOptions.sUniqueKey = sCleanedValue;
    } else if (sLowered.includes('uniquecolumn')) {
      oOptions.sUniqueKey = fsCreateHungarianNameFromColumnTitleString(sCleanedValue);
    } else if (s.slice(0, 2) === '--') {
      oOptions[_fCleanValue(s)] = true;
    } else {
      arrsOutputFiles.push(s);
    }
  });

  if (oOptions.mergeFiles && !oOptions.sUniqueKey) {
    console.error(
      'cache merge option(s) observed, but no unique key to merge on the basis of was provided. Pass --UniqueKey=MyUniqueKeyName.'
    );
    process.exit();
  }

  if (!arrsOutputFiles.length) arrsOutputFiles.push('cache');
}

function fMergeCaches() {
  const oMergedCache = arroCaches.reduce((oMergedCacheAcc, oCurrentCache, i) => {
    return Object.keys(oCurrentCache).reduce((oCurrentCacheAcc, sOriginalRecordKey, ii) => {
      const oCurrentRecord = oCurrentCache[sOriginalRecordKey];
      const sNewRecordKey = oOptions.uniquifyDuplicates ? sOriginalRecordKey + '-' + i + '-' + ii : sOriginalRecordKey;
      const oExistingRecord = oCurrentCacheAcc[sNewRecordKey];

      if (oExistingRecord) {
        if (oOptions.mergeDuplicates) {
          // existing column values survive; only overwrite unpopulated columns
          oCurrentCacheAcc[sNewRecordKey] = Object.assign({}, oNew, oExisting);
        }
        // else do nothing; the existing record survives and current record is dropped
      } else {
        oCurrentCacheAcc[sNewRecordKey] = Object.assign({}, oCurrentRecord);
      }

      return oCurrentCacheAcc;
    }, oMergedCacheAcc);
  }, {});

  arroCaches = [oMergedCache];
}

// TODO: duplicate block with write-csv.js
// by default, turns hungarian or title cased into Title Spaced Case
// with --keys-camel, turns camel case into Title Spaced Case
function fNormalizeVariableName(sOldName, bToVariable) {
  const sCleanedName = sOldName.replace(/ /g, '');
  const arriCapitals = getAllIndexes([...sCleanedName], sLetter => /[A-Z]/.test(sLetter));
  let iPrevious = oOptions.keyscamel ? 0 : null;

  arriCapitals.push(sCleanedName.length);

  return arriCapitals
    .reduce((arrsAcc, i) => {
      const bAdjacentCapitals = /[A-Z]/.test(sCleanedName[iPrevious + 1]);

      if (Number.isInteger(iPrevious)) {
        arrsAcc.push(sCleanedName.slice(iPrevious, Math.max(iPrevious + 1, i))); // at least increment one letter

        if (!bAdjacentCapitals && !bToVariable && oOptions.bSpaceTitles) {
          arrsAcc.push(' ');
        }
      }

      iPrevious = i;

      return arrsAcc;
    }, [])
    .join('');
}

function fsCreateHungarianNameFromColumnTitleString(sCleanedColumn) {
  return 's' + fNormalizeVariableName(sCleanedColumn, true);
}

function fsTitleCase(sWord) {
  const sLowerCasedWord = sWord && sWord.toLowerCase();
  const sResult = sLowerCasedWord[0] ? sLowerCasedWord[0].toUpperCase() + sLowerCasedWord.slice(1) : '';
  if (!sResult) console.log('unexpected empty result in fsTitleCase for word: ', sWord);
  return sResult;
}

// ref: https://stackoverflow.com/questions/20798477/how-to-find-index-of-all-occurrences-of-element-in-array
function getAllIndexes(arr, f) {
  const indexes = [];

  for (let i = 0; i < arr.length; i++) {
    if (f(arr[i])) {
      indexes.push(i);
    }
  }

  return indexes;
}

function fGetRepresentativeRecord(oCache) {
  try {
    return Object.values(oCache).find(fUseRecord);
  } catch (error) {
    console.log('error trying to obtain representative record:', error);
    return {};
  }
}

function foGetImpliedTitleRecord(oRepresentative) {
  try {
    return Object.keys(oRepresentative).reduce((oAcc, sKey) => Object.assign(oAcc, { [sKey]: fNormalizeVariableName(sKey) }), {});
  } catch (error) {
    console.log('error trying to obtain implied title record:', error);
    return {};
  }
}

// ref: TODO 4.3.4, `drop-key` implementation
// for now we just ensure written records include unique key
function fUseRecord(o) {
  return o[oOptions.sUniqueKey];
}

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
