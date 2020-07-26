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
label variable rulebreakersnormsprobablyhaveaha "Rule Breakers Risky"
label variable rulebreakersnormsmightbedoingsob "Rule Breakers Rockstars"
label variable rulebreakersnormstendtobegiftedi "Rule Breakers Culture Add"
