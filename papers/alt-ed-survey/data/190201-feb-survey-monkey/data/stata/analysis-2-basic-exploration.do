clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\data\190201-feb-survey-monkey\data\stata\analysis-1-vars.do"

* // summarize all variables, providing data for summary-data.csv
ssc install fsum, replace
fsum, stats(n mean sd min p25 p50 p75 max)

* // voi explains about 62.5% of the general index.
* // special regression 1
reg ioi voi

* // reg exploration, short
* // demonstrate strong cross-correlation within ioi
reg voi nvoifconventionalsoon1 nvoifonline1

* // demonstrate strong cross-correlation within technologies (innovation bias)
* // prima facie other technologies are weak predictors; we'll see if they are better in the long reg
reg nvoifonline1 nvoifai1 nvoifcrypto1

* // special regression 5
* // managers are more positive than non-managers
reg voi ismanager

* // looks like being a manager doesn't predict nationalism (no anti-foreign bias wrt employer)
reg nvoifamerican1 ismanager

* // nationalism is weakly and weirdly associated with pro-alt education; maybe it's conservatism or chance?
reg voi nvoifamerican1

* // higher if specifically Christian, proxy for socially conservative
* // weak positive correlation exists
reg voi nvoifchristianity1

* // higher economic progressivism / statism / regulatory favorability; low is fiscal conservatism
* // strong positive correlation exists. why would statists support this? maybe is a personality thing like openness
* // intial result: counterintuitively, conservatives seem more opposed to alternative credentials; maybe an attitudinal opposition
* //   theory: conservatives are more pro-free market, but this is outpaced by progressive's pro-innovation
* //   above theory can be somewhat tested using nationalism and innovation proxies
reg voi nvoifregulation1

* // special reg 10-12
* // insignificant negative linear, weak marginal and cubic, maybe suggests early stage of s-curve adoption
reg voi ctime1
reg voi ctime1 ctime2
reg voi ctime1 ctime2 ctime3

* // our best time regression... p = .004
reg logconventionalsoon1 logtime

* // we gonna use this in a second...
predict predictedlogconventionalsoon

* // voi-log conventionality rocks
reg voi logconventionalsoon

* // direct log time on voi or logvoi sucks
reg logvoi logtime

* // indirect log time on voi fails
reg voi predictedlogconventionalsoon

* // special eg 18
* // try nonlinear time on voi
* // nice!
* // r2 .8972, p ~0.000, t 40.72
nl (voi = {b0=2}*(1 - exp(-1*{b1=0.1}*nvoifconventionalsoon1)))
* // smaller increments doesn't gain us anything
* // r2 .8972, p ~0.000
nl (voi = {b0=1.1}*(1 - exp(-1*{b1=0.01}*nvoifconventionalsoon1)))
* // exponent change gains us a little bit of r2, smaller t
* // r2 .9029, p ~0.000, t 33.8
nl (voi = {b0=2}*(exp(-1*{b1=0.1}*nvoifconventionalsoon1)))
* // simpler expression doesn't lose anything
nl (voi = {b0}*(exp({b1}*nvoifconventionalsoon1)))
* // adding a constant makes the model suck, but t is huge, but constant is negative
* // r2 .2621, t 1077.23
nl (voi = {b1}+{b2=2}*(exp({b3=0.1}*nvoifconventionalsoon1)))

* // special reg 23
* // wait...i did it wrong by using conventionality on the right hand. let's use time
* // r2 .8691, p .811, t -.24
nl (voi = {b0}*(exp({b1}*ctime1)))
* // basically invalid form...
* // r2 0.0, p n/a, taken as constant, t n/a, taken as constant
nl (voi = {b1}+{b2}*(exp({b3}*ctime1)))

* // special reg 25
* // r2 .8691, adj r2 = .8689, p ~0.000
* // below is preferred. form of: voi = b1*b2^ctime1
* // b1 and b0 both more significant compared to special reg 23
* // b1 coeff 10.044, p = 0.565
* // b2 coeff .99998, p = 0.000
nl exp2: voi ctime1

* // special reg 26
* // prefer for interpretability; time is days since Monday, February 26, 2018
* // r2 .8691, adj r2 = .8689, p ~0.000
* // below is preferred. form of: voi = b1*b2^ctime1
* // b1 and b0 both more significant compared to special reg 23
* // b1 coeff 6.655, p = 0.000
* // b2 coeff .99998, p = 0.000
* // note: let t = 0, y = 6.655
* // note: let t = 437 (max), y = 6.59
* // note: let t = 557 (4 months), y = 6.58
* // note: let t = 802 (1 year, ), y = 6.55
* // decrease is unimportant; trend effectively flat
nl exp2: voi ctime1zeroed

* // r2 0.0, p ~0.000, t 10759.63
* // form of: voi = b0 + b1*b2^ctime1
nl exp3: voi ctime1

* // some individuals identified an nonbinary
count if isreportednonbinary == 1

* // special reg 13
* // max p value of .594 on nonbinary; coeffecient in excess of .5, while issurveymonkeymale has -.686
reg voi issurveymonkeymale ismanager isunemployed isreportednonbinary isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion5 isregion6 isregion7 nvoifai1 nvoifai2 nvoifconventionalsoon1 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime3

* // special reg 14, the unemployed are the least familiar with alternative learning providers
* // it's a 0.000 p value! effect is nontrivial at -.6
reg cprovider1 isunemployed

* // special reg 15, simple linear of provider familiarity on alt learning suitability
* // _cons of 6.4 indicates that when cprovider is 0 people are still positive, and it only gets more positive from there.
reg voi cprovider1

* // special reg 16, showdown of the partialling out
* // looks like exact reported age is linearly better than age group or income effects
* // but equal in significance on marginal and cubic fx to income
reg voi cr*

* // special reg 17, introducing education strengthens crea and also education is a big deal
* // notice a mild ishighered effect. Learner's regret? and linear ceduc is insane
reg voi cr* cedu* ishighered

* // linear age has a negative effect on online favorability
reg nvoifonline1 crea1

* // related to figure 4:
reg voi ctime1 ctime2 managertime1 managertime2

* // also figure 4...prior reg constant is implausible:
* // notice in this regression, managertime effects are more positive than ctime effects are negative.
reg voi ctime1 ctime2 managertime1 managertime2, noconstant

* // minors are markedly pessimistic!
tab voi crage1

* // table 3
* // 2018 weak and long model respondents
* // 2018 mean of 6.351, but this is lower than non-2018, insignificantly, 6.657.
tab is2018sample, sum (voi)

* // 2018 variables long reg
* // omits reported variables (eg, isreportedmale or crage1), voi, and ioi from right hand
* // r2 = .52, adjr2 = .3054, n = 188
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifamerican1 nvoifamerican2 nvoifamerican3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto1 nvoifcrypto2 nvoifcrypto3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 nvoifreligion2 nvoifreligion3 csmage1 csmage2 csmage3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

* // 2019 variables long reg
* // per appendix b, omits crypto, us centrism, stem, religiousness, christianity
* // r2 = .418, adjr2 = .2792, n = 271
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed ismale isfemale isreportedmale isreportedfemale isreportednonbinary isunreportedgender iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 csmage3 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

* // voi large n reg
* // individually, these factors all had the max n of 784.
* // r2 = .3067, adjr2 = .2742, n = 784
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed ismale isfemale iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

* // ioi large n reg
* // r2 = .8776, adjr2 = .8719, n = 784
reg ioi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed ismale isfemale iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3
