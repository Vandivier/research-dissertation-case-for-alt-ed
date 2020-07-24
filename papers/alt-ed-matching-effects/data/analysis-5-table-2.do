clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-1-vars.do"

* // regs of interest
* // R1 - modified maxar2 without overqualification
* // R2 - modified maxar2 with overqualification
* // R3 - modified maxar2 without overqualification, with normalized highly robust state effects
* // R4 - modified maxar2 with overqualification, with normalized highly robust state effects

* // note: industry effects independently robust
* // robust states: _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8

reg favorability _iscompanysize4 _iscompanysize8 _isduration1 _isduration2 _isduration3 _isduration4 _isduration5 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate11 _isstate12 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate28 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8 aetiwo_bodylanguage aetiwo_concientiousness aetiwo_customerserviceskill aetiwo_technicaljobskills rulebreakers* aetiwo_body_x_it
estimates store R1, title(Model 1)

reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate1 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate38 _isstate39 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers* aetiwno_rulebreaker
estimates store R2, title(Model 2)

reg favorability _iscompanysize4 _iscompanysize8 _isduration1 _isduration2 _isduration3 _isduration4 _isduration5 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8 aetiwo_bodylanguage aetiwo_concientiousness aetiwo_customerserviceskill aetiwo_technicaljobskills rulebreakers* aetiwo_body_x_it
estimates store R3, title(Model 3)

reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers* aetiwno_rulebreaker
estimates store R4, title(Model 4)

* // esttab R1 R2 using temp.tex, booktabs keep(employer_a*2 pce2 stateperm1 visa_m_h1b_2 year) label order(visa_m_h1b_2 pce2 employer_a*2 stateperm1 year) replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2 N, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
esttab R1 R2 R3 R4, label replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2 N, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
