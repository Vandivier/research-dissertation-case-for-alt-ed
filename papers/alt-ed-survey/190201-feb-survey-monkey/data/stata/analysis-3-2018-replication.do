*// TODO: maybe calculate f and q complexity

clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-1-vars.do"

* // model name:      2018voilong
* // r2:              .52
* // adjr2:           .3054
* // n:               188
* // omits reported variables (eg, isreportedmale or crage1), voi, and ioi from right hand
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifamerican1 nvoifamerican2 nvoifamerican3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto1 nvoifcrypto2 nvoifcrypto3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 nvoifreligion2 nvoifreligion3 csmage1 csmage2 csmage3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

* // 2018voiweak
* // r2:              .?
* // adjr2:           .?
* // n:               ?
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed isstem isnotstem isunsurestem isunreportedstem ismale isfemale isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifamerican1 nvoifamerican2 nvoifamerican3 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto1 nvoifcrypto2 nvoifcrypto3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 nvoifreligion2 nvoifreligion3 csmage1 csmage2 csmage3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

* // 2018voimaxar
* // r2:              .?
* // adjr2:           .?
* // n:               ?

* // 2018voistrong
* // r2:              .?
* // adjr2:           .?
* // n:               ?
