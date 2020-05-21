import * as fs from "fs";
import js_beautify from "js-beautify";
import * as util from "util";

import {
  CSVToArray,
  fMergeCaches,
  fNormalizeVariableName,
  getCaches,
  setCaches,
} from "./wrangle-lib";

const arrsOutputFiles = []; // TODO: move to wrangle-lib...currently only 1 at a time is supported
const beautify = js_beautify.beautify; // TODO: should beautify be included in wrangle lib?

const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

// TODO: prob don't need all of these options
const oOptions = {
  bSpaceTitles: false,
  keyscamel: false,
  mergeFiles: false,
  mergeDuplicates: false,
  uniquifyDuplicates: false,
  sUniqueKey: "",
};

async function main() {
  fParseOptions();

  try {
    // TODO: fix below
    const arrpReadFiles = arrsOutputFiles
      .map(async (sFile) => {
        if (sFile.includes(".csv")) {
          const sCacheFile = await fpReadFile(sFile, "utf8");
          return foParseCsvToJson(sCacheFile);
        }
      })
      .filter((o) => o);

    setCaches(await Promise.all(arrpReadFiles));
  } catch (e) {
    console.error(
      "Error reading one of the files you specified. Are you sure you ran that command correctly?",
      e
    );
    process.exit();
  }

  if (oOptions.mergeFiles) fMergeCaches(oOptions);

  // write json file outputs
  const arrp = getCaches().map(async (oCache, i) => {
    const sOutputFileName = arrsOutputFiles[i] + ".json";
    return fpWriteCache(sOutputFileName, oCache);
  });

  await Promise.all(arrp);
}

// TODO: duplicate block in /github-email-scraper-node/index.js
function fpWriteCache(sOutputFileName, oCache) {
  let sBeautifiedData = JSON.stringify(oCache);
  sBeautifiedData = beautify(sBeautifiedData, { indent_size: 4 });

  try {
    return fpWriteFile(sOutputFileName, sBeautifiedData, "utf8");
  } catch (e) {
    // TODO: maybe not needed. just here to silence errors...honestly idk why those happen and output is fine so...
    return Promise.resolve();
  }
}

function foParseCsvToJson(sUnparsedCsvFile) {
  const arrarrsParsed = CSVToArray(sUnparsedCsvFile);
  const arrsTitleLine = arrarrsParsed[0];
  const arrsHungarianizedTitleLine = arrsTitleLine.map(
    fsCreateHungarianNameFromColumnTitleString
  );
  const arrarrsParsedWithoutTitleLine = arrarrsParsed.slice(1);
  const iUniqueKeyIndex = arrsHungarianizedTitleLine.findIndex(
    (s) => s === oOptions.sUniqueKey
  );
  const oParsedFile = {};

  if (iUniqueKeyIndex === -1) {
    console.log(
      "spreadsheet unexpectedly did not have unique key / column. exiting."
    );
    process.exit();
  }

  arrarrsParsedWithoutTitleLine.forEach((arrsRow) => {
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
      console.log("duplicate record found. skipping: ", arrsRow);
    } else {
      oParsedFile[sRecordKey] = Object.assign({}, oRecord);
    }
  });

  return oParsedFile;
}

// yargs === overengineering
function fParseOptions() {
  function _fCleanValue(s) {
    return s && s.trim().replace(/[^\w ]/g, "");
  }

  process.argv.slice(2).forEach((s) => {
    const sLowered = s.toLowerCase();
    const sCleanedValue = _fCleanValue(s.split("=")[1]);

    if (sLowered.includes("uniquekey")) {
      oOptions.sUniqueKey = sCleanedValue;
    } else if (sLowered.includes("uniquecolumn")) {
      oOptions.sUniqueKey = fsCreateHungarianNameFromColumnTitleString(
        sCleanedValue
      );
    } else if (s.slice(0, 2) === "--") {
      oOptions[_fCleanValue(s)] = true;
    } else {
      arrsOutputFiles.push(s);
    }
  });

  if (oOptions.mergeFiles && !oOptions.sUniqueKey) {
    console.error(
      "cache merge option(s) observed, but no unique key to merge on the basis of was provided. Pass --UniqueKey=MyUniqueKeyName."
    );
    process.exit();
  }

  if (!arrsOutputFiles.length) arrsOutputFiles.push("cache");
}

function fsCreateHungarianNameFromColumnTitleString(sCleanedColumn) {
  return "s" + fNormalizeVariableName(sCleanedColumn, true);
}

main();
