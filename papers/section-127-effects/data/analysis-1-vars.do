clear
import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\section-127-effects.csv

gen visaenrollinteracted = newh1*totalen
gen new1 = newh1
gen new2 = newh1*newh1
gen new3 = newh1*newh1*newh1

gen year2 = year*year
gen year3 = year*year*year
gen tuition = averagetuition
gen pce = annualaveragepce

gen empassist = realassistancelimitallinstitut
gen exnew1 = empassist*new1
gen exnew2 = empassist*new2
gen exvisaenroll = empassist*visaenrollinteracted

tab gi, gen(stategi)

drop newh1
