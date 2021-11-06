# https://tutorials.methodsconsultants.com/posts/what-is-the-difference-between-logit-and-probit-models/
# logit + probit information technology industry outcome
# maybe logit + probit male gender outcome
# orthogonal analysis seeking to compliment analysis 2

# study:
# industry_information_technology <- "favor_programming_career", but that just begs the question
# two begged questions in my conclusion: expected_conventionality, favor_programming_career

import analysis_1_var_wrangler as a1
import analysis_7_reduce_to_preferred_m as a7
import statsmodels.api as sm

df_with_dummies = a1.getDeskewedDataWithDummies(True, False)
preferred_feature_names = a7.get_preferred_feature_names()

def forward_select_without_singular_matrix(data, candidate_feature_names, y_variable_name):
    causes_singular_matrix = []
    safe_feature_names = []
    feature_names = candidate_feature_names

    for idx in range(len(feature_names)):
        curr_feature = feature_names[idx]
        safe_feature_names.append(curr_feature)

        print("trying feature " + str(idx) + " of " + str(len(feature_names)))

        try:
            sm.Logit.from_formula(a7.get_formula(y_variable_name, safe_feature_names), data).fit()
        except:
            causes_singular_matrix.append(curr_feature)
            safe_feature_names.remove(curr_feature)

    print("features causing singular matrix: " + "\n+ ".join(causes_singular_matrix))
    return safe_feature_names

# drop all industry variables to remove perfect seperation and complete quasi-seperation
# Possibly complete quasi-separation: A fraction X of observations can be
# perfectly predicted. This might indicate that there is complete
# quasi-separation. In this case some parameters will not be identified.
without_industry = [s for s in preferred_feature_names if "industry" not in s]
without_singular_matrix = forward_select_without_singular_matrix(df_with_dummies, without_industry, "industry_information_technology")
print("done selecting without_singular_matrix")

# n = 86 pr2 = 0.71 k = 41
# "A fraction 0.36 of observations can be perfectly predicted."
logit_is_tech_formula = a7.get_formula("industry_information_technology", without_singular_matrix)
logit_is_tech_model = sm.Logit.from_formula(logit_is_tech_formula, df_with_dummies)
print(logit_is_tech_model.fit().summary())

# n = 86 pr2 = 0.71 k = 41
# "A fraction 0.43 of observations can be perfectly predicted."
probit_is_tech_formula = logit_is_tech_formula
probit_is_tech_model = sm.Probit.from_formula(logit_is_tech_formula, df_with_dummies)
print(probit_is_tech_model.fit().summary())
