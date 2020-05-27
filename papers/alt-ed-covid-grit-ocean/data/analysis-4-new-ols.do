do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-1-vars.do"


* // initial fxn = voiweak2018 + voimaxar2019
* // no observations. 
* // next reg1: voistr2018 + voistr2019
* // n = 168, r2 = 0.5099, ar2 = 0.4651
reg voi ismale nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline2 nvoifregulation1 issurveymonkeyfemale isregion2 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon3 nvoifonline2 nvoifregulation1 nvoifreligion1 csmage2 csmincome1

* // initial new reg
* // survey monkey vars converted to non-survey monkey equivalent
* // eg issurveymonkeyfemale -> isfemale
* // also, remove vars not in 2020 covid administration
* // eg regional fx, industry, religiosity, nvoifamerican*
* // add in ismanager and regulation_x
* // reg3
* // n = 1328, r2 = 0.3239, ar2 = 0.3125
reg voi ismanager ismale isfemale nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x crage* crincome*

* // swap age group for exact age
* // better model power, but arguably insignificant difference bc lower sample
* // reg-1
* // n = 1048, r2 = 0.3359, ar2 = 0.3217
reg voi ismanager ismale isfemale nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x crea* crincome*

* // now, add personality vars
* // crage -> crea is a super bad move here
* // reg3
* // n = 201, r2 = 0.4004, ar2 = 0.2776
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x crage* crincome*

* // now, add more standard controls
* // more is*, industry, ethnicity, educ, collector fx, provider fx
* // notably missing regional fx
* // reg4
* // n = 201, r2 = 0.4811, ar2 = 0.2793
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x crage* crincome* cprovider* ceduc* iscollector* iseth* ishighered isindustry*

* // reduce to bump ar2
* // agreeableness is first trait to lose,
* //    then collector fx,
* //    then neuroticism,
* //    then manager fx (reproduce positive, p > 0.48)
* //    then extraversion
* //    technically, 2nd to last reg is maxar with marginal neuroticism weak pos effect and ar2 0.3557
* // interesting find: personality appears to be more important than time
* // concientiousness, openness, and grit are important; very intuitive; directions somewhat less intuitive
* // perhaps surprising that concientiousness and grit both survive; in some way they don't mutually partial out
* //     grit appears to attenuate concientiousness; so maybe same abstract concept and mutual measuring is a useful refinement
* // reg5, maxar2020
* // n = 201, r2 = 0.4523, ar2 = 0.3557
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* regulation_x crage* crincome* cprovider* ceduc* iscollector20 iseth* ishighered isindustry*
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* regulation_x crage* crincome* cprovider* ceduc* iscollector20 isethnicity2 isethnicity5 isethnicity6 ishighered isindustry*
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* regulation_x crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity5 isethnicity6 ishighered isindustry*
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity5 isethnicity6 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismanager ismale isfemale personality*1 personality*2 nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity6 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismanager ismale isfemale personality_agreeableness1 personality_agreeableness2 personality_conscientiousness1 personality_conscientiousness2 personality_extraversion1 personality_extraversion2 personality_grit1 personality_grit2 personality_neuroticism1 personality_neuroticism2 personality_open1 personality_open2 nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity6 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_extraversion1 personality_extraversion2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry3 isindustry4 isindustry6
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6

* // now swap personality for time relative to reg4
* // Note: reg4+time reduces ar2 and r2 = 0.4820; basically no gain.
* // reg6
* // much more n and ar2 but lower r2
* // n = 953, r2 = 0.3745, ar2 = 0.3376
reg voi ismanager ismale isfemale nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x crage* crincome* cprovider* ceduc* iscollector* iseth* ishighered isindustry* ctime*
