*// Does not clear memory so that we can produce table-3 from analysis-5-table-3.do

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190201-feb-survey-monkey\data\stata\analysis-3-2018-replication.do"

* // model name:        voilong2019
* // r2:                .5635
* // adjr2:             .3311
* // n:                 191
* // v-complexity:      89
* // q-complexity:      ?
* // See appendix 2 for variables. All vars except stem, religion, crpto, us centrism
reg voi issurveymonkeymale issurveymonkeyfemale issurveymonkeyunreportedgender issurveymonkeyincomeprefernotdis ismanager isunemployed ismale isfemale isreportedmale isreportedfemale isreportednonbinary isunreportedgender isreportedincomeprefernotdisclos iscollector1 iscollector2 iscollector3 iscollector4 iscollector5 iscollector6 iscollector7 iscollector8 iscollector9 iscollector10 iscollector11 iscollector12 isindustry1 isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry9 isindustry10 isindustry11 isindustry12 isregion1 isregion2 isregion3 isregion4 isregion5 isregion6 isregion7 isregion8 isregion9 isethnicity1 isethnicity2 isethnicity3 isethnicity4 isethnicity5 isethnicity6 ishighered nvoifai1 nvoifai2 nvoifai3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 crage1 crage2 crage3 crea1 crea2 crea3 csmage1 csmage2 csmage3 crincome1 crincome2 crincome3 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ceduc1 ceduc2 ceduc3 ctime1 ctime2 ctime3
estimates store voilong2019, title(voilong2019)

* // model name:        voiweak2019
* // r2:                .5569
* // adjr2:             .4029
* // n:                 191
* // v-complexity:      49
* // q-complexity:      ?
reg voi issurveymonkeymale ismanager isunemployed ismale isfemale isreportedmale isindustry2 isindustry3 isindustry4 isindustry5 isindustry6 isindustry7 isindustry8 isindustry10 isindustry11 isindustry12 isregion2 isregion3 isregion4 isregion9 isethnicity4 isethnicity5 isethnicity6 ishighered nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 crage1 crage2 crea1 crea2 crea3 csmage1 csmage2 csmage3 crincome2 csmincome1 csmincome2 csmincome3 cprovider1 cprovider2 cprovider3 ceduc1 ceduc2 ctime3
estimates store voiweak2019, title(voiweak2019)

* // model name:        voimaxar2019
* // r2:                .5257
* // adjr2:             .4373
* // n:                 192
* // v-complexity:      30
* // q-complexity:      ?
reg voi issurveymonkeymale ismanager isunemployed ismale isindustry7 isindustry10 isindustry12 isregion2 isregion3 isregion4 isethnicity4 isethnicity6 ishighered nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 csmage1 csmage2 csmage3 csmincome2 csmincome3 cprovider1 cprovider2 ceduc1 ceduc2 ctime3
estimates store voimaxar2019, title(voimaxar2019)

* // model name:        voistr2019
* // r2:                .3194
* // adjr2:             .3155
* // n:                 1049
* // v-complexity:      6
* // q-complexity:      5
reg voi ismale nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline2 nvoifregulation1
estimates store voistr2019, title(voistr2019)
