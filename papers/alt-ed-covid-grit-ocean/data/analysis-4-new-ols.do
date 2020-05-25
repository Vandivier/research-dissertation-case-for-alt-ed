do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-1-vars.do"

* // initial reg
* // similar to old voistr2018 without: regional fx and religiosity
* // feels kinda cheating to forecast based on semi-unobservable nvoifconventionalsoon and nvoifonline
* // r2 .48, ar2 .27, it's almost all the above cheat questions
* // but, personality is semiobservable too;
* // that is, you would prob have to ask the person you can't just see it on linkedin, etc
reg voi regulation_x nvoifregulation* nvoifai* personality*1 personality*2 personality_isinvalid crage* crea* crincome* cprovider* ceduc* iscollector* iseth* ishighered isindustry* isfemale ismanager isreportednonbinary nvoifconventionalsoon* nvoifonline*
