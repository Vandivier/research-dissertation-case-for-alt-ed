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

* // gen aetiwo_bodylanguage_x_it_industry = 1*2
gen aetiwo_body_x_it = aetiwo_bodylanguage*_isindustry6

drop formanyprofessionsalternativecre
drop howlongdoyoubelieveitusually
drop ifyoudocontributetohiringandfiri
drop roughlyhowmany
drop thinkingaboutthejobtitle
drop whichoftheseindustries
drop whatstate
