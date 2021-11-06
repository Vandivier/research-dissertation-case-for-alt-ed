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


import analysis_1_var_wrangler as analysis
import matplotlib.pyplot as plt
from sklearn import linear_model, model_selection, metrics
import statsmodels.api as sm
import sys

deskewed = analysis.getDeskewedData()

# If p > n, the lasso selects at most n variables
# https://stats.stackexchange.com/questions/38299/if-p-n-the-lasso-selects-at-most-n-variables

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
# print(sm.OLS.from_formula(m23, data=deskewed).fit().summary())

kitchen_sink_model = sm.OLS.from_formula(m23, data=deskewed)

y = kitchen_sink_model.endog
X = kitchen_sink_model.exog

# confirm constant col in X
print("count of independent variables: " + str(len(kitchen_sink_model.exog_names)))
print("Intercept is retained: " + str("Intercept" in kitchen_sink_model.exog_names))

# https://scikit-learn.org/stable/auto_examples/linear_model/plot_lasso_and_elasticnet.html
# https://scikit-learn.org/stable/modules/classes.html#regressors-with-variable-selection
# note: some kinda issue bc these r2 are -1.609104...wtf that shouldn't happen
# ref: "Why are my elastic net and lasso r-squared measures negative?" below
#   https://stats.stackexchange.com/questions/548958/why-are-my-elastic-net-and-lasso-r-squared-measures-negative
n_X_samples = X.shape[0]
n_y_samples = y.shape[0]

X_train, y_train = X[:n_X_samples // 2], y[:n_X_samples // 2]
X_test, y_test = X[n_X_samples // 2:], y[n_X_samples // 2:]

print("count of X and y for full sample, train split, and test split below...")
print(n_X_samples, n_y_samples)
print(X_train.shape[0], y_train.shape[0])
print(X_test.shape[0], y_test.shape[0])

# #############################################################################
# Lasso

alpha = 0.1
lasso = linear_model.Lasso(alpha=alpha)

lasso_fit = lasso.fit(X_train, y_train)
y_test_pred_lasso = lasso_fit.predict(X_train)
y_train_pred_lasso = lasso_fit.predict(X_test)
y_pred_lasso = y_train_pred_lasso
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

if "chart=true" in sys.argv[1:]:
    # https://stackoverflow.com/questions/41659535/valueerror-x-and-y-must-be-the-same-size
    plt.scatter(y_train, y_train_pred_lasso, color='red')
    plt.scatter(y_test, y_test_pred_lasso, color='blue')
    plt.show()

# note: I'm freaked out that my lasso and elastic net have negative r-squared so trying ridge regression
# https://stats.stackexchange.com/questions/123572/r-squared-for-elastic-net
# ref: https://stats.stackexchange.com/questions/184029/what-is-elastic-net-regularization-and-how-does-it-solve-the-drawbacks-of-ridge/184031#184031
# "elastic net is always preferred over lasso & ridge regression because it solves the limitations of both
#   methods, while also including each as special cases"

# https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.LeaveOneOut.html
# Lasso CV https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LassoCV.html

# https://stackoverflow.com/questions/20681864/lasso-on-sklearn-does-not-converge
# max_iter 10x default val, random_state 0 for no particular reason just to seed it
cv = model_selection.LeaveOneOut()
# reg = linear_model.LassoCV(cv=cv,
reg = linear_model.ElasticNetCV(cv=cv,
    l1_ratio=0.015,
    random_state=0,
    max_iter=10000).fit(X, y)

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
print("count gender vars: " + str(len(gender_vars)))
print("var names: ")
print("\n+ ".join(names_nonzero))

# note "Automatic alpha grid generation is not supported for l1_ratio=0"
# note "0.03 l1_ratio -> top 57/143 -> top 40% of factors"
# encv results:
# [lasso]      l1_ratio=1, r2=0.5, count_nonzero=10, no gender vars
# [default]    l1_ratio=0.5, r2=0.49, count_nonzero=11, no gender vars
# [ridge-like] l1_ratio=0.1, r2=0.51, count_nonzero=23, no gender vars
# [ridge-like] l1_ratio=0.05, r2=0.53, count_nonzero=34, no gender vars
# [ridge-like] l1_ratio=0.04, r2=0.60, count_nonzero=36, no gender vars
# [ridge-like] l1_ratio=0.03, r2=0.60, count_nonzero=57, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.02, r2=0.61, count_nonzero=68, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.015, r2=0.64, count_nonzero=81, gender vars['gender[T.Male]'] **preferred** r2 drops quickly by removing factors but doesn't increase much adding many
# [ridge-like] l1_ratio=0.01, r2=0.65, count_nonzero=98, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.009, r2=0.65, count_nonzero=102, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.006, r2=0.65, count_nonzero=108, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.005, r2=0.66, count_nonzero=113, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.004, r2=0.66, count_nonzero=120, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.001, r2=0.58, count_nonzero=135, gender vars['gender[T.Male]']
# [ridge-like] l1_ratio=0.0005, r2=0.48, count_nonzero=133, gender vars['gender[T.Male]']
