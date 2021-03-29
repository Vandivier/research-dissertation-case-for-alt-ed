
import statsmodels.api as sm
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

# is the average prestige for an learning provider categories importantly different between vignette and concrete providers?
# answer: stat sig, yes, but not important for unaccredited. so we can locate a concrete high prestige alt cred.
#       diff is important for accredited and high prestige;
#       vignette high prestige was higher than concrete high prestige
#       vignette accredited prestige was lower than concrete accredited prestige
comparison_accredited = ws.CompareMeans.from_data(v_accredited, c_accredited)
comparison_unaccredited = ws.CompareMeans.from_data(v_unaccredited, c_unaccredited)
comparison_high_prestige = ws.CompareMeans.from_data(v_high_prestige, c_high_prestige)
print(comparison_accredited.summary())
print(comparison_unaccredited.summary())
print(comparison_high_prestige.summary())
print('---')
