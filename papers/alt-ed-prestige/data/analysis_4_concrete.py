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
import analysis_1_vars as GetVars

# long reg / m1: n=454, r2=0.492, ar2=0.367
m1 = '''hireability ~ conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + is_concrete + is_vignette
    + manager_effects_no + manager_effects_yes
    + gender_female + gender_male
    + 1'''

# if this file executed as script
if __name__ == '__main__':
    data = GetVars.getPanelizedData()

    long_reg = sm.OLS.from_formula(m1, data=data).fit()
    # reg_maxar2 = sm.OLS.from_formula(m3, data=data).fit()
    # robust = sm.RLM.from_formula(m9, data=data).fit()

    print(long_reg.summary())
    
