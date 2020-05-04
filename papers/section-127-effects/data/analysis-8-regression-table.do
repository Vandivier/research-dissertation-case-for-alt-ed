clear

* // Note: This table based on multiple OLS from ./analysis-2-basic-exploration.do
do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // TODO: 4 rsoi:
* // R1 - initial-stipulated ols
* // R2 - reduced-stipulated ols
* // R3 - initial-stipulated dols
* // R4 - reduced-stipulated dols

reg totalen emp* pce* staffordlimitiscombined stategi3 stateperm1 tuition_cpi visa_m* year
estimates store R1, title(Regression 1)

reg totalen employer_a*1 employer_a*2 pce2 pce3 stateperm1 visa_m_h1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year
estimates store R2, title(Regression 2)

ivreg d.totalen employer_a* stategi3 visa_m_h1b_1 visa_m_h1b_2 year year2 (l.d.totalen=l2.d.totalen)
estimates store R1, title(Regression 1)

* // dols preferred regression
* // period from 1992 - 2016
sum year if  !(missing(d.d.employer_assistance_1)) & !(missing(d.d.visa_m_h1b_1))
ivreg d.totalen employer_assistance_1 employer_assistance_2 visa_m_h1b_2 visa_m_h1b_3 year2 (l.d.totalen=l2.d.totalen) d.employer_assistance_1 d.d.employer_assistance_1 d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_2 l.visa_m_h1b_3
estimates store R2, title(Regression 2)

esttab R1 R2 using temp.tex, booktabs keep(employer_assistance_1 employer_assistance_2 visa_m_h1b_2 visa_m_h1b_3 year2) label order(visa_m_h1b_2 visa_m_h1b_3 employer_assistance_1 employer_assistance_2 year2) replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e) mtitles(5 6) nonumbers


esttab R1 R2 R3 R4 using temp.tex, booktabs keep(stategi3 real_m_both employer_a* tuition_cpi visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2) label replace order(stategi3 real_m_both employer_* tuition_cpi visa_m* year year2) se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
