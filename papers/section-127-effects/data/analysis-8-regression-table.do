clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // long reg with tuition_cpi and not real_m_both
reg totalen pce pce2 real_m_all_institution stategi3 tuition_cpi visa_m* year year2
* // long reg of interest
reg totalen pce pce2 real_m* stategi3 visa_m* year year2

