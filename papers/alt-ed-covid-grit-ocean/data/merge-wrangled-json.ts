// TODO: output.csv is broken during `npm run build` today
// TODO: make ordered-output.csv to reduce git noise and gitignore the unordered version.

import utils from "ella-utils";
import fs from "fs";
import { EOL } from "os";
import util from "util";

import {
  fGetInputFileLocations,
  fMergeCaches,
  fNormalizeVariableName,
  setCaches,
} from "./wrangle-lib";

// TODO: move to wrangle-lib
// TODO: if we want to support csv-to-csv merging and stuff, scope that in another script...this will assume json to csv only
// TODO: seperate concerns between arrsOutputCsvs and arrsInputCsvs
const arrsOutputCsvs = [];
const DEFAULT_OUTPUT_FILE_NAME = "output.csv";

const fpAppendFile = util.promisify(fs.appendFile);
const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

const oOptions = {
  assumeFileNames: false,
  mergeFiles: false,
  mergeDuplicates: false,
  uniquifyDuplicates: false,
  sUniqueKey: "",
};

async function main() {
  let caches: any[]; // TODO cache type
  fParseOptions();

  try {
    let arrpReadFiles = [];

    if (oOptions.assumeFileNames) {
      arrpReadFiles = fGetInputFileLocations(".json").map(async (sFile) => {
        const sCacheFile = await fpReadFile(sFile, "utf8");
        return JSON.parse(sCacheFile);
      });
    } else {
      // TODO: ensure one or more explicit input & output files or throw
      const arrpReadFiles = arrsOutputCsvs.map(async (sFile) => {
        const sCacheFile = await fpReadFile(sFile + ".json", "utf8");
        return JSON.parse(sCacheFile);
      });
    }

    caches = setCaches(await Promise.all(arrpReadFiles));
  } catch (e) {
    console.error(
      "Error reading one of the files you specified. Are you sure you ran that command correctly?",
      e
    );
    process.exit();
  }

  if (oOptions.mergeFiles) fMergeCaches(oOptions);

  // write caches to csvs
  // TODO: regex to skip some records
  const arrp = caches.map(async (oCache, i) => {
    const oRepresentative = fGetRepresentativeRecord(oCache);
    let sOutputFileName = oOptions.assumeFileNames
      ? DEFAULT_OUTPUT_FILE_NAME
      : arrsOutputCsvs[i] + ".csv";
    const arrTableColumnKeys = Object.keys(oRepresentative);
    const oTitleLine =
      oCache[oOptions.sUniqueKey] || foGetImpliedTitleRecord(oRepresentative);
    const arroSortedRecords = Object.values(oCache)
      .filter((o) => fUseRecord(o))
      .sort((oA, oB) =>
        oA[oOptions.sUniqueKey] > oB[oOptions.sUniqueKey] ? 1 : -1
      );

    // wipe output file
    await fpWriteFile(sOutputFileName, "", "utf8");

    // write title line first
    return [oTitleLine].concat(arroSortedRecords).map(async (oRecord, i) => {
      // only write title line as first line (don't write twice)
      if (oRecord[oOptions.sUniqueKey] === oTitleLine[oOptions.sUniqueKey] && i)
        return Promise.resolve();

      try {
        const sCsvRecord = utils.fsRecordToCsvLine(oRecord, arrTableColumnKeys);
        const oWriteResult = await fpAppendFile(
          sOutputFileName,
          sCsvRecord + EOL,
          "utf8"
        );
        return Promise.resolve(oWriteResult);
      } catch (error) {
        console.log("error writing record: ", error);
      }
    });
  });

  await Promise.all(arrp);
}

// yargs === overengineering
function fParseOptions() {
  function _fCleanValue(s) {
    return s && s.trim().replace(/[^\w ]/g, "");
  }

  process.argv.slice(2).forEach((s) => {
    if (s.toLowerCase().includes("uniquekey")) {
      oOptions.sUniqueKey = _fCleanValue(s.split("=")[1]);
    } else if (s.includes("--")) {
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
      "cache merge option(s) observed, but no unique key to merge on the basis of was provided. Pass --UniqueKey=MyUniqueKeyName."
    );
    process.exit();
  }

  if (!arrsOutputCsvs.length) oOptions.assumeFileNames = true;
}

function fGetRepresentativeRecord(oCache) {
  try {
    return Object.values(oCache).find(fUseRecord);
  } catch (error) {
    console.log("error trying to obtain representative record:", error);
    return {};
  }
}

function foGetImpliedTitleRecord(oRepresentative) {
  try {
    return Object.keys(oRepresentative).reduce(
      (oAcc, sKey) =>
        Object.assign(oAcc, { [sKey]: fNormalizeVariableName(sKey, oOptions) }),
      {}
    );
  } catch (error) {
    console.log("error trying to obtain implied title record:", error);
    return {};
  }
}

// ref: TODO 4.3.4, `drop-key` implementation
// for now we just ensure written records include unique key
function fUseRecord(o) {
  return o[oOptions.sUniqueKey];
}

main();
