clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // ref: https://www.youtube.com/watch?v=bF2Y0sHhd7w
* // ref: https://www.youtube.com/watch?v=J_B51r2Y-N0
* // begin vector autoregressive exploration using adapted preferred linear regs for enrollment, tuition, and loans models
* // see analysis-2-basic-exploration.do for linear reg exploration
* // enrollment first
* // also add empassist because we want to check that pure lag relation
* // drop power vars bc we have time var to account for dynamic nonlinearity
* // result optimal lag length is 3 using AIC selection criteria
tsset year
varsoc totalen new1 visaenroll pce exnew1 exvisaenroll stategi3 empassist

* // new empassist / section 127 is exogenous policy choice var
* // this is var model of interest
var empassist stategi3 totalen pce, lags(1/3)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(empassist) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

* // model of interest with low-confidence long-run forecast
* // the confidence inteval never fully enters the negative range,
* //    even at the low .75 threshold,
* //    although the point estimate dips negative for a while.
* //    Effects are essentially horizontal by period 20,
* //    so net effect seems positive over time.
irf create vardata, set(vardata, replace) step(24)
irf graph oirf, set(vardata) irf(vardata) impulse(empassist) response(totalenrollment) xtitle(Years) ytitle(LR Lagged Enrollment Effect) level(75) ustep(20)

* // remove non-linear factors and interactions. order from a policy process perspective
* // visa issuance as exogenous policy choice var
* // totalen is response
* // scanning r2 and p indicates significance
* // response can't use abbrev. stata is stupid lol
var new1 empassist stategi3 totalen pce, lags(1/3)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(new1) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

var exnew1 stategi3 totalen pce, lags(1/3)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(exnew1) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

* // this is simplified var of interest...shows negative effect the whole way through just like scanning through uncorrected data
varsoc empassist totalen
var empassist totalen, lags(1/4)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(empassist) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect)

* // meh i don't care about doing the below rn
* // varsoc tuition new1 totalen exnew1 exnew2 exvisaenroll year stategi3
* // varsoc loans totalen new1 exnew1 exnew2 stafford* tuition year year2
