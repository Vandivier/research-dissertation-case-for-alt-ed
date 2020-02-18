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

* // now introduce stafford loan variables
* // they should be kinda implicit in time, so we don't expect r2 increase
* // but it should repartial effect coefficients to more accurate values
* // r2 is same, adj r2 decreases
* // perhaps surprisingly, stafford limits are totally insignificant
* // coefficients of interest don't move noticeably
reg totalen new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll stafford* stategi*

* // now introduce GI variables
* // mostly dropped for colinearity except 3, because effective sample is 1990-2017
* // GI Bill is significant, stafford still isn't, r2 and adj r2 up but negligibly bc we near 1
* // more importantly, what are the effects on coefficients of interest? values shift slightly but no sign change
reg totalen new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll stafford* stategi*
reg totalen new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll stategi3

* // lastly, add robust flag
* // all vars still significant, r2 still > .999
* // this is the key / preferred regression with n = 27 over period 1990 - 2017
* // as a tertiary interest, gi bill effect is negative on enrollment
* // one interpretation might be it incentivized individual attendance of college later in time
* // so within a bounded time frame it looks like a negative effect due to sample truncation
* // it is not correct to interpret the negative non-interacted visa coefficients as their policy effect
* // regressing only visa variables shows nonlinear effects are insignificant
* // - and linear effect is positive, as we would expect
reg totalen new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll stategi3, robust
reg totalen new1 new2 new3
reg totalen new1

* // git bill effect on tuition is an insignificant and unimportant increase (p = .975)
* // point estimate of $4 increase in tuition, concordant with a scale explanation but it doesn't matter
reg tuition new1 totalen exnew1 exnew2 exvisaenroll year stategi*
reg tuition new1 totalen exnew1 exnew2 exvisaenroll year stategi3

* // as a seperate regression, not a modification to the other, I check interaction effect on total loans
* // it is important we don't put loans into the key regression because it partials out inappropriately
* // the loans variable will partial out a demand effect, but that effect belongs to the visa policy, the loan limit, or enrollment
* // actual loans are an outcome of policy, not an input (unless you have some real esoteric downstream feedback effect theory, which I don't)
* // pretty much start with the kitchen sink and filter for strong factors
reg loans totalen new1 new2 visaenroll pce exnew1 exnew2 exvisaenroll stafford* stategi* tuition empassist year year2
* // empassist weakly seems to have encouraged loans in this period which is reasonable bc empassist would no longer cover the whole degree
* // but effect is insignifant; p=.3
* // adj r2 here is .9959
reg loans totalen new1 visaenroll exnew1 exnew2 exvisaenroll stafford* tuition empassist year year2

* // strong factor loan reg. Adj r2 .9958
* // simple visa effect is to increase loans, but this is due to the interacted components of the effect
* // interacted visa effects are all positive and significant, confirming out theory
* // enrollment, tuition, and time all in their expected directions; time is linear up with decreasing marginal effect
reg loans totalen new1 exnew1 exnew2 stafford* tuition year year2
reg loans new1
