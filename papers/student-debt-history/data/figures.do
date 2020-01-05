clear

import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\data\google-search-wgu.csv

line results year, ylabel(, angle(horizontal)) ytitle("Count", orientation(horizontal))

graph export D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\figures-and-tables\figure-1-google-search-wgu.png

clear

import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\data\google-trends-digital-education.csv

gen formattedMonth = subinstr(month, "-", "",.) + "01"
gen dates = date(formattedMonth, "YMD")

tsset dates, daily
twoway (tsline moocs onlinedegree wgu udacity), tlabel(, format(%dCY)) ylabel(, angle(horizontal)) ttitle("Date")

graph export D:\GitHub\research-dissertation-case-for-alt-ed\papers\student-debt-history\figures-and-tables\figure-2-google-trends-digital-education.png

