clear

do "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-matching-effects-2\data\analysis-1-vars.do"

* // simple reg and all bools reg negative beta as expected
reg fav aetiwno_concientiousness
reg fav aetiwno_concientiousness _is*

* // negative linear positive marginal; not surprising; feeds attenuation theory (concientiousness is redundant under multiple other factors, so pure var corrects it)
reg fav c_*

* // negative marginal relation to teamwork explains hireability problem
reg aetiwno_team c_1 c_2

* // preferred reg model 5 without rulebreakers* and other skills negative beta as expected
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 aetiwno_concientiousness

* // add rulebreakers* OR other model 5 skills and sign flips...there are multiple interactions
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 aetiwno_concientiousness rulebreakers*
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 aetiwno_concientiousness aetiwno_bodylanguage aetiwno_commute aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it

* // cross-correlation in concientiousness from model 5 against other skills and rulebreakers
* // basically all factors have corr > 0.1...all but two corr > 0.2
* // start by interacting 3 corr > 0.6...no dice
* // expand to 5 corr > 0.4
corr aetiwno_concientiousness rulebreakers* aetiwno_bodylanguage aetiwno_commute aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it

* // R6 = R5 plus `c_2 c_x* r_x*'
* // non-triviality of c_2 implies bliss point concientiousness; not that arbitrarily low concientiousness is good
* // r2=0.4408, ar2=.3333
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it c_2 c_x* r_x*
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_bodylanguage aetiwno_commute aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_teamwork aetiwno_rulebreaker aetiwno_body_x_it c_2 c_x_bodylanguage c_x_commute c_x_cust c_x_rulebreaker_culture_add c_x_rulebreaker_risky c_x_rulebreaker_rockstars c_x_team c_x_tech r_x_rulebreaker_culture_add r_x_rulebreaker_risky r_x_rulebreaker_rockstars
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_rulebreaker aetiwno_body_x_it c_2 c_x_bodylanguage c_x_commute c_x_cust c_x_rulebreaker_rockstars c_x_team r_x_rulebreaker_culture_add

* // R7 = R6 + re-insert aetiwno_bodylanguage bc we know it interaction is an attenuation
* // I like it but i don't want it in my table of regs bc it's confusing to the reader
* // this is like my actually preferred regression tho...
* // don't re-insert all semi-robust bc they are terribly insignificant after interactions added
* // r2=0.4417, ar2=.3307; one of the best models i got
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_rulebreaker aetiwno_body_x_it c_2 c_x_bodylanguage c_x_commute c_x_cust c_x_rulebreaker_rockstars c_x_team r_x_rulebreaker_culture_add aetiwno_bodylanguage

* // R8 = R6 + c_2 dropped...overfit bc c_2 matters
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_technicaljobskills aetiwno_rulebreaker aetiwno_body_x_it c_x_bodylanguage c_x_commute c_x_rulebreaker_rockstars c_x_team r_x_rulebreaker_culture_add
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_rulebreaker c_x_bodylanguage c_x_commute c_x_rulebreaker_rockstars c_x_team r_x_rulebreaker_culture_add
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate16 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_rulebreaker c_x_bodylanguage c_x_commute c_x_rulebreaker_rockstars c_x_team r_x_rulebreaker_culture_add c_2
reg favorability _iscompanysize4 _iscompanysize8 _isduration6 _ismanager1 _ismanager2 _isindustry1 _isindustry10 _isindustry11 _isindustry2 _isindustry4 _isindustry6 _isindustry8 _isstate13 _isstate26 _isstate34 _isstate37 _isstate39 _isstate8 rulebreakers* aetiwno_concientiousness aetiwno_customerserviceskill aetiwno_rulebreaker c_x_bodylanguage c_x_commute c_x_rulebreaker_rockstars c_x_team r_x_rulebreaker_culture_add c_2
