clear

do "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\analysis-1-vars.do"

* // n = 322
sum aetiwo*

* // research approach:
* // 1. reduce simple effects to strong model; also include r_*
* // 2. for each ar2 or strong gap (descretionary; ideally 2-4) conduct diff-in-diff and marginal analysis. (eg c_2)
* // 3. investigate r_* interactions after step 2.
* // 4. summary stats and graphs of interest; maybe a scatter; distributions of key vars; company size and time to obtain look normal
* // 5. in general, try not to interact gaps; checking correlations is fine along w summary stats and ad hoc 'weirdness checks' like skew
* // 6. aetiwno_body_x_it is a theory-driven exception of an ad hoc interaction i'll preserve

* // long reg; begin round-robin decomp after deciding to prefer no overqualification
* // aetiwno* is alt ed skill gaps with no overqualification, and it is a better linear explainer
* // aetiwo* includes overqualification but apparently a linear model using this creates disproportional noise
* // rulebreakers* are continuous linear effects
* // n = 301; aetiwno*: r2=0.4445; aetiwo*: r2=0.4215;
reg favorability _is* cc* cd* r_* aetiwo* rulebreakers*
reg favorability _is* cc* cd* r_* aetiwno* rulebreakers*

* // reducing to weak model wip...start by removing 1 category from each categorical
reg favorability _ismanager1 _ismanager2 _ismanager3 _isstem1 _isstem2 _isstem3 _isgender1 _isgender2 _isduration1 _isduration2 _isduration3 _isduration4 _isduration5 _isduration6 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _iscompanysize9 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isawareofrelevantcredentials5 _isindustry1 _isindustry2 _isindustry3 _isindustry4 _isindustry5 _isindustry6 _isindustry7 _isindustry8 _isindustry9 _isindustry10 _isindustry11 _isindustry12 _isstate1 _isstate2 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate8 _isstate9 _isstate10 _isstate11 _isstate12 _isstate13 _isstate14 _isstate15 _isstate16 _isstate17 _isstate18 _isstate19 _isstate20 _isstate21 _isstate22 _isstate23 _isstate24 _isstate25 _isstate26 _isstate27 _isstate28 _isstate29 _isstate30 _isstate31 _isstate32 _isstate33 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate40 _isstate41 _isstate42 _isstate43 _isstate44 cc* cd* r_* aetiwno* rulebreakers*
reg favorability _ismanager1 _ismanager2 _isstem1 _isstem2 _isgender1 _isduration2 _isduration3 _isduration4 _isduration5 _isduration6 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry2 _isindustry3 _isindustry4 _isindustry5 _isindustry6 _isindustry7 _isindustry8 _isindustry9 _isindustry10 _isindustry11 _isindustry12 _isstate1 _isstate2 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate8 _isstate9 _isstate10 _isstate11 _isstate12 _isstate13 _isstate14 _isstate15 _isstate16 _isstate17 _isstate18 _isstate19 _isstate20 _isstate21 _isstate22 _isstate23 _isstate24 _isstate25 _isstate26 _isstate27 _isstate28 _isstate29 _isstate30 _isstate31 _isstate32 _isstate33 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate40 _isstate41 _isstate42 _isstate43 _isstate44 cc* cd* r_* aetiwno* rulebreakers*
reg favorability _ismanager1 _ismanager2 _isstem1 _isstem2 _isgender1 _isduration2 _isduration3 _isduration4 _isduration5 _isduration6 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry2 _isindustry3 _isindustry4 _isindustry5 _isindustry6 _isindustry7 _isindustry8 _isindustry10 _isindustry11 _isindustry12 _isstate1 _isstate2 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate8 _isstate9 _isstate10 _isstate11 _isstate12 _isstate13 _isstate14 _isstate15 _isstate16 _isstate17 _isstate18 _isstate19 _isstate20 _isstate21 _isstate23 _isstate24 _isstate25 _isstate26 _isstate27 _isstate28 _isstate29 _isstate30 _isstate31 _isstate32 _isstate33 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate40 _isstate41 _isstate42 _isstate43 _isstate44 cc* cd* r_* aetiwno* rulebreakers*
reg favorability _ismanager1 _ismanager2 _isstem1 _isstem2 _isgender1 _isduration2 _isduration3 _isduration4 _isduration5 _isduration6 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry2 _isindustry3 _isindustry4 _isindustry5 _isindustry6 _isindustry7 _isindustry8 _isindustry10 _isindustry11 _isindustry12 _isstate1 _isstate2 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate8 _isstate9 _isstate10 _isstate11 _isstate12 _isstate14 _isstate15 _isstate16 _isstate17 _isstate18 _isstate19 _isstate20 _isstate21 _isstate23 _isstate24 _isstate25 _isstate26 _isstate27 _isstate28 _isstate29 _isstate30 _isstate31 _isstate32 _isstate33 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate40 _isstate41 _isstate42 _isstate43 _isstate44 cc* cd* r_* aetiwno* rulebreakers*
reg favorability _ismanager1 _ismanager2 _isstem1 _isstem2 _isgender1 _isduration2 _isduration3 _isduration4 _isduration5 _isduration6 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry2 _isindustry3 _isindustry4 _isindustry5 _isindustry6 _isindustry7 _isindustry8 _isindustry10 _isindustry11 _isindustry12 _isstate1 _isstate2 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate8 _isstate9 _isstate10 _isstate11 _isstate12 _isstate14 _isstate15 _isstate16 _isstate17 _isstate18 _isstate19 _isstate20 _isstate21 _isstate23 _isstate24 _isstate25 _isstate26 _isstate27 _isstate28 _isstate29 _isstate30 _isstate31 _isstate32 _isstate33 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate40 _isstate41 _isstate42 _isstate43 _isstate44 cc*2 cc*3 cd*2 cd*3 r_* aetiwno* rulebreakers*

* // below is true long reg; omitted variables omitted and also dropped non-preferred interaction, aetiwno_price_x_con
reg favorability _ismanager1 _ismanager2 _isstem1 _isstem2 _isgender1 _isduration2 _isduration3 _isduration4 _isduration5 _isduration6 _iscompanysize1 _iscompanysize2 _iscompanysize3 _iscompanysize4 _iscompanysize5 _iscompanysize6 _iscompanysize7 _iscompanysize8 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry2 _isindustry3 _isindustry4 _isindustry5 _isindustry6 _isindustry7 _isindustry8 _isindustry10 _isindustry11 _isindustry12 _isstate1 _isstate2 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate8 _isstate9 _isstate10 _isstate11 _isstate12 _isstate14 _isstate15 _isstate16 _isstate17 _isstate18 _isstate19 _isstate20 _isstate21 _isstate23 _isstate24 _isstate25 _isstate26 _isstate27 _isstate28 _isstate29 _isstate30 _isstate31 _isstate32 _isstate33 _isstate34 _isstate35 _isstate36 _isstate37 _isstate38 _isstate39 _isstate40 _isstate41 _isstate42 _isstate43 _isstate44 cc*2 cc*3 cd*2 cd*3 r_* aetiwno_attractiveness aetiwno_body_x_it aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_eq aetiwno_oddhours aetiwno_rulebreaker aetiwno_salary aetiwno_teamwork aetiwno_technicaljobskills aetiwno_verbal aetiwno_written rulebreakers*

* // BELOW IS FOR PYTHON V STATA COMPARISON, NOT FOR CURRENT ANALYSIS; MAINTAINED FOR REFERENCE
* // does not apply to alt-ed-matching-effects-2.tex
* //
* // strong model from legacy analysis. ref: alt-ed-matching-effects/data
reg favorability _ismanager1 _ismanager2 _isstate13 _isstate21 _isstate34 _isstate36 _isstate8 aetiwo_concientiousness aetiwo_customerserviceskill rulebreakers*

* // regtocompare1
* // re-insert aetiwo_rulebreaker to strong model, in order to tell a story (even though this effect is weak)
* // sign is negative and p < 0.025
* // so, it's robustly negatively signed but we don't very well know the coefficient; probably less than 2.
reg favorability _ismanager1 _ismanager2 _isstate13 _isstate21 _isstate34 _isstate36 _isstate8 aetiwo_concientiousness aetiwo_customerserviceskill rulebreakers* aetiwo_rulebreaker

* // regtocompare2 === regtocompare1 without states bc i don't feel like mapping state values
* // r2=0.2047, ar2=0.1733, n=212, F=6.53,
* // minFactorP={rulebreakersnormsprobablyhaveaha, t=3.67, B=0.183},
* // maxFactorP={_ismanager1, t=0.70, B=0.591} 
reg favorability _ismanager1 _ismanager2 aetiwo_concientiousness aetiwo_customerserviceskill rulebreakers* aetiwo_rulebreaker
