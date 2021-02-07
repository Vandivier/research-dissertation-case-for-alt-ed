# ref: some models in statsmodel lib: https://www.statsmodels.org/stable/api.html
# ref: some models in general: https://stackabuse.com/multiple-linear-regression-with-python/
# ref: https://towardsdfscience.com/linear-regression-in-6-lines-of-python-5e1d0cd05b8d
# ref: https://pbpython.com/notebook-alternative.html
# note: why no stata? "...if you use an unauthorized copy it will give you the wrong results without warning..."
#    https://www.econjobrumors.com/topic/there-are-no-stata-14-and-stata-15-torrents
# ref: https://dergipark.org.tr/en/download/article-file/744047

import numpy as np
import matplotlib.pyplot as plt  # To visualize
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

df = pd.read_csv('alt-ed-covid-2-hidden-massaged.csv')
# ref: https://stackoverflow.com/a/51428632/3931488
print(df.columns)

# TODO: rename columns here...
df.rename(columns={
          "Which of these industries most closely matches your profession?": "industry"}, inplace=True)
print(df.columns)

# TODO: ...then get dummies per: https://stackoverflow.com/questions/55738056/using-categorical-variables-in-statsmodels-ols-class
# df = pd.concat((
#     df,
#     pd.get_dummies(df['industry'], drop_first=True)), axis=1)

# TODO: then any custom vars per: https://kaijento.github.io/2017/04/22/pandas-create-new-column-sum/
# df['z'] = df.x + df.y

# TODO: regress using named columns
# m1 = ar2 0.232
# X1 = df.iloc[:, [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]]
# X1 = sm.add_constant(X1)
# Y = df.iloc[:, 1].values.reshape(-1, 1)
# m1 = sm.OLS(Y, X1)
# m1Results = m1.fit()

# # m2 = ar2 0.234
# X2 = X1
# del X2['What state do you reside in?']
# m2 = sm.OLS(Y, X2)
# m2Results = m2.fit()
# # print(m2Results.summary())

# fig, axes = plt.subplots()
# fig = sm.graphics.plot_fit(m1Results, 1, ax=axes)
# axes.set_ylabel("Favorability")
# axes.set_xlabel("Poverty Level")
# axes.set_title("Linear Regression")
# plt.show()

# plt.scatter(x, y
