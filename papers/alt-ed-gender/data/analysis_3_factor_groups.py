# dumping all factors into a regression makes K > n
# so here, I do one regression per factor group and I keep the important factors per group
# alternatively (or in compliment?) I could do a principal components analysis

# m1-m10 motivate starting with a four-way interaction. here i dump in the other IVs and reduce using various strategies
# if gender is considered important in any reduced model, that will be interesting.

# another arg in favor of PCA: any given factor of personality
# doesn't vary much by age, but personality as a whole does.
# you can mca/pca categoricals, but it's "not recommended" uh whyyy:
# https://stackoverflow.com/questions/40795141/pca-for-categorical-features
# well we can use mca instead of pca although i think they are technically equivalent:
# https://academic.oup.com/ije/article/41/4/1207/690856
# https://stats.stackexchange.com/questions/364685/is-mca-equivalent-to-pca-when-all-variables-are-binary
# MDL model selection criteria?
# https://machinelearningmastery.com/probabilistic-model-selection-measures/
# AIC vs BIC
# "Is the true model finite-dimensional or infinite-dimensional? There seems to be a consensus that for the
#   former case, BIC should be preferred and AIC should be chosen for the latter."
# 1) i think they use 'true model' differently than me, 2) I think my model is infinite-dimensional (and I would expect that for most models)
# http://users.stat.umn.edu/~yangx374/papers/Pre-Print_2003-10_Biometrika.pdf
# a threshold of n/K<40 as cutoff point for whether to use AICc or not, based on Burnham and Anderson
# https://stats.stackexchange.com/questions/524258/why-does-the-akaike-information-criterion-aic-sometimes-favor-an-overfitted-mo?rq=1
# i know from prior knowledge that industry matters, eg ar2>aic in my use case
# https://stats.stackexchange.com/questions/548180/how-to-interpret-increase-to-aic-and-adjusted-r-squared

# each page of survey has a factor group. they are:
# 1. thoughts on alt creds
# 2. thoughts on rulebreakers
# 3. occupational information
# 4. demographic information
# 5. personality information
# 6. ideological
# 7. covid impact
# 8. learning provider questions
# 9. perceived skill questions

# if count(IV) > n, ridge regression still gtg
# https://stats.stackexchange.com/questions/524042/when-there-are-more-variables-than-observations-do-shrinkage-methods-such-as-ri
# but also, lasso and Non-Negative Garotte? we don't need nng can be justified bc i don't want to give initial estimate
# https://stats.stackexchange.com/questions/866/when-should-i-use-lasso-vs-ridge

from scipy import stats
import statsmodels.api as sm
import analysis_1_vars_and_regression as analysis

deskewed = analysis.getDeskewedData()

# thoughts on alt creds
# kind of question-begging: expected_conventionality
# note: surprise expected_conventionality and familiarity_count don't matter!
# ar2 .34, r2 .40, n 106, AIC 307
m11 = '''hirability ~
    + expected_duration + expected_conventionality + familiarity_count + familiarity_count^2 + favor_online_ed
    + 1'''

# rulebreakers, p2
# ar2 .39, r2 .54, n 105, AIC 309
m12 = '''hirability ~
    + rulebreakers_risky + rulebreakers_culture_value + rulebreakers_mixed_bag
    + 1'''

# occupational info, p3
# ar2 .04, r2 .28, n 105, AIC 357
m13 = '''hirability ~
    + firm_size + industry + is_prefer_college_peer + job_title_credentials + manager_effects
    + 1'''

# occupational info using is_large_firm_size
# is_tech is harmful
# ar2 .07, r2 .24, n 105, AIC 349
m13_a = '''hirability ~
    + is_large_firm_size + industry + is_prefer_college_peer + job_title_credentials + manager_effects
    + 1'''

# demographic info, p4
# ar2 .26, r2 .61, n 105, AIC 340
m14 = '''hirability ~
    + state + gender + income + age + education + ethnicity
    + 1'''

# personality, p5
# favor_programming_career is most significant
# favor_seeking_risk is second most significant
# ocean + grit alone fairly orthoganal to risk seeking and fav programming career
# ar2 .01, r2 .10, n 86, AIC 285
m15 = '''hirability ~
    + favor_programming_career + favor_seeking_risk
    + grit + personality_o + personality_c + personality_e + personality_a + personality_n
    + 1'''

# ideological questions, p6
# interacting worldview_description*worldview_continuous_activism barely ticks up ar2 and also AIC (ambiguous)
# ar2 .19, r2 .30, n 99, AIC 312
m16 = '''hirability ~
    + worldview_description*worldview_continuous_activism + worldview_continuous_pro_foreign + worldview_continuous_pro_innovation + worldview_continuous_pro_regulation
    + 1'''

# covid, p7
# interacting by gender reduces ar2; not helpful
# ar2 .04, r2 .13, n 99, AIC 324
m17 = '''hirability ~
    covid_fav_online + covid_remote + covid_impact
    + 1'''

# learning provider questions, p8
# interacting by gender reduces ar2; not helpful
# ar2 .01, r2 .09, n 99, AIC 326
m18 = '''hirability ~
    + school_hirability_ + school_hirability_1 + school_hirability_2 + school_hirability_3 + school_hirability_4
    + school_hirability_5 + school_hirability_6 + school_hirability_7
    + 1'''

# learning provider questions with engineered features
# school_other_impressed is most important effect
# AIC suggests this is a better model compared to m18? totally insane
# ar2 -.01, r2 .02, n 99, AIC 324
m18_a = '''hirability ~
    school_unaccredited_hirability + school_self_impressed + school_other_impressed
    + 1'''

print(sm.OLS.from_formula(m18_a, data=deskewed).fit().summary())

# skill questions, p9
#
m19 = '''hirability ~
    TODO
    + 1'''

print(sm.OLS.from_formula(m18_a, data=deskewed).fit().summary())
