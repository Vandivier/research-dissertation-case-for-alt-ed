# matplotlib.use('TkAgg')
# import numpy as np
import matplotlib.pyplot as plt
# import tkinter
# import seaborn as sns    # v 0.11.1
import analysis_1_vars as GetVars

concrete = GetVars.getConcreteData()
dfNew = concrete[0:0]

dfNew['p_is_low_context']                  = concrete[concrete.is_low_context == 1]['prestige_own'].dropna()
dfNew['p_is_low_context_and_accredited']   = concrete[concrete.is_low_context == 1][concrete.is_accredited == 1]['prestige_own'].dropna()
dfNew['p_is_low_context_and_unaccredited'] = concrete[concrete.is_low_context == 1][concrete.is_accredited == 0]['prestige_own'].dropna()
dfNew['p_is_high_context']                 = concrete[concrete.is_low_context == 0]['prestige_own'].dropna()
dfNew['p_is_high_context_and_accredited']  = concrete[concrete.is_low_context == 0][concrete.is_accredited == 1]['prestige_own'].dropna()
dfNew['p_is_high_context_and_unaccredited']= concrete[concrete.is_low_context == 0][concrete.is_accredited == 0]['prestige_own'].dropna()

fig, ax = plt.subplots()

np_is_low_context_and_accredited   = np.histogram(concrete[concrete.is_low_context == 1][concrete.is_accredited == 1]['prestige_own'].dropna().to_numpy())
# np_is_low_context_and_unaccredited = np.histogram(concrete[concrete.is_low_context == 1][concrete.is_accredited == 0]['prestige_own'].dropna())
# np_is_high_context_and_accredited  = np.histogram(concrete[concrete.is_low_context == 0][concrete.is_accredited == 1]['prestige_own'].dropna())
# np_is_high_context_and_unaccredited= np.histogram(concrete[concrete.is_low_context == 0][concrete.is_accredited == 0]['prestige_own'].dropna())

a_heights, a_bins = np.histogram(np_is_low_context_and_accredited)
# b_heights, b_bins = np.histogram(np_is_low_context_and_unaccredited, bins=a_bins)
# c_heights, c_bins = np.histogram(np_is_high_context_and_accredited, bins=b_bins)
# d_heights, d_bins = np.histogram(np_is_high_context_and_unaccredited, bins=c_bins)

width = 2

ax.bar(a_bins[:-1], a_heights, width=width, facecolor='cornflowerblue')
# ax.bar(b_bins[:-1] + width, b_heights, width=width)
# ax.bar(c_bins[:-1] + width, c_heights, width=width)
# ax.bar(d_bins[:-1] + width, d_heights, width=width)

dfNew[["p_is_low_context_and_accredited", "p_is_low_context_and_unaccredited", "p_is_high_context_and_accredited", "p_is_high_context_and_unaccredited"]].plot.hist(alpha=0.4)

dfNew[["p_is_low_context_and_accredited"]].plot.kde()
concrete[["prestige_own"]].plot.kde()
plt.show()
