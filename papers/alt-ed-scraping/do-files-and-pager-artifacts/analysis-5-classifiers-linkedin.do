clear

import delimited "D:\GitHub\data-science-practice\stata\udacity-exploratory-analysis\classifier-survey-data\classifier-via-linkedin-pooled.csv"

tab doyoucontributetohiringandfiring, gen(_hiring)
tab formanyprofessionsalternativecre, gen(_alternative)
tab whichbestdescribesyourethnicity, gen(_ethnicity)
tab doyoubelievethatyourlastnamerefl, gen(_lastnamereflects)
tab whichoftheseindustriesmostclosel, gen(_industry)
tab wheredoyoulive, gen(_region)
tab whatisyourgender, gen(_gender)

// todo: nameprism gender
// todo: linkedin gender

gen _age = whatisyourage

// finding 1. 34% of people do not believe lastnamereflects
sum _lastnamereflects*

// finding 2. no significant relations in small sample.
reg _lastnamereflects*1 _gender*  _region*


