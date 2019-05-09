*// Does not clear memory so that we can produce table-3 from analysis-5-table-3.do

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-3-2018-replication.do"

* // model name:      voilong2019
* // r2:              .4180
* // adjr2:           .2792
* // n:               271
* // omits reported variables (eg, isreportedmale or crage1), voi, and ioi from right hand
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender ismanager isunemployed ismale isfemale isreportedmale isreportedfemale isreportednonbinary isunreportedgender iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 nvoifai1 nvoifai2 nvoifai3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 csmage3 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ctime1 ctime2 ctime3
estimates store voilong2019, title(voilong2019)

* // model name:      voiweak2019
* // r2:              .4105
* // adjr2:           .3168
* // n:               271
* // f-complexity:    ?
* // q-complexity:    ?
reg voi issurveymonkeymale ismanager isunemployed isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion5 isregion6 isregion7 nvoifai1 nvoifai2 nvoifconventionalsoon1 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3
estimates store voiweak2019, title(voiweak2019)

* // model name:      voimaxar2019
* // r2:              .4029
* // adjr2:           .3227
* // n:               271
reg voi issurveymonkeymale ismanager isunemployed isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion5 isregion7 nvoifai1 nvoifconventionalsoon1 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 csmage1 csmage2 cprovider1 cprovider2 cprovider3
estimates store voimaxar2019, title(voimaxar2019)

* // model name:      voistr2019
* // r2:              .2949
* // adjr2:           .2806
* // n:               403
reg voi isindustry12 nvoifai1 nvoifconventionalsoon1 nvoifonline1 crage1 crage2 crage3 cprovider1
estimates store voistr2019, title(voistr2019)
