
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


## below analysis using deskewed data

# industry alone
# ar2 .10, r2 .19, n 105, AIC 339
m1 = '''hirability ~
    + industry
    + 1'''

# three-way interaction alone is highly significant and better than industry
# ar2 .18, r2 .24, n 99, AIC 306
m2 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk
    + 1'''

# industry and three-way interaction are substantially independent
# ref: https://stats.stackexchange.com/a/9174/142294
# ar2 .25, r2 .38, n 99, AIC 308
m3 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk
    + industry
    + 1'''

# this model is def overfit, but
# four way interaction is meaningful in the average case after penalty (ar2 up)
# could be a good backward selection or lasso starting point
# ref: https://stats.stackexchange.com/a/9174/142294
# ar2 .26, r2 .64, n 99, AIC 319
m4 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + 1'''

print(sm.OLS.from_formula(m4, data=deskewed).fit().summary())
# I don't care about RLM bc coefficients are equal anyway
# print(sm.RLM.from_formula(1, data=skewed).fit().summary())

