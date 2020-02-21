clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // ref: https://www.youtube.com/watch?v=bF2Y0sHhd7w
* // ref: https://www.youtube.com/watch?v=J_B51r2Y-N0
tsset year

* // begin vector autoregressive exploration using adapted preferred linear regs for enrollment, tuition, and loans models
* // see analysis-2-basic-exploration.do for linear reg exploration
* // enrollment first
* // also add empassist because we want to check that pure lag relation
* // drop power vars bc we have time var to account for dynamic nonlinearity
* // result optimal lag length is 3 using AIC selection criteria
varsoc totalen new1 visaenroll pce exnew1 exvisaenroll stategi3 empassist

* // remove non-linear factors and interactions. order from a policy process perspective
* // var estimation includes new visa issuance as exogenous policy choice var
* // totalen is response
* // scanning r2 and p indicates significance
var new1 empassist stategi3 totalen pce, lags(1/3)
irf create vardata, set(vardata, replace)
* // response can't use abbrev. stata is stupid lol
irf graph oirf, set(vardata) irf(vardata) impulse(new1) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

var empassist stategi3 totalen pce, lags(1/3)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(empassist) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

var exnew1 stategi3 totalen pce, lags(1/3)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(exnew1) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

* // meh i don't care about doing the below rn
* // varsoc tuition new1 totalen exnew1 exnew2 exvisaenroll year stategi3
* // varsoc loans totalen new1 exnew1 exnew2 stafford* tuition year year2
