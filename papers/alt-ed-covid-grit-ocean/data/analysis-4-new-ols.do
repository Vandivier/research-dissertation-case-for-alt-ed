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
* // add in ismanager and regulation_x_ai
* // reg3
* // n = 1328, r2 = 0.3239, ar2 = 0.3125
reg voi ismanager ismale isfemale nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x_ai crage* crincome*

* // swap age group for exact age
* // better model power, but arguably insignificant difference bc lower sample
* // reg-1
* // n = 1048, r2 = 0.3359, ar2 = 0.3217
reg voi ismanager ismale isfemale nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x_ai crea* crincome*

* // now, add personality vars
* // crage -> crea is a super bad move here
* // reg3
* // n = 201, r2 = 0.4004, ar2 = 0.2776
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x_ai crage* crincome*

* // now, add more standard controls
* // more is*, industry, ethnicity, educ, collector fx, provider fx
* // notably missing regional fx
* // reg4
* // n = 201, r2 = 0.4811, ar2 = 0.2793
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x_ai crage* crincome* cprovider* ceduc* iscollector* iseth* ishighered isindustry*

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
* //    a reason not to think grit attenuates concientiousness: eliminating the latter does not reverse the sign of the former
* // reg5, first maxar2020 (local maximum)
* // preferred reg
* // n = 201, r2 = 0.4495, ar2 = 0.3561
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* regulation_x_ai crage* crincome* cprovider* ceduc* iscollector20 iseth* ishighered isindustry*
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* regulation_x_ai crage* crincome* cprovider* ceduc* iscollector20 isethnicity2 isethnicity5 isethnicity6 ishighered isindustry*
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* regulation_x_ai crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity5 isethnicity6 ishighered isindustry*
reg voi ismanager ismale isfemale personality*1 personality*2 personality_isinvalid nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity5 isethnicity6 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismanager ismale isfemale personality*1 personality*2 nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity6 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismanager ismale isfemale personality_agreeableness1 personality_agreeableness2 personality_conscientiousness1 personality_conscientiousness2 personality_extraversion1 personality_extraversion2 personality_grit1 personality_grit2 personality_neuroticism1 personality_neuroticism2 personality_open1 personality_open2 nvoifai* nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome* cprovider*2 cprovider*3 ceduc* iscollector20 isethnicity2 isethnicity6 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_extraversion1 personality_extraversion2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation* crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry8
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry3 isindustry4 isindustry6
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_neuroticism2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6
reg voi ismale isfemale personality_conscientiousness1 personality_conscientiousness2 personality_grit1 personality_grit2 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6

* // reg6, second maxar2020
* // n = 201, r2 = 0.4404, ar2 = 0.3568
* // note: this removes some factors we structurally prefer, such as marginal grit+conscientiousness
reg voi isfemale personality_conscientiousness1 personality_grit1 personality_open1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered  isindustry1 isindustry10 isindustry11 isindustry4 isindustry6

* // reg8, strong2020
* // note: even more structural factors removed
* // note: grit, ethnicity2, and industry6 are the most important effects in their categories
* // openness and grit (or generally, personality effects) are stronger than industrial effects
* // personality effect (grit) are stronger than industrial, ethnic, and provider effects (familiarity bias)
* // grit coeff is negative but provider coeff is positive; what about interaction?
* // n = 1717, r2 = 0.2857, ar2 = 0.2844
reg voi isfemale personality_grit1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered isindustry6
reg voi isfemale personality_grit1 personality_open2 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered
reg voi isfemale personality_grit1 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage1 crage2 ishighered
reg voi nvoifai*1 nvoifconventional*2 nvoifonline* nvoifregulation*1 crage1 crage2
reg voi nvoifai*1 nvoifconventional*2 nvoifregulation*1

* // reg9
* // from reg5, immediately consolidate to best-in-category factors for gender, personality, ethnicity, industry
* // note: conscientiousness effectively doesn't matter
* // n = 201, r2 = 0.4096, ar2 = 0.3476
reg voi isfemale personality_conscientiousness1 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider*2 cprovider*3 isethnicity2 ishighered isindustry6

* // reg10, semi-bad reduction strong model
* // from reg9, swap grit in for conscientiousness
* // result: this demonstrates that single-factor elimination is an ideal model analysis and factor analysis pattern in comparison to kitchen sink immediate consolidation by group
* // this could be a side paper in econometrics; also note it's a fuzzy technique bc sometimes non-systematic transforms can generate pareto-better models
* // where a pareto-better model has higher ar2 and is also more intuitive (eg down-powering a marginal-cube pair)
* // so, round robin and kitchen sink analysis is a baseline approach which is complementary to a pure structural approach (multiple operationalizations of a given concept)
* // one might argue it substitutes rather than simply compliments the structural approach; that is, it could be a discovery tool rather than simply an adjudication, model analysis, and factor analysis tool
* // note: sig factors largely attributable to sample size
* // note: regulatory effect positive on voi is one of strongest four effects; as strong as conventional soon and favor online which are nearly tautological
* // interestingly, this model has more strong factors compared to normal reduction strong model.
* // n = 1717, r2 = 0.3026, ar2 = 0.3009
reg voi isfemale personality_grit1 nvoifai*1 nvoifai*2 nvoifconventional*2 nvoifonline* nvoifregulation*1 nvoifregulation*2 crage* crincome*3 cprovider2 cprovider3 isethnicity2 ishighered isindustry6
reg voi nvoifai*1 nvoifconventional*2 nvoifonline1 nvoifregulation*1

* // now swap personality for time relative to reg4
* // Note: reg4+time reduces ar2 and r2 = 0.4820; basically no gain.
* // reg11
* // much more n and ar2 but lower r2
* // n = 953, r2 = 0.3745, ar2 = 0.3376
reg voi ismanager ismale isfemale nvoifai* nvoifconventional* nvoifonline* nvoifregulation* regulation_x_ai crage* crincome* cprovider* ceduc* iscollector* iseth* ishighered isindustry* ctime*
