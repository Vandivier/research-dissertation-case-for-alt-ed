# ref: alt-ed-covid-2...analysis_1_vars_and_regression.py
# ref: alt-ed-matching-effects-2...analysis_1_vars_and_regression.py

import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm
from statsmodels.iolib.summary2 import summary_col

def fsImproveProviderNames(sColName):
    sMassagedName = sColName
    sMassagedName = sMassagedName.replace('provider_hirability_1', 'provider_hirability_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_1', 'provider_impressed_b_nacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hirability_2', 'provider_hirability_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_2', 'provider_impressed_c_nacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hirability_3', 'provider_hirability_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_3', 'provider_impressed_d_nacc_yself_yother')
    sMassagedName = sMassagedName.replace('provider_hirability_4', 'provider_hirability_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_4', 'provider_impressed_e_yacc_nself_nother')
    sMassagedName = sMassagedName.replace('provider_hirability_5', 'provider_hirability_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_impressed_5', 'provider_impressed_f_yacc_nself_yother')
    sMassagedName = sMassagedName.replace('provider_hirability_6', 'provider_hirability_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_impressed_6', 'provider_impressed_g_yacc_yself_nother')
    sMassagedName = sMassagedName.replace('provider_hirability_7', 'provider_hirability_h_yacc_yself_yother')
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
    sMassagedName = sMassagedName.replace('for_many_professions_learning_at_this_school_can_qualify_a_person_for_an_entry_level_position', 'provider_hirability')
    return sMassagedName


def getData(dropFirstDummy=True):
    df = pd.read_csv('prestige-hidden.csv')
    # ref: https://stackoverflow.com/a/51428632/3931488
    print(df.columns)

    # df.replace(to_replace="Not employed at present", value="a", inplace=True)
    # df.replace(to_replace="I usually spend more time with customers and external business partners than with coworkers.", value="b", inplace=True)
    # df.replace(to_replace="I usually spend at least an hour each day with customers and external business partners.", value="c", inplace=True)
    # df.replace(to_replace="I usually spend less than an hour each day in direct contact with customers and external business partners.", value="d", inplace=True)
    # df = df.replace("Not employed at present", "a")
    # df = df.replace("I usually spend more time with customers and external business partners than with coworkers.", "b")
    # df = df.replace("I usually spend at least an hour each day with customers and external business partners.", "c")
    # df = df.replace("I usually spend less than an hour each day in direct contact with customers and external business partners.", "d")

    df.rename(columns={
        "Do you contribute to hiring and firing decisions at your company?": "manager_effects",
        "For many professions, alternative credentials can qualify a person for an entry-level position.": "baseline_hirability", # aka favorability
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
    
    df['cat_work_with_external_partners_a'] = df['work_with_external_partners'].str.contains('Not employed at present')
    df['cat_work_with_external_partners_b'] = df['work_with_external_partners'].str.contains('I usually spend more time with customers and external business partners than with coworkers.')
    df['cat_work_with_external_partners_c'] = df['work_with_external_partners'].str.contains('I usually spend at least an hour each day with customers and external business partners.')
    df['cat_work_with_external_partners_d'] = df['work_with_external_partners'].str.contains('I usually spend less than an hour each day in direct contact with customers and external business partners.')

    df = df.rename(fsReformatColumnNames, axis='columns')

    if dropFirstDummy:
        df.drop(columns=['manager_effects_not_employed_at_present', 'industry_agriculture', 'income_prefer_not_to_answer',
                         'age_60', 'education_ged', 'ethnicity_american_indian_or_alaskan_native',
                         'state_alabama', 'gender_other'])

    # help build long model formula
    print(" + ".join(list(df.columns)))

    # custom vars
    # ref: analysis_2_summary_prestige.py
    df['provider_hirability_a_nacc_nself_nother'] = df['provider_hirability_']
    df['provider_impressed_a_nacc_nself_nother'] = df['provider_impressed']
    df.drop(columns=['provider_hirability_', 'provider_impressed'])
    df = df.rename(fsImproveProviderNames, axis='columns')

    df['hireability_concrete_high_prestige'] = (df['provider_impressed_california_institute_of_technology'] + df['provider_impressed_university_of_chicago']
        + df['provider_impressed_app_academy'] + df['provider_impressed_general_assembly'] + df['provider_impressed_google'])/5
    df['hireability_concrete_low_prestige'] = (df['provider_impressed_portland_state_university'] + df['provider_impressed_university_of_nebraska_omaha']
        + df['provider_impressed_fvi_school_of_technology'] + df['provider_impressed_bov_academy'])/4
    df['hireability_vignette_high_prestige'] = (df['provider_hirability_d_nacc_yself_yother'] + df['provider_hirability_h_yacc_yself_yother'])/2
    df['hireability_vignette_low_prestige'] = (df['provider_hirability_a_nacc_nself_nother'] + df['provider_hirability_e_yacc_nself_nother'])/2
    df['hireability_total_high_prestige'] = (df['hireability_concrete_high_prestige'] + df['hireability_vignette_high_prestige'])/2
    df['hireability_total_low_prestige'] = (df['hireability_concrete_low_prestige'] + df['hireability_vignette_low_prestige'])/2
    df['hireability_delta_prestige'] = df['hireability_total_high_prestige'] - df['hireability_total_low_prestige']

    df['hireability_concrete_accredited'] = (df['provider_impressed_california_institute_of_technology'] + df['provider_impressed_university_of_chicago']
        + df['provider_impressed_portland_state_university'] + df['provider_impressed_university_of_nebraska_omaha'])/4
    df['hireability_concrete_unaccredited'] = (df['provider_impressed_app_academy'] + df['provider_impressed_general_assembly'] + df['provider_impressed_google']
        + df['provider_impressed_fvi_school_of_technology'] + df['provider_impressed_bov_academy'])/5
    df['hireability_vignette_accredited'] = (df['provider_hirability_e_yacc_nself_nother'] + df['provider_hirability_h_yacc_yself_yother'])/2
    df['hireability_vignette_unaccredited'] = (df['provider_hirability_a_nacc_nself_nother'] + df['provider_hirability_d_nacc_yself_yother'])/2
    df['hireability_total_accredited'] = (df['hireability_concrete_accredited'] + df['hireability_vignette_accredited'])/2
    df['hireability_total_unaccredited'] = (df['hireability_concrete_unaccredited'] + df['hireability_vignette_unaccredited'])/2
    df['hireability_delta_accreditation'] = df['hireability_total_accredited'] - df['hireability_total_unaccredited']
    
    # this factor is same as revealed_preference_cat_prefer_degree but no google
    # from a consumer process perspective, the user picks a top-knotch bootcamp on an aggregator site (rating > 4/5 w 100+ reviews)
    df['prefer_alt_cred_revealed_high_v_low_no_goog'] = df.eval('False'
            + ' or provider_impressed_app_academy > provider_impressed_portland_state_university'
            + ' or provider_impressed_app_academy > provider_impressed_university_of_nebraska_omaha'
            + ' or provider_impressed_general_assembly > provider_impressed_portland_state_university'
            + ' or provider_impressed_general_assembly > provider_impressed_university_of_nebraska_omaha'
            + '').astype(int)

    # # this is a revealed or ecological preference
    # # it is more clear than the plain cat_prefer_degree_false
    # # they can also cross-reference each other as a robustness check
    # # this permissive check is 'if any high-quality alt cred is preferred to any low quality school'
    # consumer process perspective, user takes the best creds even outside of an aggregator; more difficult;
    #   can be accomplished by consulting hiring managers, industry employees, other experts, and extensive research
    df['prefer_alt_cred_revealed_high_v_low'] = df.eval('prefer_alt_cred_revealed_high_v_low_no_goog'
            + ' or provider_impressed_google > provider_impressed_portland_state_university'
            + ' or provider_impressed_google > provider_impressed_university_of_nebraska_omaha'
            + '').astype(int)

    # high v high demonstrates that some employers, although rare, prefer creds to prestigious universities
    # from a functional perspective this supports the 'job search as a numbers game' process
    #   the candidate must consult a large number of employers and will have a low chance of success, but eventually find high employer support
    df['prefer_alt_cred_revealed_high_v_high'] = df.eval('False'
            + ' or provider_impressed_app_academy > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_app_academy > provider_impressed_university_of_chicago'
            + ' or provider_impressed_general_assembly > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_general_assembly > provider_impressed_university_of_chicago'
            + ' or provider_impressed_google > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_google > provider_impressed_university_of_chicago'
            + '').astype(int)

    # high v high no goog reflects process just aggregator consult
    df['prefer_alt_cred_revealed_high_v_high_no_goog'] = df.eval('False'
            + ' or provider_impressed_app_academy > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_app_academy > provider_impressed_university_of_chicago'
            + ' or provider_impressed_general_assembly > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_general_assembly > provider_impressed_university_of_chicago'
            + '').astype(int)

    # # this is even more permissive; if any alt cred is preferred to any school
    # # why might this happen?
    # # 1. general distaste for accredited education or occasional distaste for a specific school
    # # 2. general favorability to alternative credentials or occasional high favor to specific credentials (esp google)
    # # 3. improper distorted perception; eg naming effects appear important.
    # #   eg many ppl highly rated p_fvi_school_of_technology - seems due to naming effects; caltech improperly higher than chicago too
    df['prefer_alt_cred_revealed'] = df.eval('False'
            + ' or provider_impressed_google > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_google > provider_impressed_university_of_chicago'
            + ' or provider_impressed_google > provider_impressed_portland_state_university'
            + ' or provider_impressed_google > provider_impressed_university_of_nebraska_omaha'
            + ''
            + ' or provider_impressed_app_academy > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_app_academy > provider_impressed_university_of_chicago'
            + ' or provider_impressed_app_academy > provider_impressed_portland_state_university'
            + ' or provider_impressed_app_academy > provider_impressed_university_of_nebraska_omaha'
            + ''
            + ' or provider_impressed_general_assembly > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_general_assembly > provider_impressed_university_of_chicago'
            + ' or provider_impressed_general_assembly > provider_impressed_portland_state_university'
            + ' or provider_impressed_general_assembly > provider_impressed_university_of_nebraska_omaha'
            + ''
            + ' or provider_impressed_bov_academy > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_bov_academy > provider_impressed_university_of_chicago'
            + ' or provider_impressed_bov_academy > provider_impressed_portland_state_university'
            + ' or provider_impressed_bov_academy > provider_impressed_university_of_nebraska_omaha'
            + ''
            + ' or provider_impressed_fvi_school_of_technology > provider_impressed_california_institute_of_technology'
            + ' or provider_impressed_fvi_school_of_technology > provider_impressed_university_of_chicago'
            + ' or provider_impressed_fvi_school_of_technology > provider_impressed_portland_state_university'
            + ' or provider_impressed_fvi_school_of_technology > provider_impressed_university_of_nebraska_omaha'
            + '').astype(int)

    df['prefer_alt_cred_espoused_weakly'] = df.eval('cat_prefer_degree_false == 1').astype(int)

    # TODO: maybe booleanize heard of vars and create a sum var

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
    # baseline_hirability = hirability for non-actual & non-vignette (eg, baseline) records
    dfNew['hirability'] = []
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
        observationSectionOne.at['hirability'] = observationSectionOne.at['baseline_hirability']

        observationCalTech = row.copy()
        observationCalTech.at['is_concrete'] = 1
        observationCalTech.at['is_vignette'] = 0
        observationCalTech.at['is_accredited'] = 1
        observationCalTech.at['is_reiterated_unaccredited'] = 0
        observationCalTech.at['is_stipulated_other_impressed'] = 1
        observationCalTech.at['is_stipulated_self_impressed'] = 1
        observationCalTech.at['prestige_own'] = observationCalTech.at['provider_impressed_california_institute_of_technology']

        observationChicago = row.copy()
        observationChicago.at['is_concrete'] = 1
        observationChicago.at['is_vignette'] = 0
        observationChicago.at['is_accredited'] = 1
        observationChicago.at['is_reiterated_unaccredited'] = 0
        observationChicago.at['is_stipulated_other_impressed'] = 1
        observationChicago.at['is_stipulated_self_impressed'] = 1
        observationChicago.at['prestige_own'] = observationChicago.at['provider_impressed_university_of_chicago']

        observationPsu = row.copy()
        observationPsu.at['is_concrete'] = 1
        observationPsu.at['is_vignette'] = 0
        observationPsu.at['is_accredited'] = 1
        observationPsu.at['is_reiterated_unaccredited'] = 0
        observationPsu.at['is_stipulated_other_impressed'] = 0
        observationPsu.at['is_stipulated_self_impressed'] = 0
        observationPsu.at['prestige_own'] = observationPsu.at['provider_impressed_portland_state_university']

        observationUno = row.copy()
        observationUno.at['is_concrete'] = 1
        observationUno.at['is_vignette'] = 0
        observationUno.at['is_accredited'] = 1
        observationUno.at['is_reiterated_unaccredited'] = 0
        observationUno.at['is_stipulated_other_impressed'] = 0
        observationUno.at['is_stipulated_self_impressed'] = 0
        observationUno.at['prestige_own'] = observationUno.at['provider_impressed_university_of_nebraska_omaha']

        observationAppAcademy = row.copy()
        observationAppAcademy.at['is_concrete'] = 1
        observationAppAcademy.at['is_vignette'] = 0
        observationAppAcademy.at['is_accredited'] = 0
        observationAppAcademy.at['is_reiterated_unaccredited'] = 1
        observationAppAcademy.at['is_stipulated_other_impressed'] = 1
        observationAppAcademy.at['is_stipulated_self_impressed'] = 1
        observationAppAcademy.at['prestige_own'] = observationAppAcademy.at['provider_impressed_app_academy']

        observationGenAssembly = row.copy()
        observationGenAssembly.at['is_concrete'] = 1
        observationGenAssembly.at['is_vignette'] = 0
        observationGenAssembly.at['is_accredited'] = 0
        observationGenAssembly.at['is_reiterated_unaccredited'] = 1
        observationGenAssembly.at['is_stipulated_other_impressed'] = 1
        observationGenAssembly.at['is_stipulated_self_impressed'] = 1
        observationGenAssembly.at['prestige_own'] = observationGenAssembly.at['provider_impressed_general_assembly']

        observationFviTech = row.copy()
        observationFviTech.at['is_concrete'] = 1
        observationFviTech.at['is_vignette'] = 0
        observationFviTech.at['is_accredited'] = 0
        observationFviTech.at['is_reiterated_unaccredited'] = 1
        observationFviTech.at['is_stipulated_other_impressed'] = 0
        observationFviTech.at['is_stipulated_self_impressed'] = 0
        observationFviTech.at['prestige_own'] = observationFviTech.at['provider_impressed_fvi_school_of_technology']

        observationBov = row.copy()
        observationBov.at['is_concrete'] = 1
        observationBov.at['is_vignette'] = 0
        observationBov.at['is_accredited'] = 0
        observationBov.at['is_reiterated_unaccredited'] = 1
        observationBov.at['is_stipulated_other_impressed'] = 0
        observationBov.at['is_stipulated_self_impressed'] = 0
        observationBov.at['prestige_own'] = observationBov.at['provider_impressed_bov_academy']

        observationGoogle = row.copy()
        observationGoogle.at['is_concrete'] = 1
        observationGoogle.at['is_vignette'] = 0
        observationGoogle.at['is_accredited'] = 0
        observationGoogle.at['is_reiterated_unaccredited'] = 1
        observationGoogle.at['is_stipulated_other_impressed'] = 1
        observationGoogle.at['is_stipulated_self_impressed'] = 1
        observationGoogle.at['prestige_own'] = observationGoogle.at['provider_impressed_google']

        observation_a_nacc_nself_nother = row.copy()
        observation_a_nacc_nself_nother.at['is_concrete'] = 0
        observation_a_nacc_nself_nother.at['is_vignette'] = 1
        observation_a_nacc_nself_nother.at['is_accredited'] = 0
        observation_a_nacc_nself_nother.at['is_reiterated_unaccredited'] = 1
        observation_a_nacc_nself_nother.at['is_stipulated_other_impressed'] = 0
        observation_a_nacc_nself_nother.at['is_stipulated_self_impressed'] = 0
        observation_a_nacc_nself_nother.at['prestige_own'] = observation_a_nacc_nself_nother.at['provider_impressed_a_nacc_nself_nother']
        observation_a_nacc_nself_nother.at['hirability'] = observation_a_nacc_nself_nother.at['provider_hirability_a_nacc_nself_nother']

        observation_b_nacc_nself_yother = row.copy()
        observation_b_nacc_nself_yother.at['is_concrete'] = 0
        observation_b_nacc_nself_yother.at['is_vignette'] = 1
        observation_b_nacc_nself_yother.at['is_accredited'] = 0
        observation_b_nacc_nself_yother.at['is_reiterated_unaccredited'] = 1
        observation_b_nacc_nself_yother.at['is_stipulated_other_impressed'] = 1
        observation_b_nacc_nself_yother.at['is_stipulated_self_impressed'] = 0
        observation_b_nacc_nself_yother.at['prestige_own'] = observation_b_nacc_nself_yother.at['provider_impressed_b_nacc_nself_yother']
        observation_b_nacc_nself_yother.at['hirability'] = observation_b_nacc_nself_yother.at['provider_hirability_b_nacc_nself_yother']

        observation_c_nacc_yself_nother = row.copy()
        observation_c_nacc_yself_nother.at['is_concrete'] = 0
        observation_c_nacc_yself_nother.at['is_vignette'] = 1
        observation_c_nacc_yself_nother.at['is_accredited'] = 0
        observation_c_nacc_yself_nother.at['is_reiterated_unaccredited'] = 1
        observation_c_nacc_yself_nother.at['is_stipulated_other_impressed'] = 0
        observation_c_nacc_yself_nother.at['is_stipulated_self_impressed'] = 1
        observation_c_nacc_yself_nother.at['prestige_own'] = observation_c_nacc_yself_nother.at['provider_impressed_c_nacc_yself_nother']
        observation_c_nacc_yself_nother.at['hirability'] = observation_c_nacc_yself_nother.at['provider_hirability_c_nacc_yself_nother']

        observation_d_nacc_yself_nother = row.copy()
        observation_d_nacc_yself_nother.at['is_concrete'] = 0
        observation_d_nacc_yself_nother.at['is_vignette'] = 1
        observation_d_nacc_yself_nother.at['is_accredited'] = 0
        observation_d_nacc_yself_nother.at['is_reiterated_unaccredited'] = 1
        observation_d_nacc_yself_nother.at['is_stipulated_other_impressed'] = 1
        observation_d_nacc_yself_nother.at['is_stipulated_self_impressed'] = 1
        observation_d_nacc_yself_nother.at['prestige_own'] = observation_d_nacc_yself_nother.at['provider_impressed_d_nacc_yself_yother']
        observation_d_nacc_yself_nother.at['hirability'] = observation_d_nacc_yself_nother.at['provider_hirability_d_nacc_yself_yother']

        observation_e_yacc_nself_nother = row.copy()
        observation_e_yacc_nself_nother.at['is_concrete'] = 0
        observation_e_yacc_nself_nother.at['is_vignette'] = 1
        observation_e_yacc_nself_nother.at['is_accredited'] = 1
        observation_e_yacc_nself_nother.at['is_reiterated_unaccredited'] = 0
        observation_e_yacc_nself_nother.at['is_stipulated_other_impressed'] = 0
        observation_e_yacc_nself_nother.at['is_stipulated_self_impressed'] = 0
        observation_e_yacc_nself_nother.at['prestige_own'] = observation_e_yacc_nself_nother.at['provider_impressed_e_yacc_nself_nother']
        observation_e_yacc_nself_nother.at['hirability'] = observation_e_yacc_nself_nother.at['provider_hirability_e_yacc_nself_nother']

        observation_f_yacc_nself_yother = row.copy()
        observation_f_yacc_nself_yother.at['is_concrete'] = 0
        observation_f_yacc_nself_yother.at['is_vignette'] = 1
        observation_f_yacc_nself_yother.at['is_accredited'] = 1
        observation_f_yacc_nself_yother.at['is_reiterated_unaccredited'] = 0
        observation_f_yacc_nself_yother.at['is_stipulated_other_impressed'] = 1
        observation_f_yacc_nself_yother.at['is_stipulated_self_impressed'] = 0
        observation_f_yacc_nself_yother.at['prestige_own'] = observation_f_yacc_nself_yother.at['provider_impressed_f_yacc_nself_yother']
        observation_f_yacc_nself_yother.at['hirability'] = observation_f_yacc_nself_yother.at['provider_hirability_f_yacc_nself_yother']

        observation_g_yacc_yself_nother = row.copy()
        observation_g_yacc_yself_nother.at['is_concrete'] = 0
        observation_g_yacc_yself_nother.at['is_vignette'] = 1
        observation_g_yacc_yself_nother.at['is_accredited'] = 1
        observation_g_yacc_yself_nother.at['is_reiterated_unaccredited'] = 0
        observation_g_yacc_yself_nother.at['is_stipulated_other_impressed'] = 0
        observation_g_yacc_yself_nother.at['is_stipulated_self_impressed'] = 1
        observation_g_yacc_yself_nother.at['prestige_own'] = observation_g_yacc_yself_nother.at['provider_impressed_g_yacc_yself_nother']
        observation_g_yacc_yself_nother.at['hirability'] = observation_g_yacc_yself_nother.at['provider_hirability_g_yacc_yself_nother']
        
        observation_h_yacc_yself_yother = row.copy()
        observation_h_yacc_yself_yother.at['is_concrete'] = 0
        observation_h_yacc_yself_yother.at['is_vignette'] = 1
        observation_h_yacc_yself_yother.at['is_accredited'] = 1
        observation_h_yacc_yself_yother.at['is_reiterated_unaccredited'] = 0
        observation_h_yacc_yself_yother.at['is_stipulated_other_impressed'] = 1
        observation_h_yacc_yself_yother.at['is_stipulated_self_impressed'] = 1
        observation_h_yacc_yself_yother.at['prestige_own'] = observation_h_yacc_yself_yother.at['provider_impressed_h_yacc_yself_yother']
        observation_h_yacc_yself_yother.at['hirability'] = observation_h_yacc_yself_yother.at['provider_hirability_h_yacc_yself_yother']

        newRows = [observationSectionOne, observationCalTech, observationChicago, observationPsu, observationUno,
            observationAppAcademy, observationGenAssembly, observationFviTech, observationBov, observationGoogle,
            observation_a_nacc_nself_nother, observation_b_nacc_nself_yother, observation_c_nacc_yself_nother, observation_d_nacc_yself_nother,
            observation_e_yacc_nself_nother, observation_f_yacc_nself_yother, observation_g_yacc_yself_nother, observation_h_yacc_yself_yother]

        dfNew = dfNew.append(newRows, ignore_index=True)

        # TODO: del column, don't drop https://stackoverflow.com/questions/13411544/delete-column-from-pandas-dataframe
        dfNew.drop(columns=[
            'provider_impressed_california_institute_of_technology',
            'provider_hirability_a_nacc_nself_nother', 'provider_impressed_a_nacc_nself_nother',
            'provider_hirability_b_nacc_nself_yother', 'provider_impressed_b_nacc_nself_yother',
            'provider_hirability_c_nacc_yself_nother', 'provider_impressed_c_nacc_yself_nother',
            'provider_hirability_d_nacc_yself_yother', 'provider_impressed_d_nacc_yself_yother',
            'provider_hirability_e_yacc_nself_nother', 'provider_impressed_e_yacc_nself_nother', 
            'provider_hirability_f_yacc_nself_yother', 'provider_impressed_f_yacc_nself_yother',
            'provider_hirability_g_yacc_yself_nother', 'provider_impressed_g_yacc_yself_nother',
            'provider_hirability_h_yacc_yself_yother', 'provider_impressed_h_yacc_yself_yother',
        ])

    # dfNew['is_high_prestige'] = dfNew['is_high_other_prestige'] * dfNew['is_high_prestige']
    # dfNew['is_low_prestige'] = dfNew['is_low_other_prestige'] * dfNew['is_low_prestige']
    dfNew['is_high_prestige'] = dfNew['is_stipulated_other_impressed'] * dfNew['is_stipulated_self_impressed']
    # dfNew['is_crude_aggregated_prestige'] = dfNew['is_stipulated_other_impressed'] + dfNew['is_stipulated_self_impressed']
    dfNew['is_low_prestige'] = (dfNew['is_stipulated_other_impressed'] == 0) & (dfNew['is_stipulated_self_impressed'] == 0)

    dfNew['is_low_context_and_accredited'] = dfNew['is_low_context'] * dfNew['is_accredited']
    dfNew['is_low_context_and_fvi'] = dfNew['is_low_context'] * dfNew['provider_impressed_fvi_school_of_technology']

    print('dfNew len = ' + str(len(dfNew.index)))
    print('---')
    return dfNew


def getVignetteData(df: pd.DataFrame = None) -> pd.DataFrame:
    if df is None:
        df = getPanelizedData()

    dfNew = df[df.is_vignette == 1]
    dfNew = dfNew[dfNew.hirability > 0]
    dfNew = dfNew[dfNew.prestige_own > 0]
    print('getVignetteData dfNew len = ' + str(len(dfNew.index)))
    print('---')
    return dfNew


def getConcreteData(df: pd.DataFrame = None) -> pd.DataFrame:
    if df is None:
        df = getPanelizedData()

    dfNew = df[df.is_concrete == 1]
    # uncomment below line to get 0 records; this is good bc concrete has no hirability
    # dfNew = dfNew[dfNew.hirability > 0]
    dfNew = dfNew[dfNew.prestige_own > 0]
    print('getConcreteData dfNew len = ' + str(len(dfNew.index)))
    print('---')
    return dfNew


# if this file executed as script
# dump to file to assist validation
if __name__ == '__main__':
    df = getPanelizedData()
    df.to_csv('prestige-postprocess-hidden.csv')
