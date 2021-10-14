# need to roll my own rfe to pick by p-value + ar2 max. library rfe only looks at coefficient size!
# TODO: backward elimination, LASSO, RFECV-LR, RFECV-SVR, best subset
# consider ANY variable that survives ANY to be important (double check 3 vs 2 RFECV vars add to some model metric of interest)

# m1-m10 motivate starting with a four-way interaction. here i dump in the other IVs and reduce using various strategies
# if gender is considered important in any reduced model, that will be interesting.
m10 = '''hirability ~
    + gender*favor_programming_career*favor_seeking_risk*industry
    + TODO
    + 1'''
