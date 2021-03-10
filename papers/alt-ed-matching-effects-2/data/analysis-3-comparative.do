clear

do "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\analysis-1-vars.do"

* // start w ar2 special (preferred) model from skills, but swap skill gaps for comparative gaps (diff1_wno*)
* // weaker than preferred, so skill gaps explain more than comparative gaps, but still interesting, and still around 1/3 explanation
* // n = 322; r2=0.3489, ar2=0.2201;
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate10 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate20 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno* rulebreakers*

* // local maxar2; skip weak and strong models
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_attractiveness diff1_wno_concientiousness diff1_wno_customerserviceskill diff1_wno_eq diff1_wno_oddhours diff1_wno_rulebreaker diff1_wno_teamwork diff1_wno_written rulebreakers*

* // maxar2
* // again, nonpreferred bc lower r2 and ar2, but still around 1/3
* // n = 322; r2=0.3310, ar2=0.2331;
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_attractiveness diff1_wno_concientiousness diff1_wno_customerserviceskill diff1_wno_eq diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written rulebreakers*

* // now combine maxar models (still linear)
* // higher r2 and ar2, so adding them together is valuable, but some factors now insignificant
* // n = 322; r2=0.3728, ar2=0.2705;
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_attractiveness diff1_wno_concientiousness diff1_wno_customerserviceskill diff1_wno_eq diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness aetiwno_eq rulebreakers*

* // after eliminating insignificant vars we still have higher r2 and ar2
* // n = 322; r2=0.3706, ar2=0.2784;
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cduration1 cduration2 diff1_wno_customerserviceskill diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness rulebreakers*

* // special; force rulebreaker gaps in
* // they aren't significant but they are positively signed; interesting for the story
reg favorability _ismanager2 _isstem1 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_customerserviceskill diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness rulebreakers* diff1_wno_rule aetiwno_rule

* // note: considering marginal effects will increase r2 and ar2 but
* // 1. fear overfitting
* // 2. unlikely to flip signs
* // 3a. creates complexity in interpretation and **raises more questions than it answers (interactions, how to square a diff...)
* // 3b. could be interesting future research

* // visualize results using top-line boxplots. maybe low hanging diagnostic fruit? commented visualization ideas follow but won't be used
* // ref: stata.com/links/resources-for-learning-stata/cheat-sheets/StataCheatSheet_visualization_2016_June-REV.pdf
graph hbox diff1_wno_customerserviceskill diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness

* // ig this is kinda cool but won't use
* // graph matrix rulebreakersnormsmightbedoingsob rulebreakersnormsprobablyhaveaha rulebreakersnormstendtobegiftedi fav
