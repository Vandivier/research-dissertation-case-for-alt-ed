// TODO: publish this package & maybe denofy

export let arroCaches = [];

// ref: https://stackoverflow.com/questions/1293147/javascript-code-to-parse-csv-data
export function CSVToArray(strData: string, strDelimiter?: string) {
  strDelimiter = strDelimiter || ",";

  var objPattern = new RegExp(
    // Delimiters.
    "(\\" +
      strDelimiter +
      "|\\r?\\n|\\r|^)" +
      // Quoted fields.
      '(?:"([^"]*(?:""[^"]*)*)"|' +
      // Standard fields.
      '([^"\\' +
      strDelimiter +
      "\\r\\n]*))",
    "gi"
  );

  var arrData = [[]];
  var arrMatches = null;

  while ((arrMatches = objPattern.exec(strData))) {
    var strMatchedValue;
    var strMatchedDelimiter = arrMatches[1];

    if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
      arrData.push([]);
    }

    if (arrMatches[2]) {
      strMatchedValue = arrMatches[2].replace(new RegExp('""', "g"), '"');
    } else {
      strMatchedValue = arrMatches[3];
    }

    arrData[arrData.length - 1].push(strMatchedValue);
  }

  return arrData;
}

// by default, turns hungarian or title cased into Title Spaced Case
// with --keys-camel, turns camel case into Title Spaced Case
export function fNormalizeVariableName(sOldName: string, oOptions?: any) {
  const sCleanedName = sOldName.replace(/ /g, "");
  const arriCapitals = getAllIndexes(sCleanedName.split(""), (sLetter) =>
    /[A-Z]/.test(sLetter)
  );
  let iPrevious = oOptions.keyscamel ? 0 : null;

  arriCapitals.push(sCleanedName.length);

  return arriCapitals
    .reduce((arrsAcc, i) => {
      const bAdjacentCapitals = /[A-Z]/.test(sCleanedName[iPrevious + 1]);

      if (Number.isInteger(iPrevious)) {
        arrsAcc.push(sCleanedName.slice(iPrevious, Math.max(iPrevious + 1, i))); // at least increment one letter

        if (
          !bAdjacentCapitals &&
          !oOptions.bToVariable &&
          oOptions.bSpaceTitles
        ) {
          arrsAcc.push(" ");
        }
      }

      iPrevious = i;

      return arrsAcc;
    }, [])
    .join("");
}

export function fMergeCaches() {
  let oColumns = {};

  const oMergedCache = arroCaches.reduce(
    (oMergedCacheAcc, oCurrentCache, i) => {
      return Object.keys(oCurrentCache).reduce(
        (oCurrentCacheAcc, sOriginalRecordKey, ii) => {
          const oCurrentRecord = oCurrentCache[sOriginalRecordKey];
          const sNewRecordKey = oOptions.uniquifyDuplicates
            ? sOriginalRecordKey + "-" + i + "-" + ii
            : sOriginalRecordKey;
          const oExistingRecord = oCurrentCacheAcc[sNewRecordKey];

          if (oExistingRecord) {
            if (oOptions.mergeDuplicates) {
              // existing column values survive; only overwrite unpopulated columns
              oCurrentCacheAcc[sNewRecordKey] = Object.assign(
                {},
                oCurrentRecord,
                oExistingRecord
              );
            }
            // else do nothing; the existing record survives and current record is dropped
          } else {
            oCurrentCacheAcc[sNewRecordKey] = Object.assign({}, oCurrentRecord);
          }

          oColumns = Object.assign({}, oColumns, oCurrentRecord);

          return oCurrentCacheAcc;
        },
        oMergedCacheAcc
      );
    },
    {}
  );

  // normalize columns
  // make sure every record has every column referenced, even if the value is empty
  Object.entries(oMergedCache).forEach(([sUniqueRecordKey, oRecord]) => {
    Object.keys(oColumns).forEach((sColumnKey) => {
      oRecord[sColumnKey] = oRecord[sColumnKey] || "";
    });
  });

  arroCaches = [oMergedCache];
}

export function getCaches() {
  return arroCaches;
}

export function setCaches(arr) {
  arroCaches = arr;
  return arroCaches;
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
