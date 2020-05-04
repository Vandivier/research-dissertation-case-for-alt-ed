clear

* // Note: deprecated file in V2 of paper...collapsed into analysis-8-regression-table.do
* // Note: This table based on multiple OLS from ./analysis-3-dynamic-ols.do
do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // simple iv transform of mols preferred regression
* // interpretation-friendly second short regression of interest transform is the third short regression of interest and preferred model
ivreg d.totalen employer_a* stategi3 visa_m_h1b_1 visa_m_h1b_2 year year2 (l.d.totalen=l2.d.totalen)
estimates store R1, title(Regression 1)

* // dols preferred regression
* // period from 1992 - 2016
sum year if  !(missing(d.d.employer_assistance_1)) & !(missing(d.d.visa_m_h1b_1))
ivreg d.totalen employer_assistance_1 employer_assistance_2 visa_m_h1b_2 visa_m_h1b_3 year2 (l.d.totalen=l2.d.totalen) d.employer_assistance_1 d.d.employer_assistance_1 d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_2 l.visa_m_h1b_3
estimates store R2, title(Regression 2)

esttab R1 R2 using temp.tex, booktabs keep(employer_assistance_1 employer_assistance_2 visa_m_h1b_2 visa_m_h1b_3 year2) label order(visa_m_h1b_2 visa_m_h1b_3 employer_assistance_1 employer_assistance_2 year2) replace se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e) mtitles(5 6) nonumbers
