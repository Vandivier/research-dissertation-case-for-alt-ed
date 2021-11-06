# the point of this file is: hey, you identified which factors are important but
# what are their directions of effect?
# TODO: use LOOCV-WX model l1_ratio=0.0001 as starting point
# try reducing high p-value factors, 1-by-1 until we get an optimized AIC and adjusted r2
# convinient that n < p in this case, so we can to RFE manually (bc automated lacks ar2 maximization algo)

import analysis_1_vars_and_regression as analysis
from sklearn import linear_model, model_selection
import statsmodels.api as sm

df_with_dummies = analysis.getDeskewedDataWithDummies(True)

# model is: loocv_nx_preferred + loocv_wx_preferred + sfs_gender_variables
model_important_candidates = '''hirability ~
+ expected_duration[T.Under 3 months]
+ expected_duration[T.Under 6 months]
+ expected_duration[T.Under a year]
+ industry_finance_investment_or_accounting
+ industry_health
+ industry_information_technology
+ industry[T.Manufacturing]
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are an industry norm.]
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are required by law.]
+ manager_effects[T.Yes]
+ state[T.New York]
+ state[T.North Carolina]
+ state[T.Pennsylvania]
+ state[T.Tennessee]
+ gender_male
+ income[T.100,000-124,999]
+ income[T.50,000-74,999]
+ income[T.75,000-99,999]
+ age[T.35-44]
+ age[T.45-54]
+ education[T.High School Diploma]
+ education[T.Obtained Non-Doctoral Graduate Degree]
+ education[T.Obtained Undergraduate Degree]
+ education[T.Some Graduate School]
+ ethnicity[T.Black or African American]
+ worldview_description[T.Religious, Not Christian]
+ covid_fav_online[T.No increase (or a decrease)]
+ covid_fav_online[T.Slight degree]
+ covid_remote[T.No increase (or a decrease)]
+ covid_impact[T.Moderate negative impact]
+ covid_impact[T.Slight negative impact]
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
+ worldview_description[T.Other Christian]:worldview_continuous_activism
+ worldview_description[T.Progressive Christian]:worldview_continuous_activism
+ worldview_description[T.Religious, Not Christian]:worldview_continuous_activism
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

+ covid_remote[T.Slight degree]
+ gender_male:favor_programming_career
+ gender_male:favor_programming_career:industry_information_technology
+ favor_programming_career:favor_seeking_risk
+ gender_male:favor_programming_career:favor_seeking_risk
+ favor_programming_career:favor_seeking_risk:industry[T.Education]
+ favor_programming_career:favor_seeking_risk:industry[T.Energy]
+ favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ favor_programming_career:favor_seeking_risk:industry_health
+ favor_programming_career:favor_seeking_risk:industry_information_technology
+ favor_programming_career:favor_seeking_risk:industry[T.Law]
+ favor_programming_career:favor_seeking_risk:industry[T.Manufacturing]
+ favor_programming_career:favor_seeking_risk:industry[T.Military]
+ favor_programming_career:favor_seeking_risk:industry[T.Retail]
+ favor_programming_career:favor_seeking_risk:industry[T.Transportation]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Education]
+ gender_male:favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ gender_male:favor_programming_career:favor_seeking_risk:industry_health
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Manufacturing]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Military]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Retail]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Transportation]
+ worldview_description[T.Conservative or Evangelical Christian]:worldview_continuous_activism

+ gender_male:industry_health
+ gender_male:favor_programming_career:industry_health
+ gender_male:industry[T.Energy]
+ gender_male:industry[T.Law]
+ gender_male:industry[T.Military]
+ gender_male:industry[T.Real Estate]
+ gender_male:industry[T.Transportation]
+ gender_male:favor_programming_career:industry[T.Energy]
+ gender_male:favor_programming_career:industry[T.Law]
+ gender_male:favor_programming_career:industry[T.Real Estate]
+ gender_male:favor_seeking_risk:industry[T.Energy]
+ gender_male:favor_seeking_risk:industry[T.Law]
+ gender_male:favor_seeking_risk:industry[T.Real Estate]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Energy]
+ gender_male:favor_programming_career:favor_seeking_risk:industry_information_technology
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Law]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Real Estate]
+ gender_male:industry[T.Retail]
+ gender_male:favor_programming_career:industry[T.Manufacturing]
+ gender_male:favor_programming_career:industry[T.Retail]
+ gender_male:favor_seeking_risk
+ gender_male:favor_seeking_risk:industry[T.Retail]

+ 1'''

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

reduction_step_2 = '''hirability ~
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

# ref: https://www.analyticsvidhya.com/blog/2020/10/a-comprehensive-guide-to-feature-selection-using-wrapper-methods-in-python/
def backward_elimination(data, candidate_feature_names, y_variable_name, significance_level = 0.5):
    without_index = list(candidate_feature_names)
    without_index.remove("Intercept")
    curr_feature_names = without_index

    while(len(curr_feature_names) > 0):
        curr_feature_subformula = " + ".join(list(curr_feature_names))
        formula = y_variable_name + " ~ " + curr_feature_subformula + " + 1"

        model = sm.OLS.from_formula(formula, data).fit()
        print(model.summary())

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
reduction_step_2_features = backward_elimination(df_with_dummies, reduction_step_1_feature_names, 'hirability', 0.5)
print(reduction_step_2_features)

# important_candidates = sm.OLS.from_formula(reduction_step_2, data=df_with_dummies)
# print(important_candidates.fit().summary())
