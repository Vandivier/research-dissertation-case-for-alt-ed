clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // ref: youtube.com/watch?v=wqwDcY9pq5I
tsset year

* // anderson-hsiao adjustment using double lagged voi as instrument
ivreg d.totalen d.new1 (l.d.totalen=l2.d.totalen)

* // secondary reg of interest
* // finally, full ivreg with all policy diffs
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
ivreg d.totalen d.new1 d.empassist d.exnew1 (l.d.totalen=l2.d.totalen)

* // compare to secondary reg of interest
* // below ivreg shows weak explanatory power without interaction effect
* // without interaction effect, either factor is insignificant eg could be zero or wrong sign
* // but empassist point estimate still in expected direction
* // lagged visa difference is associated with decreased enrollment which seems weird
* // but I feel fine ignoring it for extreme insignificance
* // and because we know the multi-period lagged effect flips in sign
* // so net visa effect long term can be increase, even if first lag is weakly a decline in enrollment
ivreg d.totalen d.new1 d.empassist (l.d.totalen=l2.d.totalen)

* // notice actual interaction matters more difference in interaction 
* // this is our key reg
* // negative visa effect is even weaker
* // positive empassist is essentially significant (p=.104 and higher coefficient)
* // policy effect is positive sp we are increasing enrollment (but apparently not benefit utilization?)
* // thus, loan bloat explanation confirmed by VAR and DOLS as well as more trivial and earlier ols
ivreg d.totalen d.new1 d.empassist exnew1 (l.d.totalen=l2.d.totalen)

* // notice lagged interaction is dumb and meaningless
ivreg d.totalen d.new1 d.empassist l.exnew1 (l.d.totalen=l2.d.totalen)
