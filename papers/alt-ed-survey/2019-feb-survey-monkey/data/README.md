# 2019-feb-survey-monkey data README

This README goes over how raw survey data was transformed into the spreadsheet used by Stata.

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
