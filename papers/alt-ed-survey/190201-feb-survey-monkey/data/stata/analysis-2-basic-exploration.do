clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-1-vars.do"

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
reg nvoifonline1 nvoifai1 nvoifcrypto1
* // prima facie other technologies are weak predictors; we'll see if they are better in the long reg
reg voi nvoifonline1 nvoifai1 nvoifcrypto1

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

* // special reg 10
* // simple reg time has weak negative impact!
reg voi ctime1
* // nonlinear time is insignificant, but directional effects are more intuitive; linear increasing and negative quadratic
reg voi ctime1 ctime2

* // 6 individuals identified an nonbinary
count if isreportednonbinary == 1
* // special reg 12
* // max p value of .594 on nonbinary; coeffecient in excess of .5, while issurveymonkeymale has -.686
reg voi issurveymonkeymale ismanager isunemployed isreportednonbinary isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion5 isregion6 isregion7 nvoifai1 nvoifai2 nvoifconventionalsoon1 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime3

* // minors are markedly pessimistic!
tab voi crage1

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
