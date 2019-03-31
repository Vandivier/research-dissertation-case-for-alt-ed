do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\analysis.do"
//do "C:\Users\john.vandivier\workspace\data-science-practice\stata\udacity-exploratory-analysis\analysis.do"

// paper: step 1: discuss analysis, explaning q2
// step 2: discuss analysis 2, explaining index
// step 2.b: explain index on observables only; not survey questions
// step 3: factor compare-and-contrast: what factors are q2-index robust or not or reversed and why?

// d1ilong
// r2:              .49
// adjr2:           .03
// f-complexity:    59
// q-complexity:    10
reg index eq* boughtSample employer male unemployed _region* _income* _stem* _industry* _age* cage* cincome* cprovider*

// d1iweak
// r2:              .48
// adjr2:           .25
// f-complexity:    30
// q-complexity:    10
reg index eq4 eq6 eq6cubed employer male unemployed _region3 _region5 _region6 _region8 _income2 _income6 _income10 _stem1 _stem2 _industry2 _industry4-_industry6 _industry9-_industry12 cage2 cage3 cincome2 cincome3 cprovider1 cprovider2

// d1imaxar
// r2:              .44
// adjr2:           .30
// f-complexity:    20
// q-complexity:    10
// notes: geniune or pseudosimplicity?
reg index eq4 eq6 eq6cubed male unemployed _region3 _region5 _region6 _region8 _income6 _stem2 _industry6 _industry9 _industry11 cage2 cage3 cincome2 cincome3 cprovider1

// d1istrong
// r2:              .27
// adjr2:           .23
// f-complexity:    7
// q-complexity:    4
// note: strong factor model, p < .1
reg index eq4 eq6 eq6cubed _income6 _industry6 _industry9

// d1inqlong
// r2:              .34
// adjr2:           -.12
// f-complexity:    53
// q-complexity:    8
// note: now start over without questions
reg index boughtSample employer male unemployed _region* _income* _stem* _industry* _age* cage* cincome* cprovider*

// d1inqweak
// r2:              .32
// adjr2:           .16
// f-complexity:    19
// q-complexity:    8
reg index male unemployed _region8 _region9 _income6 _income8 _stem1 _stem2 _industry2 _industry4-_industry6 _industry9 _industry11 cage2 cage3 cprovider1 cprovider2

// d1inqmaxar
// r2:              .28
// adjr2:           .18
// f-complexity:    13
// q-complexity:    8
reg index male unemployed _region8 _income6 _income8 _stem1 _stem2 _industry6 _industry9 cage2 cage3 cprovider1

// d1inqstrong
// r2:              .17
// adjr2:           .13
// f-complexity:    4
// q-complexity:    4
reg index male _income6 _industry9 cprovider1

// both robust factor models tell a similar story; people are cool with alternative credentials unless they are _income6: 175-199k/year
// there was only n=1 for _income6: how does the analysis change if this observation is dropped? see analysis-3
