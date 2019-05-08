clear

import delimited D:\GitHub\research-dissertation-case-for-alt-ed\papers\alt-ed-survey\190505-may-alternativeness\alternativeness.csv

gen rank1 = rankalt
gen rank2 = rank1*rank1
gen rank3 = rank1*rank1*rank1

gen count1 = testtaker
gen count2 = count1*count1
gen count3 = count1*count1*count1

drop rankalt
drop testtaker

* // adjusted r2 max is linear model, but marginal effect in expected negative direction
reg totalscore rank1
estimates store m1, title(Rank 1)
reg totalscore rank1 rank2
estimates store m2, title(Rank 2)
reg totalscore rank1 rank2 rank3

* // count models have more r, expected directions as well
reg totalscore count1
estimates store m3, title(Count 1)
reg totalscore count1 count2
estimates store m4, title(Count 2)
reg totalscore count1 count2 count3

* // ref: https://stats.idre.ucla.edu/stata/faq/how-can-i-use-estout-to-make-regression-tables-that-look-like-those-in-journal-articles/
estout m1 m2 m3 m4, cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons constant) stats(r2, fmt(3 0 1) label(R-sqr))
