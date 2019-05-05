*// TODO: maybe calculate f and q complexity

clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-1-vars.do"

* // model name:      2019voilong
* // r2:              .4180
* // adjr2:           .2792
* // n:               271
* // omits reported variables (eg, isreportedmale or crage1), voi, and ioi from right hand
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed ismale isfemale isreportedmale isreportedfemale isreportednonbinary isunreportedgender iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 csmage3 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3

* // 2019voiweak
* // r2:              .4105
* // adjr2:           .3168
* // n:               271
* // f-complexity:    ?
* // q-complexity:    ?
reg voi issurveymonkeymale ismanager isunemployed isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion5 isregion6 isregion7 nvoifai1 nvoifai2 nvoifconventionalsoon1 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3

* // 2019voimaxar
* // r2:              .4029
* // adjr2:           .3227
* // n:               271
reg voi issurveymonkeymale ismanager isunemployed isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion5 isregion7 nvoifai1 nvoifconventionalsoon1 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 cprovider1 cprovider2 cprovider3

* // 2019voistrong
* // r2:              .2949
* // adjr2:           .2806
* // n:               403
reg voi isindustry12 nvoifai1 nvoifconventionalsoon1 nvoifonline1 crage1 crage2 crage3 cprovider1