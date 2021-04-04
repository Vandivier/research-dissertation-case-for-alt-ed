
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

p_california_institute_of_technology = nonpanelized['provider_impressed_california_institute_of_technology'].dropna()
p_university_of_chicago = nonpanelized['provider_impressed_university_of_chicago'].dropna()
p_portland_state_university = nonpanelized['provider_impressed_portland_state_university'].dropna()
p_university_of_nebraska_omaha = nonpanelized['provider_impressed_university_of_nebraska_omaha'].dropna()

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

print('p_google mean then median below')
print(p_google.mean())
print(p_google.quantile(0.5))
print('p_app_academy mean then median below')
print(p_app_academy.mean())
print(p_app_academy.quantile(0.5))
print('p_general_assembly mean then median below')
print(p_general_assembly.mean())
print(p_general_assembly.quantile(0.5))
print('p_fvi_school_of_technology mean then median below')
print(p_fvi_school_of_technology.mean())
print(p_fvi_school_of_technology.quantile(0.5))
print('p_bov_academy mean then median below')
print(p_bov_academy.mean())
print(p_bov_academy.quantile(0.5))

# which real alt ed places are good enough to make up for not accredited?
# looks like, on average, none of them meet the 8/9 bar

print('---accredited below')

print('p_california_institute_of_technology mean then median below')
print(p_california_institute_of_technology.mean())
print(p_california_institute_of_technology.quantile(0.5))
print('p_university_of_chicago mean then median below')
print(p_university_of_chicago.mean())
print(p_university_of_chicago.quantile(0.5))
print('p_portland_state_university mean then median below')
print(p_portland_state_university.mean())
print(p_portland_state_university.quantile(0.5))
print('p_university_of_nebraska_omaha mean then median below')
print(p_university_of_nebraska_omaha.mean())
print(p_university_of_nebraska_omaha.quantile(0.5))

print('---')
print('with high context below')
print('---')

with_high_context = nonpanelized[nonpanelized.is_low_context == 0]

# results:
# with the exception of fvi_school_of_technology, unaccredited responses fell in expected order on average
# however, only google was good enough to beat any accredited degree on average (it beat 2)
# at the same time, some proportion of respondents considered alt creds substitutable to some extent every time.

p_app_academy = with_high_context['provider_impressed_app_academy'].dropna()
p_general_assembly = with_high_context['provider_impressed_general_assembly'].dropna()
p_google = with_high_context['provider_impressed_google'].dropna()
p_fvi_school_of_technology =with_high_context['provider_impressed_fvi_school_of_technology'].dropna()
p_bov_academy = with_high_context['provider_impressed_bov_academy'].dropna()

p_california_institute_of_technology = with_high_context['provider_impressed_california_institute_of_technology'].dropna()
p_university_of_chicago = with_high_context['provider_impressed_university_of_chicago'].dropna()
p_portland_state_university = with_high_context['provider_impressed_portland_state_university'].dropna()
p_university_of_nebraska_omaha = with_high_context['provider_impressed_university_of_nebraska_omaha'].dropna()

c_unaccredited = concrete[concrete.is_low_context == 0][concrete.is_reiterated_unaccredited == 1]['prestige_own'].dropna()
# score of 8
print(c_unaccredited.quantile(0.7))
# score of 9
print(c_unaccredited.quantile(0.85))

print('p_google mean then median below')
print(p_google.mean())
print(p_google.quantile(0.5))
print('p_app_academy mean then median below')
print(p_app_academy.mean())
print(p_app_academy.quantile(0.5))
print('p_general_assembly mean then median below')
print(p_general_assembly.mean())
print(p_general_assembly.quantile(0.5))
print('p_fvi_school_of_technology mean then median below')
print(p_fvi_school_of_technology.mean())
print(p_fvi_school_of_technology.quantile(0.5))
print('p_bov_academy mean then median below')
print(p_bov_academy.mean())
print(p_bov_academy.quantile(0.5))

# which real alt ed places are good enough to make up for not accredited?
# looks like, on average, none of them meet the 8/9 bar

print('---accredited below')

print('p_california_institute_of_technology mean then median below')
print(p_california_institute_of_technology.mean())
print(p_california_institute_of_technology.quantile(0.5))
print('p_university_of_chicago mean then median below')
print(p_university_of_chicago.mean())
print(p_university_of_chicago.quantile(0.5))
print('p_portland_state_university mean then median below')
print(p_portland_state_university.mean())
print(p_portland_state_university.quantile(0.5))
print('p_university_of_nebraska_omaha mean then median below')
print(p_university_of_nebraska_omaha.mean())
print(p_university_of_nebraska_omaha.quantile(0.5))


print('espoused weakly to prefer alt cred before then after adding context')
print(nonpanelized['prefer_alt_cred_espoused_weakly'].mean())
print(with_high_context['prefer_alt_cred_espoused_weakly'].mean())

print('revealed prefer alt cred sometimes before then after adding context')
print(nonpanelized['prefer_alt_cred_revealed'].mean())
print(with_high_context['prefer_alt_cred_revealed'].mean())

print('revealed prefer high alt cred to low accredited before then after adding context')
print(nonpanelized['prefer_alt_cred_revealed_high_v_low'].mean())
print(with_high_context['prefer_alt_cred_revealed_high_v_low'].mean())

print('revealed prefer high alt cred to low accredited no google before then after adding context')
print(nonpanelized['prefer_alt_cred_revealed_high_v_low_no_goog'].mean())
print(with_high_context['prefer_alt_cred_revealed_high_v_low_no_goog'].mean())

print('revealed prefer high alt cred to high accredited before then after adding context')
print(nonpanelized['prefer_alt_cred_revealed_high_v_high'].mean())
print(with_high_context['prefer_alt_cred_revealed_high_v_high'].mean())

print('revealed prefer high alt cred to high accredited no google before then after adding context')
print(nonpanelized['prefer_alt_cred_revealed_high_v_high_no_goog'].mean())
print(with_high_context['prefer_alt_cred_revealed_high_v_high_no_goog'].mean())

# a5.1
# summary with high context
# context shifts unaccredited right and accredited
# ---
# 70th - before [8] - after [7]
# 85th - before [9] - after [9]
# goog - before [7.058] - after [7.100]
# app_academy - before [5.776] - after [5.822]
# gen_ass - before [5.754] - after [5.871]
# fvi - before [6.100] - after [6.054]
# bov - before [5.647] - after [5.602]
# caltech - before [7.463] - after [7.481]
# uchicago - before [7.545] - after [7.515]
# portland - before [6.678] - after [6.494]
# nebraska - before [6.494] - after [6.344]
#
# espoused weakly to prefer alt cred before then after adding context
# before context - 0.416
# after context - 0.376
# revealed prefer alt cred sometimes before then after adding context
# before context - 0.714
# after context - 0.748
# revealed prefer high alt cred to low accredited before then after adding context
# before context - 0.626
# after context - 0.645
# revealed prefer high alt cred to low accredited no google before then after adding context
# before context - 0.377
# after context - 0.430
# revealed prefer high alt cred to high accredited before then after adding context
# before context - 0.502
# after context - 0.512
# revealed prefer high alt cred to high accredited no google before then after adding context
# before context - 0.278
# after context - 0.298
