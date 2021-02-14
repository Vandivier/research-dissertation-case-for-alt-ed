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


def fsReformatColumnNames(sColName):
    sMassagedName = sColName.replace(',', '').replace(
        ' ', '_').replace('-', '_').replace('>', '').replace('+', '').lower()
    sMassagedName = sMassagedName.replace('_/_', '_')
    sMassagedName = sMassagedName.replace('__', '_')
    return sMassagedName


def getData():
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

    df = pd.get_dummies(df, columns=['covid_impact']).rename(
        fsReformatColumnNames, axis='columns').drop(columns=['covid_impact_no_negative_impact_(or_a_positive_impact)'])

    df = pd.get_dummies(df, columns=['covid_ind_remote']).rename(
        fsReformatColumnNames, axis='columns').drop(columns=['covid_ind_remote_no_increase_(or_a_decrease)'])

    df = pd.get_dummies(df, columns=['covid_ind_fav_online']).rename(
        fsReformatColumnNames, axis='columns').drop(columns=['covid_ind_fav_online_no_more_favorable_(or_less_favorable)'])

    # help build long model formula
    print(" + ".join(list(df.columns)))

    # TODO: custom vars.
    # custom vars ref: https://kaijento.github.io/2017/04/22/pandas-create-new-column-sum/
    # df['z'] = df.x + df.y

    print("---")
    print("done getting data")
    print("---")
    return df


# TODO: fix long regression below
# formulas are built using Patsy. ref: https://patsy.readthedocs.io/en/latest/formulas.html
# from_formula ref: http://www.science.smith.edu/~jcrouser/SDS293/labs/lab2-py.html
# add constant ref: https://stackoverflow.com/questions/36409889/using-ols-from-statsmodels-formula-api-how-to-remove-constant-term
# shorthand ref: https://stackoverflow.com/questions/5251507/how-to-succinctly-write-a-formula-with-many-variables-from-a-data-frame
# long reg / m1: n=350, r2=0.437, ar2=0.239
m1 = '''favor_alt_creds ~
    + conventional_alt_creds + favor_online_ed
    + covid_impact_large_negative_impact + covid_impact_moderate_negative_impact + covid_impact_slight_negative_impact
    + covid_ind_remote_large_degree + covid_ind_remote_moderate_degree + covid_ind_remote_slight_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + manager_effects_not_employed_at_present + is_manager
    + industry_education + industry_energy + industry_finance_investment_or_accounting + industry_health + industry_information_technology + industry_law + industry_manufacturing + industry_military + industry_other + industry_real_estate + industry_retail + industry_transportation
    + age_18_29 + age_30_44 + age_45_60
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree + education_obtained_a_doctoral_degree + education_some_college + education_some_graduate_school
    + gender_male + gender_other
    + ethnicity_asian_pacific_islander + ethnicity_black_or_african_american + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999 + income_175000_199999 + income_200000+ + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_arizona + state_arkansas + state_california + state_colorado + state_connecticut + state_delaware + state_florida + state_georgia + state_hawaii + state_idaho + state_illinois + state_indiana + state_iowa + state_kentucky + state_louisiana + state_maryland + state_massachusetts + state_michigan + state_minnesota + state_mississippi + state_missouri + state_nebraska + state_nevada + state_new_jersey + state_new_mexico + state_new_york + state_north_carolina + state_north_dakota + state_ohio + state_oklahoma + state_oregon + state_pennsylvania + state_rhode_island + state_south_carolina + state_south_dakota + state_tennessee + state_texas + state_virginia + state_washington + state_wisconsin
    + 1'''

# note: first covid factor cut === covid_impact[T.No negative impact (or a positive impact)]
# weak before nonlinear effects: n = 350, r2=0.430, ar2=0.312
m2 = '''favor_alt_creds ~
    + conventional_alt_creds + favor_online_ed
    + covid_impact_large_negative_impact
    + covid_ind_remote_large_degree + covid_ind_remote_slight_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + is_manager
    + industry_health + industry_information_technology + industry_manufacturing + industry_other + industry_real_estate + industry_retail
    + age_18_29 + age_30_44
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree + education_obtained_a_doctoral_degree + education_some_college
    + gender_other
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999 + income_175000_199999 + income_200000+ + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_arizona + state_california + state_colorado + state_florida + state_georgia + state_hawaii + state_idaho + state_illinois + state_iowa + state_kentucky + state_maryland + state_michigan + state_mississippi + state_missouri + state_nevada + state_north_carolina + state_ohio + state_oregon + state_pennsylvania + state_south_carolina + state_tennessee + state_virginia + state_washington + state_wisconsin
    + 1'''

# note: fell out in order: education, age, gender
# max ar model before curvilinear effects: r2 = 0.395, ar2 = 0.328
m3 = '''favor_alt_creds ~
    + conventional_alt_creds + favor_online_ed
    + covid_impact_large_negative_impact
    + covid_ind_remote_large_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + is_manager
    + industry_health + industry_information_technology + industry_manufacturing + industry_real_estate
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999 + income_175000_199999 + income_200000+ + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_florida + state_georgia + state_idaho + state_iowa + state_kentucky + state_nevada + state_north_carolina + state_ohio + state_pennsylvania + state_tennessee + state_washington
    + 1'''

# quadratic factor for favor_online_ed was more important and linear effect insignificant
# local max ar model: r2 = 0.402, ar2 = 0.333
m4 = '''favor_alt_creds ~
    + conventional_alt_creds
    + favor_online_ed^2
    + covid_impact_large_negative_impact
    + covid_ind_remote_large_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + is_manager
    + industry_health + industry_information_technology + industry_manufacturing + industry_real_estate
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999 + income_175000_199999 + income_200000+ + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_florida + state_georgia + state_idaho + state_iowa + state_kentucky + state_nevada + state_north_carolina + state_ohio + state_pennsylvania + state_tennessee + state_washington
    + 1'''

# note: retains all coronavirus variables.
# reg of interest 1
# max ar model: r2 = 0.385, ar2 = 0.334
m5 = '''favor_alt_creds ~
    + conventional_alt_creds
    + favor_online_ed^2
    + covid_impact_large_negative_impact
    + covid_ind_remote_large_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + is_manager
    + industry_health + industry_information_technology + industry_manufacturing + industry_real_estate
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + income_10000_24999 + income_100000_124999 + income_125000_149999
    + state_florida + state_georgia + state_idaho + state_iowa + state_kentucky + state_north_carolina + state_ohio + state_pennsylvania + state_tennessee
    + 1'''

# note: fell out in order: covid_impact, income, is_manager
# note: covid_ind_fav_online measures uniformly negative relation - interesting and counterintuitive.
#   can interpret as 'thos people which were most favorably moved began by being the most disfavorable and ended in being less disfavorable, but still disfavorable.
# note: covid_ind_fav_online is robust from maxar to strong; the other two covid factors have a positive relation but smaller coefficients.
# note: on the high side of insignificant skew or on the very low side of moderate skew:
#   ref: https://www.spcforexcel.com/knowledge/basic-statistics/are-skewness-and-kurtosis-useful-statistics
# two strong covid factors.
# reg of interest 2
# strong model: r2 = 0.353, ar2 = 0.318
m6 = '''favor_alt_creds ~
    + conventional_alt_creds
    + favor_online_ed^2
    + covid_ind_remote_large_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + industry_health + industry_information_technology + industry_manufacturing + industry_real_estate
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + state_georgia + state_iowa + state_kentucky + state_ohio + state_pennsylvania
    + 1'''

# strong model with re-inserted covid_impact_large_negative_impact as a robustness test.
# note: direction of effects retained/stable/robust.
# strong model with re-inserted covid_impact_large_negative_impact: r2 = 0.355, ar2 = 0.318
m7 = '''favor_alt_creds ~
    + conventional_alt_creds
    + favor_online_ed^2
    + covid_impact_large_negative_impact
    + covid_ind_remote_large_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree + covid_ind_fav_online_slight_degree
    + industry_health + industry_information_technology + industry_manufacturing + industry_real_estate
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + state_georgia + state_iowa + state_kentucky + state_ohio + state_pennsylvania
    + 1'''

# skew correction ref: https://www.annualreviews.org/doi/pdf/10.1146/annurev.publhealth.28.082206.094100
# linear-log was insignificant independent vars, so trying log-log
# it's more skewed and kurtosis, not less
# log strong model (skew correction): r2 = 0.324, ar2 = 0.294
m8 = '''np.log(favor_alt_creds) ~
    + conventional_alt_creds
    + np.log(favor_online_ed) + favor_online_ed + favor_online_ed^2
    + covid_impact_large_negative_impact
    + covid_ind_remote_large_degree
    + covid_ind_fav_online_large_degree + covid_ind_fav_online_moderate_degree
    + industry_real_estate
    + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + state_georgia + state_iowa + state_pennsylvania
    + 1'''

if __name__ == '__main__':
    # this file executed as script
    getData()
    print(sm.OLS.from_formula(m8, data=getData()).fit().summary())

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
