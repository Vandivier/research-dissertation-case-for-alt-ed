# regression questions:
# 1. is concrete favorability driven by prestige over accreditation (concrete_booleanized)
# 2. is concrete favorability related to concrete / external prestige (quality and/or name recognition)?;
#    (concrete_interacted) - just interact bool with some prestige multiplier

# TODO: gen synthetic records csv; send this one to Robin
# sample for basic regs should be synthetic records model where is_concrete == 0 && is_vignette == 0
# synthetic records takes a persons response and cuts out n columns then turns those into n responses w same controls
# this means the expected response for Google is (high prestige)*concrete effects (interactable)
# seperately model is_google vs weighted_google, weighted for prestige
# 21 regressions and the coefficient of prestige can be averaged in different ways to emulate boolean coefficients
# boolean coefficients preferred bc controls are truly held constant. otherwise control coefficients can vary model
#   if you average the whole model by group (say, concrete high prestige) do you get the same coefficient? i'd be surprised but maybe.

import statsmodels.api as sm
import statsmodels.formula.api as smf
import analysis_1_vars as GetVars

# I want a random intercepts model which is like
# fixed effect vs random effect
# https://www.youtube.com/watch?v=QCqF-2E86r0
# random effects recommended for repeated measures/samples (eg individual effects)
# using another lib: https://www.youtube.com/watch?v=Q0kossogTko
# really confirm random individual effects: https://www.youtube.com/watch?v=FCcVPsq8VcA
# get a graph https://nbviewer.jupyter.org/urls/umich.box.com/shared/static/6tfc1e0q6jincsv5pgfa.ipynb
# https://www.youtube.com/watch?v=QeCJ9ON0WDc

# vignette long reg / m4
# this is m3 but using panelized cross-section plus vignette independent vars
# also includes linear individual fixed effects (respondent_id)
# https://www.statsmodels.org/devel/mixed_linear.html w/ citation
# n=3600, r2=0.554, ar2=0.549
m4 = '''hireability ~ prestige_own'''

    # TODO: fix above reg and include some below factors
    # fix maybe here: https://stackoverflow.com/questions/37144913/getting-valueerror-the-indices-for-endog-and-exog-are-not-aligned
    # + is_high_prestige + is_low_prestige
    # '''

    # + conventional_alt_creds + favor_online_ed
    # + cat_prefer_degree_true
    # + industry_information_technology
    # + income_0_9999
    # + age_45_60
    # + prestige_own
    # + 1'''
    # + is_accredited
    # + is_stipulated_other_impressed + is_stipulated_self_impressed
    # + prestige_own'''
    # # + 1'''
    # 

# if this file executed as script
if __name__ == '__main__':
    data = GetVars.getVignetteData()

    # sm.MixedLM.from_formula("Weight ~ Time", data, re_formula="Time", groups=data["Pig"])

    # long_v_mixedfxreg = smf.mixedlm(m4, data, groups=data["respondent_id"])
    # mdf = long_v_mixedfxreg.fit(method=["lbfgs"])
    # print(mdf.summary())

    # long_v_reg = sm.MixedLM.from_formula(m4, data, re_formula="respondent_id + is_accredited + is_high_prestige + is_low_prestige", groups=data["respondent_id"]).fit()
    # long_v_reg = sm.MixedLM.from_formula(m4, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method=["lbfgs"])
    long_v_reg = sm.MixedLM.from_formula(m4, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method=["lbfgs"])
    # TODO: maybe this is why singular fit: https://stats.stackexchange.com/a/489243/142294
    # long_v_reg = sm.OLS.from_formula(m4, data=data).fit()
    # # not bothering about weak reg
    # maxar2_v_reg = sm.OLS.from_formula(m5, data=data).fit()

    print(long_v_reg.summary())
