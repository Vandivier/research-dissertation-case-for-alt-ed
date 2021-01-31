clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-1-vars.do"

* // output ref: table-1-massaged.tex

* // regs of interest
* // R1 - modified maxar2 with overqualification
* // R2 - modified maxar2 without overqualification
* // R3 - modified maxar2 with overqualification, with normalized effects
* // R4 - modified maxar2 without overqualification, with normalized effects
* // R5 - preferred without overqualification

* // on normalized effects:
* // state normalized to robust state effects. these states are robust across specification and independently important
* // skill gaps normalized to semi-robust: they are theoretically important and appear in at least one maxar2 model, but may not be independently important
* // duration normalization results in elimination because no duration effect is significant across specification
* // company size, manager effects, and industry effects are autonormalized; that is, they independently survived to both maxar2 models

* // on kept variables:
* // industry and state effects excluded from chart for brevity
* // otherwise, any variable included in at least two models is noted in the table

* // note: industry effects independently robust
* // robust states: _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8

reg favorability _iscompanysize4 _iscompanysize8 _isduration1 _isduration2 _isduration3 _isduration4 _isduration5 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate11 _isstate12 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate28 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8 aetiwo_bodylanguage aetiwo_concientiousness aetiwo_customerserviceskill aetiwo_technicaljobskills rulebreakers* aetiwo_body_x_it
estimates store R1, title(Model 1)
* // ref: https://www.statalist.org/forums/forum/general-stata-discussion/general/1434586-regress-est-sto-esttab-adding-f-test-p-values-within-possible
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate1 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate38 _isstate39 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers* aetiwno_rulebreaker
estimates store R2, title(Model 2)
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _iscompanysize4 _iscompanysize8 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 rulebreakers* aetiwo_bodylanguage aetiwo_commute aetiwo_concientiousness aetiwo_customerserviceskill aetiwo_technicaljobskills aetiwo_salary aetiwo_teamwork aetiwo_rulebreaker aetiwo_body_x_it _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8
estimates store R3, title(Model 3)
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _iscompanysize4 _iscompanysize8 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 rulebreakers* aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_salary aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8
estimates store R4, title(Model 4)
qui testparm*
estadd scalar f_p_value = r(p)

* // R5 is R4 minus salary gap and plus _isduration6; worth talking about
* // ar2 = .2866; halfway between 1/4 and 1/3...added robustness of later models without giving up too much r2
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 rulebreakers* aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8
estimates store R5, title(Model 5)
qui testparm*
estadd scalar f_p_value = r(p)

* // R6 is R5 pl
* // ref analysis-6-concientiousness.do
* // ar2 = .2874
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 rulebreakers* aetiwno_bodylanguage aetiwno_commute aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 c_2

* // TODO: rulebreaker interaction, concientiousness interactions

* // using temp.tex, booktabs
esttab R1 R2 R3 R4 R5, keep(_isduration6 _iscompanysize* _ismanager* rulebreakers* aetiwo* aetiwno*) label order(_isduration6 _iscompanysize* _ismanager* rulebreakers* aetiwo* aetiwno*) replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2 f_p_value N, fmt(4 4 0) label(R-sqr p(F))) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
