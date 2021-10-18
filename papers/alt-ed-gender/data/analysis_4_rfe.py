# need to roll my own rfe to pick by p-value + ar2 max. library rfe only looks at coefficient size!
# TODO: backward elimination, LASSO, RFECV-LR, RFECV-SVR, best subset
# consider ANY variable that survives ANY to be important (double check 3 vs 2 RFECV vars add to some model metric of interest)


# hella links:
# https://www.youtube.com/watch?v=xS4jDHQfP2o
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5969114/
# https://stats.stackexchange.com/questions/350587/why-is-best-subset-selection-not-favored-in-comparison-to-lasso
# https://stats.stackexchange.com/a/548190/142294
# https://stats.stackexchange.com/questions/548180/how-to-interpret-increase-to-aic-and-adjusted-r-squared
# https://stats.stackexchange.com/questions/93181/ridge-lasso-and-elastic-net
# https://stats.stackexchange.com/questions/38299/if-p-n-the-lasso-selects-at-most-n-variables
# https://stats.stackexchange.com/questions/407563/choosing-model-for-more-predictors-than-observations
# https://stats.stackexchange.com/questions/223486/modelling-with-more-variables-than-data-points


# import numpy as np
# import matplotlib.pyplot as plt

from sklearn import feature_selection, linear_model, metrics
from scipy import stats
import statsmodels.api as sm
import analysis_1_vars_and_regression as analysis

deskewed = analysis.getDeskewedData()

# If p > n, the lasso selects at most n variables
# https://stats.stackexchange.com/questions/38299/if-p-n-the-lasso-selects-at-most-n-variables

# maybe we want to do an elastic net?

# large model, after selecting among skill gaps, without 4-way interaction
m23 = '''hirability ~
    + expected_duration + expected_conventionality + familiarity_count + familiarity_count^2 + favor_online_ed
    + rulebreakers_risky + rulebreakers_culture_value + rulebreakers_mixed_bag
    + is_large_firm_size + industry + is_prefer_college_peer + job_title_credentials + manager_effects
    + state + gender + income + age + education + ethnicity
    + favor_programming_career + favor_seeking_risk
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

# n = 86, K > 85, can't run a straight OLS
# try lasso and elasticnet instead
print(sm.OLS.from_formula(m23, data=deskewed).fit().summary())

kitchen_sink_model = sm.OLS.from_formula(m23, data=deskewed)

y = kitchen_sink_model.endog
X = kitchen_sink_model.exog

# https://scikit-learn.org/stable/auto_examples/linear_model/plot_lasso_and_elasticnet.html
# https://scikit-learn.org/stable/modules/classes.html#regressors-with-variable-selection
# note: some kinda issue bc these r2 are -1.609104...wtf that shouldn't happen
# Split data in train set and test set
n_samples = X.shape[0]
X_train, y_train = X[:n_samples // 2], y[:n_samples // 2]
X_test, y_test = X[n_samples // 2:], y[n_samples // 2:]

# #############################################################################
# Lasso

alpha = 0.1
lasso = linear_model.Lasso(alpha=alpha)

y_pred_lasso = lasso.fit(X_train, y_train).predict(X_test)
# TODO: compute adjusted r2, formula below
# https://stackoverflow.com/a/51038943/3931488
r2_score_lasso = metrics.r2_score(y_test, y_pred_lasso)
print(lasso)
print("r^2 on test data : %f" % r2_score_lasso)

# #############################################################################
# ElasticNet

enet = linear_model.ElasticNet(alpha=alpha, l1_ratio=0.7)

y_pred_enet = enet.fit(X_train, y_train).predict(X_test)
r2_score_enet = metrics.r2_score(y_test, y_pred_enet)
print(enet)
print("r^2 on test data : %f" % r2_score_enet)

# m, s, _ = plt.stem(np.where(enet.coef_)[0], enet.coef_[enet.coef_ != 0],
#                    markerfmt='x', label='Elastic net coefficients',
#                    use_line_collection=True)
# plt.setp([m, s], color="#2ca02c")
# m, s, _ = plt.stem(np.where(lasso.coef_)[0], lasso.coef_[lasso.coef_ != 0],
#                    markerfmt='x', label='Lasso coefficients',
#                    use_line_collection=True)
# plt.setp([m, s], color='#ff7f0e')

# plt.legend(loc='best')
# plt.title("Lasso $R^2$: %.3f, Elastic Net $R^2$: %.3f"
#           % (r2_score_lasso, r2_score_enet))
# plt.show()
