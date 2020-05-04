clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // roi2.5 - before restoration + first and second lag and difference expansion
* // anderson-hsiao transform of roi2
* // ref: youtube.com/watch?v=wqwDcY9pq5I
* // double lagged voi as instrument; breaks autocorrelation with first difference variable of interest
ivreg d.totalen employer_a*1 employer_a*2 pce2 pce3 stateperm1 visa_m_h1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year (l.d.totalen=l2.d.totalen)

* // roi4
* // reduced dols
* // 
ivreg d.totalen employer_a*1 employer_a*2 pce2 pce3 stateperm1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year (l.d.totalen=l2.d.totalen)
