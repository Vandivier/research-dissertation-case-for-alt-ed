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
    sMassagedName = sMassagedName.replace('provider_impressed_1', 'provider_impressed_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_2', 'provider_hireability_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_2', 'provider_impressed_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_3', 'provider_hireability_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_3', 'provider_impressed_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_4', 'provider_hireability_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_4', 'provider_impressed_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_5', 'provider_hireability_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_5', 'provider_impressed_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hireability_6', 'provider_hireability_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_6', 'provider_impressed_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hireability_7', 'provider_hireability_h_yacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_7', 'provider_impressed_h_yacc_yself_yother')
    return sMassagedName


def fsReformatColumnNames(sColName):
    sMassagedName = sColName.replace(',', '').replace(
        ' ', '_').replace('-', '_').replace('>', '').replace('+', '').lower()
    sMassagedName = sMassagedName.replace('?', '')
    sMassagedName = sMassagedName.replace('(', '')
    sMassagedName = sMassagedName.replace(')', '')
    sMassagedName = sMassagedName.replace('.', '_')
    sMassagedName = sMassagedName.replace('_/_', '_')
    sMassagedName = sMassagedName.replace('__', '_')
    sMassagedName = sMassagedName.replace('how_impressed_would_you_be_if_you_heard_that_someone_studied_at_this_school', 'provider_impressed')
    sMassagedName = sMassagedName.replace('how_impressed_would_you_be_if_you_heard_that_someone_studied_at_', 'provider_impressed_')
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
        "It will soon become common for high school graduates to obtain alternative credentials instead of going to college.": "conventional_alt_creds",
        "When you add up the pros and cons for online education, it's probably a good thing for society overall.": "favor_online_ed",
        "Which of these industries most closely matches your profession?": "industry",
        "Gender?": "gender",
        "Household Income?": "income",
        "Age?": "age",
        "What is the highest level of education you have completed?": "education",
        "Which race/ethnicity best describes you? (Please choose only one.) ": "ethnicity",
        "What state do you reside in?": "state",
        "What is the name of a reputable certification or non-college credential in your profession? Use “n/a” if nothing comes to mind.": "named_credential",
        "I prefer to hire or work with a person that has a college degree rather a person that holds a reputable certification or non-college credential.": "cat_prefer_degree",
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
    df = pd.get_dummies(df, columns=['cat_prefer_degree'])

    df = df.rename(fsReformatColumnNames, axis='columns')

    if dropFirstDummy:

        df.drop(columns=['manager_effects_not_employed_at_present', 'industry_agriculture', 'income_prefer_not_to_answer',
                         'age_60', 'education_ged', 'ethnicity_american_indian_or_alaskan_native',
                         'state_alabama', 'gender_other'])

    # help build long model formula
    print(" + ".join(list(df.columns)))

    # custom vars
    # ref: analysis_2_summary_prestige.py
    df['provider_hireability_a_nacc_nself_nother'] = df['provider_hireability_']
    df['provider_impressed_a_nacc_nself_nother'] = df['provider_impressed']
    df.drop(columns=['provider_hireability_', 'provider_impressed'])
    df = df.rename(fsImproveProviderNames, axis='columns')

    df['hireability_concrete_high_prestige'] = (df['provider_impressed_california_institute_of_technology'] + df['provider_impressed_university_of_chicago']
        + df['provider_impressed_app_academy'] + df['provider_impressed_general_assembly'] + df['provider_impressed_google'])/5
    df['hireability_concrete_low_prestige'] = (df['provider_impressed_portland_state_university'] + df['provider_impressed_university_of_nebraska_omaha']
        + df['provider_impressed_fvi_school_of_technology'] + df['provider_impressed_bov_academy'])/4
    df['hireability_vignette_high_prestige'] = (df['provider_hireability_d_nacc_yself_yother'] + df['provider_hireability_h_yacc_yself_yother'])/2
    df['hireability_vignette_low_prestige'] = (df['provider_hireability_a_nacc_nself_nother'] + df['provider_hireability_e_yacc_nself_nother'])/2
    df['hireability_total_high_prestige'] = (df['hireability_concrete_high_prestige'] + df['hireability_vignette_high_prestige'])/2
    df['hireability_total_low_prestige'] = (df['hireability_concrete_low_prestige'] + df['hireability_vignette_low_prestige'])/2
    df['hireability_delta_prestige'] = df['hireability_total_high_prestige'] - df['hireability_total_low_prestige']

    df['hireability_concrete_accredited'] = (df['provider_impressed_california_institute_of_technology'] + df['provider_impressed_university_of_chicago']
        + df['provider_impressed_portland_state_university'] + df['provider_impressed_university_of_nebraska_omaha'])/4
    df['hireability_concrete_unaccredited'] = (df['provider_impressed_app_academy'] + df['provider_impressed_general_assembly'] + df['provider_impressed_google']
        + df['provider_impressed_fvi_school_of_technology'] + df['provider_impressed_bov_academy'])/5
    df['hireability_vignette_accredited'] = (df['provider_hireability_e_yacc_nself_nother'] + df['provider_hireability_h_yacc_yself_yother'])/2
    df['hireability_vignette_unaccredited'] = (df['provider_hireability_a_nacc_nself_nother'] + df['provider_hireability_d_nacc_yself_yother'])/2
    df['hireability_total_accredited'] = (df['hireability_concrete_accredited'] + df['hireability_vignette_accredited'])/2
    df['hireability_total_unaccredited'] = (df['hireability_concrete_unaccredited'] + df['hireability_vignette_unaccredited'])/2
    df['hireability_delta_accreditation'] = df['hireability_total_accredited'] - df['hireability_total_unaccredited']

    # TODO: booleanize heard of vars and create a sum var

    print("---")
    print("done getting data")
    print("---")
    return df

# if this file executed as script
if __name__ == '__main__':
    getData()