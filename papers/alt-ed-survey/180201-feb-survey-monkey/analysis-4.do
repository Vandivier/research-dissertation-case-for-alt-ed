do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\analysis.do"
//do "C:\Users\john.vandivier\workspace\data-science-practice\stata\udacity-exploratory-analysis\analysis.do"

// d1qlong
// r2:              .44
// adjr2:           -.07
// f-complexity:    59
// q-complexity:    10
reg q2 eq* boughtSample employer male unemployed _region* _income* _stem* _industry* _age* cage* cincome* cprovider*

// d1qweak
// r2:              .40
// adjr2:           .18
// f-complexity:    26
// q-complexity:    9
reg q2 eq4 eq4s male unemployed _region3 _region5 _region6 _region7 _region9 _income2 _income4 _income6 _income8 _income9 _stem1 _stem2 _industry2 _industry6 _industry7 _industry9 _industry12 _age2 cincome2 cincome3 cprovider1

// d1qmaxar
// r2:              .35
// adjr2:           .22
// f-complexity:    17
// q-complexity:    7
reg q2 eq4 eq4s male unemployed _region3 _region6 _region7 _income2 _income4 _income6 _income8 _stem1 _stem2 _industry2 _industry6 _industry12

// d1qstrong
// r2:              .12
// adjr2:           .08
// f-complexity:    5
// q-complexity:    3
reg q2 eq4 _income2 _income6 _industry6
