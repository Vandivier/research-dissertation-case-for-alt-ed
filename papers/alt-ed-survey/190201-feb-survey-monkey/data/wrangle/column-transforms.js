module.exports = [{
    "sMatcher": 'Respondent ID',
},{
    "sMatcher": 'Collector ID',
},{
    "sMatcher": 'End Date',
},{
    "sMatcher": 'Do you contribute to hiring and firing decisions at your company?',
    farroTransformer: function(sCellValue, arroTransformersWithIndex) {
        const oTransformerManager = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsManager');
        const oTransformerUnemployed = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsUnemployed');

        return [
            Object.assign({}, oTransformerManager, {value: sCellValue === '1' ? 1 : 0}),
            Object.assign({}, oTransformerUnemployed, {value: sCellValue === '3' ? 1 : 0})
        ];
    }
},{
    "sMatcher": 'alternative credentials can qualify a person for an entry-level position',
},{
    "sMatcher": 'It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.',
},{
    "sMatcher": 'When you add up the pros and cons for online education',
},{
    "sMatcher": 'When you add up the pros and cons for artificial intelligence',
},{
    "sMatcher": 'Udacity',
},{
    "sMatcher": 'Udemy',
},{
    "sMatcher": 'Coursera',
},{
    "sMatcher": 'Pluralsight',
},{
    "sMatcher": 'Lynda.com',
},{
    "sMatcher": 'Which of these industries most closely matches your profession?',
},{
    "sMatcher": 'businesses treat individuals more fairly',
},{
    "bExactMatch": true,
    "sMatcher": 'Gender?',
},{
    "bExactMatch": true,
    "sMatcher": 'Household Income?',
},{
    "bExactMatch": true,
    "sMatcher": 'Age?',
},{
    "bExactMatch": true,
    "sMatcher": 'Age',
},{
    "bExactMatch": true,
    "sMatcher": 'Gender',
},{
    "bExactMatch": true,
    "sMatcher": 'Household Income',
},{
    "bExactMatch": true,
    "sMatcher": 'Region',
},
{
    "bGeneratedColumn": true,
    "sOutputColumnName": "IsManager"
},
{
    "bGeneratedColumn": true,
    "sOutputColumnName": "IsUnemployed"
}]