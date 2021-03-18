# Q13 and Q14 are factors of interest

import statsmodels.api as sm
import analysis_1_vars as GetVars

# long reg / m1: n=454, r2=0.492, ar2=0.367
m1 = '''hireability ~ conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + work_with_external_partners
    + manager_effects_no + manager_effects_yes
    + industry_education + industry_energy + industry_finance_investment_or_accounting
        + industry_health + industry_information_technology + industry_law + industry_manufacturing + industry_military + industry_other
        + industry_real_estate + industry_retail + industry_transportation
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999
        + income_175000_199999 + income_200000 + income_25000_49999 + income_50000_74999 + income_75000_99999
    + age_18_29 + age_30_44 + age_45_60 
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree
        + education_obtained_a_doctoral_degree + education_some_college + education_some_graduate_school
    + ethnicity_asian_pacific_islander + ethnicity_black_or_african_american + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + state_arizona + state_arkansas + state_california + state_colorado + state_connecticut + state_district_of_columbia_dc
        + state_florida + state_georgia + state_idaho + state_illinois + state_indiana + state_kansas + state_kentucky
        + state_louisiana + state_maine + state_maryland + state_massachusetts + state_michigan + state_minnesota + state_mississippi
        + state_missouri + state_nebraska + state_nevada + state_new_jersey + state_new_mexico + state_new_york + state_north_carolina
        + state_north_dakota + state_ohio + state_oklahoma + state_oregon + state_pennsylvania + state_rhode_island + state_south_carolina
        + state_south_dakota + state_tennessee + state_texas + state_utah + state_vermont + state_virginia + state_washington + state_west_virginia
        + state_wisconsin
    + gender_female + gender_male
    + 1'''

# weak reg / m1: n=454, r2=0.492, ar2=0.367
m2 = '''hireability ~ conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + work_with_external_partners
    + manager_effects_no + manager_effects_yes
    + industry_education + industry_energy + industry_finance_investment_or_accounting
        + industry_health + industry_information_technology + industry_law + industry_manufacturing + industry_military + industry_other
        + industry_real_estate + industry_retail + industry_transportation
    + income_0_9999 + income_10000_24999 + income_100000_124999 + income_125000_149999 + income_150000_174999
        + income_175000_199999 + income_200000 + income_25000_49999 + income_50000_74999 + income_75000_99999
    + age_18_29 + age_30_44 + age_45_60 
    + education_high_school_diploma + education_obtained_non_doctoral_graduate_degree + education_obtained_undergraduate_degree
        + education_obtained_a_doctoral_degree + education_some_college + education_some_graduate_school
    + ethnicity_asian_pacific_islander + ethnicity_black_or_african_american + ethnicity_hispanic + ethnicity_other + ethnicity_white_caucasian
    + state_arizona + state_arkansas + state_california + state_colorado + state_connecticut + state_district_of_columbia_dc
        + state_florida + state_georgia + state_idaho + state_illinois + state_indiana + state_kansas + state_kentucky
        + state_louisiana + state_maine + state_maryland + state_massachusetts + state_michigan + state_minnesota + state_mississippi
        + state_missouri + state_nebraska + state_nevada + state_new_jersey + state_new_mexico + state_new_york + state_north_carolina
        + state_north_dakota + state_ohio + state_oklahoma + state_oregon + state_pennsylvania + state_rhode_island + state_south_carolina
        + state_south_dakota + state_tennessee + state_texas + state_utah + state_vermont + state_virginia + state_washington + state_west_virginia
        + state_wisconsin
    + gender_female + gender_male
    + 1'''

# if this file executed as script
if __name__ == '__main__':
    data = GetVars.getData()

    long_reg = sm.OLS.from_formula(m1, data=data).fit()
    # reg_maxar2 = sm.OLS.from_formula(m3, data=data).fit()
    # robust = sm.RLM.from_formula(m9, data=data).fit()

    print(long_reg.summary())
    
