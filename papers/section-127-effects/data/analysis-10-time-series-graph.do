clear

* // ref: https://www.statalist.org/forums/forum/general-stata-discussion/general/1355560-plotting-multiple-time-series
do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // tsline could support more than 2 lines, but not independent y scales
* // tsline totalen loans employer_assistance_1
twoway line totalen year || line employer_assistance_1 year, yaxis(2)
