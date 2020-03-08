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

* // however, the secondly preferred model is hard to interpret.
* // The simplest explanation only uses exnew1
* // when doing this, year and tuition become insignificant
* // when doing this, empassist and exnew1 both have negative coefficients
* // this is our semi-simple model, with r2 .94 and adj r2 .932
* // this is a significant reduction in explanatory power, and results in unexpected coefficients
reg totalen emp year staffordlimitfor stategi3 tuition exnew1
reg totalen emp staffordlimitfor stategi3 exnew1

* // adding in new1 alone is insignificant, as is adding exnew2 alone
* // we can add in squared factors while omitting cubics and adj r2 is higher with expected coefficient direction
* // then stafford becomes insignificant and so does exnew2
* // this is middle-complexity model with r2 .96 and adj r2 .952, but still easy-ish to interpret with only linear interaction
* // we don't prefer this model, we just use it as an interpretive guide and robustness check
* // coefficient direction is consistent with secondly preferred model
* // increase empassist OR new1, increase enrollment. But increase them both concurrently and there is a negative interaction.
* // if we remove the interaction variable, it appears as though empassist coefficient is negative, but it's not
* // across linear models with a positive value for empassist, we see a coefficient in the range of 150-850,
* //    with a coefficient near 600 in finally preferred linear model
reg totalen emp staffordlimitfor stategi3 exnew1 new1
reg totalen emp staffordlimitfor stategi3 exnew1 exnew2
reg totalen emp staffordlimitfor stategi3 exnew1 exnew2 new1 new2
reg totalen emp stategi3 exnew1 new1 new2
