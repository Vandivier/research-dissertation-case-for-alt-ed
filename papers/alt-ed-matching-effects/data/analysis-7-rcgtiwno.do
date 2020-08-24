clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects\data\analysis-1-vars.do"

* // diff is positive but insignificant; could become significant w bigger sample.
* // ACNG has worse body lang skill bc positive diff_wno_bodylanguage
sum rcgtiwno_bodylanguage aetiwno_bodylanguage diff_wno_bodylanguage diff_wo_bodylanguage bodylanguage_recentcollege bodylanguage_ngwac
