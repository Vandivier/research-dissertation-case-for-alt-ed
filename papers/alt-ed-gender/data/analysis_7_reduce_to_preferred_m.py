# the point of this file is: hey, you identified factors that are important but
# what are their directions of effect?
# try reducing high p-value factors, 1-by-1 until we get an optimized AIC and adjusted r2
# convinient that n < p in this case, so we can to RFE manually (bc automated lacks ar2 maximization algo)

import analysis_1_var_wrangler as analysis
import statsmodels.api as sm

df_with_dummies = analysis.getDeskewedDataWithDummies(True)

# superset of all models count of x, inclusive of Intercept =
# (81) + (13) + (10) + (22)
# = 126
# reduced to k = 76

# consolidating candidate features from: loocv_nx_preferred + loocv_wx_preferred + sfs_gender_variables
# steps:
# 1. analysis_4_loocv.py result (k= 81)
# 2. BFE on 1
# 3. 2 + analysis_5_loocv_wx.py non-gender fx (k= 13)
# 4. BFE on 3
# 5. 4 + analysis_5_loocv_wx.py gender fx (k=10)
# 6. BFE on 5
# 7. 6 + SFS gender fx (k=22)
# 8. BFE on 7 <--- preferred model!! (should i reduce further from here?)

# r2 = 0.98, ar2 = .68, AIC = 96.67, n = 86, k = 80
# nx elastic net before cutting by p-values; expect it's overfit (included variable bias)
reduction_step_1 = '''hirability ~
+ expected_duration_under_3_months
+ expected_duration_under_6_months
+ expected_duration_under_a_year
+ industry_finance_investment_or_accounting
+ industry_health
+ industry_information_technology
+ industry_manufacturing
+ job_title_credentials_yes_are_an_industry_norm
+ job_title_credentials_yes_are_required_by_law
+ manager_effects_yes
+ state_new_york
+ state_north_carolina
+ state_pennsylvania
+ state_tennessee
+ gender_male
+ income_100000_124999
+ income_50000_74999
+ income_75000_99999
+ age_35_44
+ age_45_54
+ education_high_school_diploma
+ education_obtained_non_doctoral_graduate_degree
+ education_obtained_undergraduate_degree
+ education_some_college
+ ethnicity_black_or_african_american
+ worldview_description_religious_not_christian
+ covid_fav_online_no_increase_or_a_decrease
+ covid_fav_online_slight_degree
+ covid_remote_no_increase_or_a_decrease
+ covid_impact_moderate_negative_impact
+ covid_impact_slight_negative_impact
+ expected_conventionality
+ familiarity_count
+ familiarity_count^2
+ favor_online_ed
+ rulebreakers_risky
+ rulebreakers_culture_value
+ rulebreakers_mixed_bag
+ is_prefer_college_peer
+ favor_programming_career
+ favor_seeking_risk
+ grit
+ personality_o
+ personality_c
+ personality_e
+ personality_a
+ personality_n
+ worldview_continuous_activism
+ worldview_description_other_christian:worldview_continuous_activism
+ worldview_description_progressive_christian:worldview_continuous_activism
+ worldview_description_religious_not_christian:worldview_continuous_activism
+ worldview_continuous_pro_foreign
+ worldview_continuous_pro_innovation
+ worldview_continuous_pro_regulation
+ school_unaccredited_hirability
+ school_self_impressed
+ school_other_impressed
+ skill_aetiwno_skill_physical_attractiveness
+ skill_aetiwno_skill_salary
+ skill_aetiwno_skill_written_communication_skill
+ skill_aetiwno_skill_verbal_communication_skill
+ skill_aetiwno_skill_body_language_communication_skill
+ skill_aetiwno_skill_conscientiousness
+ skill_aetiwno_skill_break_rules
+ skill_aetiwno_skill_teamwork
+ skill_aetiwno_skill_commute
+ skill_aetiwno_skill_work_odd_hours_or_a_strange_schedule
+ skill_comparative_no_relative_oqskill_physical_attractiveness
+ skill_comparative_no_relative_oqskill_emotional_intelligence
+ skill_comparative_no_relative_oqskill_salary
+ skill_comparative_no_relative_oqskill_written_communication_skill
+ skill_comparative_no_relative_oqskill_verbal_communication_skill
+ skill_comparative_no_relative_oqskill_body_language_communication_skill
+ skill_comparative_no_relative_oqskill_technical_job_skills
+ skill_comparative_no_relative_oqskill_conscientiousness
+ skill_comparative_no_relative_oqskill_break_rules
+ skill_comparative_no_relative_oqskill_customer_service_skill
+ skill_comparative_no_relative_oqskill_teamwork
+ skill_comparative_no_relative_oqskill_commute
+ skill_comparative_no_relative_oqskill_work_odd_hours_or_a_strange_schedule

+ 1'''

def get_formula(y_variable_name, curr_feature_names):
    curr_feature_subformula = " + ".join(list(curr_feature_names))
    formula = y_variable_name + " ~ " + curr_feature_subformula + " + 1"
    return formula

# ref: https://www.analyticsvidhya.com/blog/2020/10/a-comprehensive-guide-to-feature-selection-using-wrapper-methods-in-python/
def backward_elimination(data, candidate_feature_names, y_variable_name, significance_level = 0.5):
    without_index = list(candidate_feature_names)
    without_index.remove("Intercept")
    curr_feature_names = without_index

    while(len(curr_feature_names) > 0):
        model = sm.OLS.from_formula(get_formula(y_variable_name, curr_feature_names), data).fit()

        p_values = model.pvalues[1:]
        max_p_value = p_values.max()

        if(max_p_value >= significance_level):
            excluded_feature = p_values.idxmax()
            curr_feature_names.remove(excluded_feature)
        else:
            break

    return curr_feature_names

reduction_step_1_model = sm.OLS.from_formula(reduction_step_1, data=df_with_dummies)
reduction_step_1_feature_names = reduction_step_1_model.exog_names

# nx elastic net after cutting by p-values
# r2 = 0.98, ar2 = .90, AIC = 77.56, n = 86, k = 67
reduction_step_2_feature_names = backward_elimination(df_with_dummies, reduction_step_1_feature_names, "hirability", 0.5)
reduction_step_2_formula = get_formula("hirability", reduction_step_2_feature_names)
reduction_step_2_model = sm.OLS.from_formula(reduction_step_2_formula, data=df_with_dummies)

# note: loocv_wx_unique_features is identified by analysis_5_loocv_wx.py
#     but, it is deduped for features that were already included in analysis_4_loocv
loocv_wx_unique_feature_names_no_gender_fx = '''
+ covid_remote_slight_degree
+ favor_programming_career:favor_seeking_risk
+ favor_programming_career:favor_seeking_risk:industry_education
+ favor_programming_career:favor_seeking_risk:industry_energy
+ favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ favor_programming_career:favor_seeking_risk:industry_health
+ favor_programming_career:favor_seeking_risk:industry_information_technology
+ favor_programming_career:favor_seeking_risk:industry_law
+ favor_programming_career:favor_seeking_risk:industry_manufacturing
+ favor_programming_career:favor_seeking_risk:industry_military
+ favor_programming_career:favor_seeking_risk:industry_retail
+ favor_programming_career:favor_seeking_risk:industry_transportation
+ worldview_description_conservative_or_evangelical_christian:worldview_continuous_activism
'''

reduction_step_3_formula = reduction_step_2_formula + loocv_wx_unique_feature_names_no_gender_fx
reduction_step_3_model = sm.OLS.from_formula(reduction_step_3_formula, data=df_with_dummies)
reduction_step_3_feature_names = reduction_step_3_model.exog_names

# step 4 is nx elastic net + wx gender fx, after cutting by p-values
# r2 = 0.99, ar2 = .94, AIC = 33.39, n = 86, k = 70
reduction_step_4_feature_names = backward_elimination(df_with_dummies, reduction_step_3_feature_names, "hirability", 0.5)
reduction_step_4_formula = get_formula("hirability", reduction_step_4_feature_names)
reduction_step_4_model = sm.OLS.from_formula(reduction_step_4_formula, data=df_with_dummies)

# note: if this works, why not increase k(nx elastic net)?
loocv_wx_unique_feature_names_gender_fx  = '''
+ gender_male:favor_programming_career
+ gender_male:favor_programming_career:industry_information_technology
+ gender_male:favor_programming_career:favor_seeking_risk
+ gender_male:favor_programming_career:favor_seeking_risk:industry_education
+ gender_male:favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ gender_male:favor_programming_career:favor_seeking_risk:industry_health
+ gender_male:favor_programming_career:favor_seeking_risk:industry_manufacturing
+ gender_male:favor_programming_career:favor_seeking_risk:industry_military
+ gender_male:favor_programming_career:favor_seeking_risk:industry_retail
+ gender_male:favor_programming_career:favor_seeking_risk:industry_transportation
'''

reduction_step_5_formula = reduction_step_4_formula + loocv_wx_unique_feature_names_gender_fx
reduction_step_5_model = sm.OLS.from_formula(reduction_step_5_formula, data=df_with_dummies)
reduction_step_5_feature_names = reduction_step_5_model.exog_names

# step 4 is wx net, after cutting by p-values
# r2 = 1.0, ar2 = .96, AIC = -24.37, n = 86, k = 73
reduction_step_6_feature_names = backward_elimination(df_with_dummies, reduction_step_5_feature_names, "hirability", 0.5)
reduction_step_6_formula = get_formula("hirability", reduction_step_6_feature_names)
reduction_step_6_model = sm.OLS.from_formula(reduction_step_6_formula, data=df_with_dummies)

# identified by analysis_6_sfscv.py
sfs_unique_feature_names = '''
+ gender_male:industry_health
+ gender_male:favor_programming_career:industry_health
+ gender_male:industry_energy
+ gender_male:industry_law
+ gender_male:industry_military
+ gender_male:industry_real_estate
+ gender_male:industry_transportation
+ gender_male:favor_programming_career:industry_energy
+ gender_male:favor_programming_career:industry_law
+ gender_male:favor_programming_career:industry_real_estate
+ gender_male:favor_seeking_risk:industry_energy
+ gender_male:favor_seeking_risk:industry_law
+ gender_male:favor_seeking_risk:industry_real_estate
+ gender_male:favor_programming_career:favor_seeking_risk:industry_energy
+ gender_male:favor_programming_career:favor_seeking_risk:industry_information_technology
+ gender_male:favor_programming_career:favor_seeking_risk:industry_law
+ gender_male:favor_programming_career:favor_seeking_risk:industry_real_estate
+ gender_male:industry_retail
+ gender_male:favor_programming_career:industry_manufacturing
+ gender_male:favor_programming_career:industry_retail
+ gender_male:favor_seeking_risk
+ gender_male:favor_seeking_risk:industry_retail
'''

sfs_unique_feature_names_collinearity_dropped = '''
+ gender_male:industry_health
+ gender_male:favor_programming_career:industry_health
+ gender_male:industry_energy
+ gender_male:industry_law
+ gender_male:industry_military
+ gender_male:industry_real_estate
+ gender_male:industry_transportation
+ gender_male:favor_programming_career:favor_seeking_risk:industry_information_technology
+ gender_male:industry_retail
+ gender_male:favor_programming_career:industry_manufacturing
+ gender_male:favor_programming_career:industry_retail
+ gender_male:favor_seeking_risk
+ gender_male:favor_seeking_risk:industry_retail
'''

reduction_step_7_formula = reduction_step_6_formula + sfs_unique_feature_names_collinearity_dropped
reduction_step_7_model = sm.OLS.from_formula(reduction_step_7_formula, data=df_with_dummies)
reduction_step_7_feature_names = reduction_step_7_model.exog_names

# step 4 is wx net, after cutting by p-values
# r2 = 1.0, ar2 = .97, AIC = -63.87, n = 86, k = 76
reduction_step_8_feature_names = backward_elimination(df_with_dummies, reduction_step_7_feature_names, "hirability", 0.5)
reduction_step_8_formula = get_formula("hirability", reduction_step_8_feature_names)
reduction_step_8_model = sm.OLS.from_formula(reduction_step_8_formula, data=df_with_dummies)
print(reduction_step_8_model.fit().summary())
