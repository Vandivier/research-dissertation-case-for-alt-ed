clear

// modified file drops subtitle row, unneeded columns, and convert "Strongly Agree" to 10
import delimited "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\classifier-survey-data\Classifier Accuracy via Self-Check\CSV\Classifier Accuracy via Self-Check_modified.csv"

tab doyoucontributetohiringandfiring, gen(_hiring)
tab formanyprofessionsalternativecre, gen(_alternative)
tab whichbestdescribesyourethnicity, gen(_ethnicity)
tab doyoubelievethatyourlastnamerefl, gen(_lastnamereflects)
tab whichoftheseindustriesmostclosel, gen(_industry)
tab gender, gen(_gender)
tab region, gen(_region)

gen _age1 = whatisyourage
gen _age2 = _age1*_age1
gen _age3 = _age1*_age1*_age1
gen male = _gender2
gen voi_agree = _lastnamereflects2

// finding 1. about 50% of people agree with NamePrism
sum voi_agree

// finding 2. no significant relations in small sample.
reg voi_agree male _age1 _region* _eth*

// logit is better because _const makes sense
logit voi_agree male _age1 _region* _eth*

// probit has slightly better pseudo r2, .0871
probit voi_agree male _age1 _region* _eth*

// yo dog, age marginal effect matters
// preferred model, pseudo-r = .1085
probit voi_agree male _age1 _age2 _region* _eth*

// not so much the cubic
probit voi_agree male _age* _region* _eth*

// m3. bring back linear to facilitate interpretation
reg voi_agree male _age1 _age2 _region* _eth*
