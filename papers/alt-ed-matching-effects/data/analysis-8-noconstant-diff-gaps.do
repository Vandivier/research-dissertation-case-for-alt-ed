clear

* // note: noconstant is possibly a bad idea and i will maybe not use it...
* // basically only definsible on structural grounds; lower p(F) is a nice result or incentive but it's not a good justification
* // I arguably have a structural defense...but i would need to redo all models for consistency
* // on second though i don't have structural defense. if all diffs are zero fav doesn't need to also be zero
* //    moreover, for non-diff models, if all observed skills are zero it doesn't mean hirability is zero; there can be unobserved skills and also some willingness to hire someone with no skills.
* // it's clear that r-squared with and without intercept is not comparablt, but it seems p(F) might be...prob need more research
* // ref: https://stats.stackexchange.com/questions/484998/how-does-stata-compute-model-constants
* // ref: https://stats.stackexchange.com/questions/26176/removal-of-statistically-significant-intercept-term-increases-r2-in-linear-mo/26205#26205
* // ref: https://stats.stackexchange.com/questions/7948/when-is-it-ok-to-remove-the-intercept-in-a-linear-regression-model

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-1-vars.do"

* // compare below 4 as a starting point...
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_wno_customerserviceskill diff_wno_technicaljobskills diff_wno_teamwork diff_wno_rulebreaker
reg fav diff_wo_bodylanguage diff_wo_commute diff_wo_concientiousness diff_wo_customerserviceskill diff_wo_technicaljobskills diff_wo_teamwork diff_wo_rulebreaker
reg fav diff_wno_bodylanguage diff_wno_commute diff_wno_concientiousness diff_wno_customerserviceskill diff_wno_technicaljobskills diff_wno_teamwork diff_wno_rulebreaker, noconstant
reg fav diff_wo_bodylanguage diff_wo_commute diff_wo_concientiousness diff_wo_customerserviceskill diff_wo_technicaljobskills diff_wo_teamwork diff_wo_rulebreaker, noconstant

* // model 8, but baptized into noconstant
* // ah, beautiful, intuitive coefficients, big rs, big fs, low ps...life is great and i can sleep now
* // crazy. this is about as good as Model 5 but it only uses 3 factors. i hope it's not overfit.
* // outlier at diff2_wo_bodylanguage > 30
* // cutting outlier improves model, as it should...it was wayne's world earlier when cutting outlier was mucking the model
reg fav diff_wo_bodylanguage diff_wo_commute diff_wo_concientiousness diff2_wo_bodylanguage diff2_wo_commute diff2_wo_concientiousness, noconstant
scatter fav diff2_wo_bodylanguage
reg fav diff_wo_bodylanguage diff_wo_commute diff_wo_concientiousness diff2_wo_bodylanguage diff2_wo_commute diff2_wo_concientiousness if diff2_wo_body < 30, noconstant

* // retest all diff2_wo* and customer service is the one that doesn't matter
reg fav diff_wo_bodylanguage diff_wo_commute diff_wo_concientiousness diff2_wo_bodylanguage diff2_wo_commute diff2_wo_concientiousness diff2_wo_customerserviceskill diff2_wo_rulebreaker diff2_wo_salary diff2_wo_teamwork diff2_wo_technicaljobskills, noconstant

* // this is cool and salary now matters...but bodylang flips? kind of opening a can of worms...not gonna mess w it
reg fav diff2_wo_*, noconstant
reg fav diff_wo_* diff2_wo_*, noconstant
