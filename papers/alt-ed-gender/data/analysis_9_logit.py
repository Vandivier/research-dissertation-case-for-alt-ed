# https://tutorials.methodsconsultants.com/posts/what-is-the-difference-between-logit-and-probit-models/
# logit + probit information technology industry outcome
# maybe logit + probit male gender outcome
# orthogonal analysis seeking to compliment analysis 2 (analysis_7_reduce_to_preferred_m)

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
# step 9 is initial logit/probit after removing singular matrix
# without_singular_matrix.append("favor_programming_career")
reduction_step_9_feature_names = without_singular_matrix
reduction_step_9_formula = a7.get_formula("industry_information_technology", without_singular_matrix)
reduction_step_9_logit_model = sm.Logit.from_formula(reduction_step_9_formula, df_with_dummies)

# n = 86 pr2 = 0.71 k = 41
# "A fraction 0.43 of observations can be perfectly predicted."
reduction_step_9_probit_model = sm.Probit.from_formula(reduction_step_9_formula, df_with_dummies)

# n = 86 pr2 = 0.67 k = 31
# "A fraction 0.28 of observations can be perfectly predicted."
reduction_step_10_feature_names = a7.backward_elimination(df_with_dummies, reduction_step_9_feature_names, "industry_information_technology", 0.5, True)
reduction_step_10_formula = a7.get_formula("industry_information_technology", reduction_step_10_feature_names)
reduction_step_10_model = sm.Logit.from_formula(reduction_step_10_formula, data=df_with_dummies)

# n = 86 pr2 = 0.66 k = 31
# "A fraction 0.31 of observations can be perfectly predicted."
reduction_step_10_probit_model = sm.Probit.from_formula(reduction_step_10_formula, df_with_dummies)
print(reduction_step_10_probit_model.fit().summary())

print("favor_programming_career in step 9: " + str("favor_programming_career" in reduction_step_9_feature_names))
print("favor_programming_career in step 10: " + str("favor_programming_career" in reduction_step_10_feature_names))

