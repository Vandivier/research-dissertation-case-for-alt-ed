do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-1-vars.do"

* // new vars: isstate* iswestcoast FavorAmerican IsReportedIncomePreferNotDisclose is*stem FavorReligion Covid
* //                                nvoifamerican*, nvoifreligion*, nvoifcovid*
* // interesting summary statistic: about as much religious as impacted by covid (2.7/5 vs 3.7/10)

* // reg-a7-1, voimaxar20203 = voimaxar20202 + new vars + collectors + ismanager + ctime1
* // collectors don't matter; state effects > regulation, ethnicity, concientiousness, gender, provider
* // ismanager and ctime1 arbitrary add improves ar2, indicating a return from scratch is recommended
* // model overall predicts more variation than it fails to predict (r2 > 0.5)
* // in this model, regulation no longer matters; kind of a conservative contradiction resolution...?
* // after removing states and covid, regulation still doesn't matter
* // it only weakly matters in this sample simple reg, so it could be a sample variation or size constraint effect
* // state effects, covid, and personality all important.
* // removing states drops ar2 by 
* // n = 192, r2 = 0.5179, ar2 = 0.4245
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate* iswestcoast isreportedincomeprefernot is*stem  nvoifamerican* nvoifreligion* nvoifcovid* iscollector*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate* iswestcoast isreportedincomeprefernot is*stem  nvoifamerican* nvoifreligion* nvoifcovid*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate* iswestcoast isreportedincomeprefernot is*stem  nvoifamerican* nvoifreligion* nvoifcovid*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate* iswestcoast isnotstem  nvoifamerican* nvoifreligion* nvoifcovid*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate1-isstate5 isstate7-isstate28 isstate30-isstate36 isstate38 isstate39 iswestcoast isnotstem  nvoifamerican* nvoifreligion* nvoifcovid*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate1-isstate5 isstate7-isstate25 isstate27 isstate28 isstate30-isstate36 isstate38 isstate39 iswestcoast isnotstem  nvoifamerican* nvoifreligion* nvoifcovid*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit isstate1-isstate5 isstate7-isstate25 isstate28 isstate30-isstate36 isstate38 isstate39 iswestcoast isnotstem  nvoifamerican* nvoifreligion* nvoifcovid*
reg voi isfemale personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry11 isindustry4 isindustry6 provider_x_grit isstate1-isstate5 isstate8-isstate15 isstate17 isstate19-isstate25 isstate28 isstate30-isstate36 isstate39 iswestcoast isnotstem  nvoifamerican* nvoifreligion* nvoifcovid2 nvoifcovid3
reg voi isfemale personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 ishighered isindustry1 isindustry4 isindustry6 provider_x_grit isstate1-isstate5 isstate8-isstate15 isstate17 isstate19-isstate25 isstate28 isstate30 isstate31 isstate33-isstate36 isstate39 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid2 nvoifcovid3
reg voi isfemale personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifregulation*1 nvoifregulation*2 crage1 crage2 crincome*3 cprovider2 ishighered isindustry1 isindustry6 provider_x_grit isstate2-isstate5 isstate8-isstate9 isstate12-isstate15 isstate17 isstate19 isstate21-isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid2 nvoifcovid3
reg voi isfemale personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 crage1 crage2 crincome*3 cprovider2 ishighered isindustry1 isindustry6 provider_x_grit isstate2 isstate5 isstate8-isstate9 isstate12 isstate13 isstate15 isstate17 isstate19 isstate21 isstate22 isstate24 isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid2 nvoifcovid3
reg voi personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 crage1 crage2 crincome*3 cprovider2 ishighered isindustry1 isindustry6 provider_x_grit isstate2 isstate5 isstate8 isstate12 isstate13 isstate15 isstate17 isstate24 isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid2 nvoifcovid3
reg voi personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 crage1 crage2 crincome*3 ishighered isindustry1 isindustry6 provider_x_grit isstate2 isstate5 isstate8 isstate13 isstate17 isstate24 isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid2 nvoifcovid3
reg voi personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 crage1 crage2 crincome*3 ishighered isindustry1 isindustry6 provider_x_grit isstate2 isstate5 isstate8 isstate13 isstate24 isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid2
reg voi personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 crage1 crage2 crincome*3 ishighered isindustry1 isindustry6 provider_x_grit isstate2 isstate5 isstate8 isstate13 isstate24 isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid1
reg voi personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 crage1 crage2 crincome*3 ishighered isindustry1 isindustry6 provider_x_grit isstate2 isstate5 isstate8 isstate13 isstate24 isstate25 isstate30 isstate31 isstate35-isstate36 iswestcoast isnotstem  nvoifamerican* nvoifreligion2 nvoifreligion3 nvoifcovid1 ismanager ctime1
estimates store voimaxar20203, title(M-2020-3)

* // just personality, regulation, and collectors indicates sample variation is important
* // regulation problem persists in larger personality sample (n=394)
* // sample variation seems to be at play, indicating under-correction and/or a need for more samples
reg voi personality* nvoifregulation1 nvoifregulation2 iscollector*
reg voi personality* nvoifregulation1 nvoifregulation2 iscollector19 iscollector20
reg voi personality*1 personality*2 nvoifregulation1 nvoifregulation2 iscollector19 iscollector20
reg voi nvoifregulation1 iscollector19 iscollector20 personality_open1 personality_open2 personality_e*1 personality_e*2 personality_n*1 personality_n*2 personality_g*1 personality_g*2
reg voi nvoifregulation1 iscollector19 iscollector20 personality_open1 personality_open2 personality_e*1 personality_e*2 personality_n*1 personality_n*2 personality_g*1 personality_g*2 if ctime1zeroed > 790
reg voi nvoifregulation1 iscollector19 iscollector20 personality_open1 personality_open2 personality_e*1 personality_e*2 personality_n*1 personality_n*2 personality_g*1 personality_g*2 if ctime1zeroed > 800

* // ideological controls make the problem bigger, not smaller
* // but adding in state effects makes the problem vanish
* // we know regional effects (with common regional devides eg census bureau regions) aren't enough to make the problem vanish
* // https://www.businessinsider.com/regions-of-united-states-2018-5
* // state effects are the best explanation on the table
* // catchy paper title: The States of Alternative Education (or is it terrible...?) supposed to be a play on words
reg voi nvoifregulation1 personality_open1 personality_open2 personality_e*1 personality_e*2 personality_n*1 personality_n*2 personality_g*1 personality_g*2 nvoifreligion1 nvoifamerican1

* // covid strongly matters. more impacted = less favorable (tenative...needs more correction)
reg voi nvoifregulation1 personality_open1 personality_open2 personality_e*1 personality_e*2 personality_n*1 personality_n*2 personality_g*1 personality_g*2 nvoifreligion1 nvoifamerican1 isstate* nvoifcovid1

* // kitchen sink regressions are a first princples approach
* // taking existing models and tweaking is analgous to argument by analogy
* // Elon Musk would support this :) I think...?
* // TODO: kitchen sink among all, and kitchen sink only among personality

