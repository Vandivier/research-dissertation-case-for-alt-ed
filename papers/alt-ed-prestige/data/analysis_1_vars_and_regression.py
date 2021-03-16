# ref: alt-ed-covid-2...analysis_1_vars_and_regression.py
# ref: alt-ed-matching-effects-2...analysis_1_vars_and_regression.py

import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm
from statsmodels.iolib.summary2 import summary_col

def fsImproveProviderNames(sColName):
    sMassagedName = sColName
    sMassagedName = sMassagedName.replace('provider_hireability_1', 'provider_hireability_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_1', 'provider_hireability_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_2', 'provider_hireability_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_2', 'provider_hireability_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_3', 'provider_hireability_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_3', 'provider_hireability_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_4', 'provider_hireability_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_4', 'provider_hireability_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_5', 'provider_hireability_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_5', 'provider_hireability_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_6', 'provider_hireability_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_6', 'provider_hireability_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_7', 'provider_hireability_h_yacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_7', 'provider_hireability_h_yacc_yself_yother')
    return sMassagedName


def fsReformatColumnNames(sColName):
    sMassagedName = sColName.replace(',', '').replace(
        ' ', '_').replace('-', '_').replace('>', '').replace('+', '').lower()
    sMassagedName = sMassagedName.replace('?', '')
    sMassagedName = sMassagedName.replace('.', '_')
    sMassagedName = sMassagedName.replace('_/_', '_')
    sMassagedName = sMassagedName.replace('__', '_')
    sMassagedName = sMassagedName.replace('how_impressed_would_you_be_if_you_heard_that_someone_studied_at_this_school', 'provider_impressed')
    sMassagedName = sMassagedName.replace('for_many_professions_learning_at_this_school_can_qualify_a_person_for_an_entry_level_position', 'provider_hireability')
    return sMassagedName


def getData(dropFirstDummy=True):
    df = pd.read_csv('prestige-hidden.csv')
    # ref: https://stackoverflow.com/a/51428632/3931488
    print(df.columns)

    df.rename(columns={
        "Do you contribute to hiring and firing decisions at your company?": "manager_effects",
        "For many professions, alternative credentials can qualify a person for an entry-level position.": "hireability", # aka favorability
        "It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.": "conventional_alt_creds",
        "When you add up the pros and cons for online education, it's probably a good thing for society overall.": "favor_online_ed",
        "Which of these industries most closely matches your profession?": "industry",
        "Gender?": "gender",
        "Household Income?": "income",
        "Age?": "age",
        "What is the highest level of education you have completed?": "education",
        "Which race/ethnicity best describes you? (Please choose only one.) ": "ethnicity",
        "What state do you reside in?": "state",
        "What is the name of a reputable certification or non-college credential in your profession? Use “n/a” if nothing comes to mind.": "named_credential",
        "I prefer to hire or work with a person that has a college degree rather a person that holds a reputable certification or non-college credential.": "is_prefer_degree",
        "Do you tend to work more closely with coworkers at your company or customers and external business partners?": "work_with_external_partners",
    }, inplace=True)

    # get dummies ref: https://stackoverflow.com/questions/55738056/using-categorical-variables-in-statsmodels-ols-class
    df = pd.get_dummies(df, columns=['manager_effects'])
    df = pd.get_dummies(df, columns=['industry']).rename(
        fsReformatColumnNames, axis='columns')
    df = pd.get_dummies(df, columns=['income'])
    df = pd.get_dummies(df, columns=['age'])
    df = pd.get_dummies(df, columns=['education'])
    df = pd.get_dummies(df, columns=['ethnicity'])
    df = pd.get_dummies(df, columns=['state'])
    df = pd.get_dummies(df, columns=['gender'])

    df = df.rename(fsReformatColumnNames, axis='columns')

    # if dropFirstDummy:Not employed at present

    #     df.drop(columns=['manager_effects_no', 'industry_agriculture', 'income_prefer_not_to_answer',
    #                      'age_60', 'education_ged', 'ethnicity_american_indian_or_alaskan_native',
    #                      'state_alabama', 'gender_female', 'covid_impact_no_negative_impact_(or_a_positive_impact)',
    #                      'covid_ind_remote_no_increase_(or_a_decrease)', 'covid_ind_fav_online_no_more_favorable_(or_less_favorable)'])

    # help build long model formula
    print(" + ".join(list(df.columns)))

    # custom vars
    # ref: analysis_2_summary_prestige.py
    df['provider_hireability_a_nacc_nself_nother'] = df['provider_hireability_']
    df['provider_impressed_a_nacc_nself_nother'] = df['provider_impressed']
    df.drop(columns=['provider_hireability_', 'provider_impressed'])
    df = df.rename(fsImproveProviderNames, axis='columns')

    # BEGIN TODO
    sMassagedName = sMassagedName.replace('provider_hireability_1', 'provider_hireability_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_1', 'provider_impressed_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_2', 'provider_hireability_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_2', 'provider_impressed_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_3', 'provider_hireability_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_3', 'provider_impressed_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_4', 'provider_hireability_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_4', 'provider_impressed_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_5', 'provider_impressed_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_5', 'provider_hireability_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_6', 'provider_impressed_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_6', 'provider_hireability_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_7', 'provider_impressed_h_yacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_7', 'provider_hireability_h_yacc_yself_yother')

    df['hireability_concrete_high_prestige'] = df['provider_hireability_h_yacc_yself_yother'] + df['provider_hireability_d_nacc_yself_yother']
    df['hireability_concrete_low_prestige'] = df['provider_hireability_h_yacc_yself_yother'] + df['provider_hireability_d_nacc_yself_yother']
    df['hireability_vignette_high_prestige'] = df['provider_impressed']
    df['hireability_vignette_low_prestige'] = df['provider_impressed']
    df['hireability_total_high_prestige']
    df['hireability_total_low_prestige']
    df['hireability_delta_prestige']
    # END TODO

    # TODO: booleanize heard of vars and create a sum var

    print("---")
    print("done getting data")
    print("---")
    return df

# long reg / m1: n=350, r2=0.437, ar2=0.239
m1 = '''favor_alt_creds ~
    + is_low_context
    + 1'''

# if this file executed as script
if __name__ == '__main__':
    data = getData()

    long_reg = sm.OLS.from_formula(m1, data=data).fit()
    # reg_maxar2 = sm.OLS.from_formula(m3, data=data).fit()
#     # robust = sm.RLM.from_formula(m9, data=data).fit()

    print(long_reg.summary())
    