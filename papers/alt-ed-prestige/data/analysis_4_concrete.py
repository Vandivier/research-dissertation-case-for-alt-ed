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
