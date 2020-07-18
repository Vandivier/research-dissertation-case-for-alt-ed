clear

import delimited D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\soac-matching-2020-07.csv

gen aetiwo_attractiveness = attractiveness_ideal - attractiveness_ngwag
gen aetiwo_eq = eq_ideal - eq_ngwag
gen aetiwo_salary = salary_ideal - salary_ngwag
gen aetiwo_written = written_ideal - written_ngwag
gen aetiwo_verbal = verbal_ideal - verbal_ngwag
gen aetiwo_bodylanguage = bodylanguage_ideal - bodylanguage_ngwag
gen aetiwo_technicaljobskills = technicaljobskills_ideal - technicaljobskills_ngwag
gen aetiwo_concientiousness = concientiousness_ideal - concientiousness_ngwag
gen aetiwo_rulebreaker = rulebreaker_ideal - rulebreaker_ngwag
gen aetiwo_customerserviceskill = customerserviceskill_ideal - customerserviceskill_ngwag
gen aetiwo_teamwork = teamwork_ideal - teamwork_ngwag
gen aetiwo_commute = willingtocommute_ideal - willingtocommute_ngwag
gen aetiwo_oddhours = willingtoworkoddhours_ideal - willingtoworkoddhours_ngwag
