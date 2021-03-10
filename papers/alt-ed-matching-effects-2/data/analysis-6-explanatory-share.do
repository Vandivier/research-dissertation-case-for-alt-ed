clear

do "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\analysis-1-vars.do"

* // this file takes factors from the preferred model and regresses favorability on those by group

* // all other factors / other controls
reg fav _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 cd*1 cd*2

* // industry
reg fav  _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12

* // state
reg fav  _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42

* // absolute skill gaps
reg fav aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness

* // comparative skill gaps
reg fav diff1_wno_customerserviceskill diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written

* // rulebreakers
reg fav rulebreakers*
