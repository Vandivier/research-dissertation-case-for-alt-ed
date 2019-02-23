// note: voi_q1 linear regression analysis
// long, weak, maxar, and strong for voi_q1; also some exploratory regressions

// voiq1long
// n:               188
// r2:              .53
// adjr2:           .30
// f-complexity:    73
// q-complexity:    ?
reg voi_q1 _timedays ismale _collector1 _collector2 _collector3 _collector4 _collector5 _collector6 _stem1 _stem2 _stem3 _region1 _region2 _region3 _region4 _region5 _region6 _region7 _region8 _region9 _industry1 _industry2 _industry3 _industry4 _industry5 _industry6 _industry7 _industry8 _industry9 _industry10 _industry11 _industry12 _heardofcoursera _heardoflynda _heardofpluralsight _heardofudacity _heardofudemy isemployee ismanager isunemployed aq2 aq2squared aq2cubed aq3 aq3squared aq3cubed aq4 aq4squared aq4cubed aq5 aq5squared aq5cubed aq6 aq6squared aq6cubed aq7 aq7squared aq7cubed aq8 aq8squared aq8cubed aq9 aq9squared aq9cubed cage1 cage2 cage3 cincome1 cincome2 cincome3 cprovider1 cprovider2 cprovider3

// voiq1weak
// n:               188
// r2:              .52
// adjr2:           .4
// f-complexity:    39
// q-complexity:    ?
// note: time has no clear effect
reg voi_q1 ismale _stem2 _region1 _region4 _region5 _region7 _region9 _industry7 _industry8 _industry9 _industry12 _heardoflynda _heardofudacity ismanager aq2 aq3 aq3squared aq3cubed aq4 aq4squared aq4cubed aq5squared aq5cubed aq7 aq7squared aq7cubed aq8 aq8squared aq8cubed aq9squared aq9cubed cage1 cage2 cage3 cincome1 cincome2 cprovider1 cprovider2 cprovider3

// voiq1maxar
// n:               188
// r2:              .49
// adjr2:           .42
// f-complexity:    24
// q-complexity:    ?
reg voi_q1 ismale _stem2 _region1 _region7 _region9 _industry8 _industry9 _industry12 _heardoflynda _heardofudacity aq2 aq3squared aq4 aq4squared aq4cubed aq5cubed aq7 aq9cubed cage2 cincome1 cincome2 cprovider1 cprovider2 cprovider3

// voiq1strong
// n:               189
// r2:              .43
// adjr2:           .40
// f-complexity:    12
// q-complexity:    8
// note: cprovider was the longest-lasting nonlinear chain (linear, quadratic, and cubic)
// note: regional and industry effects filtered
// note: aq9 survived to strong model; I think 7,8,9 were new survey questions;
//      this explains sustained low n, seems like throwing out old samples.
reg voi_q1 ismale aq2 aq3squared aq4 aq4squared aq4cubed aq9cubed cage2 cincome1 cincome2 cprovider1 cprovider2
