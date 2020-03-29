clear

* // Note: This table based on multiple OLS from ./analysis-2-basic-exploration.do
do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

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

esttab R1 R2 R3 R4 using temp.tex, booktabs keep(stategi3 real_m_both employer_a* tuition_cpi visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2) label replace order(stategi3 real_m_both employer_* tuition_cpi visa_m* year year2) se star(+ 0.10 ++ 0.05 * .01 ** .001) stats(r2, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.7e)  mtitles(1 2 3 4) nonumbers
