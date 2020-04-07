clear
import delimited D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\section-127-effects.csv

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
gen multiple_deflated_1 = real_m_both
gen multiple_deflated_2 = real_m_both*real_m_both
gen multiple_deflated_3 = real_m_both*real_m_both*real_m_both
drop realassistancelimitallinstitutio

gen employer_assistance_1 = real_m_all_institution
gen employer_assistance_2 = employer_assistance_1*employer_assistance_1
gen employer_assistance_3 = employer_assistance_1*employer_assistance_1*employer_assistance_1
gen employer_x_h1b_1 = employer_assistance_1*visa_m_h1b_1
gen employer_x_h1b_2 = employer_x_h1b_1*employer_x_h1b_1
gen employer_x_h1b_3 = employer_x_h1b_1*employer_x_h1b_1*employer_x_h1b_1

gen loans = totalfederal
gen loans_x_tuition = loans*tuition_cpi

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

label variable pce "PCE"
label variable pce2 "PCE^2"
label variable stategi3 "Montgomery GI"
label variable tuition_cpi "Tuition CPI"
label variable visa_m_h1 "H-1 Visa"
label variable visa_m_h1b_1 "H-1B Visa"
label variable visa_m_h1b_2 "H-1B^2"
label variable visa_m_h1b_3 "H-1B^3"
label variable visa_m_non_h1 "H-1 Non-H-1B"
label variable year "Year"
label variable year2 "Year^2"
label variable real_m_both "Real Limit - Ed and PCE"
label variable employer_assistance_1 "Real Limit - Ed"
label variable employer_assistance_2 "Real Limit - Ed^2"
label variable employer_assistance_3 "Real Limit - Ed^3"
label variable employer_x_h1b_1 "Assistance X H-1B"
label variable totalen "Enrollment"
