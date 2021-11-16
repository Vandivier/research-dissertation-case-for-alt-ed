# questions:
# q1 - are US programmers less formally educated?
# q2 - do US programmers and/or US fem progs tend to have less relevant ("traditional") degrees?
# q3 - among US programmers, even w trad degrees, do women stay away from comp sci? (eg prefer "Information Technology" or "Web Development", etc)
# q4 - is there an important difference by gender within Computer science, computer engineering, or software engineering

import pandas as pd

df = pd.read_csv('stack-overflow-survey-2020-country-us.csv')

less_than_some_college_values = ['Secondary school (e.g. American high school, German Realschule or Gymnasium, etc.)',
    'Primary/elementary school',
    'I never completed any formal education']

df_somecollege = df[~df['EdLevel'].isin(less_than_some_college_values)]

# Computer science, computer engineering, or software engineering
# SO 2020 global - 62.6%
#
# Another engineering discipline (such as civil, electrical, mechanical, etc.)
# SO 2020 global - 9.3%
#
# Information systems, information technology, or system administration
# SO 2020 global - 7.9%
#
# A natural science (such as biology, chemistry, physics, etc.)
# SO 2020 global - 4.4%
#
# Mathematics or statistics
# SO 2020 global - 3.6%
#
# Web development or web design
# SO 2020 global - 3.3%
#
# A business discipline (such as accounting, finance, marketing, etc.)
# SO 2020 global - 2.6%
#
# A humanities discipline (such as literature, history, philosophy, etc.)
# SO 2020 global - 2.0%
#
# A social science (such as anthropology, psychology, political science, etc.)
# SO 2020 global - 1.8%
#
# Fine arts or performing arts (such as graphic design, music, studio art, etc.)
# SO 2020 global - 1.4%
#
# I never declared a major
# SO 2020 global - 0.7%
#
# A health science (such as nursing, pharmacy, radiology, etc.)
# SO 2020 global - 0.4%

# result log:
# df_cs percent of US people: 55.89710050141705
# df_cs percent male: 80.96723868954759
# df_other_eng percent of US people: 6.649226073686505
# df_other_eng percent male: 84.26229508196721
# df_other_it percent of US people: 5.962502725092653
# df_other_it percent male: 82.08409506398537
# df_natural_science percent of US people: 4.425550468715937
# df_natural_science percent male: 72.66009852216749
# df_math percent of US people: 3.564421190320471
# df_math percent male: 76.14678899082568
# df_webdev percent of US people: 2.0819707870067585
# df_webdev percent male: 74.3455497382199
# df_business percent of US people: 3.1502071070416395
# df_business percent male: 76.12456747404845
# df_humanities percent of US people: 3.8587311968606928
# df_humanities percent male: 63.84180790960452
# df_social_science percent of US people: 3.172007848266841
# df_social_science percent male: 68.04123711340206
# df_art percent of US people: 3.0848048833660346
# df_art percent male: 66.07773851590106
# df_undeclared percent of US people: 1.1772400261608895
# df_undeclared percent male: 86.11111111111111
# df_health_science percent of US people: 0.27250926531502073
# df_health_science percent male: 56.00000000000001

print("df_cs percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('Computer science, computer engineering, or software engineering').mean()))
df_cs = df_somecollege[df_somecollege.UndergradMajor == 'Computer science, computer engineering, or software engineering']
print("df_cs percent male: " + str(100 * df_cs['Gender'].eq('Man').mean()))

print("df_other_eng percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('Another engineering discipline (such as civil, electrical, mechanical, etc.)').mean()))
df_other_eng = df_somecollege[df_somecollege.UndergradMajor == 'Another engineering discipline (such as civil, electrical, mechanical, etc.)']
print("df_other_eng percent male: " + str(100 * df_other_eng['Gender'].eq('Man').mean()))

print("df_other_it percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('Information systems, information technology, or system administration').mean()))
df_other_it = df_somecollege[df_somecollege.UndergradMajor == 'Information systems, information technology, or system administration']
print("df_other_it percent male: " + str(100 * df_other_it['Gender'].eq('Man').mean()))

print("df_natural_science percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('A natural science (such as biology, chemistry, physics, etc.)').mean()))
df_natural_science = df_somecollege[df_somecollege.UndergradMajor == 'A natural science (such as biology, chemistry, physics, etc.)']
print("df_natural_science percent male: " + str(100 * df_natural_science['Gender'].eq('Man').mean()))

print("df_math percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('Mathematics or statistics').mean()))
df_math = df_somecollege[df_somecollege.UndergradMajor == 'Mathematics or statistics']
print("df_math percent male: " + str(100 * df_math['Gender'].eq('Man').mean()))

print("df_webdev percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('Web development or web design').mean()))
df_webdev = df_somecollege[df_somecollege.UndergradMajor == 'Web development or web design']
print("df_webdev percent male: " + str(100 * df_webdev['Gender'].eq('Man').mean()))

print("df_business percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('A business discipline (such as accounting, finance, marketing, etc.)').mean()))
df_business = df_somecollege[df_somecollege.UndergradMajor == 'A business discipline (such as accounting, finance, marketing, etc.)']
print("df_business percent male: " + str(100 * df_business['Gender'].eq('Man').mean()))

print("df_humanities percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('A humanities discipline (such as literature, history, philosophy, etc.)').mean()))
df_humanities = df_somecollege[df_somecollege.UndergradMajor == 'A humanities discipline (such as literature, history, philosophy, etc.)']
print("df_humanities percent male: " + str(100 * df_humanities['Gender'].eq('Man').mean()))

print("df_social_science percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('A social science (such as anthropology, psychology, political science, etc.)').mean()))
df_social_science = df_somecollege[df_somecollege.UndergradMajor == 'A social science (such as anthropology, psychology, political science, etc.)']
print("df_social_science percent male: " + str(100 * df_social_science['Gender'].eq('Man').mean()))

print("df_art percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('Fine arts or performing arts (such as graphic design, music, studio art, etc.)').mean()))
df_art = df_somecollege[df_somecollege.UndergradMajor == 'Fine arts or performing arts (such as graphic design, music, studio art, etc.)']
print("df_art percent male: " + str(100 * df_art['Gender'].eq('Man').mean()))

print("df_undeclared percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('I never declared a major').mean()))
df_undeclared = df_somecollege[df_somecollege.UndergradMajor == 'I never declared a major']
print("df_undeclared percent male: " + str(100 * df_undeclared['Gender'].eq('Man').mean()))

print("df_health_science percent of US people: " + str(100 * df_somecollege['UndergradMajor'].eq('A health science (such as nursing, pharmacy, radiology, etc.)').mean()))
df_health_science = df_somecollege[df_somecollege.UndergradMajor == 'A health science (such as nursing, pharmacy, radiology, etc.)']
print("df_health_science percent male: " + str(100 * df_health_science['Gender'].eq('Man').mean()))
