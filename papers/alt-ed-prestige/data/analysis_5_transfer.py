
import statsmodels.api as sm
import statsmodels.stats.weightstats as ws
import analysis_1_vars as GetVars

# this file is about testing transfer theory; do vignette results apply to real world?
# concrete survey section has only high and low prestige; no 'mixed' schools

concrete = GetVars.getConcreteData()
nonpanelized = GetVars.getData()
vignette = GetVars.getVignetteData()

p_app_academy = nonpanelized['provider_impressed_app_academy'].dropna()
p_general_assembly = nonpanelized['provider_impressed_general_assembly'].dropna()
p_google = nonpanelized['provider_impressed_google'].dropna()
p_fvi_school_of_technology = nonpanelized['provider_impressed_fvi_school_of_technology'].dropna()
p_bov_academy = nonpanelized['provider_impressed_bov_academy'].dropna()

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

# so how much prestige_own to make up for is_accredited?
# even if not stipulated high prestige and holding constant whether other folks are impressed
# vignette mean is 6.49 and concrete mean was 7.05; to be conservative let's use the higher value
# m7 with method=["lbfgs"], B(is_accredited) = 0.649
# m7 without method=["lbfgs"], B(is_accredited) = 0.649
# m7, B(prestige_own) = 0.519
# m8, B(prestige_own) = 0.518
# m8, B(is_accredited) = 0.650
# avg + (B(is_accredited)+B(prestige_own)) = 7.045 + (0.649/0.519) = 7.045 + 1.250 = 8.3.
# avg + (B(is_accredited)+B(prestige_own)) = 7.045 + (0.650/0.518) = 7.045 + 1.255 = 8.3.
# that would let a non-high-prestige unaccredited credential substitute for a
# std dev 1.995; 75th quartile 9.0 (credited+unaccredited)
# logic of 8.3+ is "take the average credential and obtain a level of prestige as if it were accredited, although it's not"
# V print(c_unaccredited.describe())
# sd = 2.383, 75th quartile = 8.0, 100th quartile = 10
# https://stackoverflow.com/questions/39581893/pandas-find-percentile-stats-of-a-given-column
# 6.067 + 2.383*X = 8.3; X = req SD = 0.94 (argue a score of 8 is practically good enough, and 9 is very good)
# prestige_own quantiles within concrete distribution
# score of 8
print(c_unaccredited.quantile(0.7))
# score of 9
print(c_unaccredited.quantile(0.85))

print('p_google mean, median')
print(p_google.mean() + ', ' + p_google.quantile(0.5))
print('p_app_academy below')
p_app_academy = nonpanelized['provider_impressed_app_academy'].dropna()
print('p_general_assembly below')
p_general_assembly = nonpanelized['provider_impressed_general_assembly'].dropna()
print('p_fvi_school_of_technology below')
p_fvi_school_of_technology = nonpanelized['provider_impressed_fvi_school_of_technology'].dropna()
print('p_bov_academy below')
p_bov_academy = nonpanelized['provider_impressed_bov_academy'].dropna()


# which real alt ed places are good enough to make up for not accredited?


print('---')
