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

async function main() {
    const arrsInputFileLocations = fGetInputFileLocations();
    debugger
}

main();
