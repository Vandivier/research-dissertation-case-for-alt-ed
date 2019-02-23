// TODO: recheck all regressions, esp logits, with this analysis-0
//          remove anachronisms like age* in analysis-1
//          add vars again before every logit/probit bc they get dropped obs in stata sometimes

clear

//import delimited C:\Users\john.vandivier\workspace\data-science-practice\js\udacity-study\manually-scraped\manually-scraped-results.csv
import delimited D:\GitHub\data-science-practice\js\udacity-study\manually-scraped\manually-scraped-results.csv

// base vars
tab samplegroup, gen(_samplegroup)
tab country, gen(_country)
tab usstate, gen(_usstate)
// TODO: make continuous and dummy out 9 months
// TODO: shouldn't last updated date be from date of scrape, not from date of analysis (scrapes happen over multiple days)
tab monthssincelast, gen(_lastupdate)

tab presently, gen(voi_employed)
replace voi_employed = 0 if voi_employed != 1
tab nametruncated, gen(_nametruncated)
replace _nametruncated = 0 if _nametruncated != 1
tab speaksenglish, gen(_speaksenglish)
replace _speaksenglish = 0 if _speaksenglish != 1
tab speaksspanish, gen(_speaksspanish)
replace _speaksspanish = 0 if _speaksspanish != 1
tab speaksother, gen(_speaksother)
replace _speaksother = 0 if _speaksother != 1

replace countofudacitynanodegree = 0 if missing(countofudacitynanodegree)
replace countofudacityinformationdetails = 0 if missing(countofudacityinformationdetails)
replace countofudacityeducationentries = 0 if missing(countofudacityeducationentries)
replace countofudacityexperienceentries = 0 if missing(countofudacityexperienceentries)
replace countlanguages = 0 if missing(countlanguages)

gen age1 = age
gen age2 = age1*age1
gen age3 = age1*age1*age1
gen nnano1 = countofudacitynanodegree
gen nnano2 = nnano1*nnano1
gen nnano3 = nnano1*nnano1*nnano1
gen ndet1 = countofudacityinformationdetails
gen ndet2 = ndet1*ndet1
gen ndet3 = ndet1*ndet1*ndet1
gen nedu1 = countofudacityeducationentries
gen nedu2 = nedu1*nedu1
gen nedu3 = nedu1*nedu1*nedu1
gen nexp1 = countofudacityexperienceentries
gen nexp2 = nexp1*nexp1
gen nexp3 = nexp1*nexp1*nexp1
gen nlang1 = countlanguages
gen nlang2 = nlang1*nlang1
gen nlang3 = nlang1*nlang1*nlang1
gen interacted1 = age1*nnano1
gen interacted2 = interacted1*interacted1
gen interacted3 = interacted1*interacted1*interacted1

gen workingage = 0
replace workingage = 1 if age1 >= 16
replace workingage = 0 if missing(age1)

gen workingandusperson = workingage
replace workingandusperson = 0 if _country27 == 0

drop ageestimated
drop name*

// kairos vars
tab imagerejected, gen(_imagerejected)
replace _imagerejected = 0 if _imagerejected != 1
tab imagesubmitted, gen(_imagesubmitted)
replace _imagesubmitted = 0 if _imagesubmitted != 1

gen kairosmale = 0
replace kairosmale = 1 if kairosmaleconfidence > .5
gen agekairos1 = kairosage
gen agekairos2 = agekairos1*agekairos1
gen agekairos3 = agekairos1*agekairos1*agekairos1

drop kairosage

//github vars
tab githubaccountclaimedonudacitypro, gen(_githubclaimed)
replace _githubclaimed = 0 if missing(_githubclaimed)
tab githubaccountfoundandscraped, gen(_githubfound)
replace _githubfound = 0 if missing(_githubfound)

// TODO: these factors are expected to interact as well
gen _githubcommits1 = githubannualcommits
gen _githubcommits2 = _githubcommits1*_githubcommits1
gen _githubcommits3 = _githubcommits1*_githubcommits1*_githubcommits1
gen _githubfollowers1 = githubfollowercount
gen _githubfollowers2 = _githubfollowers1*_githubfollowers1
gen _githubfollowers3 = _githubfollowers1*_githubfollowers1*_githubfollowers1
gen _githubrepos1 = githubrepocount
gen _githubrepos2 = _githubrepos1*_githubrepos1
gen _githubrepos3 = _githubrepos1*_githubrepos1*_githubrepos1
gen _githubinteractedrepocommit1 = _githubrepos1*_githubcommits1
gen _githubinteractedrepocommit2 = _githubinteractedrepocommit1*_githubinteractedrepocommit1
gen _githubinteractedrepocommit3 = _githubinteractedrepocommit1*_githubinteractedrepocommit1*_githubinteractedrepocommit1
gen _githubinteractedrepofollower1 = _githubrepos1*_githubfollowers1
gen _githubinteractedrepofollower2 = _githubinteractedrepofollower1*_githubinteractedrepofollower1
gen _githubinteractedrepofollower3 = _githubinteractedrepofollower1*_githubinteractedrepofollower1*_githubinteractedrepofollower1
