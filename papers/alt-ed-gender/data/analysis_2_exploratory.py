
from scipy import stats
import statsmodels.api as sm
import analysis_1_vars_and_regression as analysis

skewed = analysis.getData()
deskewed = analysis.getDeskewedData()
left_of_skew = analysis.getLowHirabilityGroup()

print('\n')
skew_test_result = stats.skewtest(skewed.hirability)
print(skew_test_result)
print("skewed data is skewed")

print('\n')
deskewed_test_result = stats.skewtest(deskewed.hirability)
print(deskewed_test_result)
print("deskewed data is still skewed")

print('\n')
if len(left_of_skew) > 7:
    left_of_skew_test_result = stats.skewtest(left_of_skew.hirability)
    print(left_of_skew_test_result)
else:
    print("skew test failed due to insufficient sample size")


print("\n")
deskewed_male = deskewed[deskewed.gender == "Male"]
deskewed_female = deskewed[deskewed.gender == "Female"]
# are men and women naively different?
# p ~=.5 therefore currently retain null hypothesis of no difference
ttest, pval = stats.ttest_ind(deskewed_male.hirability, deskewed_female.hirability)
print("hirability mean diff test by gender: " + str(pval))


print("\n")
deskewed_male_with_favor_programming_career = deskewed_male[deskewed_male.favor_programming_career > 0]
deskewed_female_with_favor_programming_career = deskewed_female[deskewed_female.favor_programming_career > 0]
n_favor_programming_career = len(deskewed_male_with_favor_programming_career) + len(deskewed_female_with_favor_programming_career)

ttest, pval = stats.ttest_ind(deskewed_male_with_favor_programming_career.favor_programming_career,
    deskewed_female_with_favor_programming_career.favor_programming_career)

print("favor_programming_career mean diff test by gender: " + str(pval))
print("sample size for favor_programming_career: " + str(n_favor_programming_career))


## below analysis using deskewed data


# industry alone
# r2 .21, ar2 .31
m1 = '''hirability ~
    + industry
    + 1'''

# three-way interaction alone is highly significant and better than industry
# r2 .43, ar2 .39
m2 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk
    + 1'''

# industry and three-way interaction are substantially independent
# ref: https://stats.stackexchange.com/a/9174/142294
# r2 .599, ar2 .514
m3 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk
    + industry
    + 1'''

m4 = '''hirability ~
    + favor_programming_career
    + 1'''




print(sm.OLS.from_formula(m4, data=deskewed).fit().summary())
# I don't care about RLM bc coefficients are equal anyway
# print(sm.RLM.from_formula(1, data=skewed).fit().summary())

