
import matplotlib.pyplot as plt
import statsmodels.stats as sm

import analysis_1_vars_and_regression as GetVars

df = GetVars.getDeskewedData(False)
# m6 data gotten like:
# df = GetVars.getData(False)

# note: m6 n = 350, mean 7.65, median 8.0
# note: m9 n = 339, mean 7.81, median 8.0
print(df['favor_alt_creds'].describe())
# note: m6 - mean 0.271; m6 beta = 0.561
# note: m9 - mean 0.268; m6 beta = 0.681
print(df['covid_ind_remote_large_degree'].describe())
# note: m6 - mean 0.160; m6 beta = -0.804
# note: m9 - mean 0.156; m6 beta = -0.769
# note: m10 - mean 0.156; m6 beta = -0.613
print(df['covid_ind_fav_online_large_degree'].describe())
# note: m6 - mean 0.360; m6 beta = -0.658
# note: m9 - mean 0.360; m6 beta = -0.795
# note: m10 - mean 0.360; m6 beta = -0.729
print(df['covid_ind_fav_online_moderate_degree'].describe())
# note: m6 - mean 0.311; m6 beta = -0.535
# note: m9 - mean 0.319; m6 beta = -0.689
# note: m10 - mean 0.319; m6 beta = -0.671
print(df['covid_ind_fav_online_slight_degree'].describe())
# note: m6 - mean 0.169
# note: m6 - mean 0.165
print(df['covid_ind_fav_online_no_more_favorable_(or_less_favorable)'].describe())

# m6 model total effect:
# -0.380 = 0.561*0.271-0.804*0.160-0.658*0.360-0.535*0.311
# m9 model total effect:
# -0.443 = 0.681*0.268-0.769*0.156-0.795*0.360-0.689*0.319
# if explanation 3 below then having more prior pessimists would show a more positive covid effect.
#   we can't really run that test, but we can run a similar test if we make an assumption about current respondents.
#   if we assume today's biggest pessimists were also yesterday's biggest pessimists, then we can drop these people and see what happens
#   and also cross-tab this population.
#   m9 drops these people; so we should expect more negative effect; that was confirmed.
#   in cross-tab if exp 3 is true we should expect a more positive response in covid_ind_fav_online from pessimists.

# note: 'remote learning...for yourself or other people' negative could mean:
# 1. people tend to think other people have had a smaller favorability gain
# 2. people are not connecting 'remote learning' and 'alternative credentials' (after correction)
#       * test via m10...they should 'connect the dots' and we should see some positive partial-in to covid_ind_fav_online.
#       * m10 result: vs m9, betas uniformly became more positive...so partial validation of this explanation.
# 3. biggest gains from people originally most pessimistic
#       * test in part by m6 vs m9 but also using cross-tab comparison above vs below median tabbed covid_ind_fav_online vs fav

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
