do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-2-basic-exploration.do"

* // n = 212
sum aetiwno*

* // r2=0.5804
reg favorability _is* is* aetiwno* rulebreakers* c* aetiwo_body_x_it
reg favorability _is* is* aetiwno* rulebreakers* aetiwo_body_x_it

* // ar2 local max = 0.3506
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate1 _isstate11 _isstate12 _isstate13 _isstate14 _isstate16 _isstate19 _isstate20 _isstate21 _isstate25 _isstate26 _isstate28 _isstate30 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate4 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers*
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate1 _isstate13 _isstate14 _isstate16 _isstate19 _isstate20 _isstate21 _isstate25 _isstate26 _isstate28 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers*
* // ar2 global max = 0.3514
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate1 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate38 _isstate39 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers*

* // R2 - modified maxar2 with overqualification
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _ismanager1 _ismanager2 _isstate1 _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate38 _isstate39 _isstate6 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_salary aetiwno_teamwork rulebreakers* aetiwno_rulebreaker

* // strong model
reg favorability _isduration6 _ismanager1 _ismanager2 _isstate13 _isstate14 _isstate21 _isstate34 _isstate36 _isstate37 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_salary rulebreakers*

* // re-insert aetiwno_rulebreaker to strong model
* // negative coeff is consistent with specification allowing overqualification effects, about about the same p and magnitude
reg favorability _isduration6 _ismanager1 _ismanager2 _isstate13 _isstate14 _isstate21 _isstate34 _isstate36 _isstate37 _isstate8 aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_salary rulebreakers* aetiwno_rulebreaker
