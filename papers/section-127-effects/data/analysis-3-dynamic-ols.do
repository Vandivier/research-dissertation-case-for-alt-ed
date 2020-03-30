clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // first reg of interest
* // anderson-hsiao transform of preferred multiple regression
* // ref: youtube.com/watch?v=wqwDcY9pq5I
* // double lagged voi as instrument; breaks autocorrelation with first difference variable of interest
ivreg d.totalen employer_a* stategi3 visa_m_h1b_1 visa_m_h1b_2 year year2 (l.d.totalen=l2.d.totalen)

* // second dols reg of interest
* // expand first reg of interest with lags and first and second differences of interest
* // begin old commentary based on running var first ---
* // we should recall that ideal period fit is 3 lags per analysis-3
* // here, we use one lag, but we still see much significance
* // just keep in mind that each factor dynamic relation flips sign eventually
* // imo, this is overall a nice robustness check but pretty much a weaker test than VAR analysis-3
* // here we see:
* // 1. enrollment is importantly dynamically autocorrelated
* // 2. visa effects, partialling out the interaction, are significant and negative at one lag
* // 3. empassist is positive as expected, though still weak (p=.169)
* // 4. the interaction variable is the most significant in the model
* // 5. direction of interaction is robust to lagging at different periods
* // end old commentary based on running var first ---
ivreg d.totalen employer_a* stategi3 visa_m_h1b* year year2 (l.d.totalen=l2.d.totalen) d.employer_assistance_1 d.d.employer_assistance_1 d.stategi3 d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.employer_assistance_1 l.employer_assistance_2 l.employer_assistance_3 l.visa_m_h1b_1 l.visa_m_h1b_2 l.visa_m_h1b_3

* // third dols regression of interest
* // reduced second dols reg of interest
* // strong but complex model
ivreg d.totalen employer_assistance_2 employer_assistance_3 visa_m_h1b_2 visa_m_h1b_3 year2 (l.d.totalen=l2.d.totalen) d.employer_assistance_1 d.d.employer_assistance_1 d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_2 l.visa_m_h1b_3

* // fourth dols reg of interest
* // power-down employer assistance boosts model power and simplifies intuition
* // pulling the same trick for visa doesn't work
* // this is preferred DOLS with r2 .925 and ar2 .85.
ivreg d.totalen employer_assistance_1 employer_assistance_2 visa_m_h1b_2 visa_m_h1b_3 year2 (l.d.totalen=l2.d.totalen) d.employer_assistance_1 d.d.employer_assistance_1 d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_2 l.visa_m_h1b_3


