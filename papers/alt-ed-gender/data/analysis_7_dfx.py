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

+ expected_duration[T.Under 3 months
+ expected_duration[T.Under 6 months
+ expected_duration[T.Under a year
+ rulebreakers_risky[T.8
+ rulebreakers_risky[T.9
+ rulebreakers_culture_value[T.6
+ rulebreakers_mixed_bag[T.5
+ rulebreakers_mixed_bag[T.6
+ rulebreakers_mixed_bag[T.7
+ industry_finance_investment_or_accounting
+ industry_health
+ industry_information_technology
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are an industry norm.
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are not required or expected, but there are some which are common and valued.
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are required by law.
+ state[T.New York
+ gender_male
+ income[T.75,000-99,999
+ education[T.High School Diploma
+ education[T.Obtained Non-Doctoral Graduate Degree
+ education[T.Obtained Undergraduate Degree
+ education[T.Some Graduate School
+ worldview_description[T.Religious, Not Christian
+ covid_fav_online[T.No increase (or a decrease)
+ covid_fav_online[T.Slight degree
+ covid_remote[T.No increase (or a decrease)
+ covid_remote[T.Slight degree
+ expected_conventionality
+ familiarity_count
+ favor_online_ed
+ is_prefer_college_peer
+ favor_programming_career
+ favor_seeking_risk
+ personality_o
+ personality_c
+ personality_e
+ personality_a
+ personality_n
+ worldview_continuous_activism
+ worldview_description[T.Conservative or Evangelical Christian:worldview_continuous_activism
+ worldview_description[T.Other Christian:worldview_continuous_activism
+ worldview_description[T.Progressive Christian:worldview_continuous_activism
+ worldview_description[T.Religious, Not Christian:worldview_continuous_activism
+ worldview_description[T.Spiritual or Theistic, No Specific Religion:worldview_continuous_activism
+ worldview_continuous_pro_foreign
+ worldview_continuous_pro_innovation
+ worldview_continuous_pro_regulation
+ school_unaccredited_hirability
+ school_other_impressed
+ skill_aetiwno_skill_physical_attractiveness
+ skill_aetiwno_skill_emotional_intelligence
+ skill_aetiwno_skill_salary
+ skill_aetiwno_skill_written_communication_skill
+ skill_aetiwno_skill_conscientiousness
+ skill_aetiwno_skill_break_rules
+ skill_aetiwno_skill_customer_service_skill
+ skill_aetiwno_skill_teamwork
+ skill_aetiwno_skill_commute
+ skill_aetiwno_skill_work_odd_hours_or_a_strange_schedule
+ skill_comparative_no_relative_oqskill_physical_attractiveness
+ skill_comparative_no_relative_oqskill_emotional_intelligence
+ skill_comparative_no_relative_oqskill_salary
+ skill_comparative_no_relative_oqskill_written_communication_skill
+ skill_comparative_no_relative_oqskill_verbal_communication_skill
+ skill_comparative_no_relative_oqskill_body_language_communication_skill
+ skill_comparative_no_relative_oqskill_conscientiousness
+ skill_comparative_no_relative_oqskill_customer_service_skill
+ skill_comparative_no_relative_oqskill_teamwork
+ skill_comparative_no_relative_oqskill_work_odd_hours_or_a_strange_schedule

+ rulebreakers_culture_value[T.6
+ rulebreakers_mixed_bag[T.6
+ state[T.New York
+ education[T.Obtained Non-Doctoral Graduate Degree
+ covid_fav_online[T.Slight degree
+ covid_remote[T.Slight degree
+ expected_conventionality
+ favor_online_ed
+ favor_programming_career
+ gender_male:favor_programming_career
+ favor_programming_career:industry_health
+ favor_programming_career:industry_information_technology
+ favor_programming_career:industry_law
+ favor_programming_career:industry_manufacturing
+ favor_programming_career:industry_transportation
+ gender_male:favor_programming_career:industry_health
+ gender_male:favor_programming_career:industry_information_technology
+ gender_male:favor_programming_career:industry_manufacturing
+ gender_male:favor_programming_career:industry_transportation
+ favor_seeking_risk
+ gender_male:favor_seeking_risk
+ favor_seeking_risk:industry_finance_investment_or_accounting
+ favor_seeking_risk:industry_health
+ favor_seeking_risk:industry_information_technology
+ favor_seeking_risk:industry_law
+ favor_seeking_risk:industry_manufacturing
+ favor_seeking_risk:industry_transportation
+ gender_male:favor_seeking_risk:industry_health
+ gender_male:favor_seeking_risk:industry_information_technology
+ gender_male:favor_seeking_risk:industry_manufacturing
+ gender_male:favor_seeking_risk:industry_transportation
+ favor_programming_career:favor_seeking_risk
+ gender_male:favor_programming_career:favor_seeking_risk
+ favor_programming_career:favor_seeking_risk:industry_education
+ favor_programming_career:favor_seeking_risk:industry_energy
+ favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ favor_programming_career:favor_seeking_risk:industry_health
+ favor_programming_career:favor_seeking_risk:industry_information_technology
+ favor_programming_career:favor_seeking_risk:industry_law
+ favor_programming_career:favor_seeking_risk:industry_manufacturing
+ favor_programming_career:favor_seeking_risk:industry_retail
+ favor_programming_career:favor_seeking_risk:industry_transportation
+ gender_male:favor_programming_career:favor_seeking_risk:industry_education
+ gender_male:favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ gender_male:favor_programming_career:favor_seeking_risk:industry_health
+ gender_male:favor_programming_career:favor_seeking_risk:industry_information_technology
+ gender_male:favor_programming_career:favor_seeking_risk:industry_manufacturing
+ gender_male:favor_programming_career:favor_seeking_risk:industry_retail
+ gender_male:favor_programming_career:favor_seeking_risk:industry_transportation
+ school_self_impressed
+ skill_aetiwno_skill_verbal_communication_skill
+ skill_aetiwno_skill_technical_job_skills

+ gender_male:industry_health
+ gender_male:favor_programming_career:industry_health
+ gender_male:industry_energy
+ gender_male:industry_law
+ gender_male:industry_manufacturing
+ gender_male:industry_real_estate
+ gender_male:industry_retail
+ gender_male:favor_programming_career:industry_energy
+ gender_male:favor_programming_career:industry_law
+ gender_male:favor_programming_career:industry_real_estate
+ gender_male:favor_seeking_risk:industry_education
+ gender_male:favor_seeking_risk:industry_energy
+ gender_male:favor_seeking_risk:industry_law
+ gender_male:favor_seeking_risk:industry_real_estate
+ gender_male:favor_seeking_risk:industry_transportation
+ gender_male:favor_programming_career:favor_seeking_risk:industry_education
+ gender_male:favor_programming_career:favor_seeking_risk:industry_energy
+ gender_male:favor_programming_career:favor_seeking_risk:industry_law
+ gender_male:favor_programming_career:favor_seeking_risk:industry_real_estate
+ gender_male:industry_military
+ gender_male:industry_transportation
+ gender_male:favor_programming_career:industry_information_technology
+ gender_male:favor_programming_career:industry_manufacturing
+ gender_male:favor_programming_career:industry_military
+ gender_male:favor_programming_career:industry_transportation
+ gender_male:favor_seeking_risk:industry_health
+ gender_male:favor_seeking_risk:industry_military
+ gender_male:favor_programming_career:favor_seeking_risk
+ gender_male:favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ gender_male:favor_programming_career:favor_seeking_risk:industry_information_technology
+ gender_male:favor_programming_career:favor_seeking_risk:industry_military

+ 1'''


model_important_candidates = '''hirability ~ gender_male

+ gender_male:industry_health
+ gender_male:favor_programming_career:industry_health
+ gender_male:industry_energy
+ gender_male:industry_law
+ gender_male:industry_manufacturing
+ gender_male:industry_real_estate
+ gender_male:industry_retail
+ gender_male:favor_programming_career:industry_energy
+ gender_male:favor_programming_career:industry_law
+ gender_male:favor_programming_career:industry_real_estate
+ gender_male:favor_seeking_risk:industry_education
+ gender_male:favor_seeking_risk:industry_energy
+ gender_male:favor_seeking_risk:industry_law
+ gender_male:favor_seeking_risk:industry_real_estate
+ gender_male:favor_seeking_risk:industry_transportation
+ gender_male:favor_programming_career:favor_seeking_risk:industry_education
+ gender_male:favor_programming_career:favor_seeking_risk:industry_energy
+ gender_male:favor_programming_career:favor_seeking_risk:industry_law
+ gender_male:favor_programming_career:favor_seeking_risk:industry_real_estate
+ gender_male:industry_military
+ gender_male:industry_transportation
+ gender_male:favor_programming_career:industry_information_technology
+ gender_male:favor_programming_career:industry_manufacturing
+ gender_male:favor_programming_career:industry_military
+ gender_male:favor_programming_career:industry_transportation
+ gender_male:favor_seeking_risk:industry_health
+ gender_male:favor_seeking_risk:industry_military
+ gender_male:favor_programming_career:favor_seeking_risk
+ gender_male:favor_programming_career:favor_seeking_risk:industry_finance_investment_or_accounting
+ gender_male:favor_programming_career:favor_seeking_risk:industry_information_technology
+ gender_male:favor_programming_career:favor_seeking_risk:industry_military
 + 1'''

important_candidates = sm.OLS.from_formula(model_important_candidates, data=df_with_dummies)
print(important_candidates.fit().summary())
