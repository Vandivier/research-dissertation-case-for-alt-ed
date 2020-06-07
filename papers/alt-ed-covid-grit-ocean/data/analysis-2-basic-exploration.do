do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-1-vars.do"

* // summarize all variables, providing data for summary-data.csv
* // ssc install fsum, replace */
* // fsum, stats(n mean sd min p25 p50 p75 max)

* // voi explains about 63% of the general index.
* // special regression 1
reg ioi voi

* // demonstrate strong cross-correlation within technologies (innovation bias)
* // prima facie other technologies are weak predictors; we'll see if they are better in the long reg
reg nvoifonline1 nvoifai1 nvoifcrypto1

* // right wing multiple regression reveals positive, weak association
* // nationalism is weakly and weirdly associated with pro-alt education; maybe it's conservatism or chance?
reg voi nvoifamerican1 nvoifchristianity1

* // higher economic progressivism / statism / regulatory favorability; low is fiscal conservatism
* // strong positive correlation exists. why would statists support this? maybe is a personality thing like openness
* // intial result: counterintuitively, conservatives seem more opposed to alternative credentials; maybe an attitudinal opposition
* //   theory: conservatives are more pro-free market, but this is outpaced by progressive's pro-innovation
* //   above theory can be somewhat tested using nationalism and innovation proxies
reg voi nvoifregulation1
reg voi nvoifamerican1 nvoifchristianity1 nvoifregulation1

* // some individuals identified an nonbinary
* // TODO: a different paper, but it might relate to personality or ideology...
* // it's like an interestingly powerful negative uncorrected effect...
count if isreportednonbinary == 1
reg voi isreportednonbinary

* // TODO: personality check
* // TODO: standard controls

* // personality multiple reg
* // with quadratics and cubics, r2 .0886, ar2 = -.0016
* // dropping cubics: r2: 0.069 ar2: 0.0105
* // kinda weird personality_extraversion1 is strong positive association
reg voi personality*
reg voi personality*1 personality*2 personality_isinvalid

* // wtf...OCEAN noncompletion is strongly positive w grit!?
* // we cannot rule out either in a structural reg... adding grit to invalid alone drops total r2
* // so, git confounds the invalid thing
reg personality_grit1 personality_isinvalid

* // personality less grit reduces r2 total and adjusted,
* //   so we keep it for further research
* // also, linear oppenness is weaker than marginal openness,
* //   so we need marginal personality effects, cubics optional
reg voi personality_agreeableness1 personality_conscientiousness1 personality_extraversion1 personality_grit1 personality_isinvalid personality_neuroticism1 personality_open1 personality_open2 personality_open3
reg voi personality_agreeableness1 personality_conscientiousness1 personality_extraversion1 personality_grit1 personality_isinvalid personality_neuroticism1 personality_open1 personality_open2
reg voi personality_agreeableness1 personality_conscientiousness1 personality_extraversion1 personality_grit1 personality_isinvalid personality_neuroticism1 personality_open1
reg voi personality_agreeableness1 personality_conscientiousness1 personality_extraversion1 personality_isinvalid personality_neuroticism1 personality_open1

* // personality + ideology multiple reg
* // commented reg is desirable, but no samples
* // reg voi personality* *american* *christianity* *regulation* *religio* nvoifai* is*stem*
* // ideological effects -> r2 .1457, ar2 0.08
* // this does not include ethnicity and regional cultural effects
* // regulation_x is logically interesting but empirically reduces ar2, so super unimportant
reg voi *american* *christianity* nvoifregulation* *religio* nvoifai* is*stem*

* // do time effects dominate personality?
* // answer: linear time doesn't matter
* // linear plus nonlinear time is stronger than some personality effects, but weak (p < 0.5)
* // overall, time effects are not interesting, potentially due to sample variation constraint (few samples at difference times)
reg voi personality*1 personality*2 personality_isinvalid ctime1
reg voi personality*1 personality*2 personality_isinvalid ctime*
reg voi personality*1 personality*2 personality_isinvalid ctime* completion* iscollector*

* // completion time was hypothesized as an intelligence proxy
* // the effect may exist but it's super negligible with respect to approval
* // perhaps the completion time -> intelligence proxy is weak and/or
* // perhaps intelligence doesn't relate strongly with approval...both plausible
* // positive effect robust to collectors, but low significance
* // final nail in coffin...personality_isinvalid can also proxy iq and is more significant
* // interpret effect after including personality_isinvalid as system 2 activation (slow not due to intelligence)
* // positive with decreasing marginal effect robust to multiple regression, but very weak and unimportant
reg voi completiontimeminutes1 completiontimeminutes2
reg voi completiontimeminutes1 completiontimeminutes2 iscollector*
reg voi completiontimeminutes1 completiontimeminutes2 personality_isinvalid

* // regoi1
* // conservatives (anti-regulation) allowed more time become more anti-alternative education
* // ar2 = .06, which is not nothing. all vars significant p<.05 with interaction most significant at .001
* // compatible with evidence on intensifying conservative contradiction
reg voi completiontimeminutes1 completiontimeminutes2 personality_isinvalid completiontime_x_conservative1 completiontime_x_conservative2
reg voi completiontimeminutes1 completiontimeminutes2 personality_isinvalid completiontime_x_conservative1
reg voi completiontimeminutes1 personality_isinvalid completiontime_x_conservative1

* // ai favorability is lower among low regulation supporters
* // highly significant and positive relation found, but total r2 is low
* // this is counterintuitive because intellectual conservatives should embrace technological advancement and the free market
* // potential solution: as a matter of personality, or Kahneman's System 1 response, conservatives may exhibit anti-innovation bias
* // raising more regulation and ai (eg techno-liberal or scientistic progressive) is associated with a reduction in alt ed cred support
* // reducing ai and reducing regulation (eg anti-innovation conservative) is associated with more support for alt ed cred (indicates ideological dominance over personality at survey time)
* // but, both of these effects are weak
reg nvoifregulation*1 nvoifai*1
reg voi regulation_x nvoifregulation* nvoifai*

* // contra equivocation between grit and concientiousness
* // if they are simply different measures, then they are different enough measures that it's important to include both (as if independence)
* // if grit and concientiousness are the same, why does concientiousness only have an r2 ~ 0.5, not very different from openness?
* // in fact, given OCEAN we still see more than a third of grit unexplained (this is better than the inner-difference between most OCEAN factors)
reg personality_grit1 personality_conscientiousness1
reg personality_grit1 personality_open*1
reg personality_grit1 personality_n*1
reg personality_grit1 personality_open*1 personality_conscientiousness1 personality_e*1 personality_a*1 personality_n*1

* // conclusion food
* // contra: https://digest.bps.org.uk/2018/09/25/the-in-vogue-psychological-construct-grit-is-an-example-of-redundant-labelling-in-personality-psychology-claims-new-paper/
* // of note, a typical grit output variable is success, but for me it is attitude; so grit may be more similar to concientiousness when the output is result rather than attitude
* // one can imagine that favorability imperfectly translates to initial action and even less to outcome, so my result need not contradict research focused on activity completion
* // the 0.000 high signifiance of concientiousness and grit doesn't show they are substitutes bc:
* // 1. there is plenty of expoitable variation left over
* // 2. concientiousness has the same pattern with inverse neuroticism; but we don't treat those as synonyms
* // in fact, it is about as accurate to call grit "inverse neuroticism" as it is to call grit "a synonym for concientiousness" according to present data
* // moreover, grit has the same relation with neuroticism
* // describing grit as negative neuroticism is nearly as correct as describing grit as concientiousness if we just care about stats
* // in the end, the economic approach is more rigorous and less subjective than a pure psychometric approach relying on conventional p-value analysis
* // the economic approach would say the variable is independently important if mode inclusion yields more value than it costs, which it does.
* // given that a survey taker has already answered the OCEAN battery and all the other model factors, having them fill out the short grit scale is relatively cheap and easy,
* // and provides a better model which businesses would prefer. In fact, one might consider OCEAN inclusion as more expensive to implement with less model yield,
* // since grit is the single best factor here.
reg personality_g*1 personality_neuroticism1
reg personality_c*1 personality_neuroticism1

* // grit moves strongly with openness, but concientiousness does not, so they are structurally different
reg personality_open*1 personality_conscientiousness1

* // get Pearson's correlation coefficient
correlate personality_grit1 personality_conscientiousness1 personality_neuroticism1 personality_open1
