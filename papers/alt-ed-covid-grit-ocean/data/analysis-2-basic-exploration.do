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
reg voi *american* *christianity* *regulation* *religio* nvoifai* is*stem*

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
reg voi completiontimeminutes1 completiontimeminutes2
