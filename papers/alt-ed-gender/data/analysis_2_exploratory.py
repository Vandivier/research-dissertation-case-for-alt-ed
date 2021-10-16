
from scipy import stats
import statsmodels.api as sm
import analysis_1_vars_and_regression as analysis

skewed = analysis.getData()
deskewed = analysis.getDeskewedData()
left_of_skew = analysis.getLowHirabilityGroup()

print('\n')
print("skewed data skew test:")
skew_test_result = stats.skewtest(skewed.hirability)
print(skew_test_result)

print('\n')
print("deskewed data skew test:")
deskewed_test_result = stats.skewtest(deskewed.hirability)
print(deskewed_test_result)

print('\n')
print("left_of_skew fails skew test due to insufficient sample size")

print("\n")
deskewed_male = deskewed[deskewed.gender == "Male"]
deskewed_female = deskewed[deskewed.gender == "Female"]
# are men and women naively different?
# p ~=.68 therefore currently retain null hypothesis of no difference
ttest, pval = stats.ttest_ind(deskewed_male.hirability, deskewed_female.hirability)
print("hirability mean diff test by gender: " + str(pval))


print("\n")
deskewed_male_with_favor_programming_career = deskewed_male[deskewed_male.favor_programming_career > 0]
deskewed_female_with_favor_programming_career = deskewed_female[deskewed_female.favor_programming_career > 0]
n_favor_programming_career = len(deskewed_male_with_favor_programming_career) + len(deskewed_female_with_favor_programming_career)
print("sample size for favor_programming_career: " + str(n_favor_programming_career))
ttest, pval = stats.ttest_ind(deskewed_male_with_favor_programming_career.favor_programming_career,
    deskewed_female_with_favor_programming_career.favor_programming_career)
print("favor_programming_career mean diff test by gender: " + str(pval))


print("\n")
deskewed_male_with_favor_seeking_risk = deskewed_male[deskewed_male.favor_seeking_risk > 0]
deskewed_female_with_favor_seeking_risk = deskewed_female[deskewed_female.favor_seeking_risk > 0]
n_favor_seeking_risk = len(deskewed_male_with_favor_seeking_risk) + len(deskewed_female_with_favor_seeking_risk)
print("sample size for favor_seeking_risk: " + str(n_favor_seeking_risk))
ttest, pval = stats.ttest_ind(deskewed_male_with_favor_seeking_risk.favor_seeking_risk,
    deskewed_female_with_favor_seeking_risk.favor_seeking_risk)
print("favor_seeking_risk mean diff test by gender: " + str(pval))


print("\n")
deskewed_male_with_grit = deskewed_male[deskewed_male.grit > 0]
deskewed_female_with_grit = deskewed_female[deskewed_female.grit > 0]
n_grit = len(deskewed_male_with_grit) + len(deskewed_female_with_grit)
print("sample size for grit: " + str(n_grit))
ttest, pval = stats.ttest_ind(deskewed_male_with_grit.grit,
    deskewed_female_with_grit.grit)
print("grit mean diff test by gender: " + str(pval))


print("\n")
deskewed_male_with_is_prefer_college_peer = deskewed_male[deskewed_male.is_prefer_college_peer > -1]
deskewed_female_with_is_prefer_college_peer = deskewed_female[deskewed_female.is_prefer_college_peer > -1]
n_is_prefer_college_peer = len(deskewed_male_with_is_prefer_college_peer) + len(deskewed_female_with_is_prefer_college_peer)
print("sample size for is_prefer_college_peer: " + str(n_is_prefer_college_peer))
ttest, pval = stats.ttest_ind(deskewed_male_with_is_prefer_college_peer.is_prefer_college_peer,
    deskewed_female_with_is_prefer_college_peer.is_prefer_college_peer)
print("is_prefer_college_peer mean diff test by gender: " + str(pval))
print("is_prefer_college_peer mean for male: " + str(deskewed_male_with_is_prefer_college_peer.is_prefer_college_peer.mean()))
print("is_prefer_college_peer mean for female: " + str(deskewed_female_with_is_prefer_college_peer.is_prefer_college_peer.mean()))


print("\n")
deskewed_male_with_is_tech = deskewed_male[deskewed_male.is_tech > -1]
deskewed_female_with_is_tech = deskewed_female[deskewed_female.is_tech > -1]
n_is_tech = len(deskewed_male_with_is_tech) + len(deskewed_female_with_is_tech)
print("sample size for is_tech: " + str(n_is_tech))
ttest, pval = stats.ttest_ind(deskewed_male_with_is_tech.is_tech,
    deskewed_female_with_is_tech.is_tech)
print("is_tech mean diff test by gender: " + str(pval))
print("is_tech mean for male: " + str(deskewed_male_with_is_tech.is_tech.mean()))
print("is_tech mean for female: " + str(deskewed_female_with_is_tech.is_tech.mean()))
print("is_tech mean (fraction) invariant to gender is: " + str(deskewed.is_tech.mean()))


print("\n")
## below analysis using deskewed data

    # # pca and mca explored for dimensionality reduction
    # # of high-dimension categorical industry and state variables, but not feasible due to partial responses
    # # import prince
    # # prince can also do a graph
    # # 2 components make graphing easier
    # # https://stackoverflow.com/questions/48521740/using-mca-package-in-python
    # # https://github.com/MaxHalford/prince#multiple-correspondence-analysis-mca
    # df_industry = pd.DataFrame(df.industry)
    # mca = prince.MCA(
    #     n_components=2,
    #     n_iter=3,
    #     copy=True,
    #     check_input=True,
    #     engine='auto',
    #     random_state=7
    # )
    # mca = mca.fit(df_industry)
    # df[['industry_mca_1',
    #     'industry_mca_2']] = mca.transform(df.industry)
    # # pca.fit(df.state)

    # m1_mca = '''hirability ~
    #     + industry_mca_1 + industry_mca_2
    #     + 1'''

# industry alone
# ar2 .10, r2 .19, n 105, AIC 339
m1 = '''hirability ~
    + industry
    + 1'''

# industry*gender alone - bad move
# ar2 .07, r2 .23, n 105, AIC 348
m2 = '''hirability ~
    + industry*gender
    + 1'''

# gender alone - bad move
# ar2 -.01, r2 .00, n 105, AIC 341
m3 = '''hirability ~
    + gender
    + 1'''

# gender alone - bad move
# ar2 .09, r2 .20, n 105, AIC 341
m4 = '''hirability ~
    + gender
    + industry
    + 1'''

# three-way interaction alone is highly significant and better than industry
# ar2 .18, r2 .24, n 99, AIC 306
m5 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk
    + 1'''

# industry and three-way interaction are substantially independent
# ref: https://stats.stackexchange.com/a/9174/142294
# ar2 .25, r2 .38, n 99, AIC 308
m6 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk
    + industry
    + 1'''

# this model is def overfit, but
# four way interaction is meaningful in the average case after penalty (ar2 up)
# could be a good backward selection or lasso starting point
# ar2 .26, r2 .64, n 99, AIC 319
m7 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + 1'''

# try simplifying + concentrating explanatory power via is_tech
# nope, explanatory power is nerfed; it bad.
# ar2 .13, r2 .27, n 99, AIC 319
m8 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*is_tech
    + 1'''

# add covid_impact so m10 can compare interaction
# none of covid_impact is significant, one is p~.2
# ar2 .25, r2 .65, n 99, AIC 321
m9 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + covid_impact
    + 1'''

# covid_impact*gender
# all covid factors are worse after gender interaction, don't do that
# ar2 .20, r2 .66, n 99, AIC 325
m10 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + covid_impact*gender
    + 1'''

print(sm.OLS.from_formula(m1_mca, data=deskewed).fit().summary())

# TODO: 1. swap industry categorical for is_tech boolean
# TODO: 2. covid_impact*gender

# I don't care about RLM bc coefficients are equal anyway
# print(sm.RLM.from_formula(1, data=skewed).fit().summary())

# "This makes AIC the preferred choice if the goal is prediction and the evaluation of predictions is the likelihood."
# over MSE but what about vs ar2?
# https://stats.stackexchange.com/questions/425675/optimality-of-aic-w-r-t-loss-functions-used-for-evaluation
# other criteria like MSE:
# https://www.youtube.com/watch?v=hUSsZD5NfQI
# WAIC, DIC, and LOOCV / LOO-CV
# https://www.youtube.com/watch?v=xS4jDHQfP2o
# see 2.2.5. Background knowledge and DAG:
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5969114/

