to recreate stack-overflow-survey-2020-country-us.csv
1. download stack overflow survey results from 2020 at: https://insights.stackoverflow.com/survey/
2. Retain only the columns named below:
    * Respondent
    * MainBranch
    * Country
    * DevType
    * EdLevel
    * Employment
    * Gender
    * UndergradMajor
3. remove rows where the value of the "Country" column does not equal "United States"
4. remove rows where the value of the "MainBranch" column does not equal "I am a developer by profession"
