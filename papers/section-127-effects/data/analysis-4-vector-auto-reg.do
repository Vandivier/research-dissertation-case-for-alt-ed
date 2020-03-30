clear

do "D:\GitHub\research-dissertation-case-for-alt-ed\papers\section-127-effects\data\analysis-1-vars.do"

* // ref: https://www.youtube.com/watch?v=bF2Y0sHhd7w
* // ref: https://www.youtube.com/watch?v=J_B51r2Y-N0
* // begin vector autoregressive exploration
* // transform from preferred DOLS model
* // 2-factor model lag is 2 lags
varsoc totalen visa_m_h1b_1
varsoc totalen employer_assistance_1
varsoc totalen visa_m_h1b_1 loans
varsoc totalen visa_m_h1b_1 tuition_cpi
varsoc visa_m_h1b_1 loans
varsoc visa_m_h1b_1 tuition_cpi

* // first var reg of interest
var employer_assistance_1 totalen, lags(1/2)
irf create vardata, set(vardata, replace)
irf graph oirf, set(vardata) irf(vardata) impulse(employer_assistance_1) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect) level(60) ustep(5)

* // second var reg of interest
var visa_m_h1b_1 totalen, lags(1/2)
irf create vardata, set(vardata, replace) step(11)
irf graph oirf, set(vardata) irf(vardata) impulse(visa_m_h1b_1) response(totalenrollment) xtitle(Years) ytitle(Lagged Enrollment Effect) ustep(11)

*** // loans and tuition models below

* // loans r-sq 0.9908
* // visa_m_h1b_1 r-sq 0.9380
* // totalenrollment r-sq 0.9972
var visa_m_h1b_1 totalen loans, lags(1/3)
irf create vardata, set(vardata, replace) step(11)
irf graph oirf, set(vardata) irf(vardata) impulse(visa_m_h1b_1) response(loans) xtitle(Years) ytitle(Lagged Loan Effect) ustep(11)

* // loans r-sq 0.9875
* // visa_m_h1b_1 r-sq 0.8821
var visa_m_h1b_1 loans, lags(1/2)
irf create vardata, set(vardata, replace) step(11)
irf graph oirf, set(vardata) irf(vardata) impulse(visa_m_h1b_1) response(loans) xtitle(Years) ytitle(Lagged Loan Effect) ustep(11)

* // tuition_cpi r-sq 0.9979
* // visa_m_h1b_1 r-sq 0.8795
* // totalenrollment r-sq 0.9943
var visa_m_h1b_1 totalen tuition_cpi, lags(1/2)
irf create vardata, set(vardata, replace) step(11)
irf graph oirf, set(vardata) irf(vardata) impulse(visa_m_h1b_1) response(tuition_cpi) xtitle(Years) ytitle(Lagged Tuition Effect) ustep(11)

* // tuition_cpi r-sq 0.9962
* // visa_m_h1b_1 r-sq 0.8462
* // totalenrollment r-sq ---
var visa_m_h1b_1 tuition_cpi, lags(1/1)
irf create vardata, set(vardata, replace) step(11)
irf graph oirf, set(vardata) irf(vardata) impulse(visa_m_h1b_1) response(tuition_cpi) xtitle(Years) ytitle(Lagged Tuition Effect) ustep(11)
