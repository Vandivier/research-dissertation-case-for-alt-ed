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

* // make figure conc-linear-resid-vs-fitted.jpeg
reg fav diff_wno_concientiousness
grstyle init
grstyle color background white
rvfplot

* // M8
* // notice outlier at diff_alt2_wno_bodylanguage < -30
* // body lang negative linear and total, nothing surprising
* // commute positive linear and total, a bit surprising but this is bc mean value is negative...see next comment block + reg for more
* // concientiousness interpretation: it's bad on average, marginal increase also bad, but it's getting less bad eventually
* // why use cubics? bc linear and quads had unexpected results and residual plots were abnormal
* // now we can see cubics matter more than linear or quad (not for commute, but in general)
* // deeze resids is still abnormal, but this only means our p-values get thrown out...cardinally, not ordinally; cubic better than linear matters
* // (I think also the r-squared is thrown out...)
* // coefficient estimates are still curvilinearly optimal, p(F) still applies
* // cubic model p(F) < (ie, better than) p(F)(quad model); both worse than linear but we have theoretical issue with linear model betas
reg fav diff_wno_bodylanguage diff2_wno_bodylanguage diff3_wno_bodylanguage diff_wno_commute diff2_wno_commute diff3_wno_commute diff_wno_concientiousness diff2_wno_concientiousness diff3_wno_concientiousness
predict ym8
predict deeze, resid
swilk deeze
estimates store R8, title(Model 8)
qui testparm*
estadd scalar f_p_value = r(p)

* // compute total effect
* // result mean, respectively, rounded: .1415, -.0943, .0330
* // coeff, in order of M8, rounded:
* // -.1443692, .0340004, -.0193765, .080295, -.0112432, .0023336, -.0523916, -.046464, .0380066
* // total result = -.02925909 = (rounded) = -0.0293
sum diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness
* // concientiousness result = -.00177847 = (rounded) = -0.0018
di - 0.0524*0.0330 - 0.0465*0.0330^2 + 0.0380*0.0330^3
* // total result = -.02925909 = (rounded) = -0.0293
di -0.1444*0.1415 + 0.0340*0.1415^2 - 0.0194*0.1415^3 - 0.0803*0.0943 - 0.0112*0.0943^2 - 0.0023*0.0943^3 - 0.0524*0.0330 - 0.0465*0.0330^2 + 0.0380*0.0330^3
* // or, equally
di -0.1444*0.1415 + 0.0340*0.1415^2 - 0.0194*0.1415^3 - 0.0803*0.0943 - 0.0112*0.0943^2 - 0.0023*0.0943^3 - 0.0018

* // MAYBE TODO: include below graph in paper
scatter ym8 diff_wno_concientiousness

* // reduced if you want it, but it's an overfit bc it destroys needed variables
reg fav diff_wno_bodylanguage diff3_wno_bodylanguage diff3_wno_concientiousness

* // commute pos coefficient is counterintuitive
* // but, it just reflects the normal negative value; an increase isn't 1->2 it's -2 -> -1 which is favorable
* // to see the increasing positive case, restrict sample and get expected negative coefficient:
reg fav diff_wno_bodylanguage diff2_wno_bodylanguage diff3_wno_bodylanguage diff_wno_commute diff2_wno_commute diff3_wno_commute diff_wno_concientiousness diff2_wno_concientiousness diff3_wno_concientiousness if diff_wno_commute > 0

esttab R6 R7 R8 using temp.tex, booktabs replace se star(* .01 ** .001) stats(r2 f_p_value N, fmt(4 4 0) label(R-sqr p(F))) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers

* // M9
* // I could take or leave this model...reduce to maximize adj r2...
* // commute is dropped...not really interesting it's not like i can honestly say being flexible in commute doesn't matter for hiring.
* // seems like an overfit prob shouldn't use...
reg fav diff_wno_bodylanguage diff3_wno_bodylanguage diff3_wno_concientiousness
estimates store R9, title(Model 9)
qui testparm*
estadd scalar f_p_value = r(p)

*** // bunch of interesting historical bullshit below

* // i can't use the _alt specification; it doesn't actually tell us if slope is increasing/decreasing/etc
* // it is a marginal fx differential not a real marginal effect...not super useful and not what our theory predicts.
* // noconstant is interesting but i shouldn't use that...see analysis-8...do for some refs
* // basically, if all my skill gaps are 0 it doesn't mean hireability is 0, so i need constant
reg fav diff_alt2_wno_bodylanguage if diff_alt2_wno_body < 0
reg fav diff_alt2_wno_bodylanguage if diff_alt2_wno_body < 0, noconstant
reg fav diff_alt2_wno_bodylanguage, noconstant
reg fav diff2_wno_bodylanguage, noconstant
reg fav diff2_wo_bodylanguage, noconstant

* // i suspect there's a hidden cubic...let's check residuals
* // there is a heavy influencing outlier. so check with and without that outlier.
* //
* // residuals + normality info: https://campusguides.lib.utah.edu/c.php?g=160853&p=1054157
* // normality is violated, but per above article this means we have to throw out p-value and F-test but it doesn't undermine coefficients
* // cubic actually slightly reduces residual normality, but that's ok bc i think the data really isn't normal and it's a better fit model
* //
* // TODO: long paper food...
* // there aren't enough samples and degrees of freedom to give confidence to an analysis which systematically and simulataneouly investigates linear, quadratic,
* // and cubic fx for all skills plus higher power interactions.
* // get a sample 2-10x current sample size we would be gtg.
twoway scatter fav diff_alt2_wno_bodylanguage || lfit fav diff_alt2_wno_bodylanguage
twoway scatter fav diff_alt2_wno_bodylanguage if diff_alt2_wno_bodylanguage > -40 || lfit fav diff_alt2_wno_bodylanguage if diff_alt2_wno_bodylanguage > -40
reg fav diff_alt2_wno_bodylanguage
predict y_from_alt2_bodylang, residuals
swilk y_from_alt2_bodylang
rvfplot
reg fav diff_wno_body diff_alt2_wno_bodylanguage diff_alt3_wno_bodylanguage
estimates store R10, title(Model 10)
qui testparm*
estadd scalar f_p_value = r(p)
predict y_res_from_alt_multi_bodylang, residuals
predict y_from_alt_multi_bodylang

* // negative adj r2 and insignificant p(F)...this model doesn't fly.
reg fav diff_wno_con diff_alt2_wno_concientiousness diff_alt3_wno_concientiousness
* // among bad options, this is the best con model we have...so no, we don't want the con cubic
reg fav diff_alt2_wno_concientiousness
* // not a single p < 0.5 here...it is not comparable to the bodylang case
* // linear effect only is best p(F)...so again no we don't want cubic
reg fav diff_wno_commute diff_alt2_wno_commute diff_alt3_wno_commute
predict y_from_alt_multi_commute
predict y_res_from_alt_multi_commute, residuals
twoway scatter y_from_alt_multi_commute diff_wno_commute

* // below makes `difference-in-squared-body-lang.jpeg'
* // total effect as body lang increases is deacrease, whether using _wno or diff_alt
* // they all not normal
* // residuals look sysematically non-normal; below line for exteme values; may represent kurtosis or middle-concentration (predictable for likert-type)
* // log transform is a possible kurtosis fix https://www.researchgate.net/post/how_to_reduce_skewness_and_kurtosis
* // also other kinds of other regression, nl, maybe ologit, or boolean decomposition
* // also maybe Leptokurtic adjustment or use Golden Ratio to estimate SE/SD and ignore kurtosis https://www.researchgate.net/post/What_type_of_data_transformation_is_suitable_for_high_Kurtosis_data
swilk y_res_from_alt_multi_bodylang
qnorm y_res_from_alt_multi_bodylang
scatter y_from_alt_multi_bodylang diff_wno_bodylanguage
twoway scatter y_from_alt_multi_bodylang diff_wno_bodylanguage, xtitle("Difference in Body Language Skill") ytitle("Predicted Hireability")

* // label variable l1 "Linear"
* // label variable l2 "Quadratic"
* // label variable l3 "Cubic"
* // twoway (scatter fav diff_wno_concientiousness) (lfit fav diff_wno_concientiousness, ytitle(Linear)) (qfit fav diff_wno_concientiousness) (scatter l3 diff_wno_concientiousness), xtitle(Comparative Gap in Concientiousness) ytitle(Hireability)
* // twoway (scatter fav diff_wno_concientiousness) (scatter l1 diff_wno_concientiousness) (scatter l2 diff_wno_concientiousness) (scatter l3 diff_wno_concientiousness), xtitle(Comparative Gap in Concientiousness) ytitle(Hireability)
