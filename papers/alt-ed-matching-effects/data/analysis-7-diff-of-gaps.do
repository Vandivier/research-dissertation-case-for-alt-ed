clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-1-vars.do"

* // diff is positive but insignificant; could become significant w bigger sample.
* // ACNG has worse body lang skill bc positive diff_wno_bodylanguage
sum rcgtiwno_bodylanguage aetiwno_bodylanguage diff_wno_bodylanguage diff_wo_bodylanguage bodylanguage_recentcollege bodylanguage_ngwac

* // breaking rules is awesome and employers know it.
* // measurement robust bc rulebreaker effects and rulebreaker gap both in consistent direction
sum rulebreaker_ideal rulebreaker_ngwac rulebreaker_recentcollegegraduat rulebreaker_typicalemployeeatmyc
reg fav aetiwno_rulebreaker

* // MANOVA? nah...multiple reg diff of gaps
* // do soft skills differ collectively (not individually) for ACNG vs recent college grad
* // do soft skills collectively (not individually) explain hireability diff for ACNG vs recent college grad
* // note: the above are served just as well or better by multiple OLS compared to MANOVA
* // I think i can compute myself by multiplying p-values but someone might get mad at a homebrewed approach... will do multiple regression
* // ref: https://stats.stackexchange.com/questions/69145/what-particular-measure-to-use-multiple-regression-or-manova
* // ref: https://stats.idre.ucla.edu/stata/output/manova/
* // ref: http://www.differencebetween.net/science/mathematics-statistics/difference-between-anova-and-manova/
* // TODO: multifactor anova? ACNG vs recent grad http://onlinestatbook.com/2/analysis_of_variance/multiway.html
* // MAYBE TODO: boring but solid linear model http://sites.utexas.edu/sos/guided/inferential/numeric/glm/
* // actually I don't want any of that, i just want to know if soft 
* // just skill gaps

* // diff* is ACNG - recent college grad; so positive coeff means ACNG is comparatively valued for having a bigger gap
* // skills i care about from preferred reg...aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker
* // long diff reg, p(>F)=0.06; already not probable, r2=0.63
* // reduce to each factor p<0.5; coincidentally, each factor p<0.16; p(0.0044); r2=0.0609
* // it's all about the body language! big significant negative coefficient; other two are smaller, less sig, positive coefficients.
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_wno_customerserviceskill diff_wno_technicaljobskills diff_wno_teamwork diff_wno_rulebreaker
estimates store R6, title(Model 6)
qui testparm*
estadd scalar f_p_value = r(p)
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness
estimates store R7, title(Model 7)
qui testparm*
estadd scalar f_p_value = r(p)
* // using temp.tex, booktabs
esttab R6 R7 using temp.tex, booktabs replace se star(* .01 ** .001) stats(r2 f_p_value N, fmt(4 4 0) label(R-sqr p(F))) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers

* // plug in average values to get net total diff effect...expect negative (lower ACNG hireability)
* // this would provide evidence that ACNGs would be more hireable if their skills were more grad-like...specifically body language skill
* // result coeff, respectively: -.3394951, .1573848, .1508238
* // concientiousness diff factor w positive coefficient is not intuitive...when regressed alone it is insignificant...may be a spurious sample artifact
sum diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness
* // resulting means, respectively: .1415094, -.0943396, .0330189
* // display / compute total effect from sig different factors
display -.3394951*.1415094 - .1573848*.0943396 + .1508238*.0330189
* // total effect result = -.05790933
* // confirm total effect is negative on average
* // distributional, median, modal effects much more complicated...

* // rounded for the paper
di -0.3395*0.1415 - 0.1574*0.0943 + 0.1508*0.0330
* // rounded total effect = -0.0579