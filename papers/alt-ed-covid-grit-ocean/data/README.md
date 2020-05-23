# alt-ed-covid-grit-ocean data wrangling

Implementation of data wrangling based on:

\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\data\190201-feb-survey-monkey\data\wrangle\wrangler.js

Steps to produce output from input files:

1. `npm install`

2. `npm run build` OR steps 3-5.

3. `node wrangler`

4. `node unwrite-csv 2018-oct-survey-on-alternative-credentials 2019-feb-survey-on-alternative-credentials 2019-may-survey-on-alternative-credentials --UniqueKey=sRespondentID`

5. `node write-csv 2018-oct-survey-on-alternative-credentials 2019-feb-survey-on-alternative-credentials 2019-may-survey-on-alternative-credentials --UniqueKey=sRespondentID`
   1. TODO: fix this step; write-csv is depending on key index which varies by file so output is incorrectly merged
   2. output file doesn't even have all expected columns (eg superset of two input files)

## Miscellaneous

1. ref: https://medium.com/javascript-in-plain-english/typescript-with-node-and-express-js-why-when-and-how-eb6bc73edd5d

## TODO:

1. pre-wrangler script which is specific to surveymonkey. It would:
   1. collapse first and second rows in surveymonkey-specific way, and maybe prep some of column-transforms.ts
