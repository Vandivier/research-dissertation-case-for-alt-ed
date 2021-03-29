
from scipy import stats
import statsmodels.api as sm
import statsmodels.stats.api as sms
import statsmodels.stats.weightstats as ws
import analysis_1_vars as GetVars

# this file is about testing transfer theory; do vignette results apply to real world?
# concrete survey section has only high and low prestige; no 'mixed' schools

vignette = GetVars.getVignetteData()
concrete = GetVars.getConcreteData()
v_accredited = vignette[vignette.is_accredited == 1]['prestige_own'].dropna()
c_accredited = concrete[concrete.is_accredited == 1]['prestige_own'].dropna()
v_unaccredited = vignette[vignette.is_reiterated_unaccredited == 1]['prestige_own'].dropna()
c_unaccredited = concrete[concrete.is_reiterated_unaccredited == 1]['prestige_own'].dropna()
v_high_prestige = vignette[vignette.is_high_prestige == 1]['prestige_own'].dropna()
c_high_prestige = concrete[concrete.is_high_prestige == 1]['prestige_own'].dropna()

# summary stats to answer the questition 'what is the average prestige for high prestige learning providers'?
# this will provide transfer into concrete analysis
# go ahead and get average and sd prestige for: accredited, unaccredited, and high prestige
# TODO: make a table
print(v_accredited.describe())
print(c_accredited.describe())
print(v_unaccredited.describe())
print(c_unaccredited.describe())
print(v_high_prestige.describe())
print(c_high_prestige.describe())

# X1 = v_accredited.dropna().to_numpy()
# X2 = c_accredited.dropna().to_numpy()
# print(X1)
# print(X2)
# cm = sms.CompareMeans(sms.DescrStatsW(X1), sms.DescrStatsW(X2))
# # print(cm.tconfint_diff())
# print(cm.tconfint_diff(usevar='unequal'))

# # this works!
# print(stats.ttest_ind(X1,X2, equal_var = False, nan_policy='omit'))

# is the average prestige for an learning provider categories importantly different between vignette and concrete providers?
comparison_accredited = ws.CompareMeans.from_data(v_accredited, c_accredited)
comparison_unaccredited = ws.CompareMeans.from_data(v_unaccredited, c_unaccredited)
comparison_high_prestige = ws.CompareMeans.from_data(v_high_prestige, c_high_prestige)
print(comparison_accredited.summary())
print(comparison_unaccredited.summary())
print(comparison_high_prestige.summary())
print('---')
