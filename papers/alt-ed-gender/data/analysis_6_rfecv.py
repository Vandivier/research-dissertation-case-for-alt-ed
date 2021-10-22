# excellent comparison of multiple methods:
# https://blog.datadive.net/selecting-good-features-part-iv-stability-selection-rfe-and-everything-side-by-side/
# cite stability selection: https://stat.ethz.ch/~nicolai/stability.pdf
# "Sklearn implements stability selection in the randomized lasso and randomized logistics regression classes."

# https://quantifyinghealth.com/stepwise-selection/
# AIC is interesting
# "Unless the number of candidate variables > sample size (or number of events), use a backward stepwise approach."
# https://stats.stackexchange.com/questions/89202/superiority-of-lasso-over-forward-selection-backward-elimination-in-terms-of-the
# LASSO regression vs backward selection
# looks like i need to test lasso, forward, backward, and stepwise selection and choose best using
# MSE, ar2, r2, max(p), number vars selected (yes my other complexity metric is dope too)
# "Don't use stepwise/forward selection. Reasons not to do this have been discussed here a lot"
# https://stats.stackexchange.com/questions/276268/why-avoid-stepwise-regression
# more options
# https://www.datasklr.com/ols-least-squares-regression/variable-selection
# sklearn.feature_selection.RFE is an implementation of backward Backward Elimination:
# https://stats.stackexchange.com/questions/450518/rfe-vs-backward-elimination-is-there-a-difference


# TODO: cite: https://scikit-learn.org/stable/about.html#citing-scikit-learn
# TODO: heatmap @ 2:40 https://www.youtube.com/watch?v=xlHk4okO8Ls
# cross-validation: https://www.youtube.com/watch?v=6dbrR-WymjI


# ref #1: https://stats.stackexchange.com/questions/7935/what-are-disadvantages-of-using-the-lasso-for-variable-selection-for-regression
# If you only care about prediction error and don't care about interpretability, casual-inference, model-simplicity, coefficients' tests, etc, why do you still want to use linear regression model?
# You can use something like boosting on decision trees or support vector regression and get better prediction quality and still avoid overfitting in both mentioned cases. That is Lasso may not be the best choice to get best prediction quality.
# If my understanding is correct, Lasso is intended for situations when you are still interested in the model itself, not only predictions.


from sklearn import feature_selection, linear_model, model_selection, metrics, svm
import statsmodels.api as sm
import analysis_1_vars_and_regression as analysis

deskewed = analysis.getDeskewedData()

# large model, after selecting among skill gaps, without 4-way interaction
kitchen_sink_formula = '''hirability ~
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

kitchen_sink_model = sm.OLS.from_formula(kitchen_sink_formula, data=deskewed)

y = kitchen_sink_model.endog
X = kitchen_sink_model.exog
cv = model_selection.LeaveOneOut()

# SVR is nonlinear, even tho kernel is linear
# avoid SVR due to ref #1 above
# ref: https://stackoverflow.com/questions/46970888/difference-between-linearregression-and-svm-svrkernel-linear
# coef_ is literally coefficient sizes! boo! can't use it
# ref: https://machinelearningmastery.com/calculate-feature-importance-with-python/
estimator_lr = linear_model.LinearRegression()
estimator_svr = svm.SVR(kernel="linear")


#   RFE by p-value (within-sample, kind of comparable to previous study but still not really...
#       because it is a univariate selection instead of multivariate selection, so no true colinearity correction :(
#       which is kind of the whole point of doing ANY multivariate regression bc otherwise i could just regress gender on y
#       ...
#       So i will do this as an estimation preprocessing step only NOT for final analysis (that will be true multiple regression)
#       we NEED multiple regression to partial in and out appropriately on the right hand side
# "Univariate feature selection works by selecting the best features based on univariate statistical tests.
#   It can be seen as a preprocessing step to an estimator."


# 5 is default for RFECV but make it clear
# force 3 features to select; by default only 1 or 2 survived depending on estimator
# ref: https://stats.stackexchange.com/questions/328358/fpr-fdr-and-fwe-for-feature-selection
model_gus_fdr = feature_selection.GenericUnivariateSelect(score_func=feature_selection.f_classif, mode='fdr', param=0.5) # keep features which pass a cumulative p < 0.5
model_gus_fwe = feature_selection.GenericUnivariateSelect(score_func=feature_selection.f_classif, mode='fwe', param=0.5) # keep features with univariate P < 0.5
model_lr =  feature_selection.RFECV(estimator_lr, cv=cv, step=1)
model_svr =  feature_selection.RFECV(estimator_svr, cv=cv, step=1)


#   what about the old justification for adjusted r-squared? meh
# `The algorithm drops features with P values greater than 0.5.`
# https://towardsdatascience.com/feature-selection-why-how-explained-part-2-352d9130c2e1
# if including significant relations and excluding spurious relations is the goal,
# p-value optimization is better than ar2 targeting or AIC, etc.
# so there's basically no theoretical use case for ar2; or is there?
# there certainly might be a practical one as a heurestic around:
#   1. willingness to pay
#   2. 'bang for the buck'
#   3. a clear middle between weak and strong models as i have defined them

# ref: https://en.wikipedia.org/wiki/Family-wise_error_rate#Alternative_approaches
# I prefer FDR so I can maximize the number of variables identified as important to maximize the chances of identifying gender as important
# FDR < 0.5 so I am still sure that "most selected variables are non-erroneous" down to min 0.4 "significantly likely to be non-erroneous"
# The most common FDR-controling procedure (Benjamini-Hochberg) can accommodate positive dependence between hypotheses
# ...
# FWER control exerts a more stringent control over false discovery compared to false discovery rate (FDR) procedures.
# FWER control limits the probability of at least one false discovery, whereas FDR control limits
# (in a loose sense) the expected proportion of false discoveries.
# Thus, FDR procedures have greater power at the cost of increased rates of type I errors, i.e., rejecting null hypotheses that are actually true.[16]


results_fdr = model_gus_fdr.fit(X, y)
# results_fwe = model_gus_fwe.fit(X, y)
# results_lr = model_lr.fit(X, y)
# results_svr = model_svr.fit(X, y)

# # TODO: 1) use feature_importances_
# # TODO: 2) implement custom RFE, possibly using statsmodel for p-value access
# #       eh maybe save this for another paper; maxar2, p-value selection (0.5 default), or r-squared selection (1% default)
# #   possible way to validate GenericMultivariateSelect:


# ref: https://stackoverflow.com/questions/54560611/getting-the-features-names-form-selectkbest

column_names = [column[0]  for column in zip(kitchen_sink_model.exog_names, results_fdr.get_support()) if column[1]]
print(column_names) # yep includes gender
# # col_names_fdr = kitchen_sink_model.exog_names[results_fdr.get_support()]
# # names_nonzero = []
# # gender_vars = []
# # for idx, name in enumerate(kitchen_sink_model.exog_names):
# #     curr_beta = results_fdr.coef_[idx]
# #     if curr_beta != 0:
# #         print(name)
# #         print("encv beta: " + str(curr_beta))
# #         names_nonzero.append(name)
# #         if "gender" in name or "Male" in name:
# #             gender_vars.append(name)

# for idx, name in enumerate(col_names_fdr):
#     print(name)


# print("r2: " + str(results_fdr.score(X, y)))
# print("count nonzero: " + str(len(names_nonzero)))
# print("gender vars" + str(gender_vars))

