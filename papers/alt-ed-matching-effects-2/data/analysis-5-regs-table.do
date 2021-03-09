clear

do "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\analysis-1-vars.do"

* // output ref: table-1-massaged.tex

* // regs of interest
* // R1 - maxar2 skills without overqualification
* // R2 - maxar2 skills with overqualification
* // R3 - maxar2 comparative skill gaps
* // R4 - preferred model; skill gaps and diffs
* // R5 - preferred model; skill gaps and diffs plus forced vars of interest (duration)

* // ref: https://www.statalist.org/forums/forum/general-stata-discussion/general/1434586-regress-est-sto-esttab-adding-f-test-p-values-within-possible
reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate10 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate20 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 aetiwo_attractiveness aetiwo_body_x_it aetiwo_concientiousness aetiwo_eq rulebreakers*
estimates store R1, title(Model 1)
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isawareofrelevantcredentials3 _isawareofrelevantcredentials4 _isindustry1 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate7 _isstate10 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate20 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness aetiwno_eq rulebreakers*
estimates store R2, title(Model 2)
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_attractiveness diff1_wno_concientiousness diff1_wno_customerserviceskill diff1_wno_eq diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written rulebreakers*
estimates store R3, title(Model 3)
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_customerserviceskill diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness rulebreakers*
estimates store R4, title(Model 4)
qui testparm*
estadd scalar f_p_value = r(p)

reg favorability _ismanager2 _isstem1 _iscompanysize3 _isawareofrelevantcredentials1 _isawareofrelevantcredentials2 _isindustry3 _isindustry4 _isindustry6 _isindustry7 _isindustry12 _isstate3 _isstate4 _isstate5 _isstate6 _isstate12 _isstate14 _isstate16 _isstate17 _isstate18 _isstate26 _isstate27 _isstate28 _isstate29 _isstate32 _isstate34 _isstate36 _isstate37 _isstate38 _isstate42 cd*1 cd*2 diff1_wno_customerserviceskill diff1_wno_oddhours diff1_wno_teamwork diff1_wno_written aetiwno_attractiveness aetiwno_body_x_it aetiwno_concientiousness rulebreakers* diff1_wno_rule aetiwno_rule
estimates store R5, title(Model 5)
qui testparm*
estadd scalar f_p_value = r(p)

* // using temp.tex, booktabs
* // esttab R1 R2 R3 R4 R5, keep(_isduration6 _iscompanysize* _ismanager* rulebreakers* aetiwo* aetiwno*) label order(_isduration6 _iscompanysize* _ismanager* rulebreakers* aetiwo* aetiwno*) replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2 f_p_value N, fmt(4 4 0) label(R-sqr p(F))) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
esttab R1 R2 R3 R4 R5, label replace se star(* 0.10 ** 0.05 *** .01) stats(r2 f_p_value N, fmt(4 4 0) label(R-sqr p(F))) varwidth(25)  mtitles(1 2 3 4) nonumbers
