* // ref: udacity-exploratory-analysis/analysis-0-vars.do
* // ref: udacity-exploratory-analysis/analysis.do
* // this is a panel survey where the ref above was the original single-period survey

clear

import delimited D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\wrangled-write-csv-output.csv

tab collector, gen(iscollector)
tab industry, gen(isindustry)
tab surveymonkeyregion, gen(isregion)
tab ethnicity, gen(isethnicity)

* // ishighered = obtained undergraduate degree
gen ishighered = 0 if !missing(educ)
replace ishighered = 1 if educ >= 5

* // nvoi => not variable of interest
* // nvoif => not variable of interest, favorability question
* // voi => variable of interest
* // favor questions specify favorability toward a statement on a scale from 1 to 10.
* // refer to favorability questions EXCEPT voi with nvoi*
* // voi is a favor question so we can't just reg y favor*
* //
* // Question Text:
* // favorai
* //    - When you add up the pros and cons for artificial intelligence, it's probably a good thing for society overall.
* // favoramerican
* //    - When evaluating an applicant's education, it is important is important to check whether the degree was awarded from a US institution.
* // favorchristianity
* //    - I consider myself Christian
* // favorconventionalsoon
* //    - It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.
* // favorcrypto
* //    - When you add up the pros and cons for cryptocurrency, it's probably a good thing for society overall.
* // favorentrylevel
* //    - For many professions, alternative credentials can qualify a person for an entry-level position.
* // favoronline
* //    - When you add up the pros and cons for online education, it's probably a good thing for society overall.
* // favorregulation
* //    - Government regulation helps ensure businesses treat individuals more fairly.
* // note: maybe we should phrase favorregulation in the normal pattern. Eg `When you add up the pros and cons for government regulation, it's probably a good thing for society overall.'
* // favorreligion
* //    - I consider myself religious
* //
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

* // ioi is a general index of pro-alternative-credentialness
* // it is interesting alongside voi in that q1 cares about a specific use case, the index is more a general attitude
gen ioi = favorentrylevel + favorconventionalsoon + favoronline

* // generate continuous survey-reported age (age group)
gen crage1 = reportedage
gen crage2 = reportedage*reportedage
gen crage3 = reportedage*reportedage*reportedage

gen crea1 = reportedexactage
gen crea2 = reportedexactage*reportedexactage
gen crea3 = reportedexactage*reportedexactage*reportedexactage

* // generate continuous survey monkey account-reported age
gen csmage1 = surveymonkeyage
gen csmage2 = surveymonkeyage*surveymonkeyage
gen csmage3 = surveymonkeyage*surveymonkeyage*surveymonkeyage

* // generate continuous reported income
gen crincome1 = reportedincome
gen crincome2 = reportedincome*reportedincome
gen crincome3 = reportedincome*reportedincome*reportedincome

* // generate continuous survey monkey account-reported income
gen csmincome1 = surveymonkeyincome
gen csmincome2 = surveymonkeyincome*surveymonkeyincome
gen csmincome3 = surveymonkeyincome*surveymonkeyincome*surveymonkeyincome

gen cprovider1 = heardofcoursera + heardoflynda + heardofpluralsight + heardofudacity + heardofudemy
gen cprovider2 = cprovider1*cprovider1
gen cprovider3 = cprovider1*cprovider1*cprovider1

gen ceduc1 = educ
gen ceduc2 = ceduc1*ceduc1
gen ceduc3 = ceduc1*ceduc1*ceduc1

* // timedays is the time when a single user submitted his response, where time is finitely-measured at the daily level.
* // ref: https:* //www.stata.com/support/faqs/data-management/creating-date-variables/
split enddate
gen enddatestatafriendly = subinstr(enddate1, "/", "-", .)
gen ctime1 = date(enddatestatafriendly, "MDY")
gen ctime2 = ctime1*ctime1
gen ctime3 = ctime1*ctime1*ctime1
gen ctime1zeroed = ctime1 - 21241

gen is2018sample = 0
replace is2018sample = 1 if !missing(nvoifchristianity1) & !missing(csmincome1)

gen logconventionalsoon1 = log(nvoifconventionalsoon1)
gen logtime = log(ctime1)
gen logvoi = log(voi)

gen managertime1 = ismanager*ctime1
gen managertime2 = managertime1*managertime1

gen personality_open1 = personality_open
drop personality_openness
gen personality_open2 = personality_open1*personality_open1
gen personality_open3 = personality_open1*personality_open1*personality_open1

gen personality_conscientiousness1 = personality_conscientiousness
drop personality_conscientiousness
gen personality_conscientiousness2 = personality_conscientiousness1*personality_conscientiousness1
gen personality_conscientiousness3 = personality_conscientiousness1*personality_conscientiousness1*personality_conscientiousness1

gen personality_extraversion1 = personality_extraversion
drop personality_extraversion
gen personality_extraversion2 = personality_extraversion1*personality_extraversion1
gen personality_extraversion3 = personality_extraversion1*personality_extraversion1*personality_extraversion1

gen personality_agreeableness1 = personality_agreeableness
drop personality_agreeableness
gen personality_agreeableness2 = personality_agreeableness1*personality_agreeableness1
gen personality_agreeableness3 = personality_agreeableness1*personality_agreeableness1*personality_agreeableness1

gen personality_neuroticism1 = personality_neuroticism
drop personality_neuroticism
gen personality_neuroticism2 = personality_neuroticism1*personality_neuroticism1
gen personality_neuroticism3 = personality_neuroticism1*personality_neuroticism1*personality_neuroticism1

gen personality_grit1 = personality_grit
drop personality_grit
gen personality_grit2 = personality_grit1*personality_grit1
gen personality_grit3 = personality_grit1*personality_grit1*personality_grit1

gen completiontimeminutes1 = completiontimeminutes
drop completiontimeminutes
gen completiontimeminutes2 = completiontimeminutes1*completiontimeminutes1
gen completiontimeminutes3 = completiontimeminutes1*completiontimeminutes1*completiontimeminutes1
gen completiontimeminutes4 = completiontimeminutes1*completiontimeminutes1*completiontimeminutes1*completiontimeminutes1

* // TODO: interact administration with completion
* // collectors and time may proxy administration
* // below comment is pseudo code which should be abstract re-implemented in js/ts
* // gen completion_x_collector = (FOR EACH iscollector)*completion
* // below is ad-hoc administration detection which can be interacted w

gen regulation_x_ai = nvoifregulation1*nvoifai1
gen regulation_x_grit = nvoifregulation1*personality_grit1
gen provider_x_open = cprovider1*personality_open1
gen provider_x_conscientiousness = cprovider1*personality_conscientiousness1
gen provider_x_extraversion = cprovider1*personality_extraversion1
gen provider_x_agreeableness = cprovider1*personality_agreeableness1
gen provider_x_neuroticism = cprovider1*personality_neuroticism1
gen provider_x_grit = cprovider1*personality_grit1
gen grit_x_conscientiousness = personality_grit1*personality_conscientiousness1

drop collector
drop educ
drop eth
drop heard*
drop enddat*
drop favor*
drop industry
drop reportedage
drop reportedexactage
drop reportedincome
drop respondentid
drop surveymonk*

label variable ishighered "Is College Graduate"
label variable ismale "Is Male"
label variable ismanager "Is Manager"
label variable isstem "Is STEM"
label variable isindustry6 "IT Industry"
label variable isregion7 "West South Central Region"
label variable nvoifai1 "AI"
label variable nvoifai2 "AI^2"
label variable nvoifamerican2 "Nationalism^2"
label variable ctime1 "Time"
label variable ctime2 "Time^2"
label variable ctime3 "Time^3"
label variable nvoifconventionalsoon1 "Expectation"
label variable nvoifconventionalsoon2 "Expectation^2"
label variable nvoifconventionalsoon3 "Expectation^3"
label variable nvoifregulation1 "Pro Regulation"
label variable nvoifreligion1 "Religiosity"
label variable cprovider3 "Familiarity^3"
label variable provider_x_grit "Familiarity-Grit"
label variable crincome3 "Income^3"
