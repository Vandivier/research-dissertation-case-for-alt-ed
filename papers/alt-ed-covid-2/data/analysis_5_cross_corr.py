

import analysis_1_vars_and_regression as GetVars

df = GetVars.getData(False)

# Pearson's Correlation Coefficient = 0.445 - moderate
print(df['conventional_alt_creds'].corr(df['favor_online_ed']))
# Pearson's Correlation Coefficient = 0.303 - weak to moderate
print(df['favor_online_ed'].corr(df['covid_ind_fav_online_large_degree']))
# Pearson's Correlation Coefficient = 0.044 - nil
print(df['favor_online_ed'].corr(df['covid_ind_remote_large_degree']))
# Pearson's Correlation Coefficient = 0.107 - nil
print(df['conventional_alt_creds'].corr(
    df['covid_ind_fav_online_large_degree']))
# Pearson's Correlation Coefficient = -0.114 - nil
print(df['conventional_alt_creds'].corr(
    df['covid_ind_remote_large_degree']))
