clear

do "D:\workspace\github\research-dissertation-case-for-alt-ed\papers\alt-ed-covid-grit-ocean\data\analysis-5-interactions.do"

* // nvoifai1 direction flips when personality included
* // personality > ethnic effects
* // isindustry6 is Information Technology industry
* // familiarity ~ 10x more important than income effect

* // esttab voimaxar2018 voimaxar2019 voimaxar2020, keep(ishighered isindustry6 ismale ismanager isstem nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifregulation1 nvoifreligion1 crincome3 cprovider2 provider_x_grit) replace star(* 0.10 ** .01 *** .001) stats(r2 N, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.3f) nonumbers mlabels(, ti) label order(nvoifai1 nvoifai2 nvoifconventionalsoon2 nvoifconventionalsoon3 cprovider2 provider_x_grit crincome3 ishighered ismale ismanager isstem isindustry6 nvoifamerican2 nvoifregulation1 nvoifreligion1)
esttab voimaxar2018 voimaxar2019 voimaxar20192 voimaxar2020 using temp.tex, booktabs keep(ishighered isindustry6 ismale ismanager isstem nvoifai1 nvoifai2 nvoifamerican2 nvoifconventionalsoon2 nvoifconventionalsoon3 nvoifregulation1 nvoifreligion1 crincome3 cprovider2 provider_x_grit personality_conscientiousness1) replace star(* 0.10 ** .01 *** .001) stats(r2 N, fmt(4 0 1) label(R-sqr)) varwidth(25) b(%10.3f) nonumbers mlabels(, ti) label order(nvoifai1 nvoifai2 personality_conscientiousness1 nvoifconventionalsoon2 nvoifconventionalsoon3 cprovider2 provider_x_grit crincome3 ishighered ismale ismanager isstem isindustry6 nvoifamerican2 nvoifregulation1 nvoifreligion1)
