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

# I want a random intercepts model which is like
# fixed effect vs random effect
# https://www.youtube.com/watch?v=QCqF-2E86r0
# random effects recommended for repeated measures/samples (eg individual effects)
# using another lib: https://www.youtube.com/watch?v=Q0kossogTko
# really confirm random individual effects: https://www.youtube.com/watch?v=FCcVPsq8VcA
# get a graph https://nbviewer.jupyter.org/urls/umich.box.com/shared/static/6tfc1e0q6jincsv5pgfa.ipynb
# https://www.youtube.com/watch?v=QeCJ9ON0WDc

import statsmodels.api as sm
import analysis_1_vars as GetVars


data = GetVars.getVignetteData()


# removing is_low_prestige eliminates Hessian concern. ref: theanalysisfactor.com/wacky-hessian-matrix/
#   however, maybe backwards elimination will also remove the hessian concern. let's see.
# long_v_reg, is m3 + vignette effects and respecified into a mixed linear model
#   (that is, a cross-sectional panel OLS plus individual random effects)
# singular matrix ref: https://stats.stackexchange.com/a/489243/142294
# n=3600, r2=0.554, ar2=0.549
m4 = '''hireability ~ prestige_own
    + is_accredited
    + is_high_prestige + is_low_prestige
    + is_stipulated_other_impressed
    + conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + cat_work_with_external_partners_b + cat_work_with_external_partners_c + cat_work_with_external_partners_d
    + industry_education + industry_finance_investment_or_accounting
    + industry_information_technology + industry_manufacturing + industry_other
    + income_0_9999 + income_100000_124999
        + income_175000_199999 + income_200000 + income_25000_49999 + income_50000_74999 + income_75000_99999
    + age_45_60
    + state_arizona + state_california + state_connecticut
        + state_florida + state_georgia + state_kansas
        + state_maryland + state_massachusetts + state_michigan + state_mississippi
        + state_missouri + state_nebraska + state_new_mexico
        + state_pennsylvania
        + state_tennessee + state_texas + state_west_virginia
    '''
    # + is_stipulated_self_impressed

m5 = '''hireability ~ prestige_own
    + is_accredited
    + is_high_prestige + is_low_prestige
    + is_stipulated_other_impressed
    + conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + industry_other
    + income_0_9999 + income_100000_124999
        + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_california + state_michigan + state_missouri + state_nebraska
    '''

m6 = '''hireability ~ prestige_own
    + is_accredited
    + is_high_prestige + is_low_prestige
    + is_stipulated_other_impressed
    + conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + industry_other
    + income_0_9999 + income_100000_124999
        + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_california
    '''

# technically, this was optimized using .fit(method=["lbfgs"])
# then i dropped it bc m8 wouldn't converge unless i dropped it
# also, idk what it does so good idea to drop it
# negative side-effect is, I didn't backward-select m4-m7 without it
# m7 with method=["lbfgs"], B(is_accredited) = 0.649
# m7 without method=["lbfgs"], B(is_accredited) = 0.649
# so, I don't think it matters
m7 = '''hireability ~ prestige_own
    + is_accredited
    + is_low_prestige
    + is_stipulated_other_impressed
    + conventional_alt_creds
    + state_california
    '''

# shorter model for practical application
# during application, assume is_stipulated_other_impressed = false for a more conservative estimate
# in practice, degree-substituting consumers will prefer high prestige alt creds; so removing the factor
# creates a more conservative prestige_own effect through an intentional omitted variable bias
# i would keep the CA factor but model doesn't converge in that case
m8 = '''hireability ~ prestige_own
    + is_accredited
    + is_stipulated_other_impressed
    '''

# this is m7 plus is_accredited*prestige_own
# the idea here is that accreditation interacts w prestige in such a way
# that there is no independent substance to accreditation other than the hidden prestige
# the expected result is not found
# instead, accreditation and prestige magnitudes both increase while maintaining high significance
# the interaction presents a highly significant negative, or attenuating, effect.
# this agrees with the hypothesis that accreditation and prestige share a duplicative explanatory component,
# but it strongly disagrees with the hypothesis that the shared component dominates the total explanatory power of accreditation
# what are the non-prestige reasons accreditation might matter?
#   1) legal requirement of education for doctors, lawyers, and so on,
#   2) legal support for accredited education vis a vis subsidies, loans, and so on,
#   3) predictability / risk concerns,
#   4) deep systemic lock-in from before the internet and flourishing of alternative education
m9 = '''hireability ~ prestige_own
    + is_accredited + (is_accredited*prestige_own) 
    + is_low_prestige
    + is_stipulated_other_impressed
    + conventional_alt_creds
    + state_california
    '''

# if this file executed as script
if __name__ == '__main__':
    # prefer weak v strong to fight overfit in mixed lm; there is no ar2 measure
    # weak reg has Hessian matrix issue
    # long_v_reg = sm.MixedLM.from_formula(m4, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method=["lbfgs"])
    # weak_v_reg = sm.MixedLM.from_formula(m5, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method=["lbfgs"])
    # point_three_v_reg = sm.MixedLM.from_formula(m6, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method=["lbfgs"])

    strong_v_reg = sm.MixedLM.from_formula(m7, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit()
    print(strong_v_reg.summary())

    strong_modified_v_reg = sm.MixedLM.from_formula(m8, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit()
    print(strong_modified_v_reg.summary())

    strong_modified_interacted_v_reg = sm.MixedLM.from_formula(m9, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit()
    print(strong_modified_interacted_v_reg.summary())

    # a4.1
    # low prestige is about one-third of a standard deviation lower hireability
    # and still over 5; more yes than no (maybe affirmation bias can negate tho)
    without_accreditation = data[data.is_accredited == False]
    print(without_accreditation[without_accreditation.is_low_prestige == True].hireability.mean())
    print(without_accreditation.hireability.describe())

    # a4.2
    # average alt cred prestige among those exposed to quality ratings vs not
    # small increase but increase nontheless (stat insignificant tbh; multiple reg could change that)
    print(without_accreditation[without_accreditation.is_low_context == False].prestige_own.mean())
    print(without_accreditation[without_accreditation.is_low_context == True].prestige_own.mean())
