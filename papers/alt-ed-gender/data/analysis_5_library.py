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


from sklearn.linear_model import LinearRegression
from sklearn.feature_selection import RFECV
from sklearn.svm import SVR
import statsmodels.api as sm
import analysis_1_vars_and_regression as analysis

deskewed = analysis.getDeskewedData()

kitchen_sink_formula = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + 1'''

kitchen_sink_model = sm.OLS.from_formula(kitchen_sink_formula, data=deskewed)

y = kitchen_sink_model.endog
X = kitchen_sink_model.exog

# SVR is nonlinear, even tho kernel is linear
# avoid SVR due to ref #1 above
# ref: https://stackoverflow.com/questions/46970888/difference-between-linearregression-and-svm-svrkernel-linear
# coef_ is literally coefficient sizes! boo! can't use it
# ref: https://machinelearningmastery.com/calculate-feature-importance-with-python/
estimator_lr = LinearRegression()
estimator_svr = SVR(kernel="linear")

# 5 is default for RFECV but make it clear
# force 3 features to select; by default only 1 or 2 survived depending on estimator
model_lr =  RFECV(estimator, cv=5, min_features_to_select=3, step=1)
model_svr =  RFECV(estimator, cv=5, min_features_to_select=3, step=1)

results_lr = rfe_model.fit(X, y)
results_svr = rfe_model.fit(X, y)

print(results.support_)
# print(results.ranking_)


#Concat and name columns
ranked = pd.concat([names,rankings], axis=1)
ranked.columns = ["Feature", "Rank"]
ranked

top_features = ranked.loc[ranked['Rank'] ==1]
print(most_important)

most_important['Rank'].count()
