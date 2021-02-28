
import matplotlib.pyplot as plt
import statsmodels.stats as sm
from scipy.stats import skew

import analysis_1_vars_and_regression as GetVars

df = GetVars.getDeskewedData(False)
df_skewed = GetVars.getData(False)
df_out = GetVars.getOutlierData(False)
df_ten = GetVars.getTens(False)

print(df_ten['favor_alt_creds'].describe())
print(df_ten['covid_impact_slight_negative_impact'].describe())
print(df_ten['covid_impact_moderate_negative_impact'].describe())
print(df_ten['covid_impact_large_negative_impact'].describe())
print(df_ten['covid_ind_remote_slight_degree'].describe())
print(df_ten['covid_ind_remote_moderate_degree'].describe())
print(df_ten['covid_ind_remote_large_degree'].describe())
print(df_ten['covid_ind_fav_online_slight_degree'].describe())
print(df_ten['covid_ind_fav_online_moderate_degree'].describe())
print(df_ten['covid_ind_fav_online_large_degree'].describe())
