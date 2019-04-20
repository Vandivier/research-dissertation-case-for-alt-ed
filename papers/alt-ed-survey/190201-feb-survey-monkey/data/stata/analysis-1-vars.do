// ref: udacity-exploratory-analysis/analysis-0-vars.do
// ref: udacity-exploratory-analysis/analysis.do
// this is a panel survey where the ref above was the original single-period survey

clear

import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\wrangle\output.csv

// is variables are boolean...and categoricals are split into many booleans
tab collector, gen(iscollector)
tab industry, gen(isindustry)
tab surveymonkeyregion, gen(isregion)
tab surveymonkeygender, gen(issurveymonkeygender)

// nvoi => not variable of interest
// nvoif => not variable of interest, favorability question
// voi => variable of interest
// favor questions specify favorability toward a statement on a scale from 1 to 10.
// refer to favorability questions EXCEPT voi with nvoi*
// voi is a favor question so we can't just reg y favor*
//
// Question Text:
// favorai
//    - When you add up the pros and cons for artificial intelligence, it's probably a good thing for society overall.
// favoramerican
//    - When evaluating an applicant's education, it is important is important to check whether the degree was awarded from a US institution.
// favorchristianity
//    - I consider myself Christian
// favorconventionalsoon
//    - It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.
// favorcrypto
//    - When you add up the pros and cons for cryptocurrency, it's probably a good thing for society overall.
// favorentrylevel
//    - For many professions, alternative credentials can qualify a person for an entry-level position.
// favoronline
//    - When you add up the pros and cons for online education, it's probably a good thing for society overall.
// favorregulation
//    - Government regulation helps ensure businesses treat individuals more fairly.
// note: maybe we should phrase favorregulation in the normal pattern. Eg `When you add up the pros and cons for government regulation, it's probably a good thing for society overall.'
// favorreligion
//    - I consider myself religious
//
gen nvoifai1 = favorai
gen nvoifai2 = favorai*favorai
gen nvoifai3 = favorai*favorai*favorai
gen nvoifamerican1 = favoramerican
gen nvoifamerican2 = favoramerican*favoramerican
gen nvoifamerican3 = favoramerican*favoramerican*favoramerican
gen nvoifchristianity1 = favorchristianity
gen nvoifchristianity2 = favorchristianity*favorchristianity
gen nvoifchristianity3 = favorchristianity*favorchristianity*favorchristianity
gen nvoifconventionalsoon1 = favorconventionalsoon
gen nvoifconventionalsoon2 = favorconventionalsoon*favorconventionalsoon
gen nvoifconventionalsoon3 = favorconventionalsoon*favorconventionalsoon*favorconventionalsoon
gen nvoifcrypto1 = favorcrypto
gen nvoifcrypto2 = favorcrypto*favorcrypto
gen nvoifcrypto3 = favorcrypto*favorcrypto*favorcrypto
gen nvoifonline1 = favoronline
gen nvoifonline2 = favoronline*favoronline
gen nvoifonline3 = favoronline*favoronline*favoronline
gen nvoifregulation1 = favorregulation
gen nvoifregulation2 = favorregulation*favorregulation
gen nvoifregulation3 = favorregulation*favorregulation*favorregulation
gen nvoifreligion1 = favorreligion
gen nvoifreligion2 = favorreligion*favorreligion
gen nvoifreligion3 = favorreligion*favorreligion*favorreligion
gen voi = favorentrylevel

// ioi is a general index of pro-alternative-credentialness
// it is interesting alongside voi in that q1 cares about a specific use case, the index is more a general attitude
gen ioi = favorentrylevel + favorconventionalsoon + favoronline

// generate continuous survey-reported age
gen crage1 = reportedage
gen crage2 = reportedage*reportedage
gen crage3 = reportedage*reportedage*reportedage

// generate continuous survey monkey account-reported age
gen csmage1 = surveymonkeyage
gen csmage2 = surveymonkeyage*surveymonkeyage
gen csmage3 = surveymonkeyage*surveymonkeyage*surveymonkeyage

// generate continuous reported income
gen crincome1 = reportedincome
gen crincome2 = reportedincome*reportedincome
gen crincome3 = reportedincome*reportedincome*reportedincome

// generate continuous survey monkey account-reported income
gen csmincome1 = surveymonkeyincome
gen csmincome2 = surveymonkeyincome*surveymonkeyincome
gen csmincome3 = surveymonkeyincome*surveymonkeyincome*surveymonkeyincome

gen cprovider1 = heardofcoursera + heardoflynda + heardofpluralsight + heardofudacity + heardofudemy
gen cprovider2 = cprovider1*cprovider1
gen cprovider3 = cprovider1*cprovider1*cprovider1

// timedays is the time when a single user submitted his response, where time is finitely-measured at the daily level.
// ref: https://www.stata.com/support/faqs/data-management/creating-date-variables/
split enddate
gen enddatestatafriendly = subinstr(enddate1, "/", "-", .)
gen ctime1 = date(enddatestatafriendly, "MDY")
gen ctime2 = ctime1*ctime1
gen ctime3 = ctime1*ctime1*ctime1

drop collector
drop heard*
drop enddat*
drop favor*
drop industry
drop reportedage
drop reportedincome
drop respondentid
drop surveymonk*

// voi explains about 62.5% of the general index.
reg ioi voi
// reg exploration, short
// demonstrate strong cross-correlation within ioi
reg voi nvoifconventionalsoon1 nvoifonline1
// demonstrate strong cross-correlation within technologies (innovation bias)
reg nvoifonline1 nvoifai1 nvoifcrypto1
// prima facie other technologies are weak predictors; we'll see if they are better in the long reg
reg voi nvoifonline1 nvoifai1 nvoifcrypto1
// managers are more positive than non-managers
reg voi ismanager
// looks like being a manager doesn't predict nationalism (no anti-foreign bias wrt employer)
reg nvoifamerican1 ismanager
// nationalism is weakly and weirdly associated with pro-alt education; maybe it's conservatism or chance?
reg voi nvoifamerican1
// higher if specifically Christian, proxy for socially conservative
// weak positive correlation exists
reg voi nvoifchristianity1
// higher economic progressivism / statism / regulatory favorability; low is fiscal conservatism
// strong positive correlation exists. why would statists support this? maybe is a personality thing like openness
reg voi nvoifregulation1
// simple reg time has weak negative impact!
reg voi ctime1
// nonlinear time is insignificant, but directional effects are more intuitive; linear increasing and negative quadratic
reg voi ctime1 ctime2

// long reg voi; all right hand except voi and ioi
// n = 0. lowest n column is 240 observations for religion and christianity questions. will study seperately.
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isreportedmale isreportedfemale isreportednonbinary isunreportedgender iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifamerican1 nvoifamerican2 nvoifamerican3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto1 nvoifcrypto2 nvoifcrypto3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 nvoifreligion2 nvoifreligion3 crage1 crage2 crage3 csmage1 csmage2 csmage3 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

// special reg on christianity and religion
// r2 = .0252, adjr2 = .0001, n = 240
// religion has positive linear, negative marginal, positive cubic; christianity is similar but weaker when independently tested
//      and opposite/attenuating when added to the same regression.
// religion effects are significant. christianity p values are insignificant but move in the expected direction; so it's simply a weaker correlation.
reg voi nvoifreligion1 nvoifreligion2 nvoifreligion3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 

// cross-survey reg causes n = 0. we need to map questions by survey 1, 2, or both
// n = 0
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isrepo
> rtedmale isreportedfemale isreportednonbinary isunreportedgender


// long reg ioi; all right hand except voi and ioi
// r2 ?, adjr2 ?, n
reg ioi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isreportedmale isreportedfemale isreportednonbinary isunreportedgender iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifamerican1 nvoifamerican2 nvoifamerican3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto1 nvoifcrypto2 nvoifcrypto3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 nvoifreligion2 nvoifreligion3 crage1 crage2 crage3 csmage1 csmage2 csmage3 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

// initial result: time has had an insignificant impact on attitudes
// intial result: counterintuitively, conservatives seem more opposed to alternative credentials; maybe an attitudinal opposition
//   theory: conservatives are more pro-free market, but this is outpaced by progressive's pro-innovation
//   above theory can be somewhat tested using nationalism and innovation proxies
