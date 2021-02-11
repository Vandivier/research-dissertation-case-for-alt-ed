# ref: some models in statsmodel lib: https://www.statsmodels.org/stable/api.html
# ref: some models in general: https://stackabuse.com/multiple-linear-regression-with-python/
# ref: https://towardsdfscience.com/linear-regression-in-6-lines-of-python-5e1d0cd05b8d
# ref: https://pbpython.com/notebook-alternative.html
# note: why no stata? "...if you use an unauthorized copy it will give you the wrong results without warning..."
#    https://www.econjobrumors.com/topic/there-are-no-stata-14-and-stata-15-torrents
# ref: https://dergipark.org.tr/en/download/article-file/744047

import numpy as np
import matplotlib.pyplot as plt  # To visualize
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

df = pd.read_csv('alt-ed-covid-2-hidden-massaged.csv')
# ref: https://stackoverflow.com/a/51428632/3931488
print(df.columns)

df.rename(columns={
          "Do you contribute to hiring and firing decisions at your company?": "manager_effects",
          "For many professions, alternative credentials can qualify a person for an entry-level position.": "favor_alt_creds",
          "It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.": "conventional_alt_creds",
          "When you add up the pros and cons for online education, it's probably a good thing for society overall.": "favor_online_ed",
          "Which of these industries most closely matches your profession?": "industry",
          "Gender?": "gender",
          "Household Income?": "income",
          "Age?": "age",
          "What is the highest level of education you have completed?": "education",
          "Which race/ethnicity best describes you? (Please choose only one.) ": "ethnicity",
          "What state do you reside in?": "state",
          "To what degree has coronavirus negatively impacted your life?": "covid_impact",
          "To what degree has coronavirus caused you to increase your participation in remote learning, remote working, and other remote activities?": "covid_ind_remote",
          "To what degree has coronavirus-induced remote activity improved your favorability to remote learning (either for yourself or for other people)?": "covid_ind_fav_online",
          }, inplace=True)

# get dummies ref: https://stackoverflow.com/questions/55738056/using-categorical-variables-in-statsmodels-ols-class
manager_effects_series = pd.get_dummies(df['manager_effects'])
manager_effects_series = manager_effects_series.drop(columns=['No']).rename(columns={
    'Yes': 'is_manager', 'Not employed at present': 'is_unemployed'})


def fsReformatColumnNames(sColName):
    sMassagedName = sColName.replace(',', '').replace(
        ' ', '_').replace('-', '_').replace('>', '').lower()
    sMassagedName = sMassagedName.replace('_/_', '_')
    sMassagedName = sMassagedName.replace('__', '_')
    return sMassagedName


industry_effects_series = pd.get_dummies(
    df['industry']).rename(fsReformatColumnNames, axis='columns')
industry_effects_series = industry_effects_series.drop(
    columns=['agriculture']).rename(columns={})

income_effects_series = pd.get_dummies(df['income']).rename(
    fsReformatColumnNames, axis='columns')
income_effects_series = income_effects_series.drop(
    columns=['prefer_not_to_answer']).rename(columns={})

df = pd.get_dummies(df, columns=['age']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['age_60'])

df = pd.get_dummies(df, columns=['education']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['education_ged'])

ethnicity_effects_series = pd.get_dummies(
    df['ethnicity']).rename(fsReformatColumnNames, axis='columns')
ethnicity_effects_series = ethnicity_effects_series.drop(
    columns=['american_indian_or_alaskan_native']).rename(columns={})

state_effects_series = pd.get_dummies(df['state']).rename(
    fsReformatColumnNames, axis='columns')
state_effects_series = state_effects_series.drop(
    columns=['alabama']).rename(columns={})

gender_effects_series = pd.get_dummies(df['gender']).rename(
    fsReformatColumnNames, axis='columns')
gender_effects_series = gender_effects_series.drop(columns=['female']).rename(columns={
    'Male': 'is_male', 'Other': 'is_nonbinary'
})

# TODO: don't forget to analyze no negative impact / positive impact effects seperately.
covid_impact_series = pd.get_dummies(df['covid_impact'])
covid_impact_series = covid_impact_series.drop(columns=['No negative impact (or a positive impact)']).rename(columns={
    'Large negative impact': 'covid_impact_large', 'Moderate negative impact': 'covid_impact_moderate', 'Slight negative impact': 'covid_impact_slight'})

covid_ind_remote_series = pd.get_dummies(df['covid_ind_remote'])
covid_ind_remote_series = covid_ind_remote_series.drop(columns=['No increase (or a decrease)']).rename(columns={
    'Large degree': 'covid_ind_remote_large', 'Moderate degree': 'covid_ind_remote_moderate', 'Slight degree': 'covid_ind_remote_slight'})

covid_ind_fav_online_series = pd.get_dummies(df['covid_ind_fav_online'])
covid_ind_fav_online_series = covid_ind_fav_online_series.drop(columns=['No more favorable (or less favorable)']).rename(columns={
    'Large degree': 'covid_ind_fav_online_large', 'Moderate degree': 'covid_ind_fav_online_moderate', 'Slight degree': 'covid_ind_fav_online_slight'})

# help build long model formula
print(" + ".join(list(df.columns)))

# TODO: custom vars.
# custom vars ref: https://kaijento.github.io/2017/04/22/pandas-create-new-column-sum/
# df['z'] = df.x + df.y

print("---")

# TODO: fix long regression below
# from_formula ref: http://www.science.smith.edu/~jcrouser/SDS293/labs/lab2-py.html
# add constant ref: https://stackoverflow.com/questions/36409889/using-ols-from-statsmodels-formula-api-how-to-remove-constant-term
# shorthand ref: https://stackoverflow.com/questions/5251507/how-to-succinctly-write-a-formula-with-many-variables-from-a-data-frame
# long reg / m1: n=350, r2=0.437, ar2=0.239
print(sm.OLS.from_formula('''favor_alt_creds ~
    manager_effects + conventional_alt_creds + favor_online_ed + industry
    + age_18_29 + age_30_44 + age_45_60
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree + education_obtained_a_doctoral_degree + education_some_college + education_some_graduate_school
    + gender + ethnicity + income + state
    + covid_impact + covid_ind_remote + covid_ind_fav_online + 1''', data=df).fit().summary())

# # m2 = ar2 0.234
# X2 = X1
# del X2['What state do you reside in?']
# m2 = sm.OLS(Y, X2)
# m2Results = m2.fit()
# # print(m2Results.summary())

# fig, axes = plt.subplots()
# fig = sm.graphics.plot_fit(m1Results, 1, ax=axes)
# axes.set_ylabel("Favorability")
# axes.set_xlabel("Poverty Level")
# axes.set_title("Linear Regression")
# plt.show()

# plt.scatter(x, y
