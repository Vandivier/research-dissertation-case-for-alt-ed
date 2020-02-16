clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // time alone explains most tuition
* // linear ommitted from complex reg, quadratic and cubic both very important
reg averagetuition year
reg averagetuition year year2 year3

* // reg shows if more visas awarded, more people go to college
* // this is expected bc employers implement degree requirements as an h1b justification
* // potentially, when h1b becomes super scarce employers stop caring for them and the tides turn...post 2017 story?
* // effect on public is more than half effect on total...interpret as preferential to public school prob due to pricing
* // effect on public is marginally bigger p and r2
* // even if private schools are higher quality, it matters relatively little bc the degree is the key not the education given this policy situation
reg public new1
reg totalen new1

* // tuition relation is much stronger
* // more visas and more enrollment both associated with higher price: expected demand effect
* // but, public enrollment numbers are insignificant once the interaction variable is included
* // linear newh1 also flips sign but is still significant, indicating a nonlinear relation
* // use totalen not public bc average is for all institutions (r2 and p is better in the complex reg as well)
reg public new1 averagetuition
reg averagetuition new1 totalen
reg averagetuition new1 totalen visaenroll

* // h1bs have basically no direct relation to tuition
* // cubic effect doesn't exist in complex reg
* // all vars significant with new1 and new2. adj R2 alkready at .98
* // add in year (time) and all vars still sig, adj r2 now > .996
* // complex time has weaker factor significance compared to simple time in long reg
* // overall, we show additional enrollment and visas decrease unit price of tuition
* // plausible explanations include economies of scale and economic efficiency gains from visa holders
* // these benefits are hampered by the visa-enrollment interaction effect
* // pce is helpful
reg averagetuition new*
reg averagetuition new* totalen visaenroll
reg averagetuition new1 new2 totalen visaenroll
reg averagetuition new1 new2 totalen visaenroll year pce
reg averagetuition new1 new2 totalen visaenroll year2 year3

* // so far, `reg averagetuition new1 new2 totalen visaenroll year pce` is preferred reg
* // now that we know factors, reshape relation to get left hand of interest - enrollment
* // when predicting enrollment, the visa-enrollment interaction effect is important
* // excluding the interaction, adj r square drops from about .99 to about .95
* // time also becomes insignificant. Dropping time, in turn tuition becomes unimportant.
* // The strongest factors are PCE and quadratic Visa effects, with adj r2 of .91 alone.
* // However, qua economist we think time and price matter.
* // Without time, many omitted factors could be claimed to not even be proxied.
reg totalen averagetuition new1 new2 visaenroll year pce

* // now i introduce tuition-adjusted real assistance limit
* // this is selected bc nominal has no variation to exploit and pce-corrected is implied in pce variable
* // still, university inflation is faster than general inflation
* // so we expect this variable to stick at least for that reason
* // we can't use nominal bc no variation over period
* // I explore swapping pce + nominal assistance limit for adjusted assistance limit vars
* // remember, our theory is that h1b causes degree requirement so people can't access section 127 for undergrad
* // totalen is undergrads only
* // we expect to see section 127 and h1b interacted policy effect overall reduces enrollment while pure section 127 boosts enrollment.
* // adding empassist improves r2 and adj r2, but year becomes insignificant
* // dropping year we are even better in adj r2 and still better than before empassist in raw r2
* // this is analytically nice because we establish an atemporal relation! :) it's lit
reg totalen averagetuition new1 new2 visaenroll year pce empassist

* // grand finale - let's interact empassist with visa variable
* // but which visa variable? honestly, all of them.
* // arguably, visaenroll is most important because it accounts for the most r2
* // but i wouldn't want to miss other possible interactions
* // ex* means empassist interacted with the suffix
reg totalen averagetuition new1 new2 visaenroll pce empassist exnew1 exnew2 exvisaenroll

* // result: all interactions are significant but empassist itself is not insignificant
* // is this a contrary result? No! It's exactly what we expect. It solves why employer benefits haven't really been effective (to some extent)
* // notice also that the final coefficient of empassist on enrollment is positive, as expected, but it's just really weak bc of policy interaction
* // even tuition becomes insignificant! below model explains totalenroll with r2 .999 (over limitted sample) better than tuition
reg totalen new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll

* // as a curiosity, what about solving for tuition implications of the policy interaction?
* // I re-introduce year and empassist for this check
* // at p < .1, independent policy effects are both insignificant - but interactions remain
* // as we expect in pure theory, the number of visas awarded or the level of assistance don't independently matter
* // their relative values determine net tuition effect
* // linear interaction increases tuition, but it has diminishing marginal effect.
* // this indicates growing both limits would eventually stop increasing tuition
* // meanwhile, reducing both to 0 would also stop increasing tuition
* // because visaenroll is hard to understand or interpret, I tried swapping for components new1 totalen
* // look at that! even better r2 and adj r2 (.998), plus simpler to interpret
* // no benefit to including linear factors with their interaction.
* // interpretation is that more enrollments and more visas both linearly increase tuition,
* // holding constant / before considering interacted policy effects
reg tuition new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll year
reg tuition visaenroll exnew1 exnew2 exvisaenroll year
reg tuition new1 totalen visaenroll exnew1 exnew2 exvisaenroll year
reg tuition new1 totalen exnew1 exnew2 exvisaenroll year
