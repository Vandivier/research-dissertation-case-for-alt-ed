# Question of interest: Does prestige matter more than accreditation?
# three approaches:
# 1. summary stats (this file)
# 2. synthetic records regression (turn 1 row into multiple; concrete 2 ways and vignette)
#   b. supplement with rotation of models approach in case big regression is contested
# 3. standard regression (Q13 and 14 of interest)

import statsmodels.stats as sm
import analysis_1_vars as GetVars

df = GetVars.getData(False)
panelized = GetVars.getPanelizedData()
concrete = GetVars.getConcreteData(panelized)
vignette = GetVars.getVignetteData(panelized)

# Make Table like [Difference, High, Low] x [Accreditation, Prestige]
# These summary table categories turn into Booleans for reg analysis:
# Subgroups:
#   Accreditation -> [concrete, vignette] x [high, low]
#   Prestige -> [concrete] x [high, low] + [vignette] x [high, low, mixed]
# Mixed should be broken up for regression, but need not be broken up for summary table

print(df['hireability_delta_accreditation'].describe())
print(df['hireability_delta_prestige'].describe())

print(df['cat_work_with_external_partners_a'].describe())
print(df['cat_work_with_external_partners_b'].describe())
print(df['cat_work_with_external_partners_c'].describe())
print(df['cat_work_with_external_partners_d'].describe())

# a2.1
# uncomment below line to throw error...this is good it proves hirability exists only for vignette as expected
# print(df['hirability'].describe())
print(df['baseline_hirability'].describe())

# a2.2
# n = 454, mean = frequency of disagreement (to prefer degree) = 41.63%
print(df['cat_prefer_degree_false'].describe())

# nan for hirability here is good. it proves hirability for concrete DNE as expected
print('agg')
print(concrete['hirability'].mean())
print(concrete['prestige_own'].mean())
print(concrete['hirability'][concrete.is_accredited == 1].mean())
print(concrete['prestige_own'][concrete.is_accredited == 1].mean())
print(concrete['hirability'][concrete.is_accredited == 0].mean())
print(concrete['prestige_own'][concrete.is_accredited == 0].mean())
print('prestige, high')
print(concrete['hirability'][concrete.is_high_prestige == 1].mean())
print(concrete['prestige_own'][concrete.is_high_prestige == 1].mean())
print(concrete['hirability'][concrete.is_low_prestige == 1].mean())
print(concrete['prestige_own'][concrete.is_low_prestige == 1].mean())

print('agg')
print(vignette['hirability'].mean())
print(vignette['prestige_own'].mean())
print(vignette['hirability'][vignette.is_accredited == 1].mean())
print(vignette['prestige_own'][vignette.is_accredited == 1].mean())
print(vignette['hirability'][vignette.is_accredited == 0].mean())
print(vignette['prestige_own'][vignette.is_accredited == 0].mean())
print('prestige, high')
print(vignette['hirability'][vignette.is_high_prestige == 1].mean())
print(vignette['prestige_own'][vignette.is_high_prestige == 1].mean())
print(vignette['hirability'][vignette.is_low_prestige == 1].mean())
print(vignette['prestige_own'][vignette.is_low_prestige == 1].mean())

print('agg')
print(panelized['hirability'].mean())
print(panelized['prestige_own'].mean())
print(panelized['hirability'][panelized.is_accredited == 1].mean())
print(panelized['prestige_own'][panelized.is_accredited == 1].mean())
print(panelized['hirability'][panelized.is_accredited == 0].mean())
print(panelized['prestige_own'][panelized.is_accredited == 0].mean())
print('prestige, high')
print(panelized['hirability'][panelized.is_high_prestige == 1].mean())
print(panelized['prestige_own'][panelized.is_high_prestige == 1].mean())
print(panelized['hirability'][panelized.is_low_prestige == 1].mean())
print(panelized['prestige_own'][panelized.is_low_prestige == 1].mean())

# a2.3
# ref: table-summary-stats.tex
#                                   Avg Hirability      Avg Prestige                            
# Actual Schools                    n/a                 6.50
#     accredited                    n/a                 7.05
#     unaccredited                  n/a                 6.07
#     difference                    n/a                 0.98
#     stipulated high prestige      n/a                 6.72
#     stipulated low prestige       n/a                 6.23
#     difference                    n/a                 0.49
# Vignette Schools                  6.49                6.21
#     accredited                    6.97                6.49
#     unaccredited                  6.02                5.93
#     difference                    0.95                0.56
#     stipulated high prestige      7.59                7.69
#     stipulated low prestige       5.63                4.94
#     difference                    1.96                2.75
# Combined Schools                  n/a                 6.37
#     accredited                    n/a                 6.77
#     unaccredited                  n/a                 6.01
#     difference                    n/a                 0.76
#     stipulated high prestige      n/a                 7.00
#     stipulated low prestige       n/a                 5.80
#     difference                    n/a                 1.20

