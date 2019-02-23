// ref: udacity-exploratory-analysis/analysis-0-vars.do
// ref: udacity-exploratory-analysis/analysis.do
// this is a panel survey where the ref above was the original single-period survey

clear

import delimited D:\GitHub\data-science-practice\stata\october-2018-survey-monkey-alt-creds\survey-on-alternative-credentials.csv

// timedays is the time when a single user submitted his response, where time is finitely-measured at the daily level.
// ref: https://www.stata.com/support/faqs/data-management/creating-date-variables/
split enddate
gen enddatestatefriendly = subinstr(enddate1, "/", "-", .)
gen _timedays = date(enddatestatefriendly, "MDY")

gen ismale = 0
replace ismale = 1 if gender == 1

tab collector, gen (_collector)
tab doyouworkin, gen(_stem)
tab region, gen(_region)
tab whichofthese, gen(_industry)

gen _heardofcoursera = 0
replace _heardofcoursera = 1 if !missing(heardofcoursera)
gen _heardoflynda = 0
replace _heardoflynda = 1 if !missing(heardoflynda)
gen _heardofpluralsight = 0
replace _heardofpluralsight = 1 if !missing(heardofpluralsight)
gen _heardofudacity = 0
replace _heardofudacity = 1 if !missing(heardofudacity)
gen _heardofudemy = 0
replace _heardofudemy = 1 if !missing(heardofudemy)

gen isemployee = 0
replace isemployee = 1 if doyoucontribute == 2
gen ismanager = 0
replace ismanager = 1 if doyoucontribute == 1
// consider making isunemployed a SurveyMonkey qualifier, so we can focus on employers better
gen isunemployed = 0
replace isunemployed = 1 if doyoucontribute == 3

// generate q vars; q vars are the questions "on a scale from 1 to 10"
// note: q* here is NOT identical to q*under udacity-exploratory-analysis/analysis.do
// refer to all questions EXCEPT voi_q1 with aq*
gen voi_q1 = q1
gen aq2 = q2
gen aq2squared = q2*q2
gen aq2cubed = q2*q2*q2
gen aq3 = q3
gen aq3squared = q3*q3
gen aq3cubed = q3*q3*q3
gen aq4 = q4
gen aq4squared = q4*q4
gen aq4cubed = q4*q4*q4
gen aq5 = q5
gen aq5squared = q5*q5
gen aq5cubed = q5*q5*q5
gen aq6 = q6
gen aq6squared = q6*q6
gen aq6cubed = q6*q6*q6
gen aq7 = q7
gen aq7squared = q7*q7
gen aq7cubed = q7*q7*q7
gen aq8 = q8
gen aq8squared = q8*q8
gen aq8cubed = q8*q8*q8
gen aq9 = q9
gen aq9squared = q9*q9
gen aq9cubed = q9*q9*q9

// voi_index is a general index of pro-alternative-credentialness
// it is interesting alongside voi_q1 in that q1 cares about a specific use case, the index is more a general attitude
// refer to all questions EXCEPT voi_index with eq*
gen voi_index = q1 + q2 + q3
gen eq4 = q4
gen eq4squared = q4*q4
gen eq4cubed = q4*q4*q4
gen eq5 = q5
gen eq5squared = q5*q5
gen eq5cubed = q5*q5*q5
gen eq6 = q6
gen eq6squared = q6*q6
gen eq6cubed = q6*q6*q6
gen eq7 = q7
gen eq7squared = q7*q7
gen eq7cubed = q7*q7*q7
gen eq8 = q8
gen eq8squared = q8*q8
gen eq8cubed = q8*q8*q8
gen eq9 = q9
gen eq9squared = q9*q9
gen eq9cubed = q9*q9*q9

// generate continuous age
gen cage1 = age
gen cage2 = cage1*cage1
gen cage3 = cage1*cage1*cage1

// generate continuous income
gen cincome1 = household
gen cincome2 = cincome1*cincome1
gen cincome3 = cincome1*cincome1*cincome1

gen cprovider1 = _heardofcoursera + _heardoflynda + _heardofpluralsight + _heardofudacity + _heardofudemy
gen cprovider2 = cprovider1*cprovider1
gen cprovider3 = cprovider1*cprovider1*cprovider1

drop age
drop collector
drop customdata
drop doyou*
drop enddate*
drop gender
drop heard*
drop household
drop region
drop startdate
drop whichofthese

// reg exploration, short
// demonstrate strong cross-correlation within voi_index
reg q1 q2 q3
// demonstrate strong cross-correlation within technologies (innovation bias)
reg q3 q4 q5
// prima facie other technologies are weak predictors; we'll see if they are better in the long reg
reg voi_q1 q4 q5
// managers are more positive than non-managers
reg voi_q1 ismanager
// looks like being a manager doesn't predict nationalism (no anti-foreign bias wrt employer)
reg q6 ismanager
// nationalism is weakly and weirdly associated with pro-alt education; maybe it's conservatism or chance?
reg voi_q1 q6
// higher q8 is specifically Christian, proxy for socially conservative
// weak positive correlation exists
reg voi_q1 q8
// higher q9 = economic progressivism / statism / regulatory favorability; low is fiscal conservatism
// strong positive correlation exists. why would statists support this? maybe is a personality thing like openness
reg voi_q1 q9
// simple reg time has insignificant impact
reg voi_q1 _time

// reg exploration, long
// identical to voiq1long; look there for long reg for ez copy and paste
// r2 .53, adjr2 .30
reg voi_q1 _* aq* c* is*
// long reg for ez copy and paste:
// identical to voiindexlong; look there for long reg for ez copy and paste
// r2 .43, adjr2 .19
reg voi_index _* c* eq* is*

// initial result: time has had an insignificant impact on attitudes
// intial result: counterintuitively, conservatives seem more opposed to alternative credentials; maybe an attitudinal opposition
//   theory: conservatives are more pro-free market, but this is outpaced by progressive's pro-innovation
//   above theory can be somewhat tested using nationalism and innovation proxies
