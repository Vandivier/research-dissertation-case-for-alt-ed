do "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\manually-scraped\analysis-0-vars.do"

// d1long
// n:               197
// r2:              .53
// adjr2:           .28
// f-complexity:    102
// q-complexity:    9
reg voi_employed age* n* interacted* _*

// exploratory1
// n:               391
// r2:              .06
// adjr2:           -.01
// f-complexity:    28
// q-complexity:    1
// note: country matters, but it is entirely collinear with other stuff in the long regression
reg voi_employed _country*

// d1weak
// n:               197
// r2:              .52
// adjr2:           .36
// f-complexity:    51
// q-complexity:    7
// note: weak factor model, p < .5
// note: sample effects didn't make it
// note: name truncation effect didn't make it
// note: age effect is overwhelmingly significant and complex
// note: education and nnano still matter
reg voi_employed age1 age2 age3 ndet1 ndet2 nedu1 nedu3 nexp1 nexp2 nexp3 nlang1 nlang2 nnano1 nnano2 nnano3 interacted1 interacted2 interacted3 _lastupdate1 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7 _lastupdate8 _lastupdate9 _speaksenglish1 _speaksother1 _speaksspanish1 _usstate10 _usstate11 _usstate13 _usstate15 _usstate16 _usstate17 _usstate18 _usstate19 _usstate2 _usstate20 _usstate21 _usstate23 _usstate24 _usstate27 _usstate3 _usstate30 _usstate31 _usstate32 _usstate34 _usstate6 _usstate7 _usstate9

// d1maxar
// n:               197
// r2:              .49
// adjr2:           .40
// f-complexity:    30
// q-complexity:    7
// note: alt education had a stronger effect than number of languages spoken, or whether english is spoken
// note: all nanodegree effects were robust to this level, better than any other continous factor except age (interacted is a nnano effect and it's robust to this level too)
reg voi_employed age* ndet1 ndet2 nedu1 nedu3 nexp1 nexp2 nnano1 nnano2 nnano3 interacted1 interacted2 interacted3 _lastupdate1 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7 _lastupdate8 _lastupdate9 _speaksother1 _speaksspanish1 _usstate11 _usstate17 _usstate18 _usstate2 _usstate7

// exploratory2
// n:               260
// r2:              .38
// adjr2:           .32
// f-complexity:    25
// q-complexity:    6
// note: removing states from d1maxar reduces r2 by .1 and makes many factors superweak. So state effects matter.
// note: age and experience effects are robust to state removal.
reg voi_employed age* ndet1 ndet2 nedu1 nedu3 nexp1 nexp2 nnano1 nnano2 nnano3 interacted1 interacted2 interacted3 _lastupdate1 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7 _lastupdate8 _lastupdate9 _speaksother1 _speaksspanish1

// exploratory3
// n:               260
// r2:              .38
// adjr2:           .34
// f-complexity:    16
// q-complexity:    5
// note: standard reduction to max adjr2 leaves only the linear nnano effect, but it's positive!
// note: a cubic negative interaction effect is identified.
// note: from this point on we seem to be removing factors due to low-sample reasons, not unstable coefficient direction reasons
// note: noob effect still present, maybe distinguishable with reanalysis that seperately codes traditional educational units from alternative ones
reg voi_employed age* ndet1 ndet2 nedu1 nedu3 nexp1 nexp2 nnano1 interacted3 _lastupdate10 _lastupdate6 _lastupdate7 _lastupdate8

// exploratory4
// n:               260
// r2:              .37
// adjr2:           .34
// f-complexity:    16
// q-complexity:    5
// note: if you swap the cubic interaction effect for a cubic nnano, r2 is reduced by .01, which is something but not much.
// note: if you swap the cubic interaction effect for a cubic nnano, the cubic effect is directionally similar and significant like the cubic interaction
//          but, the interaction effect is closer to 0. This means the cubic age effect is attenuating the negative cubic on nnano, which is consistent
//          this interpretation is consistent with a positive age cubic effect
//          this indicates the observed interaction is mostly a cubic nnano effect, but it includes a small degree of geniune interaction effect in the same direction.
//          what this means is that although nnano3 was filtered out due to our significance threshold, it is robustly operating in the background. It's still a thing.
//          a structurally correct model should therefore include both nnano3 and interacted4
//          it becomes indefinsible to use a lower model p-threshold because we would be knowingly filtering structurally important findings.
//          so d1maxar is preferred over d1strong, except for those which remain on d1strong are taken to be of course the strongest factors, but non-strongest factors are non-negligible
reg voi_employed age* ndet1 ndet2 nedu1 nedu3 nexp1 nexp2 nnano1 nnano3 _lastupdate10 _lastupdate6 _lastupdate7 _lastupdate8

// d1strong
// n:               197
// r2:              .43
// adjr2:           .38
// f-complexity:    17
// q-complexity:    7
// note: strong factor model, p < .1
// note: linear nnano and nedu effects are absent; somehow the inclusion of states undercuts the importance of linear education effects
// note: age is stupid important; if you aren't including age you aren't studying this right
// note: nedue and nnano both survived, a couple states survived (CA and MI), but the states both had negative effects!
// note: speaksother makes some sense, but I'm surprised at the survival of ndet and lastupdate; interpret ndet to reflect transparency and portfolio diversity
reg voi_employed age* ndet2 nedu3 nexp1 nexp2 nnano2 _lastupdate10 _lastupdate5 _lastupdate6 _lastupdate7 _lastupdate8 _speaksother1 _usstate18 _usstate2

// d1longlogit
// n:               164
// r2:              .45 (pseudo)
// adjr2:           n/a
// f-complexity:    102
// q-complexity:    9
logit voi_employed age* n* interacted* _*

// d1weaklogit
// n:               197
// r2:              .42 (pseudo)
// adjr2:           n/a
// f-complexity:    24
// q-complexity:    7
// note: reproduce non-importance of sample differences and weak survival of nedu, nnano, interacted
logit voi_employed age* ndet3 nedu1 nedu3 nexp1 nexp2 nexp3 nlang1 nlang3 nnano1 interacted1 interacted2 _lastupdate10 _speaksenglish1 _speaksother1 _speaksspanish1 _usstate11 _usstate18 _usstate2 _usstate27 _usstate7

// d1mediumlogit
// n:               197
// r2:              .41 (pseudo)
// adjr2:           n/a
// f-complexity:    21
// q-complexity:    7
// note: medium factor model, p < .3. There is no adjr2 for logit, and this is half between weak and strong.
// note: pure nnano disappeared, although interacted is still here
// note: q-complexity no different from weak model
logit voi_employed age* ndet3 nedu1 nedu3 nexp1 nexp2 nlang1 nlang3 interacted1 interacted2 _lastupdate10 _speaksenglish1 _speaksother1 _speaksspanish1 _usstate11 _usstate18 _usstate2 _usstate7

// d1stronglogit
// n:               197
// r2:              .36 (pseudo)
// adjr2:           n/a
// f-complexity:    12
// q-complexity:    7
// note: neither nnano nore interacted made it, but nedu did.
// note: nedu noob effect reproduced
logit voi_employed age* ndet3 nedu1 nedu3 nexp1 nexp2 _lastupdate10 _speaksother1 _usstate18 _usstate2

// exploratory5
// n:               197
// r2:              .37 (pseudo)
// adjr2:           n/a
// f-complexity:    15
// q-complexity:    7
// note: resinserting nnano1 and interacted3 on the strong model results in strong intertacted3 and superweak nnano1 (p = .517)
//          but, both coefficients are directionally expected. This multi-directional robustness indicates structural
//          correctness with insignificance attributable to sample size
// note: nedu noob effect preserved, nnano non-noob effect preserved.
//          nnano is similar to nexp in this non-noob regard, so maybe larger composition of human capital?
logit voi_employed age* ndet3 nedu1 nedu3 nexp1 nexp2 nnano1 interacted3 _lastupdate10 _speaksother1 _usstate18 _usstate2

// exploratory6
// n:               397
// r2:              .19
// adjr2:           .19
// f-complexity:    1
// q-complexity:    1
// note: just now created this var...good thing it's collinear w/ age1 so I don't have to redo everything.
reg voi_employed workingage
