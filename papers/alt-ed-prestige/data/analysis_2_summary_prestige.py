# Question of interest: Does prestige matter more than accreditation?
# three approaches:
# 1. summary stats (this file)
# 2. synthetic records regression (turn 1 row into multiple; concrete 2 ways and vignette)
# 3. standard regression (Q13 and 14 of interest)

import matplotlib.pyplot as plt
import statsmodels.stats as sm
from scipy.stats import skew

import analysis_1_vars_and_regression as GetVars

df = GetVars.getData(False)

# Make Table like [Difference, High, Low] x [Accreditation, Prestige]
# These summary table categories turn into Booleans for reg analysis:
# Subgroups:
#   Accreditation -> [concrete, vignette] x [high, low]
#   Prestige -> [concrete] x [high, low] + [vignette] x [high, low, mixed]
# Mixed should be broken up for regression, but need not be broken up for summary table



print(df['favor_alt_creds'].describe())
print(df['covid_impact_slight_negative_impact'].describe())
print(df['covid_impact_moderate_negative_impact'].describe())
print(df['covid_impact_large_negative_impact'].describe())
print(df['covid_ind_remote_slight_degree'].describe())
print(df['covid_ind_remote_moderate_degree'].describe())
print(df['covid_ind_remote_large_degree'].describe())
print(df['covid_ind_fav_online_slight_degree'].describe())
print(df['covid_ind_fav_online_moderate_degree'].describe())
print(df['covid_ind_fav_online_large_degree'].describe())
