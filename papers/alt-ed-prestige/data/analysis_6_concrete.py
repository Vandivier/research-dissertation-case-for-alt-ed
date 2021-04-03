import statsmodels.api as sm
import analysis_1_vars as GetVars

data = GetVars.getConcreteData()

# same as m8 but with a different sample
m9 = '''hireability ~ prestige_own
    + is_accredited
    + is_stipulated_other_impressed
    '''

m10 = '''hireability ~ prestige_own
    + is_accredited
    + is_stipulated_other_impressed
    + conventional_alt_creds + favor_online_ed
    + cat_prefer_degree_true
    + industry_other
    + income_0_9999 + income_100000_124999
        + income_25000_49999 + income_50000_74999 + income_75000_99999
    + state_california
    '''

# method bfgs bc optimizer recommended by system
# none of these are converging so let's not use em
m11 = '''hireability ~ prestige_own
    + is_accredited
    + is_stipulated_other_impressed
    '''

# if this file executed as script
if __name__ == '__main__':
    strong_c_reg = sm.MixedLM.from_formula(m9, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method="bfgs")
    print(strong_c_reg.summary())

    bad = sm.MixedLM.from_formula(m10, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method="bfgs")
    print(bad.summary())

    strong_modified_c_reg = sm.MixedLM.from_formula(m11, data=data, groups=data["respondent_id"], re_formula="respondent_id").fit(method="bfgs")
    print(strong_modified_c_reg.summary())
