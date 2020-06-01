do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-3-replicate-old-ols.do"

* // reg12
* // preferred reg plus linear provider plus linear interactions of interest (regulation_x* provider_x*)
* // provider grit interaction much stronger and opposite direction compared to concientiousness interaction
* // grit interaction with provider proves more significant than any personality var, and allows concientiousness to survive
* // sign of grit wrt 
* // n = 201, r2 = 0.4479, ar2 = 0.3654
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider1 cprovider2 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 regulation_x_ai regulation_x_grit provider_x_open provider_x_neuroticism provider_x_grit provider_x_extraversion provider_x_conscientiousness provider_x_agreeableness
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider1 cprovider2 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 regulation_x_grit provider_x_open provider_x_grit provider_x_agreeableness
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider1 cprovider2 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_open provider_x_grit provider_x_agreeableness
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_open provider_x_grit
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit
reg voi ismale isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit
reg voi isfemale personality_conscientiousness1 personality_grit1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit

* // reg13
* // reg12+grit_x_conscientiousness
* // grit-concientiousness interaction is insignificant, but more significant than concientiousness
reg voi isfemale personality_conscientiousness1 personality_grit1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit grit_x_conscientiousness
reg voi isfemale personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit grit_x_conscientiousness

* // reg14, maxar v3, preferred
* // note: ismale was more significant in older models
* // n = 201, r2 = 0.4476, ar2 = 0.3687
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit

* // reg15
* // reg14+grit_x_conscientiousness
* // replicates unimportance of grit_x_conscientiousness
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit grit_x_conscientiousness

* // reg16, maxar v4, comparison-preferred
* // transform reg14 to facilitate backwards-comparison
* // isfemale -> ismale
* // add ismanager
* // n = 201, r2 = 0.4480, ar2 = 0.3655
reg voi ismale ismanager personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit
estimates store voimaxar2020, title(M-2020)
