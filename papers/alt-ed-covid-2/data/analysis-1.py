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


def fsReformatColumnNames(sColName):
    sMassagedName = sColName.replace(',', '').replace(
        ' ', '_').replace('-', '_').replace('>', '').replace('+', '').lower()
    sMassagedName = sMassagedName.replace('_/_', '_')
    sMassagedName = sMassagedName.replace('__', '_')
    return sMassagedName


# get dummies ref: https://stackoverflow.com/questions/55738056/using-categorical-variables-in-statsmodels-ols-class
df = pd.get_dummies(df, columns=['manager_effects']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['manager_effects_no']).rename(columns={
        'manager_effects_yes': 'is_manager'})

df = pd.get_dummies(df, columns=['industry']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['industry_agriculture'])

df = pd.get_dummies(df, columns=['income']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['income_prefer_not_to_answer'])

df = pd.get_dummies(df, columns=['age']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['age_60'])

df = pd.get_dummies(df, columns=['education']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['education_ged'])

df = pd.get_dummies(df, columns=['ethnicity']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['ethnicity_american_indian_or_alaskan_native'])

df = pd.get_dummies(df, columns=['state']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['state_alabama'])

df = pd.get_dummies(df, columns=['gender']).rename(
    fsReformatColumnNames, axis='columns').drop(columns=['gender_female'])

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
# formulas are built using Patsy. ref: https://patsy.readthedocs.io/en/latest/formulas.html
# from_formula ref: http://www.science.smith.edu/~jcrouser/SDS293/labs/lab2-py.html
# add constant ref: https://stackoverflow.com/questions/36409889/using-ols-from-statsmodels-formula-api-how-to-remove-constant-term
# shorthand ref: https://stackoverflow.com/questions/5251507/how-to-succinctly-write-a-formula-with-many-variables-from-a-data-frame
# long reg / m1: n=350, r2=0.437, ar2=0.239
sm.OLS.from_formula('''favor_alt_creds ~
    + conventional_alt_creds + favor_online_ed
    + covid_impact + covid_ind_remote + covid_ind_fav_online
    + manager_effects_not_employed_at_present + is_manager
    + industry_education + industry_energy + industry_finance_investment_or_accounting + industry_health + industry_information_technology + industry_law + industry_manufacturing + industry_military + industry_other + industry_real_estate + industry_retail + industry_transportation
    + age_18_29 + age_30_44 + age_45_60
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree + education_obtained_a_doctoral_degree + education_some_college + education_some_graduate_school
    + gender_male + gender_other
    + ethnicity_asian_pacific_islander + ethnicity_black_or_african_american + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999 + income_175000_199999 + income_200000+ + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_arizona + state_arkansas + state_california + state_colorado + state_connecticut + state_delaware + state_florida + state_georgia + state_hawaii + state_idaho + state_illinois + state_indiana + state_iowa + state_kentucky + state_louisiana + state_maryland + state_massachusetts + state_michigan + state_minnesota + state_mississippi + state_missouri + state_nebraska + state_nevada + state_new_jersey + state_new_mexico + state_new_york + state_north_carolina + state_north_dakota + state_ohio + state_oklahoma + state_oregon + state_pennsylvania + state_rhode_island + state_south_carolina + state_south_dakota + state_tennessee + state_texas + state_virginia + state_washington + state_wisconsin
    + 1''', data=df).fit().summary()

print(sm.OLS.from_formula('''favor_alt_creds ~
    + conventional_alt_creds + favor_online_ed
    + covid_impact + covid_ind_remote + covid_ind_fav_online
    + is_manager
    + industry_education + industry_energy + industry_finance_investment_or_accounting + industry_health + industry_information_technology + industry_manufacturing + industry_military + industry_other + industry_real_estate + industry_retail + industry_transportation
    + age_18_29 + age_30_44 + age_45_60
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree + education_obtained_a_doctoral_degree + education_some_college
    + gender_male + gender_other
    + ethnicity_black_or_african_american + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999 + income_175000_199999 + income_200000+ + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_arizona + state_arkansas + state_california + state_colorado + state_connecticut + state_florida + state_georgia + state_hawaii + state_idaho + state_illinois + state_indiana + state_iowa + state_kentucky + state_maryland + state_massachusetts + state_michigan + state_minnesota + state_mississippi + state_missouri + state_nebraska + state_nevada + state_new_jersey + state_new_mexico + state_north_carolina + state_north_dakota + state_ohio + state_oregon + state_pennsylvania + state_south_carolina + state_tennessee + state_virginia + state_washington + state_wisconsin
    + 1''', data=df).fit().summary())

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
