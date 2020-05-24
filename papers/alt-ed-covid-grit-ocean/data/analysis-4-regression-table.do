clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // TODO: 4 rsoi:
* // R1 - initial-stipulated ols
* // R2 - reduced-stipulated ols
* // R3 - initial-stipulated dols
* // R4 - reduced-stipulated dols

reg totalen emp* pce* staffordlimitiscombined stategi3 stateperm1 tuition_cpi visa_m* year
estimates store R1, title(Model 1)

reg totalen employer_a*1 employer_a*2 pce2 stateperm1 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 visa_m_total year
estimates store R2, title(Model 2)

ivreg d.totalen employer_a* d.employer_assistance_1 d.d.employer_assistance_1 l.employer_assistance_1 l.l.employer_assistance_1 pce* d.pce d.d.pce l.pce l.l.pce stateperm1 visa_m_h1 visa_m_h1b_* d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_1 l.l.visa_m_h1b_1 visa_m_non_h1 visa_m_total year (l.d.totalen=l2.d.totalen)
estimates store R3, title(Model 3)

ivreg d.totalen employer_a*2 pce*2 d.pce d.d.pce l.l.pce visa_m_h1b_*2 year2 (l.d.totalen=l2.d.totalen)
estimates store R4, title(Model 4)

esttab R1 R2 R3 R4 using temp.tex, booktabs keep(employer_a*2 pce2 stateperm1 visa_m_h1b_2 year) label order(visa_m_h1b_2 pce2 employer_a*2 stateperm1 year) replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2 N, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
