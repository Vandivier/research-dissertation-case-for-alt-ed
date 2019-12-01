
clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-4-2019-exploration.do"

estout voiweak2018 voimaxar2018 voistr2018 voiweak2019 voimaxar2019 voistr2019, cells(b(star fmt(3)) se(par fmt(2))) legend varlabels(_cons constant) stats(r2, fmt(3 0 1) label(R-sqr))
