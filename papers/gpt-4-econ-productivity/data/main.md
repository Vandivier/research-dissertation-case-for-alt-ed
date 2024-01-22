# main data explanation file

The main.csv uses terse column names. This file expounds on the meaning of those column names.

The column names and their descriptions amount to a description of the survey.

This is mainly a working file. Please prefer the PDF form of the paper, its methodology section, and its questionnaire appendix, once available, to this file for the purpose of explaining questionnaire details.

---

## submission_date

A timestamp of web form submission is noted in the source data.

These timestamps were lumped by day into a submission_date for analysis.

## reported_attention

On a scale of 1-10, with one being the least attention and 10 being the most attention, please indicate how much attention you applied while completing this study

## participant_id

Q3 is omitted from main.csv. This question identified the participant for the purpose of survey response integrity, communication as needed, and reward administration.

For the purpose of analysis, we substitute an obfuscated participant_id to capture participant effects.

In `with_gpt.csv`, the January 2024 model of GPT-4 provides samples with participant_id 32.
In `with_pi.csv`, GPT-4 samples are included with participant_id 32 and also a response from the Principal Investigator is included as participant_id 33.

## education_lvl

What is your highest level of education?

Possible answers:

1. High School or Less
2. Some College
3. An Undergraduate Degree
4. A Graduate Degree
5. A Ph.D.

## with_econ_degree

Do you have a postsecondary degree in Economics? (Yes/No)

## rating questions

This question set accounts for questions number 6 to 24, called "doc1_rating...doc18_rating".
This question is repeated for a DOCUMENT_ID ranging from 1 to 18:

```
For Document ID [DOCUMENT_ID], please answer the following three questions using a comma-separated format.

1. What education level does the writer appear to have? Use ""u"" for undergraduate or lower, ""m"" for the master's level, or ""p"" for Ph.D. or higher.
2. Rate the article quality on a scale from 1-10.
3. Rate the likelihood that the article is written by GPT-4 on a scale from 1-10.

An example answer would be ""u,1,1""
```

Each document has a unique combination of paper topic (topic effects) and authorship (author effects).
There are four research questions or topics:

1. Is modern Austrian economics distinct from neoclassical economics?
2. What key factors indicate the overall health of the macroeconomy? Include both general concepts and also specific public measures.
3. What is the impact of remote work on the gender wage gap and career progression in the post-pandemic labor market?
4. Suggest best practices for literature search with and without a large language model (LLM). Given the benefits and problems of such a process, do you expect the gains to researcher productivity from LLM augmentation to be large, small, or negative?
