*// TODO: maybe calculate f and q complexity

clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-1-vars.do"

* // model name:      voilong2018
* // r2:              .6187
* // adjr2:           .4158
* // n:               168
* // v-complexity:    69
* // q-complexity:    15
* // omits reported variables (eg, isreportedmale or crage1), voi, and ioi from right hand
* // I would prefer model name like 2018voilong, but it's invalid to start var name w integer
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender issurveymonkeyincomeprefernotdis ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifamerican1 nvoifamerican2 nvoifamerican3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto1 nvoifcrypto2 nvoifcrypto3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 nvoifreligion2 nvoifreligion3 csmage1 csmage2 csmage3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3
estimates store voilong2018, title(voilong2018)

* // model name:      voiweak2018
* // r2:              .6070
* // adjr2:           .4832
* // n:               168
* // v-complexity:    39
* // q-complexity:    14
* // employment status was the only superweak factor.
reg voi issurveymonkeyfemale isstem isnotstem isindustry1 isindustry2 isindustry4 isindustry5 isindustry6 isindustry10 isindustry11 isregion2 isregion3 isregion6 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto2 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 csmage1 csmage2 csmage3 csmincome1 csmincome2 cprovider1 cprovider2 cprovider3 ctime3
estimates store voiweak2018, title(voiweak2018)

* // model name:      voimaxar2018
* // r2:              .5971
* // adjr2:           .5016
* // n:               168
* // v-complexity:    32
* // q-complexity:    13
* // Christian identification filtered out.
reg voi issurveymonkeyfemale isstem isnotstem isindustry1 isindustry2 isindustry4 isindustry5 isindustry6 isindustry10 isindustry11 isregion2 isregion3 isregion6 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon3 nvoifcrypto2 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 csmage1 csmage2 csmage3 csmincome1 csmincome2 cprovider2 ctime3
estimates store voimaxar2018, title(voimaxar2018)

* // model name:      voistr2018
* // r2:              .?
* // adjr2:           .?
* // n:               ?
* // v-complexity:    ?
* // q-complexity:    ?
reg voi issurveymonkeyfemale isregion2 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon3 nvoifonline2 nvoifregulation1 nvoifreligion1 csmage2 csmincome1
estimates store voistr2018, title(voistr2018)
