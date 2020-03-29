clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // Note: This table based on multiple OLS from ./analysis-2-basic-exploration.do

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

* // long reg with tuition_cpi and not real_m_both
reg totalen pce pce2 employer_assistance_1 stategi3 tuition_cpi visa_m* year year2
estimates store R1, title(Regression 1)
* // long reg of interest
reg totalen pce pce2 employer_assistance_1 real_m_both stategi3 visa_m* year year2
estimates store R2, title(Regression 2)
* // third long reg of interest
reg totalen employer_assistance_2 employer_assistance_3 employer_x_h1b_1 stategi3 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 year year2
estimates store R3, title(Regression 3)
* // interpretation-friendly second short regression of interest transform is the third short regression of interest and preferred model
reg totalen employer_assistance_1 employer_assistance_2 employer_assistance_3 stategi3 visa_m_h1b_1 visa_m_h1b_2 year year2
estimates store R4, title(Regression 4)

* // ref estout in other *table*.do files
* // esttab R1 R2 R3 R4, keep(stategi3 real_m_both employer_a* tuition_cpi visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2) label replace order(stategi3 real_m_both employer_* tuition_cpi visa_m* year year2) se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)
esttab R1 R2 R3 R4 using temp.tex, booktabs keep(stategi3 real_m_both employer_a* tuition_cpi visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2) label replace order(stategi3 real_m_both employer_* tuition_cpi visa_m* year year2) se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)

* // not sure why the below drops \addlinespace rows
* // esttab R1 R2 R3 R4 using temp.tex, booktabs keep(stategi3 real_m_both employer_a* tuition_cpi visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2) label replace order(stategi3 real_m_both employer_* tuition_cpi visa_m* year year2) se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) cell(b(f(3 3 %10.7e) par(\num{ })) t(f(3) par((\num{ }))))


