clear

do "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\analysis-1-vars.do"

* // start w preferred first-round model then add marginal skill gaps
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate10 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate20 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness aetiwno_eq rulebreakers* m2* diff_wno* diff2_wno*


