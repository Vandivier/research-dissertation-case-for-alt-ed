const EOL = require('os').EOL;
const fs = require('fs');
const util = require('util');
const utils = require('ella-utils');

const arrsOutputCsvs = [];
let arroCaches = [];

const fpAppendFile = util.promisify(fs.appendFile);
const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

const oOptions = {
  mergeFiles: false,
  mergeDuplicates: false,
  uniquifyDuplicates: false,
  sUniqueKey: '',
};

async function main() {
  fParseOptions();

  try {
    const arrpReadFiles = arrsOutputCsvs.map(async sFile => {
      const sCacheFile = await fpReadFile(sFile + '.json', 'utf8');
      return JSON.parse(sCacheFile);
    });

    arroCaches = await Promise.all(arrpReadFiles);
  } catch (e) {
    console.error('Error reading one of the files you specified. Are you sure you ran that command correctly?', e);
    process.exit();
  }

  if (oOptions.mergeFiles) fMergeCaches();

  // write caches to csvs
  // TODO: regex to skip some records
  const arrp = arroCaches.map(async (oCache, i) => {
    const oRepresentative = fGetRepresentativeRecord(oCache);
    const sOutputFileName = arroCaches.length > 1 ? arrsOutputCsvs[i] + '.csv' : 'output.csv';
    const arrTableColumnKeys = Object.keys(oRepresentative);
    const oTitleLine = oCache[oOptions.sUniqueKey] || foGetImpliedTitleRecord(oRepresentative);
    const arroSortedRecords = Object.values(oCache)
      .filter(o => fUseRecord(o))
      .sort((oA, oB) => (oA[oOptions.sUniqueKey] > oB[oOptions.sUniqueKey] ? 1 : -1));

    // wipe output file
    await fpWriteFile(sOutputFileName, '', 'utf8');

    // write title line first
    return [oTitleLine].concat(arroSortedRecords).map(async (oRecord, i) => {
      // only write title line as first line (don't write twice)
      if (oRecord[oOptions.sUniqueKey] === oTitleLine[oOptions.sUniqueKey] && i) return Promise.resolve();

      try {
        const sCsvRecord = utils.fsRecordToCsvLine(oRecord, arrTableColumnKeys);
        const oWriteResult = await fpAppendFile(sOutputFileName, sCsvRecord + EOL, 'utf8');
        return Promise.resolve(oWriteResult);
      } catch (error) {
        console.log('error writing record: ', error);
      }
    });
  });

  await Promise.all(arrp);
}

// yargs === overengineering
function fParseOptions() {
  function _fCleanValue(s) {
    return s && s.trim().replace(/[^\w ]/g, '');
  }

  process.argv.slice(2).forEach(s => {
    if (s.toLowerCase().includes('uniquekey')) {
      oOptions.sUniqueKey = _fCleanValue(s.split('=')[1]);
    } else if (s.includes('--')) {
      oOptions[_fCleanValue(s)] = true;
    } else {
      arrsOutputCsvs.push(s);
    }
  });

  if (Object.entries(oOptions).find((sKey, sVal) => sVal)) {
    // if any merge option exists, set merge to true as a safety measure
    oOptions.mergeFiles = true;
  }

  if (oOptions.mergeFiles && !oOptions.sUniqueKey) {
    console.error(
      'cache merge option(s) observed, but no unique key to merge on the basis of was provided. Pass --UniqueKey=MyUniqueKeyName.'
    );
    process.exit();
  }

  if (!arrsOutputCsvs.length) arrsOutputCsvs.push('cache');
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

main();
