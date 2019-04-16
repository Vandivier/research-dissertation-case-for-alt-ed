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
    bTransientColumn: true,
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
    bTransientColumn: true,
    sMatcher: 'Do you work in a STEM profession?',
    farroTransformer: function(sCellValue, oTransformer, arroTransformersWithIndex) {
      const oTransformerStem = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsStem');
      const oTransformerNotStem = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsNotStem');
      const oTransformerUnsureStem = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsUnsureStem');
      const oTransformerUnreportedStem = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsUnreportedStem');

      return [
        Object.assign({}, oTransformerStem, { value: sCellValue === '1' ? 1 : 0 }),
        Object.assign({}, oTransformerNotStem, { value: sCellValue === '2' ? 1 : 0 }),
        Object.assign({}, oTransformerUnsureStem, { value: sCellValue === '3' ? 1 : 0 }),
        Object.assign({}, oTransformerUnreportedStem, { value: !sCellValue ? 1 : 0 }),
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
    sOutputColumnName: 'HeardOfUdacity',
  },
  {
    sMatcher: 'Udemy',
    farroTransformer: fBooleanize,
    sOutputColumnName: 'HeardOfUdemy',
  },
  {
    sMatcher: 'Coursera',
    farroTransformer: fBooleanize,
    sOutputColumnName: 'HeardOfCoursera',
  },
  {
    sMatcher: 'Pluralsight',
    farroTransformer: fBooleanize,
    sOutputColumnName: 'HeardOfPluralsight',
  },
  {
    sMatcher: 'Lynda.com',
    farroTransformer: fBooleanize,
    sOutputColumnName: 'HeardOfLynda',
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
    bTransientColumn: true,
    farroTransformer: function(sCellValue, oTransformer, arroTransformersWithIndex) {
      const oTransformerMale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsReportedMale');
      const oTransformerFemale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsReportedFemale');
      const oTransformerNonbinary = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsReportedNonbinary');
      const oTransformerUnreportedGender = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsUnreportedGender');

      return [
        Object.assign({}, oTransformerMale, { value: sCellValue === '2' ? 1 : 0 }),
        Object.assign({}, oTransformerFemale, { value: sCellValue === '1' ? 1 : 0 }),
        Object.assign({}, oTransformerNonbinary, { value: sCellValue === '3' ? 1 : 0 }),
        Object.assign({}, oTransformerUnreportedGender, { value: !sCellValue ? 1 : 0 }),
      ];
    },
    sMatcher: 'Gender?',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsReportedMale',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsReportedFemale',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsReportedNonbinary',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsUnreportedGender',
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
    bTransientColumn: true,
    farroTransformer: function(sCellValue, oTransformer, arroTransformersWithIndex) {
      const oTransformerMale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsSurveyMonkeyMale');
      const oTransformerFemale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsSurveyMonkeyFemale');
      const oTransformerUnreportedGender = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsSurveyMonkeyUnreportedGender');

      return [
        Object.assign({}, oTransformerMale, { value: sCellValue === '1' ? 1 : 0 }),
        Object.assign({}, oTransformerFemale, { value: sCellValue === '2' ? 1 : 0 }),
        Object.assign({}, oTransformerUnreportedGender, { value: !sCellValue ? 1 : 0 }),
      ];
    },
    sMatcher: 'Gender',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsSurveyMonkeyMale',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsSurveyMonkeyFemale',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsSurveyMonkeyUnreportedGender',
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
    sOutputColumnName: 'IsNotStem',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsUnsureStem',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsUnreportedStem',
  },
  {
    bGeneratedColumn: true,
    bTransientColumn: true,
    farroTransformer: function(sCellValue, oTransformer, arroTransformersWithIndex) {
      const oTransformerReportedMale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsReportedMale');
      const oTransformerReportedFemale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsMale');
      const oTransformerSurveyMonkeyMale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsMale');
      const oTransformerSurveyMonkeyFemale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsMale');
      const oTransformerMale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsMale');
      const oTransformerFemale = arroTransformersWithIndex.find(oTransformer => oTransformer.sOutputColumnName === 'IsFemale');

      const bIsMale = oTransformerReportedMale.value === 1 || oTransformerSurveyMonkeyMale.value === 1;
      const bIsFemale = oTransformerReportedFemale.value === 1 || oTransformerSurveyMonkeyFemale.value === 1;

      return [
        Object.assign({}, oTransformerMale, { value: bIsMale ? 1 : 0 }),
        Object.assign({}, oTransformerFemale, { value: bIsFemale ? 1 : 0 }),
      ];
    },
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsMale',
  },
  {
    bGeneratedColumn: true,
    sOutputColumnName: 'IsFemale',
  },
];
