# the point of this file is: hey, you identified which factors are important but
# what are their directions of effect?
# TODO: use LOOCV-WX model l1_ratio=0.0001 as starting point
# try reducing high p-value factors, 1-by-1 until we get an optimized AIC and adjusted r2
# convinient that n < p in this case, so we can to RFE manually (bc automated lacks ar2 maximization algo)

import analysis_1_vars_and_regression as analysis
from sklearn import linear_model, model_selection
import statsmodels.api as sm

df_with_dummies = analysis.getDeskewedDataWithDummies(True)

# model is: loocv_nx_preferred + loocv_wx_preferred + sfs_gender_variables
model_important_candidates = '''hirability ~


+ gender_male:industry[T.Health]
+ gender_male:favor_programming_career:industry[T.Health]
+ gender_male:industry[T.Energy]
+ gender_male:industry[T.Law]
+ gender_male:industry[T.Military]
+ gender_male:industry[T.Real Estate]
+ gender_male:industry[T.Transportation]
+ gender_male:favor_programming_career:industry[T.Energy]
+ gender_male:favor_programming_career:industry[T.Law]
+ gender_male:favor_programming_career:industry[T.Real Estate]
+ gender_male:favor_seeking_risk:industry[T.Energy]
+ gender_male:favor_seeking_risk:industry[T.Law]
+ gender_male:favor_seeking_risk:industry[T.Real Estate]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Energy]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Information Technology]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Law]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Real Estate]
+ gender_male:industry[T.Retail]
+ gender_male:favor_programming_career:industry[T.Manufacturing]
+ gender_male:favor_programming_career:industry[T.Retail]
+ gender_male:favor_seeking_risk
+ gender_male:favor_seeking_risk:industry[T.Retail]
+ gender_male:favor_programming_career:favor_seeking_risk:industry[T.Retail]

+ 1'''

important_candidates = sm.OLS.from_formula(model_important_candidates, data=df_with_dummies)
print(important_candidates.fit().summary())
