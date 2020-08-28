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

* // truncation theory check...
* // consistent with papers that say "B students are more succesful"
* // ...it seems like the average college grad is closer to ideal, but distrobutionally a significant chunk of them suffer from overqualification
* // "The average GPA for students at four-year colleges in the US is around 3.15, or a B average. This is much higher than it's been in the past..."
* // https://blog.prepscholar.com/average-college-gpa-by-major
sum diff_wno_concientiousness
sum diff_wno_concientiousness if aetiwno_concientiousness != 0 & rcgtiwno_concientiousness != 0
sum diff_wno_concientiousness if rcgtiwno_concientiousness != 0
sum diff_wno_concientiousness if aetiwno_concientiousness != 0
* // still positive coefficient for diff_wno_concientiousness
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness if aetiwno_concientiousness != 0 & rcgtiwno_concientiousness != 0

* // this guy finally has a negative coefficient as expected but concientiousness is not significant
* // benefit: gap diff interpretation is simpler because the variable is now just ACNG skill gap
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness if rcgtiwno_concientiousness == 0
* // average is 1.2; we can relax restriction of == 0 to "is less than average" and still get expected negative sign
* // positive sign decreases as allowed rcgtiwno_concientiousness increases, indicating a marginal effect
sum rcgtiwno_concientiousness
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness if rcgtiwno_concientiousness < 1.3
* // marginal fx not significant but they are moreso than linear with constrained sample ig progress
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff2_wno_concientiousness

* // exploring...
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness if rcgtiwno_concientiousness > aetiwno_concientiousness
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness if rcgtiwno_concientiousness < aetiwno_concientiousness
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness if aetiwno_concientiousness == 0
reg fav diff_alt2* diff_alt3_wno_bodylanguage

* // it heteroscedastic, but glm/robust std err don't change coefficient
* // https://rstudio-pubs-static.s3.amazonaws.com/187387_3ca34c107405427db0e0f01252b3fbdb.html
scatter fav diff_alt2_wno_bodylanguage

* // distinct truncation flags...positive coefficient persists
* // minor good news - isideal is positively signed
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness is*
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated* oq* isbetter*

* // one third of respondents think acng better work ethic compared to college grad
* // but then they don't want to hire em!!
* // could be indicative of a spurious result or overqualification rearing its head again...
sum isbetter_acng_concientiousness
reg fav isbetter_acng_concientiousness

* // marginal gap fx with overqualification
* // negative marginal concientiousness survives longer than linear effect but neither is p < 0.5
* // still, weak model is all quads showing marginal analysis may be the key; these effects are stronger
reg fav diff_wo* diff2_wo*
reg fav diff2_wo_bodylanguage diff2_wo_commute diff2_wo_concientiousness diff2_wo_customerserviceskill diff2_wo_rulebreaker diff2_wo_teamwork diff2_wo_technicaljobskills diff_wo_bodylanguage diff_wo_commute diff_wo_concientiousness diff_wo_customerserviceskill diff_wo_rulebreaker diff_wo_teamwork diff_wo_technicaljobskills
reg fav diff2_wo_bodylanguage diff2_wo_commute diff2_wo_customerserviceskill diff2_wo_teamwork diff2_wo_technicaljobskills

* // wno still wins
reg fav diff_wno* diff2_wno*
reg fav diff_wno* diff2_wno* isideal* istruncated* oq* isbetter*
reg fav diff2_wno_bodylanguage diff2_wno_commute diff2_wno_concientiousness diff2_wno_customerserviceskill diff2_wno_rulebreaker diff2_wno_teamwork diff2_wno_technicaljobskills diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_wno_customerserviceskill diff_wno_rulebreaker diff_wno_teamwork diff_wno_technicaljobskills isideal* istruncated* oq* isbetter*

* // start from M7 skill gaps not M5
* // diff2_wno_concientiousness doesn't matter here
* // conclusion: this could be a spurious result or it looks like concientiousness is a case where overqualification is desired
reg fav diff2_wno_bodylanguage diff2_wno_commute diff2_wno_concientiousness diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated* oq* isbetter*
reg fav diff2_wno_bodylanguage diff2_wno_commute diff2_wno_concientiousness diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated* oq* isbetter_acng_concientiousness isbetter_acng_commute
reg fav diff2_wno_bodylanguage diff2_wno_concientiousness diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated_rcg oq* isbetter_acng_concientiousness isbetter_acng_commute
reg fav diff2_wno_bodylanguage diff2_wno_concientiousness diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated_rcg oq* isbetter_acng_commute
reg fav diff2_wno_bodylanguage diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated_rcg oq* isbetter_acng_commute

* // one last check; maybe overqualification is desired bc we ignore price. so the true ideal is inclusive of cost considerations.
* // nah they are pretty independent
reg fav diff2_wno_bodylanguage diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness isideal* istruncated_rcg oq* isbetter_acng_commute aetiwno_price_x_con rcgtiwno_price_x_con diff_wno_price_x_con diff2_wno_price_x_con
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_wno_price_x_con
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_wno_salary

* // another last thing lol...computing square diff an alternative way
* // now we get negative coefficient that matters more than linear effect!
* // computation difference is square the gap then take difference (instead of diff then square)
* // result is sensitive to the order of operations.
* // this model is technically better on model metrics but is fkin complex to explain and arguably contrived and/or wrong...maybe don't talk about it...
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff2_wno_concientiousness diff_alt2_wno_concientiousness
reg fav diff_wno_bodylanguage diff_wno_commute diff_alt2_wno_concientiousness

* // M8
* // notice outlier at diff_alt2_wno_bodylanguage < -30
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_alt2*
estimates store R8, title(Model 8)
qui testparm*
estadd scalar f_p_value = r(p)
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness is*

* // M9
reg fav diff_alt2_wno_bodylanguage diff_alt2_wno_commute diff_alt2_wno_concientiousness
estimates store R9, title(Model 9)
qui testparm*
estadd scalar f_p_value = r(p)

esttab R6 R7 R8 R9 using temp.tex, booktabs replace se star(* .01 ** .001) stats(r2 f_p_value N, fmt(4 4 0) label(R-sqr p(F))) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers

* // wow. compare the five below and consider `noconstant' in future:
reg fav diff_alt2_wno_bodylanguage if diff_alt2_wno_body < 0
reg fav diff_alt2_wno_bodylanguage if diff_alt2_wno_body < 0, noconstant
reg fav diff_alt2_wno_bodylanguage, noconstant
reg fav diff2_wno_bodylanguage, noconstant
reg fav diff2_wo_bodylanguage, noconstant
