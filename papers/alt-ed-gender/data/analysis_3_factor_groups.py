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
# ar2 .27, r2 .70, n 86, AIC 275
m11 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + TODO
    + duration + expected_conventionality + familiarity_count + favor_online_ed
    + 1'''

# personality
# ar2 .27, r2 .70, n 86, AIC 275
m11 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + grit + personality_o + personality_c + personality_e + personality_a + personality_n
    + 1'''

# worldview
# ar2 .51, r2 .81, n 99, AIC 276
m12 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + worldview_description + worldview_continuous_activism + worldview_continuous_pro_foreign + worldview_continuous_pro_innovation + worldview_continuous_pro_regulation
    + 1'''

# state
# ar2 .43, r2 .83, n 99, AIC 281
m13 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + state
    + 1'''

# m11 = '''hirability ~
#     + gender*favor_programming_career*favor_seeking_risk*industry
#     + grit + personality_o + personality_c + personality_e + personality_a + personality_n
#     + expected_duration
#     + age + education + income + ethnicity + state
#     + manager_effects + is_prefer_college_peer
#     + worldview_activism + worldview_description + worldview_pro_foreign + worldview_pro_innovation + worldview_pro_regulation
#     + 1'''

print(sm.OLS.from_formula(m13, data=deskewed).fit().summary())
