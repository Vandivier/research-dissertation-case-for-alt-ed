# ref: https://datatofish.com/multiple-linear-regression-python/

# import numpy as np
import pandas as pd
import statsmodels.api as sm

# could have made a normal dataframe in csv and do pd.readcsv
oStudentData = {
    # 'SchoolType': ['Home School', 'Public', 'Religious', 'Independent', 'Other'],
    'TotalScore': [1623, 1471, 1597, 1657, 1521],
    'Rank': [5, 1, 2, 4, 3],
    # 'Count': [13549, 1306039, 142783, 102358, 121215],
}

# oStudentData['RankSquared'] = list(map(lambda i: i * i, oStudentData['Rank']))
# oStudentData['CountSquared'] = [*map(lambda i: i * i, oStudentData['Count'])]
# oStudentData['CountRank'] = [*map(lambda iCount, iRank: iCount * iRank, oStudentData['Count'], oStudentData['Rank'])]
# oStudentData['CountRankSquared'] = [*map(lambda i: i * i, oStudentData['CountRank'])]

arrsStudentDataColumns = [*oStudentData.keys()]
arrsIndependentVariableNames = [*filter(lambda sKey: sKey != 'TotalScore', arrsStudentDataColumns)]
dataFrame = pd.DataFrame(oStudentData, columns=arrsStudentDataColumns)
dictIndependent = dataFrame[arrsIndependentVariableNames]
dictDependent = dataFrame['TotalScore']

dictIndependentWithConstants = sm.add_constant(dictIndependent)
model = sm.OLS(dictDependent, dictIndependentWithConstants).fit() 
print_model = model.summary()
print(print_model)
