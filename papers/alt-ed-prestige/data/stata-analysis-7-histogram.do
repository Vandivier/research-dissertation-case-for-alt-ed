clear

import delimited "C:\Users\vandi\workspace\research-dissertation-case-for-alt-ed\papers\alt-ed-prestige\data\prestige-postprocess-hidden.csv"

gen p_low_context_and_accredited = prestige_own if is_accredited == 1 & is_low_context == 1
gen p_low_context_and_high_prestige = prestige_own if is_accredited == 1 & is_low_context == 0
gen p_high_context_and_accredited = prestige_own if is_accredited == 0 & is_low_context == 1
gen p_high_context_and_unaccredited = prestige_own if is_accredited == 0 & is_low_context == 0

* // response distribution
twoway (histogram p_low_context_and_accredited, width(1) color(red%20)) (histogram p_high_context_and_accredited, width(1) color(blue%20)), legend(order(1 "High Context" 2 "Low Context" )) ytitle("")
* // ytitle("Accredited Prestige")

twoway (histogram prestige_own, width(1)), legend(order(1 "High Context" 2 "Low Context" )) ytitle("") by(is_accredited is_low_context)
