clear

import delimited D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\soac-matching-2020-07.csv

tab doyoucontributetohiring, gen(_ismanager)
tab doyouworkinastem, gen(_isstem)
tab gender, gen(_isgender)
tab howlongdoyoubelieve, gen(_isduration)
tab roughlyhowmany, gen(_iscompanysize)
tab thinkingaboutthejobtitle, gen(_isawareofrelevantcredentials)
tab whichoftheseindustries, gen(_isindustry)
tab whatstate, gen(_isstate)

gen cawareofrelevantcredentials1 = thinkingaboutthejobtitle if thinkingaboutthejobtitle != 5
gen cawareofrelevantcredentials2 = cawareofrelevantcredentials1*cawareofrelevantcredentials1
gen cawareofrelevantcredentials3 = cawareofrelevantcredentials1*cawareofrelevantcredentials1*cawareofrelevantcredentials1
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

gen rcgtiwno_bodylanguage = bodylanguage_ideal - bodylanguage_recentc
gen rcgtiwo_bodylanguage = bodylanguage_ideal - bodylanguage_recentc
replace rcgtiwno_bodylanguage = 0 if rcgtiwno_bodylanguage < 0
gen diff_wno_bodylanguage = aetiwno_bodylanguage-rcgtiwno_bodylanguage
gen diff_wo_bodylanguage = aetiwo_bodylanguage-rcgtiwo_bodylanguage
gen diff2_wno_bodylanguage = diff_wno_bodylanguage*diff_wno_bodylanguage
gen diff3_wno_bodylanguage = diff_wno_bodylanguage*diff_wno_bodylanguage*diff_wno_bodylanguage
gen diff2_wo_bodylanguage = diff_wo_bodylanguage*diff_wo_bodylanguage
gen diff_alt2_wno_bodylanguage = rcgtiwno_bodylanguage*rcgtiwno_bodylanguage - aetiwno_bodylanguage*aetiwno_bodylanguage
gen diff_alt3_wno_bodylanguage = rcgtiwno_bodylanguage*rcgtiwno_bodylanguage*rcgtiwno_bodylanguage - aetiwno_bodylanguage*aetiwno_bodylanguage*aetiwno_bodylanguage

* // acng more willing to commute on average `sum willingtocommute_recentc willingtocommute_ng'
gen rcgtiwno_commute = willingtocommute_ideal - willingtocommute_recentc
gen rcgtiwo_commute = willingtocommute_ideal - willingtocommute_recentc
replace rcgtiwno_commute = 0 if rcgtiwno_commute < 0
gen diff_wno_commute = aetiwno_commute-rcgtiwno_commute
gen diff_wo_commute = aetiwo_commute-rcgtiwo_commute
gen diff2_wno_commute = diff_wno_commute*diff_wno_commute
gen diff3_wno_commute = diff_wno_commute*diff_wno_commute*diff_wno_commute
gen diff2_wo_commute = diff_wo_commute*diff_wo_commute
gen diff_alt2_wno_commute = rcgtiwno_commute*rcgtiwno_commute - aetiwno_commute*aetiwno_commute
gen diff_alt3_wno_commute = rcgtiwno_commute*rcgtiwno_commute*rcgtiwno_commute - aetiwno_commute*aetiwno_commute*aetiwno_commute

gen rcgtiwno_concientiousness = concientiousness_ideal - concientiousness_recentc
gen rcgtiwo_concientiousness = concientiousness_ideal - concientiousness_recentc
replace rcgtiwno_concientiousness = 0 if rcgtiwno_concientiousness < 0
gen diff_wno_concientiousness = aetiwno_concientiousness-rcgtiwno_concientiousness
gen diff_wo_concientiousness = aetiwo_concientiousness-rcgtiwo_concientiousness
gen diff2_wno_concientiousness = diff_wno_concientiousness*diff_wno_concientiousness
gen diff3_wno_concientiousness = diff_wno_concientiousness*diff_wno_concientiousness*diff_wno_concientiousness
gen diff2_wo_concientiousness = diff_wo_concientiousness*diff_wo_concientiousness
gen diff_alt2_wno_concientiousness = rcgtiwno_concientiousness*rcgtiwno_concientiousness - aetiwno_concientiousness*aetiwno_concientiousness
gen diff_alt3_wno_concientiousness = rcgtiwno_concientiousness*rcgtiwno_concientiousness*rcgtiwno_concientiousness - aetiwno_concientiousness*aetiwno_concientiousness*aetiwno_concientiousness

gen rcgtiwno_customerserviceskill = customerserviceskill_ideal - customerserviceskill_recentc
gen rcgtiwo_customerserviceskill = customerserviceskill_ideal - customerserviceskill_recentc
replace rcgtiwno_customerserviceskill = 0 if rcgtiwno_customerserviceskill < 0
gen diff_wno_customerserviceskill = aetiwno_customerserviceskill-rcgtiwno_customerserviceskill
gen diff_wo_customerserviceskill = aetiwo_customerserviceskill-rcgtiwo_customerserviceskill
gen diff2_wno_customerserviceskill = diff_wno_customerserviceskill*diff_wno_customerserviceskill
gen diff2_wo_customerserviceskill = diff_wo_customerserviceskill*diff_wo_customerserviceskill

gen rcgtiwno_technicaljobskills = technicaljobskills_ideal - technicaljobskills_recentc
gen rcgtiwo_technicaljobskills = technicaljobskills_ideal - technicaljobskills_recentc
replace rcgtiwno_technicaljobskills = 0 if rcgtiwno_technicaljobskills < 0
gen diff_wno_technicaljobskills = aetiwno_technicaljobskills-rcgtiwno_technicaljobskills
gen diff_wo_technicaljobskills = aetiwo_technicaljobskills-rcgtiwo_technicaljobskills
gen diff2_wno_technicaljobskills = diff_wno_technicaljobskills*diff_wno_technicaljobskills
gen diff2_wo_technicaljobskills = diff_wo_technicaljobskills*diff_wo_technicaljobskills

gen rcgtiwno_teamwork = teamwork_ideal - teamwork_recentc
gen rcgtiwo_teamwork = teamwork_ideal - teamwork_recentc
replace rcgtiwno_teamwork = 0 if rcgtiwno_teamwork < 0
gen diff_wno_teamwork = aetiwno_teamwork-rcgtiwno_teamwork
gen diff_wo_teamwork = aetiwo_teamwork-rcgtiwo_teamwork
gen diff2_wno_teamwork = diff_wno_teamwork*diff_wno_teamwork
gen diff2_wo_teamwork = diff_wo_teamwork*diff_wo_teamwork

gen rcgtiwno_rulebreaker = rulebreaker_ideal - rulebreaker_recentc
gen rcgtiwo_rulebreaker = rulebreaker_ideal - rulebreaker_recentc
replace rcgtiwno_rulebreaker = 0 if rcgtiwno_rulebreaker < 0
gen diff_wno_rulebreaker = aetiwno_rulebreaker-rcgtiwno_rulebreaker
gen diff_wo_rulebreaker = aetiwo_rulebreaker-rcgtiwo_rulebreaker
gen diff2_wno_rulebreaker = diff_wno_rulebreaker*diff_wno_rulebreaker
gen diff2_wo_rulebreaker = diff_wo_rulebreaker*diff_wo_rulebreaker

* // 7.5 seems to be a real shelling point...i wonder why?
* // queue some other paper on unconcious logical bias; 7.5 is the 'very mark' half way between 5 and 10
* // interpreted this way, 7.2 salary means 'ideal candidate costs more than average, but not very well paid'
gen rcgtiwno_salary = salary_ideal - salary_recentc
gen rcgtiwo_salary = salary_ideal - salary_recentc
replace rcgtiwno_salary = 0 if rcgtiwno_salary < 0
gen diff_wno_salary = aetiwno_salary-rcgtiwno_salary
gen diff_wo_salary = aetiwo_salary-rcgtiwo_salary
gen diff2_wno_salary = diff_wno_salary*diff_wno_salary
gen diff2_wo_salary = diff_wo_salary*diff_wo_salary

gen istruncated_acng = aetiwno_concientiousness == 0
gen istruncated_rcg = rcgtiwno_concientiousness == 0

gen isideal_acng = concientiousness_ngwac == concientiousness_ideal
gen isideal_rcg = concientiousness_recent == concientiousness_ideal
gen isbetter_acng_concientiousness = concientiousness_ngwac > concientiousness_recent
gen isbetter_acng_commute = willingtocommute_ngwac > willingtocommute_recent
gen isbetter_acng_bodylanguage = bodylanguage_ngwac > bodylanguage_recent

gen aetiwno_price_x_con = aetiwno_salary*aetiwno_concientiousness
gen rcgtiwno_price_x_con = rcgtiwno_salary*rcgtiwno_concientiousness
gen diff_wno_price_x_con = aetiwno_price_x_con-rcgtiwno_price_x_con
gen diff2_wno_price_x_con = diff_wno_price_x_con*diff_wno_price_x_con

* // oq = overqualified
* // it's like an inverse _wno_ operation
gen oq_rcg_concientiousness = concientiousness_recentc - concientiousness_ideal
replace oq_rcg_concientiousness = 0 if oq_rcg_concientiousness < 0
gen oq_acng_concientiousness = concientiousness_ngwac - concientiousness_ideal
replace oq_acng_concientiousness = 0 if oq_acng_concientiousness < 0

drop formanyprofessionsalternativecre
drop howlongdoyoubelieveitusually
drop ifyoudocontributetohiringandfiri
drop roughlyhowmany
drop thinkingaboutthejobtitle
drop whichoftheseindustries
drop whatstate

label variable _iscompanysize4 "Employees 201-500"
label variable _iscompanysize8 "Employees 10,000+"
label variable _isduration6 "Duration 1 Year+"
label variable _ismanager1 "Is Manager"
label variable _ismanager2 "Is Employed Non-Manager"
label variable aetiwo_bodylanguage "Gap, Body Language"
label variable aetiwno_bodylanguage "Gap, Body Language"
label variable aetiwo_commute "Gap, Commute"
label variable aetiwno_commute "Gap, Commute"
label variable aetiwo_body_x_it "Gap, Body Language-IT"
label variable aetiwno_body_x_it "Gap, Body Language-IT"
label variable aetiwo_concientiousness "Gap, Conscientiousness"
label variable aetiwno_concientiousness "Gap, Conscientiousness"
label variable aetiwo_customerserviceskill "Gap, Customer Service"
label variable aetiwno_customerserviceskill "Gap, Customer Service"
label variable aetiwo_rulebreaker "Gap, Rule Breaker"
label variable aetiwno_rulebreaker "Gap, Rule Breaker"
label variable aetiwo_salary "Gap, Salary"
label variable aetiwno_salary "Gap, Salary"
label variable aetiwo_technicaljobskills "Gap, Technical"
label variable aetiwno_technicaljobskills "Gap, Technical"
label variable aetiwo_teamwork "Gap, Teamwork"
label variable aetiwno_teamwork "Gap, Teamwork"
label variable fav "Hirability"
label variable diff_alt2_wno_bodylanguage "Difference in Squared Body Language Communication Skill"
label variable diff2_wno_bodylanguage "Squared Difference in Body Language Communication Skill"
label variable rulebreakersnormsprobablyhaveaha "Rule Breakers Risky"
label variable rulebreakersnormsmightbedoingsob "Rule Breakers Rockstars"
label variable rulebreakersnormstendtobegiftedi "Rule Breakers Culture Add"
