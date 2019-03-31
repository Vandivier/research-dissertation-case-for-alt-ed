clear
import delimited "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\data-condensed\CSV\dropped-income-6.csv"

//import delimited "C:\Users\john.vandivier\workspace\data-science-practice\stata\udacity-exploratory-analysis\data-condensed\CSV\dropped-income-6.csv"

// tab/gen ref: https://stats.idre.ucla.edu/stata/faq/how-can-i-create-dummy-variables-in-stata/ */
// destring. ref: https://www.reed.edu/psychology/stata/gs/tutorials/destring.html
tab region, gen(_region)
tab income, gen(_income)
tab stem, gen(_stem)
tab industry, gen(_industry)
tab age, gen(_age)

// which sample var
gen boughtSample = 0
replace boughtSample = 1 if _region1 != .

// refer to all questions EXCEPT variable of interest q2 with aq*
gen aq3 = q3
gen aq4 = q4
gen aq5 = q5
gen aq6 = q6

// refer to questions outside of varible of interest index with eq*
gen index = q2 + q3 + q5
gen eq4 = q4
gen eq4squared = q4*q4
gen eq4cubed = q4*q4*q4
gen eq6 = q6
gen eq6squared = q6*q6
gen eq6cubed = q6*q6*q6

// generate continuous age
gen cage1 = 1 if _age1 == 1
replace cage1 = 2 if _age2 == 1
replace cage1 = 3 if _age3 == 1
replace cage1 = 4 if _age4 == 1
gen cage2 = cage1*cage1
gen cage3 = cage1*cage1*cage1

// generate continuous income
gen cincome1 = 1 if _income1 == 1
replace cincome1 = 2 if _income2 == 1
replace cincome1 = 3 if _income3 == 1
replace cincome1 = 4 if _income4 == 1
replace cincome1 = 5 if _income5 == 1
replace cincome1 = 6 if _income6 == 1
replace cincome1 = 7 if _income7 == 1
replace cincome1 = 8 if _income8 == 1
replace cincome1 = 9 if _income9 == 1
replace cincome1 = 10 if _income10 == 1
gen cincome2 = cincome1*cincome1
gen cincome3 = cincome1*cincome1*cincome1

gen cprovider1 = providercount
gen cprovider2 = cprovider1*cprovider1
gen cprovider3 = cprovider1*cprovider1*cprovider1

drop providercount
drop region
drop income
drop stem
drop industry
drop age

// for the record this was explored; perfectly collinear
reg index provider*

// d2ilong
// r2:              .44
// adjr2:           -.05
// f-complexity:    58
// q-complexity:    10
reg index eq* boughtSample employer male unemployed _region* _income* _stem* _industry* _age* cage* cincome* cprovider*

// d2iweak
// r2:              .39
// adjr2:           .22
// f-complexity:    22
// q-complexity:    9
// notes: p < .5
reg index eq4squared eq4cubed eq6 eq6cubed employer male unemployed _region3 _region5 _income9 _industry2 _industry4 _industry5 _industry6  _industry9- _industry12 _age2 cprovider1 cprovider2

// d2imaxar
// r2:              .35
// adjr2:           .25
// f-complexity:    14
// q-complexity:    7
reg index eq4squared eq4cubed eq6 eq6cubed male unemployed _region3 _region5 _industry4 _industry6  _industry9 _industry12 cprovider1

// d2istrong
// r2:              .22
// adjr2:           .18
// f-complexity:    7
// q-complexity:    3
// notes: strong factors, p < .1
reg index eq4squared eq4cubed eq6 eq6cubed _industry6  _industry9

// d2qlong
// r2:              .42
// adjr2:           -.09
// f-complexity:    58
// q-complexity:    10
// notes: q2 reanalysis.
// Model df != f-complexity; df = 44, omits constant and ommitted vars, even some whole questions.
// Here's a consideration not captured in f-complexity: Derived values are relatively cheap. Eg eq6squared and eq6cubed are derived.
reg q2 eq* boughtSample employer male unemployed _region* _income* _stem* _industry* _age* cage* cincome* cprovider*

// d2qweak
// r2:              .39
// adjr2:           .20
// f-complexity:    23
// q-complexity:    10
reg q2 eq4 eq6squared eq6cubed male unemployed _region3 _region5 _region6 _income2 _income3 _income6 _stem1 _stem2 _industry2 _industry6 _industry7 _industry9 _industry12 _age2 cage2 cincome3 cprovider1

// d2qmaxar
// r2:              .37
// adjr2:           .21
// f-complexity:    20
// q-complexity:    9
reg q2 eq4 eq6squared eq6cubed unemployed _region3 _region6 _income2 _income3 _income6 _stem1 _stem2 _industry2 _industry6 _industry7 _industry9 _industry12 _age2 cincome3 cprovider1

// d2qstrong
// r2:              .18
// adjr2:           .13
// f-complexity:    6
// q-complexity:    3
reg q2 eq6squared eq6cubed _income2 _industry6 _industry9
