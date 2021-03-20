# Question of interest: Does prestige matter more than accreditation?
# three approaches:
# 1. summary stats (this file)
# 2. synthetic records regression (turn 1 row into multiple; concrete 2 ways and vignette)
#   b. supplement with rotation of models approach in case big regression is contested
# 3. standard regression (Q13 and 14 of interest)

import statsmodels.stats as sm
import analysis_1_vars as GetVars

df = GetVars.getData(False)

# Make Table like [Difference, High, Low] x [Accreditation, Prestige]
# These summary table categories turn into Booleans for reg analysis:
# Subgroups:
#   Accreditation -> [concrete, vignette] x [high, low]
#   Prestige -> [concrete] x [high, low] + [vignette] x [high, low, mixed]
# Mixed should be broken up for regression, but need not be broken up for summary table

print(df['hireability_delta_accreditation'].describe())
print(df['hireability_delta_prestige'].describe())

# n = 454, mean = frequency of agreement (to prefer degree) = 58.37%
print(df['cat_prefer_degree_true'].describe())
