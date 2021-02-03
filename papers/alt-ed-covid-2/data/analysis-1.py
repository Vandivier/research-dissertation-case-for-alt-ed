# ref: https://towardsdatascience.com/linear-regression-in-6-lines-of-python-5e1d0cd05b8d
# ref: https://pbpython.com/notebook-alternative.html
# note: why no stata? "...if you use an unauthorized copy it will give you the wrong results without warning..."
#    https://www.econjobrumors.com/topic/there-are-no-stata-14-and-stata-15-torrents

import numpy as np
import matplotlib.pyplot as plt  # To visualize
import pandas as pd  # To read data
from sklearn.linear_model import LinearRegression

data = pd.read_csv('alt-ed-covid-2-hidden-massaged.csv')

# -1 means that calculate the dimension of rows, but have 1 column
# X variable is age
X = data.iloc[:, 7].values.reshape(-1, 1)

# Col 1 is favorability, output var of interested
Y = data.iloc[:, 1].values.reshape(-1, 1)

linear_regressor = LinearRegression()  # create object for the class
linear_regressor.fit(X, Y)  # perform linear regression
Y_pred = linear_regressor.predict(X)  # make predictions

plt.scatter(X, Y)
plt.plot(X, Y_pred, color='red')
plt.show()

# # -1 means that calculate the dimension of rows, but have 1 column
# # X1 Variable Question: "To what degree has coronavirus negatively impacted your life?"
# X1 = data.iloc[:, 11].values.reshape(-1, 1)

# # X2 Variable Question: "Age?"
# X2 = data.iloc[:, 7].values.reshape(-1, 1)

# # Col 1 is favorability, output var of interested
# Y = data.iloc[:, 1].values.reshape(-1, 1)

# linear_regressor = LinearRegression()  # create object for the class
# linear_regressor.fit(X2, X1, Y)  # perform linear regression
# Y_pred = linear_regressor.predict(X2, X1)  # make predictions

# plt.scatter(X1, Y)
# plt.plot(X1, Y_pred, color='red')
# plt.show()
