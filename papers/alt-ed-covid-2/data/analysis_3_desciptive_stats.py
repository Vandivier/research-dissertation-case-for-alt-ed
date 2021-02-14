
import matplotlib.pyplot as plt

import analysis_1_vars_and_regression as GetVars

df = GetVars.getData()

# note: mean 7.6, median 8.0
print(df['favor_alt_creds'].describe())

# TODO: results:
# 1. what is effect of covid impact?
# 2. what is the average effect of covid impact?
# 3. what is effect of other two covid vars?
# 4. how do interpret counterintuitive covid_ind_fav_online?
# 5. what is the average total effect across all three vars?
# 6. what is the average favorability?

# TODO: conclusion:
# 1. it's a bit speculative, but do we think this bump is transient or permanent? why?
# 2. how does this relate to covid impact to school choice results?
# 3. what open questions remain?
#     a. collecting more samples and samples over time would allow for more confidence bc multi-specification checks, forward-testing, more factor confidence.
#     b. identifying underlying patterns within-group for state, industry, and ethnic effects could prove useful for modelling and also instructive for policy.
#          i. my skill gap survey dives into industry effects.
#     c. alternative credentials are extremely diverse. a useful study would disaggregate this category and ask about alternative credentials of different kinds.
#          i. my prestige study does this, and the skill gap study to some degree.
# 4. are there any implications for consumers, policymakers, firms/hiring managers, or alternative education providers?