clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

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
* // also minus loans which would steal credit for effect of interest
* // deflators dropped for redundancy
* // same for nominalassistance same
* // pce-corrected real assistance limit wins horse race
* // stategi3 flag captures all veteran benefit variation
reg totalen base* stafford* nominalassistance pce* real* state* tuition* visa_* year*

* // more rounds of kitchen sink
* // drops in order by round:
* // staffordlimitforundergraduates, visa_total, pce3, tuition_nom, staffordlimitiscombinedsubsidize, realassistancelimitpcecorrection
reg totalen staffordlimitiscombinedsubsidize pce* real* stategi3 tuition* visa_* year*
reg totalen staffordlimitiscombinedsubsidize pce* real* stategi3 tuition* visa_m* year*
reg totalen staffordlimitiscombinedsubsidize pce pce2 real* stategi3 tuition_cpi visa_m* year*
reg totalen pce pce2 real_m* stategi3 tuition_cpi visa_m* year*

* // dropping year3 simplifies technically and theoretically, plus r2 goes up
* // dropping tuition_cpi would be next normal round-robin / kitchen sink move
* // but we have some motivation to preserve factor groups, and tuition seems critical
* // is real_m_both stealing credit from tuition_cpi? or vice versa?
* // Yes, they basically explain the same thing. Importantly, inflationary price effects.
* // dropping tuition leads to overall stronger model and to significant real_m_both but not vice versa
* // after this check, dropping tuition is OK. Real effectively capture price effects indirectly.
reg totalen pce pce2 real_m* stategi3 visa_m* year year2
reg totalen pce pce2 real_m_all_institution stategi3 tuition_cpi visa_m* year year2

* // long regression of interest
* // surprising because direct measure of price / tuition is dropped
* // interesting because it has more raw explanatory power than kitchen sink
* // also more structurally sound, way more adjusted r2, less complex
* // r2 .9975, ar2 .9953
reg totalen pce pce2 real_m* stategi3 visa_m* year year2
