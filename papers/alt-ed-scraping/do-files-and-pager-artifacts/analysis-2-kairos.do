do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\manually-scraped\analysis-0-vars.do"

// d1longkairos
// n:               103
// r2:              .73
// adjr2:           .1
// f-complexity:    114
// q-complexity:    10
reg voi_employed age* n* interacted* _* workingandus kairos*

// exploratory7
// n:               149
// r2:              .15
// adjr2:           .12
// f-complexity:    7
// q-complexity:    3
// note: non-kairos age > kairos age
// note: Udacity age estimate has q = 2 because you must know education count and experience count to get it
reg voi_employed age*

// exploratory8
// n:               149
// r2:              .15
// adjr2:           .12
// f-complexity:    7
// q-complexity:    3
// note: non-kairos age > kairos age
// note: proving it's not just order variables are entered
reg voi_employed agekairos1 agekairos2 agekairos3 age1 age2 age3

// exploratory9
// n:               260
// r2:              .29
// adjr2:           .28
// f-complexity:    4
// q-complexity:    2
// note: non-kairos age > kairos age
reg voi_employed age1 age2 age3

// exploratory10
// n:               212
// r2:              .02
// adjr2:           .11
// f-complexity:    4
// q-complexity:    1
// note: non-kairos age > kairos age
reg voi_employed agekairos*

// d1weakkairos
// n:               103
// r2:              .73
// adjr2:           .37
// f-complexity:    59
// q-complexity:    9
// note: weak factor model, p < .5
reg voi_employed age1 age2 age3 ndet2 ndet3 nedu1 nedu3 nexp2 nlang1 nlang2 nlang3 nnano1 interacted* _lastupdate10 _lastupdate11 _lastupdate7 _samplegroup3 _speaksenglish1 _speaksspanish1 _usstate1 _usstate10 _usstate11 _usstate12 _usstate14 _usstate15 _usstate16 _usstate17 _usstate18 _usstate19 _usstate2 _usstate20 _usstate21 _usstate22 _usstate23 _usstate24 _usstate25 _usstate26 _usstate27 _usstate28 _usstate29 _usstate3 _usstate30 _usstate31 _usstate32 _usstate34 _usstate4 _usstate5 _usstate7 _usstate8 kairos*

// d1maxarkairos
// n:               103
// r2:              .71
// adjr2:           .41
// f-complexity:    52
// q-complexity:    9
reg voi_employed age1 age2 age3 ndet2 ndet3 nedu1 nedu3 nlang2 interacted* _lastupdate10 _lastupdate7 _samplegroup3 _speaksspanish1 _usstate1 _usstate10 _usstate11 _usstate12 _usstate14 _usstate15 _usstate16 _usstate17 _usstate18 _usstate19 _usstate2 _usstate20 _usstate21 _usstate22 _usstate23 _usstate24 _usstate25 _usstate26 _usstate27 _usstate28 _usstate29 _usstate3 _usstate30 _usstate31 _usstate32 _usstate34 _usstate4 _usstate7 _usstate8 kairos*

// d1strongkairos
// n:               197
// r2:              .33
// adjr2:           .32
// f-complexity:    5
// q-complexity:    3
// note: strong factor model, p < .1
// note: _usstate23 = New Jersey
reg voi_employed age1 age2 age3 _usstate23

// d1longlogitkairos
// n:               60
// r2:              1.0 (pseudo)
// adjr2:           n/a
// f-complexity:    114
// q-complexity:    10
logit voi_employed age* n* interacted* _* workingandus kairos*

// d1weaklogitkairos
// n:               114
// r2:              .4 (pseudo)
// adjr2:           n/a
// f-complexity:    22
// q-complexity:    8
// note: I got a perfect prediction with no factors showing z, so I couldn't select which to eliminate
//          then, I reduced from d1weakkairos using iter(1000) and got to here
logit voi_employed age1 age2 age3 ndet2 ndet3 nedu1 nedu3 nlang1 nlang2 interacted* _lastupdate10 _samplegroup3 _usstate19 _usstate2 _usstate27 _usstate7 kairosasian kairosmale kairosmaleconfidence, iter(1000)

// d1mediumlogitkairos
// n:               116
// r2:              .36 (pseudo)
// adjr2:           n/a
// f-complexity:    16
// q-complexity:    8
logit voi_employed age1 age2 age3 ndet3 nedu1 nedu3 nlang1 interacted3 _lastupdate10 _samplegroup3 _usstate19 _usstate2 _usstate27 kairosmale kairosmaleconfidence, iter(1000)

// d1stronglogitkairos
// n:               260
// r2:              .25 (pseudo)
// adjr2:           n/a
// f-complexity:    4
// q-complexity:    2
logit voi_employed age1 age2 age3, iter(1000)
