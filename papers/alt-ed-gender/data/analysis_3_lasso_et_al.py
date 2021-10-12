# https://quantifyinghealth.com/stepwise-selection/
# AIC is interesting
# "Unless the number of candidate variables > sample size (or number of events), use a backward stepwise approach."
# https://stats.stackexchange.com/questions/89202/superiority-of-lasso-over-forward-selection-backward-elimination-in-terms-of-the
# LASSO regression vs backward selection
# looks like i need to test lasso, forward, backward, and stepwise selection and choose best using
# MSE, ar2, r2, max(p), number vars selected (yes my other complexity metric is dope too)
# "Don't use stepwise/forward selection. Reasons not to do this have been discussed here a lot"
# "https://stats.stackexchange.com/questions/276268/why-avoid-stepwise-regression"



# use this file like `py [this_file] >> foo.tex` to get table source
# for table in robust.summary().tables:
#     print(table.as_latex_tabular())

# ref: https://stackoverflow.com/questions/23576328/any-python-library-produces-publication-style-regression-tables
# print(summary_col([m1, m2, m3],
#                   stars=True, float_format='%0.2f',
#                   info_dict={
#     'N': lambda x: "{0:d}".format(int(x.nobs)),
#     'R2': lambda x: "{:.3f}".format(x.rsquared)
# }
# ).as_latex())
