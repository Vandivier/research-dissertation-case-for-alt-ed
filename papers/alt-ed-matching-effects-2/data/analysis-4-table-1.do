clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-1-vars.do"

* // 6 robust effects: industry, state, duration, company size, skill gaps, rulebreaker effects
* // rulebreaker, duration, company size will be spelled out in main reg table, so not here...or should they be? if space allows

* // summary factor group explanatory power...another table
* // industry effects; all highly robust (both maxar2 multiple regs and simple effects reg)
* // n=212, r2=0.0510, ar2=0.0185, maxp=0.288
reg fav _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8
* // semi-robust states
* // significant in multiple regression but not in a simple regression of state effects on favorability
* // n=212, r2=0.0648, ar2=0.0034, maxp=0.831
reg fav _isstate13 _isstate14 _isstate16 _isstate20 _isstate21 _isstate25 _isstate26 _isstate34 _isstate36 _isstate37 _isstate39 _isstate6 _isstate8
* // highly robust state effects; maxar2 among state effect simple regression
* // state effects are about as important as industry effects
* // n=212, r2=0.0503, ar2=0.0177, maxp=0.227
reg fav _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8
* // rulebreaker effects
* // n=212, r2=0.1554, ar2=0.1432, maxp=0.053
reg fav rulebreakers*
* // robust skill gaps with overqualification
* // n=212, r2=0.0737, ar2=0.0558, maxp=0.106
reg fav aetiwo_bodylanguage aetiwo_concientiousness aetiwo_customerserviceskill aetiwo_body_x_it
* // robust skill gaps with no overqualification
* // n=212, r2=0.0933, ar2=0.0758, maxp=0.115
reg fav aetiwno_bodylanguage aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_body_x_it

* // robust skill gaps (3 + an interaction): bodylanguage, concientiousness, customerserviceskill, body_x_it
* // semi-robust skill gaps (either maxar2 model, superset of robust): commute, salary, teamwork, rulebreaker, technicaljobskills
* // notice that semi-robust skill gaps are generally structurally/theoretically important...but we can't say the same for states/industries...
* // that's why it's ok semi-robust skill gaps in preferred model but not states/industries
* // generally supports soft-skill dominance; but not EQ per se
* // skill gaps 1.5-2x as important industry or states but rulebreaker effects even more important.
* // simple (linear) analysis friendly to 'no overqualification' specification; heterogenous nonlinear effects might be harder to detect tho
