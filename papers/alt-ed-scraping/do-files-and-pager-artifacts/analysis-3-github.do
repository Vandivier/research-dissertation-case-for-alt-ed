do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\manually-scraped\analysis-0-vars.do"

// exploratory11
// n:               175
// r2:              .13
// adjr2:           .05
// f-complexity:    18
// q-complexity:    3
// note: repositories matter, but fewer high quality repos are better than many repos.
reg voi _git*

// exploratory12
// n:               175
// r2:              .27
// adjr2:           .2
// f-complexity:    18
// q-complexity:    3
// note: inverse regression run to compare normalized associations
//          decidedly non-causal or reverse-causal (eg nnano causes commits)
// note: strongly related to the number of commits and repos, but not their interaction
//      i read that like a multi-dimensional indada condition, and that as someone has
//      more commits and repos, they are linearly less likely to have had a nanodegree,
//      which amounts to credibility for a nanodegree on the fewer-and-better repo as quality
// note: another reading. People with many repos at few commits per repo or few repos
//      at many commits per repo are more likely to have a nanodegree than people with many
//      commits on many repos
// note: or maybe idk wtf i'm talking about
reg nnan*1 _git*

// d1longgithub
// n:               59
// r2:              1
// adjr2:           n/a
// f-complexity:    132
// q-complexity:    13
reg voi_employed age* n* interacted* _* workingandus kairos*

// d1weakgithub
// n:               66
// r2:              .98
// adjr2:           .92
// f-complexity:    52
// q-complexity:    11
// note: weak factor model, p < .5
// note: long was unreducible (factor reduction undecidable), so start from d1weakkairos + _git*
//          but, that was undecidable too. Decidable models included (d1weak or d1strongkairos) + _git*
//          the former had r2 = .98 and the latter r2 = .35, so clearly prefer former
//          then reduce until p satistfied.
reg voi_employed age* ndet1 nedu1 nedu3 nexp1 nexp2 nexp3 nlang1 nlang2 nnano1 nnano3 interacted1 interacted2 interacted3 _lastupdate1 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7  _speaksenglish1 _speaksother1 _speaksspanish1 _usstate10 _usstate11 _usstate16 _usstate17 _usstate18 _usstate2 _usstate20 _usstate21 _usstate24 _usstate3 _usstate31 _usstate34 _githubrepos3 _githubrepos2 _githubinteractedrepofollower3 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubfollowers3 _githubfollowers2 _githubfollowers1 _githubcommits3 _githubcommits2

// d1maxargithub
// n:               66
// r2:              .98
// adjr2:           .92
// f-complexity:    51
// q-complexity:    11
reg voi_employed age* ndet1 nedu1 nedu3 nexp1 nexp2 nexp3 nlang1 nlang2 nnano1 nnano3 interacted1 interacted2 interacted3 _lastupdate1 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7  _speaksenglish1 _speaksother1 _speaksspanish1 _usstate10 _usstate11 _usstate16 _usstate17 _usstate18 _usstate2 _usstate20 _usstate24 _usstate3 _usstate31 _usstate34 _githubrepos3 _githubrepos2 _githubinteractedrepofollower3 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubfollowers3 _githubfollowers2 _githubfollowers1 _githubcommits3 _githubcommits2

// d1stronggithub
// n:               66
// r2:              .97
// adjr2:           .91
// f-complexity:    46
// q-complexity:    11
// note: strong factor model, p < .1
// note: I tested adding kairos* and all factors were superweak
//          but wait! age* includes agekairos*...this is an anacronism onto analysis-1 bc it didn't exist.
//          so, we will run a 2 whole other set without agekairos*. One starting now and one from scratch.
reg voi_employed age* ndet1 nedu1 nedu3 nexp1 nexp2 nexp3 nlang1 nlang2 nnano1 nnano3 interacted1 interacted2 interacted3 _lastupdate1 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7  _speaksenglish1 _speaksother1 _speaksspanish1 _usstate11 _usstate16 _usstate17 _usstate18 _usstate2 _usstate3 _githubrepos3 _githubrepos2 _githubinteractedrepofollower3 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubfollowers3 _githubfollowers2 _githubfollowers1 _githubcommits3 _githubcommits2

// d2weakgithub
// n:               94
// r2:              .62
// adjr2:           .42
// f-complexity:    33
// q-complexity:    10
// note: weak factor model, p < .5
// note: start with d1stronggithub without agekairos* and reduce
// note: edu vanished but nnano, interacted, and _git* remain in this weak forward test
reg voi_employed age1 age2 age3 ndet1 nexp1 nexp2 nexp3 nnano1 nnano3 interacted1 interacted2 interacted3 _lastupdate10 _lastupdate6 _lastupdate7  _speaksother1 _usstate11 _usstate17 _usstate18 _usstate2 _usstate3 _githubrepos3 _githubrepos2 _githubinteractedrepofollower3 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubfollowers3 _githubfollowers2 _githubfollowers1 _githubcommits2

// d2maxargithub
// n:               94
// r2:              .61
// adjr2:           .44
// f-complexity:    28
// q-complexity:    9
// note: notice here that portfolio + alt ed out-survive edu and exp!
// note: notice here that this model can be applied to someone who has never had professional experience!
// note: notice here that nnano1 is negative! githubfollowers are the best indicator of employment...but that may not be a pure skill signal
reg voi_employed age1 age2 age3 ndet1 nnano1 interacted1 interacted2 interacted3 _lastupdate10 _lastupdate6 _lastupdate7  _speaksother1 _usstate11 _usstate17 _usstate18 _usstate3 _githubrepos3 _githubrepos2 _githubinteractedrepofollower3 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubfollowers3 _githubfollowers2 _githubfollowers1 _githubcommits2

// d2stronggithub
// n:               94
// r2:              .56
// adjr2:           .43
// f-complexity:    21
// q-complexity:    9
// note: strong factor model, p < .1
// note: interacted has a negative effect. Age and followers are positive signals; repos has a sweet spot.
reg voi_employed age1 age2 age3 ndet1 interacted2 _lastupdate10 _speaksother1 _usstate11 _usstate17 _usstate18 _githubrepos3 _githubrepos2 _githubinteractedrepofollower3 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubfollowers3 _githubfollowers2 _githubfollowers1

// d3longgithub
// n:               94
// r2:              .82
// adjr2:           .27
// f-complexity:    121
// q-complexity:    12
reg voi_employed age1 age2 age3 n* interacted* _*

// d3weakgithub
// n:               94
// r2:              .81
// adjr2:           .54
// f-complexity:    56
// q-complexity:    11
// note: weak factor model, p < .5
reg voi_employed age1 age2 age3 nnano1 nlang3 nlang2 nlang1 nexp1 nedu1 ndet3 ndet2 ndet1 interacted* _usstate8 _usstate7 _usstate34 _usstate32 _usstate31 _usstate30 _usstate3 _usstate28 _usstate27 _usstate26 _usstate24 _usstate22 _usstate21 _usstate20 _usstate2 _usstate19 _usstate18 _usstate17 _usstate16 _usstate14 _usstate12 _usstate11 _usstate10 _usstate1 _speaksother1 _lastupdate7 _lastupdate6 _lastupdate5 _lastupdate1 _githubrepos2 _githubrepos1 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubinteractedrepocommit1 _githubfollowers3 _githubfollowers1 _githubcommits2 _githubcommits1

// d3maxargithub
// n:               94
// r2:              .80
// adjr2:           .55
// f-complexity:    53
// q-complexity:    9
// note: weak factor model, p < .5
reg voi_employed age1 age2 age3 nnano1 nlang3 nlang2 nlang1 ndet3 ndet2 ndet1 interacted* _usstate8 _usstate7 _usstate34 _usstate32 _usstate31 _usstate30 _usstate3 _usstate28 _usstate27 _usstate26 _usstate24 _usstate22 _usstate21 _usstate20 _usstate2 _usstate19 _usstate18 _usstate17 _usstate16 _usstate14 _usstate12 _usstate11 _usstate10 _usstate1 _lastupdate7 _lastupdate6 _lastupdate5 _lastupdate1 _githubrepos2 _githubrepos1 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubinteractedrepocommit1 _githubfollowers3 _githubfollowers1 _githubcommits2 _githubcommits1

// d3stronggithub
// n:               66
// r2:              .97
// adjr2:           .91
// f-complexity:    46
// q-complexity:    3
// note: strong factor model, p < .1
// note: nnano has strong neg linear survivor
// note: try appending kairos* and see negative white and asian effect
reg voi_employed age1 age2 age3 nnano1 nlang3 nlang2 ndet3 ndet2 ndet1 interacted* _usstate8 _usstate7 _usstate34 _usstate32 _usstate31 _usstate30 _usstate3 _usstate28 _usstate27 _usstate26 _usstate24 _usstate22 _usstate21 _usstate20 _usstate2 _usstate19 _usstate18 _usstate17 _usstate16 _usstate14 _usstate12 _usstate11 _usstate10 _usstate1 _lastupdate7 _lastupdate1 _githubrepos2 _githubrepos1 _githubinteractedrepofollower2 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubinteractedrepocommit1 _githubfollowers3 _githubcommits2 _githubcommits1

// exploratory13
// n:               122
// r2:              .24
// adjr2:           .09
// f-complexity:    21
// q-complexity:    6
// note: githubfollowers explains employment better than age! way better than nexp or nedu
reg voi_employed nedu* nexp* _githubcom* _githubfol* _githubrep* age1 age2 age3

// d3longlogitgithub
// n:               76
// r2:              1.0 (pseudo)
// adjr2:           n/a
// f-complexity:    ?
// q-complexity:    ?
// note: starting with all is undecidable, so start from weak d3weakgithub
//      but, same issue, so go to d3maxargithub
// note: cutting one is undecidable, so cut all above .9 for first round.
do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\manually-scraped\analysis-0-vars.do"
logit voi_employed age1 age2 age3 nnano1 nlang3 nlang2 nlang1 ndet3 ndet2 ndet1 interacted* _usstate8 _usstate7 _usstate34 _usstate32 _usstate31 _usstate30 _usstate3 _usstate28 _usstate27 _usstate26 _usstate24 _usstate22 _usstate21 _usstate20 _usstate2 _usstate19 _usstate18 _usstate17 _usstate16 _usstate14 _usstate12 _usstate11 _usstate10 _usstate1 _lastupdate7 _lastupdate6 _lastupdate5 _lastupdate1 _githubrepos2 _githubrepos1 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubinteractedrepocommit1 _githubfollowers3 _githubfollowers1 _githubcommits2 _githubcommits1, iter(1000)

// d3weaklogitgithub
// n:               287
// r2:              .17 (pseudo)
// adjr2:           n/a
// f-complexity:    12
// q-complexity:    2
// note: so it's all state effects. cool.
do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\manually-scraped\analysis-0-vars.do"
logit voi_employed nlang2 _usstate8 _usstate30 _usstate3 _usstate28 _usstate27 _usstate21 _usstate2 _usstate19 _usstate18 _usstate1, iter(1000)

// d3longprobitgithub
// n:               76
// r2:              1.0 (pseudo)
// adjr2:           n/a
// f-complexity:    ?
// q-complexity:    ?
// note: gives same result as the logit reduction - it's all state effects
probit voi_employed age1 age2 age3 nnano1 nlang3 nlang2 nlang1 ndet3 ndet2 ndet1 interacted* _usstate8 _usstate7 _usstate34 _usstate32 _usstate31 _usstate30 _usstate3 _usstate28 _usstate27 _usstate26 _usstate24 _usstate22 _usstate21 _usstate20 _usstate2 _usstate19 _usstate18 _usstate17 _usstate16 _usstate14 _usstate12 _usstate11 _usstate10 _usstate1 _lastupdate7 _lastupdate6 _lastupdate5 _lastupdate1 _githubrepos2 _githubrepos1 _githubinteractedrepofollower2 _githubinteractedrepofollower1 _githubinteractedrepocommit3 _githubinteractedrepocommit2 _githubinteractedrepocommit1 _githubfollowers3 _githubfollowers1 _githubcommits2 _githubcommits1, iter(1000)
