const fs = require('fs');
const path = require('path')
const util = require('util');

const fpReadFile = util.promisify(fs.readFile);
const fpWriteFile = util.promisify(fs.writeFile);

const arrsSurveyMonkeyCsvConventionalLocation = ['CSV', 'Survey on Alternative Credentials.csv'];

// ref: https://stackoverflow.com/a/35759360/3931488
const farrsGetSubfolderPathsByFolderPath = sPath => fs.readdirSync(sPath).map(sFileName => {
    const sFilePath = path.join(sPath, sFileName)

    if (fs.statSync(sFilePath).isDirectory()) {
        return sFilePath;
    }
}).filter(s =>s)

function fGetInputFileLocations() {
    const sDataFolderPath = path.join(__dirname, '..');
    return farrsGetSubfolderPathsByFolderPath(sDataFolderPath).filter(sPath => sPath !== __dirname)
        .map(sSubfolder => path.join(sSubfolder, ...arrsSurveyMonkeyCsvConventionalLocation));
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
}

function fsTransformSurveyMonkeyCsvContent(sOriginalFileContent) {
    const sNewFileContent = sOriginalFileContent;
    // TODO
    return sNewFileContent;
}

async function main() {
    const arrsInputFileLocations = fGetInputFileLocations();
    const arrpFileOperations = arrsInputFileLocations.map(fpWrangleSurveyMonkeyFile)
    await Promise.all(arrpFileOperations);
}

main();

