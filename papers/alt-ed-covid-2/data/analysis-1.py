# ref: some models in statsmodel lib: https://www.statsmodels.org/stable/api.html
# ref: some models in general: https://stackabuse.com/multiple-linear-regression-with-python/
# ref: https://towardsdfscience.com/linear-regression-in-6-lines-of-python-5e1d0cd05b8d
# ref: https://pbpython.com/notebook-alternative.html
# note: why no stata? "...if you use an unauthorized copy it will give you the wrong results without warning..."
#    https://www.econjobrumors.com/topic/there-are-no-stata-14-and-stata-15-torrents

import numpy as np
import matplotlib.pyplot as plt  # To visualize
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

df = pd.read_csv('alt-ed-covid-2-hidden-massaged.csv')

favorableAltCreds = df.iloc[:, 1].values.reshape(-1, 1)

isManager = df.iloc[:, 0].values.reshape(-1, 1)
expectedConventional = df.iloc[:, 2].values.reshape(-1, 1)
favorableOnlineEd = df.iloc[:, 3].values.reshape(-1, 1)
industry = df.iloc[:, 4].values.reshape(-1, 1)
gender = df.iloc[:, 5].values.reshape(-1, 1)
income = df.iloc[:, 6].values.reshape(-1, 1)
age = df.iloc[:, 7].values.reshape(-1, 1)
education = df.iloc[:, 8].values.reshape(-1, 1)
ethnicity = df.iloc[:, 9].values.reshape(-1, 1)
state = df.iloc[:, 10].values.reshape(-1, 1)
covidImpact = df.iloc[:, 11].values.reshape(-1, 1)
covidRemoteActivity = df.iloc[:, 12].values.reshape(-1, 1)
covidFavorability = df.iloc[:, 13].values.reshape(-1, 1)

X = df.iloc[:, [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]]
Y = favorableAltCreds

model = sm.OLS(Y, X)
results = model.fit()
print(results.params)
