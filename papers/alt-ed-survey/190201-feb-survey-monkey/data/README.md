# 2019-feb-survey-monkey data README

Section 1 describes transformation of raw survey data into the spreadsheet used by Stata.

Section 2 has notes on collecting responses, with emphasis on responses obtained through Github.

Section 3 has miscellaneous notes.

## Transformation of Raw Survey Data

Massaging is accomplished by executing a JavaScript / Node process. The /massage folder contains the code for that program.

The program reads CSV files within the /2018 and /2019 folders to produce /data/output.csv

From SurveyMonkey's perspective, all observations fall under two distinct surveys:

1. Survey on Alternative Credentials was administered multiple times in 2018.

2. Survey on Alternative Credentials-2 was administered in February 2019.

The question set from Oct 2018 was a superset of Feb 2018, so a new SurveyMonkey survey wasn't needed, just new collectors.

However, the Feb 2019 questions were a subset of Oct 2018, so a new survey needed to be created, or else data would have been thrown out.

When exporting data from SurveyMonkey, the following steps were taken:

1. Go to the analyze results tab for the survey and click Save As in the top-right.

2. Choose Export Data -> All responses data

3. In the Export Survey Data overlay, choose format = XLS, data view = original view, columns = condensed, cells = numerical value.

4. Click export button.

5. The zip was extracted to the relevant folder and the Excel folder was deleted, leaving the CSV folder and READ_ME.txt

## Collecting Responses

From the perspective of SurveyMonkey, all responses fall into the scope of a collector. A variable representing the collector associated with a response is used in analysis, and it's significance is empirically unknown but structurally known at this time. One collector represents SurveyMonkey purchased responses, another represents Mechanical Turk purchased responses, one represents responses gathered on social media, and another represents responses gathered by sending emails to addresses found on Github.

[This Github scraper](https://github.com/Vandivier/github-email-scraper-node) was developed to obtain email addresses on Github. The /github-responses folder, particularly the  /github-responses/emailed.csv file, tracks which scraped addresses were emailed, what they were emailed, and how they were emailed. Different invitation text files are contained in the same folder. These were comparatively assessed for performance to maximize response rates. I track method of email because I started with individual emails from my personal account, but I want to leave open the possibility of using an email blasting service. Subject line performance was seperately tracked. Subject lines are causally associated with the open rate, but the email body contributes to explanation of the click-through rate of opened emails.

Each combination of email and subject line is associated with a specific collector. Because there were 5 subject lines and 3 email body variants, there are a total of 15 collectors. Each collector was named with a collector-business-id, which is different compared to SurveyMonkey's assigned Collector ID.

## Miscellaneous Notes

While the survey launched in February, some responses occured in March.

Those invited to take the survey were scraped from Github profiles. The population of Github users is unique for many reasons, but a key feature is that they are generally software developers.
