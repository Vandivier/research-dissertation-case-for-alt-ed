clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // roi-2: anderson-Hsiao adjustment of roi-1
* // r-squared 0.904 before expansion; compare to roi3 with nill ar2 before and .919 ar2 after expansion
ivreg d.totalen emp* pce* real* staffordlimitiscombined stategi3 stateperm1 tuition* visa_m* year (l.d.totalen=l2.d.totalen)

* // roi2.5 - before restoration + first and second lag and difference expansion
* // anderson-hsiao transform of roi2
* // ref: youtube.com/watch?v=wqwDcY9pq5I
* // double lagged voi as instrument; breaks autocorrelation with first difference variable of interest
ivreg d.totalen employer_a*1 employer_a*2 pce2 pce3 stateperm1 visa_m_h1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year (l.d.totalen=l2.d.totalen)

* // roi3
* // roi2.5 + restoration + first and second lag and difference expansion
* // restoration means that if subfactors of a factor were significant, I will try all permutations to start with
* // eg I start with `pce*`' rather than `pce2 pce3'
ivreg d.totalen employer_a* d.employer_assistance_1 d.d.employer_assistance_1 l.employer_assistance_1 l.l.employer_assistance_1 pce* d.pce d.d.pce l.pce l.l.pce stateperm1 visa_m_h1 visa_m_h1b_* d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_1 l.l.visa_m_h1b_1 visa_m_non_h1 visa_m_total year (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a* d.d.employer_assistance_1 l.l.employer_assistance_1 pce* l.l.pce stateperm1 visa_m_h1 visa_m_h1b_* d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_1 l.l.visa_m_h1b_1 visa_m_non_h1 visa_m_total year (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*1 employer_a*2 d.d.employer_assistance_1 l.l.employer_assistance_1 pce pce2 l.l.pce visa_m_h1 visa_m_h1b_* d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_1 l.l.visa_m_h1b_1 visa_m_non_h1 year (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*1 employer_a*2 d.d.employer_assistance_1 l.l.employer_assistance_1 pce pce2 l.l.pce visa_m_h1 visa_m_h1b_* d.d.visa_m_h1b_1 l.l.visa_m_h1b_1 visa_m_non_h1 year (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*1 employer_a*2 d.d.employer_assistance_1 l.l.employer_assistance_1 pce pce2 l.l.pce visa_m_h1 visa_m_h1b_*2 visa_m_h1b_*3 d.d.visa_m_h1b_1 l.l.visa_m_h1b_1 visa_m_non_h1 year (l.d.totalen=l2.d.totalen)

* // DOLS reduction WIP; prior to removing employer_a*1, coefficient is negative but not significant
ivreg d.totalen employer_a*1 employer_a*2 d.d.employer_assistance_1 l.l.employer_assistance_1 pce pce2 l.l.pce visa_m_h1 visa_m_h1b_*2 visa_m_h1b_*3 l.l.visa_m_h1b_1 visa_m_non_h1 year (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*2 d.d.employer_assistance_1 l.l.employer_assistance_1 pce pce2 l.l.pce visa_m_h1b_*2 visa_m_h1b_*3 l.l.visa_m_h1b_1 visa_m_non_h1 year (l.d.totalen=l2.d.totalen)

* // a quick horse race to make sure that h1b matters more than non-h1b issuance
* // given that validation, I am comfortable executing a simplicity transform collapsing visa vars to h1b specifically
ivreg d.totalen employer_a*2 d.d.employer_assistance_1 l.l.employer_assistance_1 pce pce2 l.l.pce visa_m_h1b_1 visa_m_non_h1 year (l.d.totalen=l2.d.totalen)

* // after simplicity transform, we can access a larger sample for all given factors
* // need to restore variables of interest including time and try again
ivreg d.totalen employer_a* d.employer_assistance_1 d.d.employer_assistance_1 l.employer_assistance_1 l.l.employer_assistance_1 pce* d.pce d.d.pce l.pce l.l.pce visa_m_h1b_* d.visa_m_h1b_1 d.d.visa_m_h1b_1 l.visa_m_h1b_1 l.l.visa_m_h1b_1 year* (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a* d.d.employer_assistance_1 l.l.employer_assistance_1 pce* d.pce d.d.pce l.l.pce visa_m_h1b_* d.visa_m_h1b_1 year* (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a* d.d.employer_assistance_1 pce* d.pce d.d.pce l.l.pce visa_m_h1b_* d.visa_m_h1b_1 year* (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*2 employer_a*3 d.d.employer_assistance_1 pce*2 pce*3 d.pce d.d.pce l.l.pce visa_m_h1b_* d.visa_m_h1b_1 year* (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*2 employer_a*3 d.d.employer_assistance_1 pce*2 pce*3 d.pce d.d.pce l.l.pce visa_m_h1b_* d.visa_m_h1b_1 year year2 (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*3 pce*2 pce*3 d.pce d.d.pce l.l.pce visa_m_h1b_* year2 (l.d.totalen=l2.d.totalen)
ivreg d.totalen employer_a*3 pce*2 pce*3 d.pce d.d.pce l.l.pce visa_m_h1b_*2 year2 (l.d.totalen=l2.d.totalen)

* // empassist, time, and visa differences, lags, and linear fx fail.
* // marginal effects matter for all of them
* // anderson-hsiao estimator is not significant (p > 0.6)
ivreg d.totalen employer_a*3 pce*2 pce*3 d.pce d.d.pce l.l.pce visa_m_h1b_*2 year2 (l.d.totalen=l2.d.totalen)

* // roi4
* // n = 44 in this model
* // two analytical transforms:
* // 1) employer_a*3 -> employer_a*2
* // 2) collapse pce2+pce3 -> pce2
* // #2 is bc they are both significant but sign flips; collapse them to compare total marginal effect
* // marginal effect robustly + and comparable to other models.
ivreg d.totalen employer_a*2 pce*2 d.pce d.d.pce l.l.pce visa_m_h1b_*2 year2 (l.d.totalen=l2.d.totalen)
