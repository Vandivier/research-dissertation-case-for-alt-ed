# orthogonal analysis seeking to compliment analysis 2 (analysis_7_reduce_to_preferred_m)
# study:
# "favor_programming_career" <- preferred_model?
# two begged questions in my conclusion: expected_conventionality, favor_programming_career

import analysis_1_var_wrangler as a1
import analysis_7_reduce_to_preferred_m as a7
import statsmodels.api as sm

df_with_dummies = a1.getDeskewedDataWithDummies(True, False)
preferred_feature_names = a7.get_preferred_feature_names()

# drop all industry variables to remove perfect seperation and complete quasi-seperation
# Possibly complete quasi-separation: A fraction X of observations can be
# perfectly predicted. This might indicate that there is complete
# quasi-separation. In this case some parameters will not be identified.
interest_m1_feature_names = [s for s in preferred_feature_names if "favor_programming_career" not in s]
print("done selecting without_voi")

# n = 86 r2 = 0.79, ar2 .22, k (df model) = 62, aic = 364.8
interest_m1_formula = a7.get_formula("favor_programming_career", interest_m1_feature_names)
interest_m1_model = sm.OLS.from_formula(interest_m1_formula, df_with_dummies)

# n = 86 r2 = 0.77, ar2 .59, k (df model) = 38, aic = 323.6
# preferred favor_programming_career model
interest_m2_feature_names = a7.backward_elimination(df_with_dummies, interest_m1_feature_names, "favor_programming_career", 0.5)
interest_m2_formula = a7.get_formula("favor_programming_career", interest_m2_feature_names)
interest_m2_model = sm.OLS.from_formula(interest_m2_formula, df_with_dummies)
print(interest_m2_model.fit().summary())
