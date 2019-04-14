// if a cell value is empty transform it to 0
// if a cell value is non-empty, transform it to 1
function fBooleanize(sCellValue, oTransformer) {
  return [Object.assign({}, oTransformer, { value: sCellValue ? 1 : 0 })];
}

module.exports = [
  {
    sMatcher: 'Respondent ID',
  },
  {
    sMatcher: 'Collector ID',
  },
  {
    sMatcher: 'End Date',
  },
  {
    sMatcher: 'Do you contribute to hiring and firing decisions at your company?',
    farroTransformer: function(sCellValue, oTransformer, arroTransformersWithIndex) {
      const oTransformerManager = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsManager');
      const oTransformerUnemployed = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsUnemployed');

      return [
        Object.assign({}, oTransformerManager, { value: sCellValue === '1' ? 1 : 0 }),
        Object.assign({}, oTransformerUnemployed, { value: sCellValue === '3' ? 1 : 0 }),
      ];
    },
  },
  {
    sMatcher: 'Do you work in a STEM profession?',
    farroTransformer: function(sCellValue, oTransformer, arroTransformersWithIndex) {
      const oTransformerStem = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsStem');
      const oTransformerUnsureStem = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsUnsureStem');

      // TODO: this doesn't work
      return [
        Object.assign({}, oTransformerStem, { value: sCellValue === '1' ? 1 : 0 }),
        Object.assign({}, oTransformerUnsureStem, { value: sCellValue === '3' ? 1 : 0 }),
      ];
    },
  },
  {
    sMatcher: 'alternative credentials can qualify a person for an entry-level position',
    sOutputColumnName: 'FavorEntryLevel',
  },
  {
    sMatcher:
      'It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.',
      sOutputColumnName: 'FavorConventionalSoon',
  },
  {
    sMatcher: 'When you add up the pros and cons for online education',
    sOutputColumnName: 'FavorOnlineEducation',
  },
  {
    sMatcher: 'When you add up the pros and cons for cryptocurrency',
    sOutputColumnName: 'FavorCrypto',
  },
  {
    sMatcher: 'When you add up the pros and cons for artificial intelligence',
    sOutputColumnName: 'FavorAI',
  },
  {
    sMatcher: 'is important to check whether the degree was awarded from a US institution',
    sOutputColumnName: 'FavorAmerican',
  },
  {
    sMatcher: 'Udacity',
    farroTransformer: fBooleanize,
  },
  {
    sMatcher: 'Udemy',
    farroTransformer: fBooleanize,
  },
  {
    sMatcher: 'Coursera',
    farroTransformer: fBooleanize,
  },
  {
    sMatcher: 'Pluralsight',
    farroTransformer: fBooleanize,
  },
  {
    sMatcher: 'Lynda.com',
    farroTransformer: fBooleanize,
    sOutputColumnName: 'Lynda',
  },
  {
    sMatcher: 'Which of these industries most closely matches your profession?',
    sOutputColumnName: 'Industry',
  },
  {
    sMatcher: 'businesses treat individuals more fairly',
    sOutputColumnName: 'FavorRegulation',
  },
  {
    sMatcher: 'I consider myself religious',
    sOutputColumnName: 'FavorReligion',
  },
  {
    sMatcher: 'I consider myself Christian',
    sOutputColumnName: 'FavorChristianity',
  },
  {
    bExactMatch: true,
    sMatcher: 'Gender?',
    sOutputColumnName: 'ReportedGender',
  },
  {
    bExactMatch: true,
    sMatcher: 'Household Income?',
    sOutputColumnName: 'ReportedIncome',
  },
  {
    bExactMatch: true,
    sMatcher: 'Age?',
    sOutputColumnName: 'ReportedAge',
  },
  {
    bExactMatch: true,
    sMatcher: 'Age',
    sOutputColumnName: 'SurveyMonkeyAge',
  },
  {
    bExactMatch: true,
    sMatcher: 'Gender',
    sOutputColumnName: 'SurveyMonkeyGender',
  },
  {
    bExactMatch: true,
    sMatcher: 'Household Income',
    sOutputColumnName: 'SurveyMonkeyIncome',
  },
  {
    bExactMatch: true,
    sMatcher: 'Region',
    sOutputColumnName: 'SurveyMonkeyRegion',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsManager',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsUnemployed',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsStem',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsUnsureStem',
  }
];
