clear

import delimited D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\soac-matching-2020-07.csv

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
