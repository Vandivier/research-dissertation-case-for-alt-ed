# the point of this file is: hey, you identified which factors are important but
# what are their directions of effect?
# TODO: use LOOCV-WX model l1_ratio=0.0001 as starting point
# try reducing high p-value factors, 1-by-1 until we get an optimized AIC and adjusted r2
# convinient that n < p in this case, so we can to RFE manually (bc automated lacks ar2 maximization algo)

import analysis_1_vars_and_regression as analysis
from sklearn import linear_model, model_selection
import statsmodels.api as sm

deskewed = analysis.getDeskewedData()

# model is: loocv_nx_preferred + loocv_wx_preferred + sfs_gender_variables
model_important_candidates = '''hirability ~

+ expected_duration[T.Under 3 months]
+ expected_duration[T.Under 6 months]
+ expected_duration[T.Under a year]
+ rulebreakers_risky[T.8]
+ rulebreakers_risky[T.9]
+ rulebreakers_culture_value[T.6]
+ rulebreakers_mixed_bag[T.5]
+ rulebreakers_mixed_bag[T.6]
+ rulebreakers_mixed_bag[T.7]
+ industry[T.Finance, Investment, or Accounting]
+ industry[T.Health]
+ industry[T.Information Technology]
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are an industry norm.]
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are not required or expected, but there are some which are common and valued.]
+ job_title_credentials[T.Yes. Certification, license, or other non-degree credentials are required by law.]
+ state[T.New York]
+ gender[T.Male]
+ income[T.75,000-99,999]
+ education[T.High School Diploma]
+ education[T.Obtained Non-Doctoral Graduate Degree]
+ education[T.Obtained Undergraduate Degree]
+ education[T.Some Graduate School]
+ worldview_description[T.Religious, Not Christian]
+ covid_fav_online[T.No increase (or a decrease)]
+ covid_fav_online[T.Slight degree]
+ covid_remote[T.No increase (or a decrease)]
+ covid_remote[T.Slight degree]
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
+ worldview_description[T.Conservative or Evangelical Christian]:worldview_continuous_activism
+ worldview_description[T.Other Christian]:worldview_continuous_activism
+ worldview_description[T.Progressive Christian]:worldview_continuous_activism
+ worldview_description[T.Religious, Not Christian]:worldview_continuous_activism
+ worldview_description[T.Spiritual or Theistic, No Specific Religion]:worldview_continuous_activism
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

+ expected_duration[T.Under 6 months]
+ rulebreakers_culture_value[T.6]
+ rulebreakers_mixed_bag[T.6]
+ state[T.New York]
+ education[T.Obtained Non-Doctoral Graduate Degree]
+ covid_fav_online[T.Slight degree]
+ covid_remote[T.Slight degree]
+ expected_conventionality
+ favor_online_ed
+ favor_programming_career
+ gender[T.Male]:favor_programming_career
+ favor_programming_career:industry[T.Health]
+ favor_programming_career:industry[T.Information Technology]
+ favor_programming_career:industry[T.Law]
+ favor_programming_career:industry[T.Manufacturing]
+ favor_programming_career:industry[T.Transportation]
+ gender[T.Male]:favor_programming_career:industry[T.Health]
+ gender[T.Male]:favor_programming_career:industry[T.Information Technology]
+ gender[T.Male]:favor_programming_career:industry[T.Manufacturing]
+ gender[T.Male]:favor_programming_career:industry[T.Transportation]
+ favor_seeking_risk
+ gender[T.Male]:favor_seeking_risk
+ favor_seeking_risk:industry[T.Finance, Investment, or Accounting]
+ favor_seeking_risk:industry[T.Health]
+ favor_seeking_risk:industry[T.Information Technology]
+ favor_seeking_risk:industry[T.Law]
+ favor_seeking_risk:industry[T.Manufacturing]
+ favor_seeking_risk:industry[T.Transportation]
+ gender[T.Male]:favor_seeking_risk:industry[T.Health]
+ gender[T.Male]:favor_seeking_risk:industry[T.Information Technology]
+ gender[T.Male]:favor_seeking_risk:industry[T.Manufacturing]
+ gender[T.Male]:favor_seeking_risk:industry[T.Transportation]
+ favor_programming_career:favor_seeking_risk
+ gender[T.Male]:favor_programming_career:favor_seeking_risk
+ favor_programming_career:favor_seeking_risk:industry[T.Education]
+ favor_programming_career:favor_seeking_risk:industry[T.Energy]
+ favor_programming_career:favor_seeking_risk:industry[T.Finance, Investment, or Accounting]
+ favor_programming_career:favor_seeking_risk:industry[T.Health]
+ favor_programming_career:favor_seeking_risk:industry[T.Information Technology]
+ favor_programming_career:favor_seeking_risk:industry[T.Law]
+ favor_programming_career:favor_seeking_risk:industry[T.Manufacturing]
+ favor_programming_career:favor_seeking_risk:industry[T.Retail]
+ favor_programming_career:favor_seeking_risk:industry[T.Transportation]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Education]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Finance, Investment, or Accounting]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Health]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Information Technology]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Manufacturing]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Retail]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Transportation]
+ personality_o
+ personality_c
+ personality_e
+ personality_a
+ personality_n
+ worldview_continuous_activism
+ worldview_description[T.Conservative or Evangelical Christian]:worldview_continuous_activism
+ worldview_description[T.Other Christian]:worldview_continuous_activism
+ worldview_description[T.Progressive Christian]:worldview_continuous_activism
+ worldview_description[T.Spiritual or Theistic, No Specific Religion]:worldview_continuous_activism
+ worldview_continuous_pro_foreign
+ worldview_continuous_pro_innovation
+ worldview_continuous_pro_regulation
+ school_unaccredited_hirability
+ school_self_impressed
+ school_other_impressed
+ skill_aetiwno_skill_physical_attractiveness
+ skill_aetiwno_skill_emotional_intelligence
+ skill_aetiwno_skill_salary
+ skill_aetiwno_skill_written_communication_skill
+ skill_aetiwno_skill_verbal_communication_skill
+ skill_aetiwno_skill_technical_job_skills
+ skill_aetiwno_skill_conscientiousness
+ skill_aetiwno_skill_customer_service_skill
+ skill_aetiwno_skill_commute
+ skill_comparative_no_relative_oqskill_physical_attractiveness
+ skill_comparative_no_relative_oqskill_verbal_communication_skill
+ skill_comparative_no_relative_oqskill_body_language_communication_skill
+ skill_comparative_no_relative_oqskill_teamwork

+ gender[T.Male]:industry[T.Health]
+ gender[T.Male]:favor_programming_career:industry[T.Health]
+ gender[T.Male]:industry[T.Energy]
+ gender[T.Male]:industry[T.Law]
+ gender[T.Male]:industry[T.Manufacturing]
+ gender[T.Male]:industry[T.Real Estate]
+ gender[T.Male]:industry[T.Retail]
+ gender[T.Male]:favor_programming_career:industry[T.Energy]
+ gender[T.Male]:favor_programming_career:industry[T.Law]
+ gender[T.Male]:favor_programming_career:industry[T.Real Estate]
+ gender[T.Male]:favor_seeking_risk:industry[T.Education]
+ gender[T.Male]:favor_seeking_risk:industry[T.Energy]
+ gender[T.Male]:favor_seeking_risk:industry[T.Law]
+ gender[T.Male]:favor_seeking_risk:industry[T.Real Estate]
+ gender[T.Male]:favor_seeking_risk:industry[T.Transportation]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Education]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Energy]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Law]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Real Estate]
+ gender[T.Male]:industry[T.Military]
+ gender[T.Male]:industry[T.Transportation]
+ gender[T.Male]:favor_programming_career:industry[T.Information Technology]
+ gender[T.Male]:favor_programming_career:industry[T.Manufacturing]
+ gender[T.Male]:favor_programming_career:industry[T.Military]
+ gender[T.Male]:favor_programming_career:industry[T.Transportation]
+ gender[T.Male]:favor_seeking_risk:industry[T.Health]
+ gender[T.Male]:favor_seeking_risk:industry[T.Military]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Finance, Investment, or Accounting]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Information Technology]
+ gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Military]

+ 1'''

important_candidates = sm.OLS.from_formula(model_important_candidates, data=deskewed)
print(important_candidates.fit().summary())
