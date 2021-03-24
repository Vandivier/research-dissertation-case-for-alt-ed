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

# https://en.wikipedia.org/wiki/Panel_data
# this is basically wrangling a cross-sectional panel
def getPanelizedData():
    df = getData()

    # section 1 hireability on alternative credentials in general is_unaccredited,
    # and this is communicated to respondents.
    # i expect/hope is_reiterated_unaccredited is insignificant; that is in section 2, 3
    dfNew = df[0:0]
    dfNew['is_concrete'] = []
    dfNew['is_vignette'] = []
    dfNew['is_accredited'] = []
    dfNew['is_reiterated_unaccredited'] = []
    dfNew['prestige_other'] = []
    dfNew['prestige_own'] = []
    dfNew['is_high_other_prestige'] = []
    dfNew['is_high_own_prestige'] = []
    dfNew['is_high_prestige'] = []
    dfNew['is_low_other_prestige'] = []
    dfNew['is_low_own_prestige'] = []
    dfNew['is_low_prestige'] = []

    # TODO: I'm not using name recognition for now, but I will check it out as a follow-on study
    #   OR, if current study doesn't present expected result (prestige ~=||> accreditation) 
    # TODO: future study, external quality data; name recognition and quality for when is_concrete
    # TODO: future study, internal name recognition (heard of) instead of external name recognition
    # TODO: future study, are own prestige, perceived other prestige, and actual other prestige correlated? shouldn't they be in an efficient economy?
    # internal_name_recognition
    # external_name_recognition

    # Each raw response is folded into 18 cross-sectional panel observations.
    # TODO: I guess itertouples is preferred but having trouble doing that or seeing perf benefit w named tuples
    for index, row in df.iterrows():
        observationSectionOne = row.copy()
        observationSectionOne.at['is_concrete'] = 0
        observationSectionOne.at['is_vignette'] = 0
        observationSectionOne.at['is_accredited'] = 0
        observationSectionOne.at['is_reiterated_unaccredited'] = 0
        # observationSectionOne.at['prestige_other'] = []
        # observationSectionOne.at['prestige_own'] = []
        # observationSectionOne.at['is_high_other_prestige'] = []
        # observationSectionOne.at['is_high_own_prestige'] = []
        # observationSectionOne.at['is_high_prestige'] = []
        # observationSectionOne.at['is_low_other_prestige'] = []
        # observationSectionOne.at['is_low_own_prestige'] = []
        # observationSectionOne.at['is_low_prestige'] = []

        observationCalTech = row.copy()
        observationCalTech.at['is_concrete'] = 1
        observationCalTech.at['is_vignette'] = 0
        observationCalTech.at['is_accredited'] = 1
        observationCalTech.at['is_reiterated_unaccredited'] = 0
        observationCalTech.at['prestige_own'] = observationCalTech.at['provider_impressed_california_institute_of_technology']

        observationChicago = row.copy()
        observationChicago.at['is_concrete'] = 1
        observationChicago.at['is_vignette'] = 0
        observationChicago.at['is_accredited'] = 1
        observationChicago.at['is_reiterated_unaccredited'] = 0
        observationChicago.at['prestige_own'] = observationChicago.at['provider_impressed_university_of_chicago']

        observationPsu = row.copy()
        observationPsu.at['is_concrete'] = 1
        observationPsu.at['is_vignette'] = 0
        observationPsu.at['is_accredited'] = 1
        observationPsu.at['is_reiterated_unaccredited'] = 0
        observationPsu.at['prestige_own'] = observationPsu.at['provider_impressed_portland_state_university']

        observationUno = row.copy()
        observationUno.at['is_concrete'] = 1
        observationUno.at['is_vignette'] = 0
        observationUno.at['is_accredited'] = 1
        observationUno.at['is_reiterated_unaccredited'] = 0
        observationUno.at['prestige_own'] = observationUno.at['provider_impressed_university_of_nebraska_omaha']

        observationAppAcademy = row.copy()
        observationAppAcademy.at['is_concrete'] = 1
        observationAppAcademy.at['is_vignette'] = 0
        observationAppAcademy.at['is_accredited'] = 0
        observationAppAcademy.at['is_reiterated_unaccredited'] = 1
        observationAppAcademy.at['prestige_own'] = observationAppAcademy.at['provider_impressed_app_academy']

        observationGenAssembly = row.copy()
        observationGenAssembly.at['is_concrete'] = 1
        observationGenAssembly.at['is_vignette'] = 0
        observationGenAssembly.at['is_accredited'] = 0
        observationGenAssembly.at['is_reiterated_unaccredited'] = 1
        observationGenAssembly.at['prestige_own'] = observationGenAssembly.at['provider_impressed_general_assembly']

        observationFviTech = row.copy()
        observationFviTech.at['is_concrete'] = 1
        observationFviTech.at['is_vignette'] = 0
        observationFviTech.at['is_accredited'] = 0
        observationFviTech.at['is_reiterated_unaccredited'] = 1
        observationFviTech.at['prestige_own'] = observationFviTech.at['provider_impressed_fvi_school_of_technology']

        observationBov = row.copy()
        observationBov.at['is_concrete'] = 1
        observationBov.at['is_vignette'] = 0
        observationBov.at['is_accredited'] = 0
        observationBov.at['is_reiterated_unaccredited'] = 1
        observationBov.at['prestige_own'] = observationBov.at['provider_impressed_bov_academy']

        observationGoogle = row.copy()
        observationGoogle.at['is_concrete'] = 1
        observationGoogle.at['is_vignette'] = 0
        observationGoogle.at['is_accredited'] = 0
        observationGoogle.at['is_reiterated_unaccredited'] = 1
        observationGoogle.at['prestige_own'] = observationGoogle.at['provider_impressed_google']

        observation_a_nacc_nself_nother = row.copy()
        observationSectionOne.at['is_concrete'] = 0
        observationSectionOne.at['is_vignette'] = 1
        observationSectionOne.at['is_accredited'] = 0
        observationSectionOne.at['is_reiterated_unaccredited'] = 0
        observationSectionOne.at['is_stipulated_other_impressed'] = 0
        observationSectionOne.at['is_stipulated_self_impressed'] = 0
        observationSectionOne.at['prestige_own'] = observationSectionOne.at['provider_impressed_a_nacc_nself_nother']
        observationSectionOne.at['hireability'] = observationSectionOne.at['provider_hireability_a_nacc_nself_nother']

        observation_b_nacc_nself_yother = row.copy()

        observation_c_nacc_yself_nother = row.copy()

        observation_d_nacc_yself_yother = row.copy()

        observation_e_yacc_nself_nother = row.copy()

        observation_f_yacc_nself_yother = row.copy()

        observation_g_yacc_yself_nother = row.copy()
        
        observation_h_yacc_yself_yother = row.copy()

        newRows = [observationSectionOne, observationCalTech, observationChicago, observationPsu, observationUno,
            observationAppAcademy, observationGenAssembly, observationFviTech, observationBov, observationGoogle,
            observation_a_nacc_nself_nother, observation_b_nacc_nself_yother, observation_c_nacc_yself_nother, observation_d_nacc_yself_yother,
            observation_e_yacc_nself_nother, observation_f_yacc_nself_yother, observation_g_yacc_yself_nother, observation_h_yacc_yself_yother]

        dfNew = dfNew.append(newRows, ignore_index=True)

        # TODO: del column, don't drop https://stackoverflow.com/questions/13411544/delete-column-from-pandas-dataframe
        dfNew.drop(columns=[
            'provider_impressed_california_institute_of_technology',
            'provider_hireability_a_nacc_nself_nother', 'provider_impressed_a_nacc_nself_nother',
            'provider_hireability_b_nacc_nself_yother', 'provider_impressed_b_nacc_nself_yother',
            'provider_hireability_c_nacc_yself_nother', 'provider_impressed_c_nacc_yself_nother',
            'provider_hireability_d_nacc_yself_yother', 'provider_impressed_d_nacc_yself_yother',
            'provider_hireability_e_yacc_nself_nother', 'provider_impressed_e_yacc_nself_nother', 
            'provider_hireability_f_yacc_nself_yother', 'provider_impressed_f_yacc_nself_yother',
            'provider_hireability_g_yacc_yself_nother', 'provider_impressed_g_yacc_yself_nother',
            'provider_hireability_h_yacc_yself_yother', 'provider_impressed_h_yacc_yself_yother',
        ])
            
    dfNew['is_high_prestige'] = 1 if dfNew['is_high_other_prestige'] + dfNew['is_high_prestige'] == 2 else 0
    dfNew['is_low_prestige'] = 1 if dfNew['is_low_other_prestige'] + dfNew['is_low_prestige'] == 2 else 0

    print('dfNew len = ' + str(len(dfNew.index)))
    print('---')
    return dfNew


# if this file executed as script
# dump to file to assist validation
if __name__ == '__main__':
    df = getPanelizedData()
    df.to_csv('prestige-postprocess-hidden.csv')
