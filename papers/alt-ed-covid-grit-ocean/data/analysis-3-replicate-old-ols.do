do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-1-vars.do"

* // model name:        voimaxar2019
* // prior r2:          .5257
* // prior adjr2:       .4373
* // prior n:           192
* // current r2:                .4182
* // current adjr2:             .3528
* // current n:                 298
* // v-complexity:      30
* // q-complexity:      12
* // drops reported gender, reported age group, reported exact age, reported income
* // append `if ctime1zeroed<500' to repro preliminary
reg voi issurveymonkeymale ismanager isunemployed ismale isindustry7 isindustry10 isindustry12 isregion2 isregion3 isregion4 isethnicity4 isethnicity6 ishighered nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 csmage1 csmage2 csmage3 csmincome2 csmincome3 cprovider1 cprovider2 ceduc1 ceduc2 ctime3 if ctime1zeroed < 500
estimates store voimaxar2019, title(M-2019)
* // COVID administration 1
reg voi issurveymonkeymale ismanager isunemployed ismale isindustry7 isindustry10 isindustry12 isregion2 isregion3 isregion4 isethnicity4 isethnicity6 ishighered nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 csmage1 csmage2 csmage3 csmincome2 csmincome3 cprovider1 cprovider2 ceduc1 ceduc2 ctime3 if ctime1zeroed < 800
estimates store voimaxar20192, title(M-2019-2)
* // COVID administration 2
* // notice: not diff from admin 1 bc no new surveymonkey samples
reg voi issurveymonkeymale ismanager isunemployed ismale isindustry7 isindustry10 isindustry12 isregion2 isregion3 isregion4 isethnicity4 isethnicity6 ishighered nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline1 nvoifonline2 nvoifonline3 nvoifregulation1 csmage1 csmage2 csmage3 csmincome2 csmincome3 cprovider1 cprovider2 ceduc1 ceduc2 ctime3

* // model name:        voistr2019
* // r2:                .3194
* // adjr2:             .3155
* // n:                 1049
* // current r2:                .3083
* // current adjr2:             .3058
* // current n:                 1717
* // v-complexity:      6
* // q-complexity:      5
reg voi ismale nvoifai3 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifonline2 nvoifregulation1
estimates store voistr2019, title(voistr2019)

* // model name:      voiweak2018
* // r2:              .6070
* // adjr2:           .4832
* // n:               168
* // current r2:                .6057
* // current adjr2:             .4855
* // current n:                 168
* // v-complexity:    39
* // q-complexity:    14
* // employment status was the only superweak factor.
reg voi issurveymonkeyfemale isstem isnotstem isindustry1 isindustry2 isindustry4 isindustry5 isindustry6 isindustry10 isindustry11 isregion2 isregion3 isregion6 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifchristianity1 nvoifchristianity2 nvoifchristianity3 nvoifconventionalsoon1 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifcrypto2 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 csmage1 csmage2 csmage3 csmincome1 csmincome2 cprovider1 cprovider2 cprovider3 ctime3
estimates store voiweak2018, title(voiweak2018)

* // model name:      voimaxar2018
* // r2:              .5971
* // adjr2:           .5016
* // n:               168
* // current r2:                .5971
* // current adjr2:             .5016
* // current n:                 168
* // v-complexity:    32
* // q-complexity:    13
* // Christian identification filtered out.
reg voi issurveymonkeyfemale isstem isnotstem isindustry1 isindustry2 isindustry4 isindustry5 isindustry6 isindustry10 isindustry11 isregion2 isregion3 isregion6 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon3 nvoifcrypto2 nvoifonline2 nvoifonline3 nvoifregulation1 nvoifregulation2 nvoifregulation3 nvoifreligion1 csmage1 csmage2 csmage3 csmincome1 csmincome2 cprovider2 ctime3
estimates store voimaxar2018, title(M-2018)

* // model name:      voistr2018
* // r2:              .5044
* // adjr2:           .4660
* // n:               168
* // current r2:                .5044
* // current adjr2:             .4660
* // current n:                 168
* // v-complexity:    12
* // q-complexity:    8
reg voi issurveymonkeyfemale isregion2 isregion7 nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon3 nvoifonline2 nvoifregulation1 nvoifreligion1 csmage2 csmincome1
estimates store voistr2018, title(voistr2018)
