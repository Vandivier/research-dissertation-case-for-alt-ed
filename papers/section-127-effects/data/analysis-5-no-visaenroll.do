clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // original exploration explained averagetuition then just swapped left hand for totalen
* // I'm pretty sure this was a mistake to allow visaenroll to persist on the right hand
* // that's pretty much regressing y on itself which is like cheating...so here I re-explore totalen OLS
* // without using visaenroll and similar total-containing right hand variables

* // start with everything applicable and round-robin down by factor p-value
* // emp is right hand variable of interest
* // no interactions at first
* // don't include loans bc that is a noncausal association which is an included variable bias
* // higher loans mainly is an output, not an input, of people deciding to go to school, which is our left hand
reg totalen emp year* stafford* stategi* new* pce tuition

* // drop stafford* and tuition variables
* // this is initially preferred model with r2 .9899, adj r2 .9854
* // we cut with p > .25, result factors with p < .05
reg totalen emp year year2 stategi3 new* pce

* // now, introduce interactions and start from the top...don't use visaenroll though
* // first reduction is pce, then year2 and stafford state variable
reg totalen emp year* stafford* stategi* new* pce tuition exnew*
reg totalen emp year year2 stafford* stategi3 new* tuition exnew*

* // this is secondly preferred model with r2 .9973, adj r2 .9953
* // it is also finally preferred linear model
* // we cut with p > .25, result factors with p < .05, except new3 with p ~=.07
* // however, this is hard to interpret. The simplest would be only exnew1
reg totalen emp year staffordlimitfor stategi3 new* tuition exnew*

* // pce corrected assistance limit doesn't add or change anything
reg totalen emp year staffordlimitfor stategi3 new* tuition exnew* realassistancelimitpcecorrection

* // negligibly better and even harder to understand...
reg totalen em2 year staffordlimitfor stategi3 new1 new2 tuition exnew*

* // however, the secondly preferred model is hard to interpret.
* // The simplest explanation only uses exnew1 and no cubic effects
* // start from the top again...
* // reduces to time plus GI Bill...!
reg totalen emp year year2 stafford* stategi3 pce tuition exnew1
reg totalen year year2 stategi3

* // adding in new1 alone is insignificant, as is adding exnew2 alone
* // try adding in squared factors while omitting cubics...
* // here we see positive linear, negative marginal effect to empassist, which makes sense
* // some factors insignificant, but keeping power symmetry for interpretability
* // adj r2 down slightly from secondly-preferred model
* // new and exnew signs flipped during simplification, so I don't feel confident signing them
* // but linear effect of interest direction is consistent with predictable marginal effect
* // I don't prefer this model, we just use it as an interpretive guide and robustness check
* // across linear models with a positive value for empassist, we see a coefficient in the range of 150-850,
* //    with a coefficient near 600 in finally preferred linear model
reg totalen emp em2 year year2 exnew1 exnew2 new1 new2 stafford* stategi3 pce tuition
reg totalen emp em2 year year2 exnew1 exnew2 new1 new2 stategi3 pce tuition
reg totalen emp em2 year year2 exnew1 new1 new2 pce tuition
