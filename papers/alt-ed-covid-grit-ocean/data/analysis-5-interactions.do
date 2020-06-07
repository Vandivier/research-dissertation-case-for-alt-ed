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
* // cprovider3 -> cprovider2 simplicity transform w no loss of p, r2, nor ar2.
* // n = 201, r2 = 0.4476, ar2 = 0.3687
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit

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

* // reg16
* // reg15+conservatism and completion time
* // new effects wash out; not signfiicant;
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit grit_x_conscientiousness completiontimeminutes* personality_isinvalid completiontime_x_conservative*
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit grit_x_conscientiousness completiontimeminutes* personality_isinvalid completiontime_x_conservative2 completiontime_x_conservative3
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit completiontimeminutes* completiontime_x_conservative1 completiontime_x_conservative2
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit

* // reg17
* // reg14+conservatism and completion time, only linear and marginal
* // while this model is not preferred, it does yield expected directional effects
* // completiontime_x_conservative1 positive and marginally negative.
* // given presence of completiontime_x_conservative and other ideological proxies, we expect ideology and system 2 effects are well-extracted
* // what remains is completiontimeminutes to stand for IQ. again insignificant, but negative as expected.
reg voi isfemale personality_conscientiousness1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider3 isethnicity2 ishighered isindustry1 isindustry10 isindustry11 isindustry4 isindustry6 provider_x_grit completiontimeminutes1 completiontimeminutes2 completiontime_x_conservative1 completiontime_x_conservative2
