clear
import delimited "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\data-condensed\CSV\Alternative Creds Baseline Attitudinal.csv"

//import delimited "C:\Users\john.vandivier\workspace\data-science-practice\stata\udacity-exploratory-analysis\data-condensed\CSV\Alternative Creds Baseline Attitudinal.csv"

// tab/gen ref: https://stats.idre.ucla.edu/stata/faq/how-can-i-create-dummy-variables-in-stata/ */
// destring. ref: https://www.reed.edu/psychology/stata/gs/tutorials/destring.html
tab region, gen(_region)
tab income, gen(_income)
tab stem, gen(_stem)
tab industry, gen(_industry)
tab age, gen(_age)

drop region
drop income
drop stem
drop industry
drop age

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
replace cincome1 = 11 if _income11 == 1
gen cincome2 = cincome1*cincome1
gen cincome3 = cincome1*cincome1*cincome1

gen cprovider1 = providercount
gen cprovider2 = cprovider1*cprovider1
gen cprovider3 = cprovider1*cprovider1*cprovider1
drop providercount

// reg exploration, short
reg q2 q3                                                                                           // strong cross-correlation, but R^2 of only .2: Good!
reg q2 employer                                                                                     // In a simple regression, employers are more positive than average!
reg q2 q4                                                                                           // strong anti-innovation bias exists
reg q6 employer                                                                                     // strong anti-foreign bias by employers not found
reg q2 q6                                                                                           // strong nationalism doesn't really effect alt favorability
reg _stem3 _industry*                                                                               // IT professionals are uniquely unsure about whether they work in STEM

// reg exploration, long
reg q2 employer unemployed cprovider1 male _region* _income* _stem* _industry* _age* boughtSample     // employer pref w correction, intial; not significant factor
reg q3 employer unemployed cprovider1 male _region* _income* _stem* _industry* _age* boughtSample     // q3 is more predictable than q2 (R^2 .7, adjusted is awful)

// notice industry effects are very different from q2 and q3; as expected: law, accounting, and health are bad for entry level by alt; unexpected is transportation
// I will need to seperately analyze q2 and q3; therefore making seperate explore-* .do files

// long long regression for ez copy and paste: 
// reg index eq4 eq4s eq4c eq6 eq6s eq6c boughtSample employer male unemployed _region1 _region2 _region3 _region4 _region5 _region6 _region7 _region8 _region9 _income1 _income2 _income3 _income4 _income5 _income6 _income7 _income8 _income9 _income10 _income11 _stem1 _stem2 _stem3 _industry1 _industry2 _industry3 _industry4 _industry5 _industry6 _industry7 _industry8 _industry9 _industry10 _industry11 _industry12 _age1 _age2 _age3 _age4 cage1 cage2 cage3 cincome1 cincome2 cincome3 cprovider1 cprovider2 cprovider3
