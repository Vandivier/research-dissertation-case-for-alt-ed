# ref: analysis_1_vars_and_regression.py within papers/alt-ed-covid-2

import numpy as np
import matplotlib.pyplot as plt  # To visualize
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm


def fsReformatColumnNamesLikeStata(sColName):
    sMassagedName = sColName.lower() \
        .replace(',', '').replace(' ', '').replace('-', '') \
        .replace('>', '').replace('+', '').replace('_/_', '') \
        .replace('?', '')

    return (sMassagedName[0:32]).strip()


def getData(dropFirstDummy=True):
    df = pd.read_csv('replicate-hidden-wrangled.csv')
    df.rename(fsReformatColumnNamesLikeStata, axis='columns', inplace=True)

    if dropFirstDummy:
        df = pd.get_dummies(df, columns=['doyoucontributetohiring', 'whatstatedoyouresidein'], drop_first=True)
    else:
        df = pd.get_dummies(df, columns=['doyoucontributetohiring', 'whatstatedoyouresidein'])

    print(" + ".join(list(df.columns)))

    df['aetiwo_concientiousness'] = df.concientiousness_ideal - df.concientiousness_ngwac
    df['aetiwo_customerserviceskill'] = df.customerserviceskill_ideal - df.customerserviceskill_ngwac
    df['aetiwo_rulebreaker'] = df.rulebreaker_ideal - df.rulebreaker_ngwac

    print("---")
    print("done getting data")
    print("---")
    return df

# ref: equivalent to STATA model `regtocompare2`
# note: STATA(state_13) != response value of "13" || whatstatedoyouresidein_13
#   for STATA, state_13 is the 13th unique state response...I think using an alpha sort not sure
#TODO: better to include the states but these vals aren't equivalent to regtocompare1:
# + whatstatedoyouresidein_13 + whatstatedoyouresidein_21 + whatstatedoyouresidein_34 + whatstatedoyouresidein_36 + whatstatedoyouresidein_8
m1 = '''formanyprofessionsalternativecre ~
    + aetiwo_concientiousness + aetiwo_customerserviceskill + aetiwo_rulebreaker
    + doyoucontributetohiring_1 + doyoucontributetohiring_2
    + rulebreakersnormsprobablyhaveaha + rulebreakersnormsmightbedoingsob + rulebreakersnormstendtobegiftedi
    + 1'''

# if this file executed as script
if __name__ == '__main__':
    print(sm.OLS.from_formula(m1, data=getData(False)).fit().summary())

# Note: Output pasted in comment below for quick reference.
# TLDR: How does it compare to STATA? Total match.
# ====
#                                    OLS Regression Results
# ============================================================================================
# Dep. Variable:     formanyprofessionsalternativecre   R-squared:                       0.205
# Model:                                          OLS   Adj. R-squared:                  0.173
# Method:                               Least Squares   F-statistic:                     6.530
# Date:                              Fri, 26 Feb 2021   Prob (F-statistic):           1.43e-07
# Time:                                      00:36:54   Log-Likelihood:                -401.01
# No. Observations:                               212   AIC:                             820.0
# Df Residuals:                                   203   BIC:                             850.2
# Df Model:                                         8
# Covariance Type:                          nonrobust
# ====================================================================================================
#                                        coef    std err          t      P>|t|      [0.025      0.975]
# ----------------------------------------------------------------------------------------------------
# Intercept                            2.8988      0.991      2.925      0.004       0.945       4.853
# aetiwo_concientiousness              0.1498      0.072      2.083      0.039       0.008       0.292
# aetiwo_customerserviceskill         -0.1575      0.062     -2.534      0.012      -0.280      -0.035
# aetiwo_rulebreaker                  -0.0573      0.057     -1.006      0.315      -0.170       0.055
# doyoucontributetohiring_1            0.5910      0.847      0.697      0.486      -1.080       2.262
# doyoucontributetohiring_2            0.9664      0.843      1.147      0.253      -0.695       2.628
# rulebreakersnormsprobablyhaveaha     0.1836      0.050      3.670      0.000       0.085       0.282
# rulebreakersnormsmightbedoingsob     0.1923      0.077      2.494      0.013       0.040       0.344
# rulebreakersnormstendtobegiftedi     0.1858      0.071      2.623      0.009       0.046       0.326
# ==============================================================================
# Omnibus:                       16.415   Durbin-Watson:                   1.958
# Prob(Omnibus):                  0.000   Jarque-Bera (JB):               18.145
# Skew:                          -0.638   Prob(JB):                     0.000115
# Kurtosis:                       3.654   Cond. No.                         162.
# ==============================================================================

# Notes:
# [1] Standard Errors assume that the covariance matrix of the errors is correctly specified.
