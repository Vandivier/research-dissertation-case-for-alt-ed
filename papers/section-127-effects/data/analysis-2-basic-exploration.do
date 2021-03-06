clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // reg shows if more visas awarded, more people go to college
* // this is consistent with theory that employers implement degree requirements as an h1b justification
* // the simple enrollment effect is preferential to public enrollment
* // totalen is overall more predictable though, which makes sense because tuition info is across all institutions
* // prefer totalen for enrollment variable
reg public visa_m_h1b_1
reg totalen visa_m_h1b_1
reg public visa_* tuition* year*
reg totalen visa_* tuition* year*

* // kitchen sink regression minus interaction vars that would partial out importance
* // TODO: maybe revisit kitchen sink approach later with new variables
reg totalen base* stafford* nominalassistance pce* real* state* tuition* visa_* year*

* // constrained / v2 analysis kitchen sink below
reg totalen emp* pce* real* stafford* state* tuition* visa_* year*
* // below max r2 and ar2
reg totalen emp* pce* real* stafford* stategi3 stateperm1 tuition* visa_m* year*
reg totalen emp* pce* real* staffordlimitiscombined stategi3 stateperm1 tuition* visa_m* year*

* // roi-1
* // below strong model. It's non-robust though bc removing nom tuition breaks alot.
* // I think it's a good robustness check to compare with stipulated models but i won't bc i don't want to annoy editor
* // so, not included in 4 rsoi, so i call it roi-1
* // swap year3 -> year from prior model without loss of explanatory power and gain simplicity
* // Note: Anderson-Hsiao adjustment of this model preserves model r-squared while adjustment of roi2 yields an insignificant model
* // compare to so-called roi2.5 in the same source commit as this comment
* // also ref EDIT: 5/4/2020 at: https://www.afterecon.com/economics-and-finance/kitchen-sink-regression-and-horse-racing/
reg totalen emp* pce* real* staffordlimitiscombined stategi3 stateperm1 tuition* visa_m* year

* // roi1: initial stipulated model
* // changes by analytical stipulation
* // note: the editors made me do it. I would leave both in by statistical justification
* // 1) drop tuition_nom and keep tuition_cpi
* // 2) drop real* and keep employer_a* (equivalent to real_m_all_institution)
* // 3) only look at h-1b for visa effects
* // now, employer_x* is insignificant (and a bunch of other factors...)
reg totalen emp* pce* staffordlimitiscombined stategi3 stateperm1 tuition_cpi visa_m* year

* // new reduction
reg totalen employer_a* pce* stategi3 stateperm1 tuition_cpi visa_m* year
reg totalen employer_a* pce2 pce3 stategi3 stateperm1 tuition_cpi visa_m_h1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year
reg totalen employer_a* pce2 pce3 stateperm1 tuition_cpi visa_m_h1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year
reg totalen employer_a*1 employer_a*2 pce2 pce3 stateperm1 visa_m_h1 visa_m_h1b_3 visa_m_non_h1 visa_m_total year

* // roi2: reduced stipulated model with two unimportant (wrt p, r2, ar2...) analytical transforms.
* // 1) visa_m_h1b_3 -> visa_m_h1b_2 unimportantly changes model
* // 2) collapse pce2 + pce3 -> pce2
* // analytical transforms allow cross-specification comparison of effects
* // analytical transforms also function as robustness checks; if a minor factor transform breaks u, u are bad
reg totalen employer_a*1 employer_a*2 pce2 stateperm1 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 visa_m_total year
