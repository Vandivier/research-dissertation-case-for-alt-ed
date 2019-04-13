# 2019-feb-survey-monkey data README

Section 1 describes obtaining and wrangling raw data into the output.csv used for STATA analysis.

Section 2 has notes on collecting responses, with emphasis on responses obtained through Github.

Section 3 has miscellaneous notes.

## Transformation of Raw Survey Data

Data was sourced through multiple administrations of differently formatted SurveyMonkey surveys.

When exporting data from SurveyMonkey, the following steps were taken:

1. Go to the analyze results tab for the survey and click Save As in the top-right.

2. Choose Export Data -> All responses data

3. In the Export Survey Data overlay, choose format = XLS, data view = original view, columns = condensed, cells = numerical value.

4. Click export button.

5. The zip was extracted to the relevant folder and the Excel folder was deleted, leaving the CSV folder and READ_ME.txt

From SurveyMonkey's perspective, all observations fall under two distinct surveys:

1. Survey on Alternative Credentials was administered multiple times in 2018.

2. Survey on Alternative Credentials-2 was administered multiple times in 2019.

Because SurveyMonkey exports by survey rather than by administration, this yields two CSV source files. The folder containing each CSV file is labeled by year.

Wrangling survey data is documented as code within /wrangle/wrangle.js.

Wrangling involves variable preperation. For example, a wrangling operation might be to transform the question on whether the respondent contributes to hiring decisions from a categorical variable with answers yes, no, and I am currently unemployed, into two boolean variables called IsManager and IsUnemployed which represent the same information in a slightly more analytical-friendly way.

Each source file is independently wrangled into an intermediary output file, and these files are then joined to form output.csv. The joining process uses two scripts copied from the /github-email-scraper-node repository at revision d08724f0c63b on 4/12/19. The two scripts are called unwrite-csv.js and write-csv.js.

With a terminal open in the /wrangle folder, the wrangling and joining process is accomplished by running the following three bash commands in order:

1. `npm install`

2. `node wrangler`

3. `node unwrite-csv 2018-survey-on-alternative-credentials 2019-survey-on-alternative-credentials --UniqueKey=sRespondentID`

4. `node write-csv 2018-survey-on-alternative-credentials 2019-survey-on-alternative-credentials --UniqueKey=sRespondentID`
    1. TODO: fix this step; write-csv is depending on key index which varies by file so output is incorrectly merged
    2. output file doesn't even have all expected columns (eg superset of two input files)

## Collecting Responses

From the perspective of SurveyMonkey, all responses fall into the scope of a collector. A variable representing the collector associated with a response is used in analysis, and it's significance is empirically unknown but structurally known at this time. One collector represents SurveyMonkey purchased responses, another represents Mechanical Turk purchased responses, one represents responses gathered on social media, and another represents responses gathered by sending emails to addresses found on Github.

[This Github scraper](https://github.com/Vandivier/github-email-scraper-node) was developed to obtain email addresses on Github. The /github-responses folder, particularly the  /github-responses/emailed.csv file, tracks which scraped addresses were emailed, what they were emailed, and how they were emailed. Different invitation text files are contained in the same folder. These were comparatively assessed for performance to maximize response rates. I track method of email because I started with individual emails from my personal account, but I want to leave open the possibility of using an email blasting service. Subject line performance was seperately tracked. Subject lines are causally associated with the open rate, but the email body contributes to explanation of the click-through rate of opened emails.

Each combination of email and subject line is associated with a specific collector. Because there were 5 subject lines and 3 email body variants, there are a total of 15 collectors. Each collector was named with a collector-business-id, which is different compared to SurveyMonkey's assigned Collector ID.

## Miscellaneous Notes

While the survey launched in February, some responses occured in March.

Those invited to take the survey were scraped from Github profiles. The population of Github users is unique for many reasons, but a key feature is that they are generally software developers.
