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

* // first long regression of interest
* // surprising because direct measure of price / tuition is dropped
* // interesting because it has more raw explanatory power than kitchen sink
* // also more structurally sound, way more adjusted r2, less complex
* // r2 .9975, ar2 .9953
* // all factors p < .17
reg totalen pce pce2 real_m* stategi3 visa_m* year year2
* // aliased
reg totalen pce pce2 employer_assistance_1 real_m_both stategi3 visa_m* year year2

* // reducing WIP
reg totalen real_m_all_institution stategi3 visa_m* year year2
reg totalen real_m_all_institution stategi3 visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2

* // first short regression of interest
* // r2 .9959, ar2 .9945, all factors p < .02
* // real_m_all_institution becomes right hand var of interest and aliased employer_assistance_1
reg totalen real_m_all_institution stategi3 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 year year2

* // second long regression of interest
* // it is first short regression of interest plus nonlinear and interacted employer_assistance
* // p-value of employer_assistance_1 went from 0.000 to 0.685.
* // interaction variable is more significant than linear Section 127 effect
* // That proves this non-linear second-stage analysis is essential
* // but then interaction variables quickly fall out
* // H1-non-b finally fall out
reg totalen employer* stategi3 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 year year2

* // first medium regression of interest / third long regression of interest.
* // here we see the most strongest visa-section 127 interaction variable, although it's still weak (p = .34)
* // it's interesting to note that the effect is negative, opposite expectation
* // but, interpretation of net policy effects is not obvious because of complex visa and employer effects
reg totalen employer_assistance_2 employer_assistance_3 employer_x_h1b_1 stategi3 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 year year2

* // interpretable transformations of medium regression of interest
* // simple regression on the interaction variable confirms negative relationship with no significant higher-power effect
* // add in linear and marginal section 127 and h1-b policy effects and veteran effects
* // reduce, see section 127 linear effect insignificant, but marginal effect is important.
* // drop veteran policy state
* // linear interaction sign flips in the context of multiple regression with significant linear h-1b visa effect
* // adj r2 > .98
* // now try adding other linear h1 effects. Result model is stable with all strong factors except visa_m_h1
reg totalen employer_x_h1b_1 employer_x_h1b_2 year year2
reg totalen employer_x_h1b_1
reg totalen employer_assistance_1 employer_assistance_2 visa_m_h1b_1 visa_m_h1b_2 employer_x_h1b_1 stategi3 year year2
reg totalen employer_assistance_2 visa_m_h1b_1 visa_m_h1b_2 employer_x_h1b_1 year year2
reg totalen employer_assistance_2 visa_m_h1b_1 visa_m_h1b_2 employer_x_h1b_1 year year2
reg totalen employer_assistance_2 employer_x_h1b_1 visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2

* // how does our interpretable transform contrast with medium regression of interest?
* // remove employer_assistance_3, stategi3
* // add visa_m_h1b_1
* // let's try medium plus visa_m_h1b_1
* // interaction effect flips to positive but now not significant and frankly not important
* // let's drop employer cubic effect bc it's hard to interpret
* // interaction effect becomes stronger and still positive but still insignificant
* // conclusion is that the interaction variable:
* //    has a sign which is sensitive to specification,
* //    is insignificant in most specifications,
* //    and is unimportant in most specifications.
reg totalen employer_assistance_2 employer_assistance_3 employer_x_h1b_1 stategi3 visa_m_h1 visa_m_h1b_1 visa_m_h1b_2 visa_m_non_h1 year year2
reg totalen employer_assistance_2 employer_x_h1b_1 stategi3 visa_m_h1 visa_m_h1b_2 visa_m_non_h1 year year2

* // power-reducing the medium reg of interest here drops r2 and nukes interaction effect significance
reg totalen employer_assistance_1 employer_assistance_2 stategi3 visa_m_h1 visa_m_h1b_2 year year2

* // second short regression of interest.
* // reduced from medium regression of interest
* // all factors p-value < .03, r2 .9965, ar2 .9952
* // pain in the ass nonlinear employer effect interpretation:
* //    1. linear effect doesn't matter.
* //    2. marginal effect is positive but decreasing.
reg totalen employer_assistance_2 employer_assistance_3 stategi3 visa_m_h1 visa_m_h1b_2 year year2

* // interpretation-friendly second short regression of interest transform is the third short regression of interest and preferred model
* // no loss to r2 (.9965) and unimportantly reduced ar2 (.9950)
* // add employer_assistance_1 even though it isn't strong it assists interpretation (p=.170)
* // swap visa_m_h1 for visa_m_h1b_1. visa_m_h1b_1 is the lion's share of visa_m_h1 anyway and facilitate interpration.
* // plus, these swaps act as robustness checks; which visa effects pass; linear negative positive marginal is robust to swap
* // linear employer effects are weakly negative with low confidence. positive marginal, negative tertiary.
* // TODO: calculate enrollment-maximizing assistance amount based on this preferred model
* // visa linear effects are significantly negative, with weak positive marginal effect
reg totalen employer_assistance_1 employer_assistance_2 employer_assistance_3 stategi3 visa_m_h1b_1 visa_m_h1b_2 year year2

* // total effects regression, not presented in tables
* // it is the preferred model without nonlinear effects of interest
* // time is the only factor with nonlinear effects here.
* // Model is non-robust to removing quadratic time.
reg totalen employer_assistance_1 stategi3 visa_m_h1b_1 year year2
