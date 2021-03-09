clear

import delimited C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\data-hidden-wrangled.csv

tab doyoucontributetohiring, gen(_ismanager)
tab doyouworkinastem, gen(_isstem)
tab gender, gen(_isgender)
tab howlongdoyoubelieve, gen(_isduration)
tab roughlyhowmany, gen(_iscompanysize)
tab thinkingaboutthejobtitle, gen(_isawareofrelevantcredentials)
tab whichoftheseindustries, gen(_isindustry)
tab whatstate, gen(_isstate)

gen ccompanysize1 = roughlyhowmany if roughlyhowmany != 9
gen ccompanysize2 = ccompanysize1*ccompanysize1
gen ccompanysize3 = ccompanysize1*ccompanysize1*ccompanysize1
gen cduration1 = howlongdoyoubelieve
gen cduration2 = cduration1*cduration1
gen cduration3 = cduration1*cduration1*cduration1

gen favorability = formanyprofessionsalternativecre

gen aetiwo_attractiveness = attractiveness_ideal - attractiveness_ngwac
gen aetiwo_eq = eq_ideal - eq_ngwac
gen aetiwo_salary = salary_ideal - salary_ngwac
gen aetiwo_written = written_ideal - written_ngwac
gen aetiwo_verbal = verbal_ideal - verbal_ngwac
gen aetiwo_bodylanguage = bodylanguage_ideal - bodylanguage_ngwac
gen aetiwo_technicaljobskills = technicaljobskills_ideal - technicaljobskills_ngwac
gen aetiwo_concientiousness = concientiousness_ideal - concientiousness_ngwac
gen aetiwo_rulebreaker = rulebreaker_ideal - rulebreaker_ngwac
gen aetiwo_customerserviceskill = customerserviceskill_ideal - customerserviceskill_ngwac
gen aetiwo_teamwork = teamwork_ideal - teamwork_ngwac
gen aetiwo_commute = willingtocommute_ideal - willingtocommute_ngwac
gen aetiwo_oddhours = willingtoworkoddhours_ideal - willingtoworkoddhours_ngwac

gen aetiwno_attractiveness = attractiveness_ideal - attractiveness_ngwac
replace aetiwno_attractiveness = 0 if aetiwno_attractiveness < 0
gen aetiwno_eq = eq_ideal - eq_ngwac
replace aetiwno_eq = 0 if aetiwno_eq < 0
gen aetiwno_salary = salary_ideal - salary_ngwac
replace aetiwno_salary = 0 if aetiwno_salary < 0
gen aetiwno_written = written_ideal - written_ngwac
replace aetiwno_written = 0 if aetiwno_written < 0
gen aetiwno_verbal = verbal_ideal - verbal_ngwac
replace aetiwno_verbal = 0 if aetiwno_verbal < 0
gen aetiwno_bodylanguage = bodylanguage_ideal - bodylanguage_ngwac
replace aetiwno_bodylanguage = 0 if aetiwno_bodylanguage < 0
gen aetiwno_technicaljobskills = technicaljobskills_ideal - technicaljobskills_ngwac
replace aetiwno_technicaljobskills = 0 if aetiwno_technicaljobskills < 0
gen aetiwno_concientiousness = concientiousness_ideal - concientiousness_ngwac
replace aetiwno_concientiousness = 0 if aetiwno_concientiousness < 0
gen aetiwno_rulebreaker = rulebreaker_ideal - rulebreaker_ngwac
replace aetiwno_rulebreaker = 0 if aetiwno_rulebreaker < 0
gen aetiwno_customerserviceskill = customerserviceskill_ideal - customerserviceskill_ngwac
replace aetiwno_customerserviceskill = 0 if aetiwno_customerserviceskill < 0
gen aetiwno_teamwork = teamwork_ideal - teamwork_ngwac
replace aetiwno_teamwork = 0 if aetiwno_teamwork < 0
gen aetiwno_commute = willingtocommute_ideal - willingtocommute_ngwac
replace aetiwno_commute = 0 if aetiwno_commute < 0
gen aetiwno_oddhours = willingtoworkoddhours_ideal - willingtoworkoddhours_ngwac
replace aetiwno_oddhours = 0 if aetiwno_oddhours < 0

* // gen aetiwo_bodylanguage_x_it_industry = 1*2
gen aetiwo_body_x_it = aetiwo_bodylanguage*_isindustry6
gen aetiwno_body_x_it = aetiwno_bodylanguage*_isindustry6

gen c_1 = aetiwno_concientiousness
gen c_2 = c_1*c_1
gen c_x_bodylanguage = c_1*aetiwno_bodylanguage
gen c_x_commute = c_1*aetiwno_commute
gen c_x_cust = c_1*aetiwno_cust
gen c_x_team = c_1*aetiwno_team
gen c_x_tech = c_1*aetiwno_tech
gen c_x_rulebreaker_risky = c_1*rulebreakersnormsprobablyhaveaha
gen c_x_rulebreaker_rockstars = c_1*rulebreakersnormsmightbedoingsob
gen c_x_rulebreaker_culture_add = c_1*rulebreakersnormstendtobegiftedi

gen r_x_rulebreaker_risky = aetiwno_rulebreaker*rulebreakersnormsprobablyhaveaha
gen r_x_rulebreaker_rockstars = aetiwno_rulebreaker*rulebreakersnormsmightbedoingsob
gen r_x_rulebreaker_culture_add = aetiwno_rulebreaker*rulebreakersnormstendtobegiftedi

* // gen istruncated_acng = aetiwno_concientiousness == 0
* // gen istruncated_rcg = rcgtiwno_concientiousness == 0

gen isideal_acng = concientiousness_ngwac == concientiousness_ideal
gen isideal_rcg = concientiousness_recent == concientiousness_ideal
gen isbetter_acng_concientiousness = concientiousness_ngwac > concientiousness_recent
gen isbetter_acng_commute = willingtocommute_ngwac > willingtocommute_recent
gen isbetter_acng_bodylanguage = bodylanguage_ngwac > bodylanguage_recent

* // oq = overqualified
* // it's like an inverse _wno_ operation
gen oq_rcg_concientiousness = concientiousness_recentc - concientiousness_ideal
replace oq_rcg_concientiousness = 0 if oq_rcg_concientiousness < 0
gen oq_acng_concientiousness = concientiousness_ngwac - concientiousness_ideal
replace oq_acng_concientiousness = 0 if oq_acng_concientiousness < 0

gen m2aetiwno_concientiousness = aetiwno_concientiousness*aetiwno_concientiousness
gen m2aetiwno_attractiveness = aetiwno_attractiveness*aetiwno_attractiveness
gen m2aetiwno_body_x_it = aetiwno_body_x_it*aetiwno_body_x_it
gen m2aetiwno_eq = aetiwno_eq*aetiwno_eq

drop formanyprofessionsalternativecre
drop howlongdoyoubelieveitusually
drop ifyoudocontributetohiringandfiri
drop roughlyhowmany
drop thinkingaboutthejobtitle
drop whichoftheseindustries
drop whatstate

gen rcgtiwno_attractiveness = attractiveness_ideal - attractiveness_recentc
replace rcgtiwno_attractiveness = 0 if rcgtiwno_attractiveness < 0
gen diff1_wno_attractiveness = aetiwno_attractiveness-rcgtiwno_attractiveness
gen diff2_wno_attractiveness = diff1_wno_attractiveness*diff1_wno_attractiveness
gen diff3_wno_attractiveness = diff1_wno_attractiveness*diff1_wno_attractiveness*diff1_wno_attractiveness

gen rcgtiwno_eq = eq_ideal - eq_recentc
replace rcgtiwno_eq = 0 if rcgtiwno_eq < 0
gen diff1_wno_eq = aetiwno_eq-rcgtiwno_eq
gen diff2_wno_eq = diff1_wno_eq*diff1_wno_eq
gen diff3_wno_eq = diff1_wno_eq*diff1_wno_eq*diff1_wno_eq

gen rcgtiwno_salary = salary_ideal - salary_recentc
replace rcgtiwno_salary = 0 if rcgtiwno_salary < 0
gen diff1_wno_salary = aetiwno_salary-rcgtiwno_salary
gen diff2_wno_salary = diff1_wno_salary*diff1_wno_salary
gen diff3_wno_salary = diff1_wno_salary*diff1_wno_salary*diff1_wno_salary

gen rcgtiwno_written = written_ideal - written_recentc
replace rcgtiwno_written = 0 if rcgtiwno_written < 0
gen diff1_wno_written = aetiwno_written-rcgtiwno_written
gen diff2_wno_written = diff1_wno_written*diff1_wno_written
gen diff3_wno_written = diff1_wno_written*diff1_wno_written*diff1_wno_written

gen rcgtiwno_verbal = verbal_ideal - verbal_recentc
replace rcgtiwno_verbal = 0 if rcgtiwno_verbal < 0
gen diff1_wno_verbal = aetiwno_verbal-rcgtiwno_verbal
gen diff2_wno_verbal = diff1_wno_verbal*diff1_wno_verbal
gen diff3_wno_verbal = diff1_wno_verbal*diff1_wno_verbal*diff1_wno_verbal

gen rcgtiwno_bodylanguage = bodylanguage_ideal - bodylanguage_recentc
replace rcgtiwno_bodylanguage = 0 if rcgtiwno_bodylanguage < 0
gen diff1_wno_bodylanguage = aetiwno_bodylanguage-rcgtiwno_bodylanguage
gen diff2_wno_bodylanguage = diff1_wno_bodylanguage*diff1_wno_bodylanguage
gen diff3_wno_bodylanguage = diff1_wno_bodylanguage*diff1_wno_bodylanguage*diff1_wno_bodylanguage

gen rcgtiwno_technicaljobskills = technicaljobskills_ideal - technicaljobskills_recentc
replace rcgtiwno_technicaljobskills = 0 if rcgtiwno_technicaljobskills < 0
gen diff1_wno_technicaljobskills = aetiwno_technicaljobskills-rcgtiwno_technicaljobskills
gen diff2_wno_technicaljobskills = diff1_wno_technicaljobskills*diff1_wno_technicaljobskills
gen diff3_wno_technicaljobskills = diff1_wno_technicaljobskills*diff1_wno_technicaljobskills*diff1_wno_technicaljobskills

gen rcgtiwno_concientiousness = concientiousness_ideal - concientiousness_recentc
replace rcgtiwno_concientiousness = 0 if rcgtiwno_concientiousness < 0
gen diff1_wno_concientiousness = aetiwno_concientiousness-rcgtiwno_concientiousness
gen diff2_wno_concientiousness = diff1_wno_concientiousness*diff1_wno_concientiousness
gen diff3_wno_concientiousness = diff1_wno_concientiousness*diff1_wno_concientiousness*diff1_wno_concientiousness

gen rcgtiwno_rulebreaker = rulebreaker_ideal - rulebreaker_recentc
replace rcgtiwno_rulebreaker = 0 if rcgtiwno_rulebreaker < 0
gen diff1_wno_rulebreaker = aetiwno_rulebreaker-rcgtiwno_rulebreaker
gen diff2_wno_rulebreaker = diff1_wno_rulebreaker*diff1_wno_rulebreaker
gen diff3_wno_rulebreaker = diff1_wno_rulebreaker*diff1_wno_rulebreaker*diff1_wno_rulebreaker

gen rcgtiwno_customerserviceskill = customerserviceskill_ideal - customerserviceskill_recentc
replace rcgtiwno_customerserviceskill = 0 if rcgtiwno_customerserviceskill < 0
gen diff1_wno_customerserviceskill = aetiwno_customerserviceskill-rcgtiwno_customerserviceskill
gen diff2_wno_customerserviceskill = diff1_wno_customerserviceskill*diff1_wno_customerserviceskill
gen diff3_wno_customerserviceskill = diff1_wno_customerserviceskill*diff1_wno_customerserviceskill*diff1_wno_customerserviceskill

gen rcgtiwno_teamwork = teamwork_ideal - teamwork_recentc
replace rcgtiwno_teamwork = 0 if rcgtiwno_teamwork < 0
gen diff1_wno_teamwork = aetiwno_teamwork-rcgtiwno_teamwork
gen diff2_wno_teamwork = diff1_wno_teamwork*diff1_wno_teamwork
gen diff3_wno_teamwork = diff1_wno_teamwork*diff1_wno_teamwork*diff1_wno_teamwork

gen rcgtiwno_commute = willingtocommute_ideal - willingtocommute_recentc
replace rcgtiwno_commute = 0 if rcgtiwno_commute < 0
gen diff1_wno_commute = aetiwno_commute-rcgtiwno_commute
gen diff2_wno_commute = diff1_wno_commute*diff1_wno_commute
gen diff3_wno_commute = diff1_wno_commute*diff1_wno_commute*diff1_wno_commute

gen rcgtiwno_oddhours = willingtoworkoddhours_ideal - willingtoworkoddhours_recentc
replace rcgtiwno_oddhours = 0 if rcgtiwno_oddhours < 0
gen diff1_wno_oddhours = aetiwno_oddhours-rcgtiwno_oddhours
gen diff2_wno_oddhours = diff1_wno_oddhours*diff1_wno_oddhours
gen diff3_wno_oddhours = diff1_wno_oddhours*diff1_wno_oddhours*diff1_wno_oddhours

* // TODO: interesting, but not studied
* // gen diff1_wno_price_x_con = aetiwno_price_x_con-rcgtiwno_price_x_con
* // gen diff2_wno_price_x_con = diff1_wno_price_x_con*diff1_wno_price_x_con

* // TODO: remember how STATA names a tab_gen variable:
* // in alphabetical order, but skipping when 0 responses
* // eg, _isstate16 is Kansas rather than Iowa bc 0 ppl said Iowa
* // but, below _is* have been verified
label variable _iscompanysize3 "Employees 51-200"
label variable _iscompanysize4 "Employees 201-500"
label variable _iscompanysize8 "Employees 10,000+"
label variable _isduration6 "Duration 1 Year+"
label variable _ismanager1 "Is Manager"
label variable _ismanager2 "Is Employed Non-Manager"
label variable aetiwo_bodylanguage "WOQ, Gap, Body Language"
label variable aetiwno_bodylanguage "Gap, Body Language"
label variable aetiwo_commute "WOQ, Gap, Commute"
label variable aetiwno_commute "Gap, Commute"
label variable aetiwo_eq "WOQ, Gap, EQ"
label variable aetiwo_body_x_it "WOQ, Gap, Body Language-IT"
label variable aetiwno_body_x_it "Gap, Body Language-IT"
label variable aetiwo_concientiousness "WOQ, Gap, Conscientiousness"
label variable aetiwno_concientiousness "Gap, Conscientiousness"
label variable aetiwo_customerserviceskill "WOQ, Gap, Customer Service"
label variable aetiwno_customerserviceskill "Gap, Customer Service"
label variable aetiwo_rulebreaker "WOQ, Gap, Rule Breaker"
label variable aetiwno_rulebreaker "Gap, Rule Breaker"
label variable aetiwo_salary "WOQ, Gap, Salary"
label variable aetiwno_salary "Gap, Salary"
label variable aetiwo_technicaljobskills "WOQ, Gap, Technical"
label variable aetiwno_technicaljobskills "Gap, Technical"
label variable aetiwo_teamwork "WOQ, Gap, Teamwork"
label variable aetiwno_teamwork "Gap, Teamwork"
label variable fav "Hireability"
* // label variable diff_alt2_wno_bodylanguage "Difference in Squared Body Language Communication Skill"
label variable diff2_wno_bodylanguage "Squared Difference in Body Language Communication Skill"
label variable rulebreakersnormsprobablyhaveaha "Rule Breakers Risky"
label variable rulebreakersnormsmightbedoingsob "Rule Breakers Rockstars"
label variable rulebreakersnormstendtobegiftedi "Rule Breakers Culture Add"
label variable diff1_wno_attractiveness "Comparative, Attractiveness"
label variable diff1_wno_concientiousn "Comparative, Conscientiousness"
label variable diff1_wno_eq "Comparative, EQ"
label variable diff1_wno_rulebreaker "Comparative, Rulebreaker"
label variable diff1_wno_customerserviceskill "Comparative, Customer Service"
label variable diff1_wno_oddhours "Comparative, Willing to Work Odd Hours"
label variable diff1_wno_teamwork "Comparative, Teamwork"
label variable diff1_wno_written "Comparative, Written Communication"
label variable aetiwno_attractiveness "Gap, Attractiveness"
label variable aetiwo_attractiveness "WOQ, Gap, Attractiveness"
label variable aetiwno_eq "Gap, EQ"
label variable cduration1 "Duration"
label variable _isstem1 "Is STEM Worker"
label variable _isstem2 "Is Not STEM Worker"
label variable _isstem2 "Is Unsure on STEM Status"
label variable _isawareofrelevantcredentials1 "Industry Credentials Legally Required"
label variable _isawareofrelevantcredentials2 "Industry Credentials Normal"
label variable _isawareofrelevantcredentials3 "Industry Credentials Sometimes Used"
label variable _isawareofrelevantcredentials4 "Industry Credentials Unknown"
label variable _isawareofrelevantcredentials5 "Industry Credentials n/a"

* // state, industry
