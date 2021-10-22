# wx meaning with interaction instead of nx meaning no interactions
# specifically in reference to 4-way interaction:
#   gender*favor_programming_career*favor_seeking_risk*industry


import analysis_1_vars_and_regression as analysis
from sklearn import linear_model, model_selection
import statsmodels.api as sm

deskewed = analysis.getDeskewedData()

# large model, after selecting among skill gaps, without 4-way interaction
m23 = '''hirability ~
    + expected_duration + expected_conventionality + familiarity_count + familiarity_count^2 + favor_online_ed
    + rulebreakers_risky + rulebreakers_culture_value + rulebreakers_mixed_bag
    + is_large_firm_size + is_prefer_college_peer + job_title_credentials + manager_effects
    + gender*favor_programming_career*favor_seeking_risk*industry
    + state + income + age + education + ethnicity
    + grit + personality_o + personality_c + personality_e + personality_a + personality_n
    + worldview_description*worldview_continuous_activism + worldview_continuous_pro_foreign + worldview_continuous_pro_innovation + worldview_continuous_pro_regulation
    + covid_fav_online + covid_remote + covid_impact
    + school_unaccredited_hirability + school_self_impressed + school_other_impressed
    + skill_aetiwno_skill_physical_attractiveness
    + skill_aetiwno_skill_emotional_intelligence
    + skill_aetiwno_skill_salary
    + skill_aetiwno_skill_written_communication_skill
    + skill_aetiwno_skill_verbal_communication_skill
    + skill_aetiwno_skill_body_language_communication_skill
    + skill_aetiwno_skill_technical_job_skills
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
    + skill_comparative_no_relative_oqskill_technical_job_skills
    + skill_comparative_no_relative_oqskill_conscientiousness
    + skill_comparative_no_relative_oqskill_break_rules
    + skill_comparative_no_relative_oqskill_customer_service_skill
    + skill_comparative_no_relative_oqskill_teamwork
    + skill_comparative_no_relative_oqskill_commute
    + skill_comparative_no_relative_oqskill_work_odd_hours_or_a_strange_schedule
    + 1'''

kitchen_sink_model = sm.OLS.from_formula(m23, data=deskewed)

y = kitchen_sink_model.endog
X = kitchen_sink_model.exog

print("count of independent variables: " + str(len(kitchen_sink_model.exog_names)))
print("Intercept is retained: " + str("Intercept" in kitchen_sink_model.exog_names))

n_X_samples = X.shape[0]
n_y_samples = y.shape[0]

print("count of X and y for full sample")
print(n_X_samples, n_y_samples)

cv = model_selection.LeaveOneOut()
reg = linear_model.ElasticNetCV(cv=cv,
    l1_ratio=0.000005,
    random_state=0,
    max_iter=30000).fit(X, y)

names_nonzero = []
gender_vars = []
for idx, name in enumerate(kitchen_sink_model.exog_names):
    curr_beta = reg.coef_[idx]
    if curr_beta != 0:
        print(name)
        print("encv beta: " + str(curr_beta))
        names_nonzero.append(name)
        if "gender" in name or "Male" in name:
            gender_vars.append(name)

print("r2: " + str(reg.score(X, y)))
print("count nonzero: " + str(len(names_nonzero)))
print("gender vars" + str(gender_vars))

# 165 vars before any filtering
# TODO: on what basis is LOOCV retaining factors? p-value? i don't think so.
# top 5 factors from lasso:
# favor_programming_career:favor_seeking_risk
# encv beta: 0.004342207347733295
# favor_programming_career:favor_seeking_risk:industry[T.Health]
# encv beta: -1.9311614010532145e-05
# favor_programming_career:favor_seeking_risk:industry[T.Information Technology]
# encv beta: 0.002978764704554218
# favor_programming_career:favor_seeking_risk:industry[T.Manufacturing]
# encv beta: 0.0008553020494987524
# gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Information Technology]
# encv beta: 0.00035693321766747094

# note: r2 doesn't have it's usual interpretation under an elastic net
#   because "regularization wrecks orthogonality"
#   ref: https://stats.stackexchange.com/questions/494274/why-does-regularization-wreck-orthogonality-of-predictions-and-residuals-in-line
# note "Automatic alpha grid generation is not supported for l1_ratio=0"
# encv results:
# [lasso] l1_ratio=1, r2=0.09, count_nonzero=2, no gender vars
# [default] l1_ratio=0.75, r2=0.09, count_nonzero=2, no gender vars
# [default] l1_ratio=0.5, r2=0.09, count_nonzero=2, no gender vars
# [ridge-like] l1_ratio=0.1, r2=0.09, count_nonzero=2, no gender vars
# [ridge-like] l1_ratio=0.05, r2=0.09, count_nonzero=2, no gender vars
# [ridge-like] l1_ratio=0.01, r2=0.09, count_nonzero=3, no gender vars
# [ridge-like] l1_ratio=0.005, r2=0.08, count_nonzero=5, vars['gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Information Technology]']
# [ridge-like] l1_ratio=0.0005, r2=0.12, count_nonzero=21, gender vars['gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Education]', 'gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Finance, Investment, or Accounting]', 'gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Health]', 'gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Information Technology]', 'gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Manufacturing]', 'gender[T.Male]:favor_programming_career:favor_seeking_risk:industry[T.Transportation]']
# [ridge-like] l1_ratio=0.00005, r2=0.14, count_nonzero=116, many gender vars (not counting)
# [ridge-like] l1_ratio=0.000005, r2=0.10, count_nonzero=187, many gender vars (not counting)
