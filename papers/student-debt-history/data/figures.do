clear

import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\data\google-search-wgu.csv

ssc install grstyle, replace
ssc install palettes, replace
grstyle init
grstyle set plain

line results year, ylabel(, angle(horizontal)) ytitle("Count", orientation(horizontal)) bgcolor(white)

graph export D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\figures-and-tables\google-search-wgu.png

clear

import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\data\google-trends-digital-education.csv

gen formattedMonth = subinstr(month, "-", "",.) + "01"
gen dates = date(formattedMonth, "YMD")

tsset dates, daily
twoway (tsline moocs onlinedegree wgu udacity), tlabel(, format(%dCY)) ylabel(, angle(horizontal)) ttitle("Date") bgcolor(white) ytitle("Interest")

graph export D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\figures-and-tables\google-trends-digital-education.png

