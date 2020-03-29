clear
import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\section-127-effects.csv

gen visaenrollinteracted = newh1*totalen
gen visa_total = totalvisaaward
gen visa_m_h1 = totalh1familyvisaaward
gen visa_m_h1b_1 = newh1
gen visa_m_h1b_2 = newh1*newh1
gen visa_m_h1b_3 = newh1*newh1*newh1
gen visa_m_non_h1 = h1nonbaward
gen visa_is_edge_case = ish1edgecase
drop totalh1familyvisaaward
drop totalvisaaward
drop ish1edgecase
drop newh1
drop h1nonbaward

gen year2 = year*year
gen year3 = year*year*year
gen tuition_nom = nominaladjustedav
gen tuition_cpi = cpiadjusted
gen pce = annualaveragepce
gen pce2 = annualaveragepce*annualaveragepce
gen pce3 = annualaveragepce*annualaveragepce*annualaveragepce

gen real_m_all_institution = realassistancelimitallinstitutio
gen real_m_both = realassistancelimitallinstitut*basedpcedeflator
drop realassistancelimitallinstitutio

gen empassist = realassistancelimitpcecorrection
gen em2 = empassist*empassist
gen em3 = empassist*empassist*empassist
gen exnew1 = empassist*visa_m_h1b_1
gen exnew2 = empassist*visa_m_h1b_2
gen exnew3 = empassist*visa_m_h1b_3
gen exvisaenroll = empassist*visaenrollinteracted
gen loans = totalfederal

tab gi, gen(stategi)
tsset year

drop realassistanceratio*
drop nominaladjustedav
drop annualaveragepce
drop cpiadjusted
drop gi
drop unused*
drop totalfederal
* // dropping below bc 1) it isn't clear to me why it matters structurally
* // 2) I'm afraid it will steal credit for effects of interest
drop collegeageenrollmentpercent

