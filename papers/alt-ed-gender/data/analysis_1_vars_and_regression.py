# ref: some models in statsmodel lib: https://www.statsmodels.org/stable/api.html
# ref: some models in general: https://stackabuse.com/multiple-linear-regression-with-python/
# ref: https://towardsdfscience.com/linear-regression-in-6-lines-of-python-5e1d0cd05b8d
# ref: https://pbpython.com/notebook-alternative.html
# note: why no stata? "...if you use an unauthorized copy it will give you the wrong results without warning..."
#    https://www.econjobrumors.com/topic/there-are-no-stata-14-and-stata-15-torrents
# ref: https://dergipark.org.tr/en/download/article-file/744047

import pandas as pd
import re
# from sklearn.decomposition import PCA
# from statsmodels.iolib.summary2 import summary_col


def fsReformatColumnNames(sColName):
    sMassagedName = sColName.replace(',', '') \
        .replace(' ', '_').replace('-', '_').replace('>', '').replace('+', '') \
        .replace('?', '').replace('.', '') \
        .lower()
    sMassagedName = sMassagedName.replace('_/_', '_')
    sMassagedName = sMassagedName.replace('__', '_')
    return sMassagedName


def getData(dropFirstDummy=True):
    df = pd.read_csv('alt-ed-metasurvey-100821.csv')

    # TODO: split OCEAN, maybe extract value wrangling function
    df = df.replace({
        "Strongly Agree": "10",
        "Strongly Disagree": "1",
        "Very Much": "10",
        "Very Little": "1",
        "Very Impressed": "10",
        "Very Unimpressed": "1",
    })

    df = df.rename(columns=lambda x: re.sub(r'Have you heard of any of the following online course providers\?','familiarity_', x))
    df = df.rename(columns={
        "Age?": "age",
        "Do you contribute to hiring and firing decisions at your company?": "manager_effects",
        "For many professions, alternative credentials can qualify a person for an entry-level position.": "hirability",
        "Gender?": "gender",
        "Government regulation helps ensure businesses treat individuals more fairly.": "worldview_continuous_pro_regulation",
        "Household Income?": "income",
        "How long do you believe it usually takes to obtain an alternative credential?": "expected_duration",
        "I enjoy taking risks": "favor_seeking_risk",
        "I favor freer trade and migration with other nations": "worldview_continuous_pro_foreign",
        "I have a high level of community engagement, participation, or activism related to my worldview.": "worldview_continuous_activism",
        "I prefer to hire or work with a person that has a college degree rather a person that holds a reputable certification or non-college credential.": "is_prefer_college_peer",
        "I think of a career in programming as enjoyable": "favor_programming_career",
        "It will soon become common for high school graduates to obtain alternative credentials instead of going to college.": "expected_conventionality",
        "It will soon become fairly conventional for high school graduates to obtain alternative credentials instead of going to college.": "expected_conventionality",
        "Roughly how many full-time employees currently work for your organization?": "firm_size",
        "To what degree has coronavirus-induced remote activity improved your favorability to remote learning (either for yourself or for other people)?": "covid_fav_online",
        "To what degree has coronavirus caused you to increase your participation in remote learning, remote working, and other remote activities?": "covid_remote",
        "To what degree has coronavirus negatively impacted your life?": "covid_impact",
        "What is the highest level of education you have completed?": "education",
        "What state do you reside in?": "state",
        "When you add up the pros and cons for online education, it's probably a good thing for society overall.": "favor_online_ed",
        "When you add up the pros and cons for artificial intelligence, it's probably a good thing for society overall.": "worldview_continuous_pro_innovation",
        "Which of these industries most closely matches your profession?": "industry",
        "Which race/ethnicity best describes you?": "ethnicity",
        "Which worldview best describes you?": "worldview_description",
    })
    df = df.rename(fsReformatColumnNames, axis='columns')
    df = df.rename(columns=lambda x: re.sub(r'people_who_(.)*break_(.)*present_a_risk(.)*','rulebreakers_risky', x))
    df = df.rename(columns=lambda x: re.sub(r'people_who_(.)*break_(.)*benefit_the_culture(.)*','rulebreakers_culture_value', x))
    df = df.rename(columns=lambda x: re.sub(r'people_who_(.)*break_(.)*could_(.)*be_high_performers(.)*','rulebreakers_mixed_bag', x))
    df = df.rename(columns=lambda x: re.sub(r'if_you_do_contribute_to_hiring_and_firing_decisions_please_write_(.)*','job_title', x))
    df = df.rename(columns=lambda x: re.sub(r'thinking_about_the_job_title_provided_(.)*','job_title_credentials', x))
    df = df.rename(columns=lambda x: re.sub(r'the_level_of','skill', x))
    df = df.rename(columns=lambda x: re.sub(r'the_willingness_to','skill', x))
    df = df.rename(columns=lambda x: re.sub(r'_held_by_a(n)?','', x))
    df = df.rename(columns=lambda x: re.sub(r'non_college_graduate_with_an_alternative_credential','ngwac', x))
    df = df.rename(columns=lambda x: re.sub(r'willingness_to_break_formal_or_informal_rules_and_norms','break_rules', x))
    df = df.rename(columns=lambda x: re.sub(r'attention_to_detail_work_ethic_timeliness_and_organization_of_work','conscientiousness', x))
    df = df.rename(columns=lambda x: re.sub(r'commute_or_travel_to_a_workplace_or_even_as_a_part_of_the_daily_work_as_in_commercial_trucking','commute', x))
    df = df.rename(columns=lambda x: re.sub(r'for_many_professions_learning_at_this_school_can_qualify_a_person_for_an_entry_level_position',
        'school_hirability_', x))

    df['ocean'] = df['ocean'].replace(regex=r'[a-zA-Z\s]*', value='')
    df.loc[df['ocean'].str.count(',') != 4, 'ocean'] = ''

    df[['personality_o',
        'personality_c',
        'personality_e',
        'personality_a',
        'personality_n']] = df['ocean'].str.split(',', n=5, expand=True)

    familiarity_columns = [s for s in df.columns if 'familiarity_' in s]
    favorability_columns = [s for s in df.columns if 'favor_' in s]
    other_column_to_numerize = [
        "expected_conventionality",
        "hirability",
        "is_prefer_college_peer"
    ]
    personality_columns = [s for s in df.columns if 'personality_' in s]
    school_columns = [s for s in df.columns if 'school_hirability_' in s]
    skill_columns = [s for s in df.columns if 'skill_' in s]
    worldview_columns = [s for s in df.columns if 'worldview_continuous_' in s]
    column_names_to_numerize = favorability_columns + other_column_to_numerize + personality_columns + school_columns + skill_columns + worldview_columns
    df[column_names_to_numerize] = df[column_names_to_numerize].apply(pd.to_numeric)

    df['familiarity_count'] = df.apply(lambda row: compute_familiarity_count(row, familiarity_columns), axis='columns')
    df['is_large_firm_size'] = df.apply(compute_is_large_firm_size, axis='columns')
    df['is_serious'] = df.apply(compute_fraud_flag, axis='columns')
    df['is_tech'] = df.industry == "Information Technology"
    df['school_unaccredited_hirability'] = df.school_hirability_ + df.school_hirability_1 + df.school_hirability_2 + df.school_hirability_3
    df['school_self_impressed'] = df.school_hirability_2 + df.school_hirability_3 + df.school_hirability_6 + df.school_hirability_7
    df['school_other_impressed'] = df.school_hirability_1 + df.school_hirability_3 + df.school_hirability_5 + df.school_hirability_7

    compute_skill_gaps(df, skill_columns)

    # df = pd.get_dummies(df, columns=['industry']).rename(
    #     fsReformatColumnNames, axis='columns')
    # if dropFirstDummy:
    #     df.drop(columns=['industry_agriculture''])

    # help build long model formula
    print("\n+ ".join(list(df.columns)))

    print("\n---")
    print("done getting data")
    print("---\n")
    return df


def compute_familiarity_count(row, familiarity_columns):
    total = 0
    for column in familiarity_columns:
        curr_value = row[column]
        if not pd.isnull(curr_value):
            total += 1

    return total


def compute_fraud_flag(row=None):
    # rudimentary fraud detection algo: if they put the same answer every time for skills, consider it fraud
    # compute suspected fraud response value as average of first 3 skill questions
    # give an allowance of varied answers up to arbitrarily threshold, still call it fraud
    # tuned based on manual input data review, threshold = 3 (like, 3 is OK, less is fraud)
    allowance_remaining = 2
    count_done = 0
    sus_skill_value = 0

    for column in row.index:
        if re.match("skill_", column):
            curr_value = row[column]

            # > 0 is a quick NaN check
            if curr_value > 0:
                if count_done < 3:
                    sus_skill_value += curr_value
                    count_done += 1
                elif count_done == 3:
                    # get average of first three
                    sus_skill_value = sus_skill_value / 3
                    count_done += 1
                elif count_done > 3:
                    if curr_value != sus_skill_value:
                        allowance_remaining -= 1
                        if allowance_remaining < 1:
                            return True

    if sus_skill_value == 0:
        return True
    else:
        return False

def compute_is_large_firm_size(row=None):
    if row.firm_size in ["501-1,000", "1,001-5,000", "5,001-10,000", "10,000+"]:
        return True
    return False

def compute_skill_gaps(df, skill_columns):
    ideal_substring = "_ideal_job_applicant"

    alt_ed_individual_levels = [s for s in df.columns if '_ngwac' in s]
    college_grad_levels = [s for s in df.columns if 'recent_college_graduate' in s]
    ideal_levels = [s for s in df.columns if ideal_substring in s]

    for ideal_skill_name in ideal_levels:
        # eg skill_commute_ideal_job_applicant -> skill_commute
        skill_name, *ignored = ideal_skill_name.split(ideal_substring)
        # ideal - alt_ed_individual_levels[index]
        df["aetiwo" + "_" + skill_name] = 0
        # df.apply(lambda row: compute_familiarity_count(row, familiarity_columns), axis='columns')
        # aetiwno = Math.max(aetiwo, 0)
        # rcgtiwo = ideal - college_grad_levels[index]
        # rcgtiwno = Math.max(aetiwo, 0)

# drop out-of-quartile to reduce skew
# intended to reduce skew and kurtosis
# tradeoff is analytical restriction (hopefully unimportant)
def getDeskewedData(dropFirstDummy=True):
    df = getData(dropFirstDummy)

    # drop Other gender bc n=2 is too small (maybe revisit here or in seperate analysis if over say a dozen)
    df = df[df.gender != "Other"]
    df = df[df.is_serious == True]

    return df.drop(df[df['hirability'] < 5].index)


def getLowHirabilityGroup(dropFirstDummy=True):
    df = getData(dropFirstDummy)
    return df.drop(df[df['hirability'] >= 5].index)


def getTens(dropFirstDummy=True):
    df = getData(dropFirstDummy)
    return df.drop(df[df['hirability'] < 10].index)

# if this file executed as script
if __name__ == '__main__':
    skewedData = getData(False)
    skewedData.to_csv('./alt-ed-metasurvey-wrangled.csv')

    # TODO: touch faster if we implement deskewed as f(skewed)
    deskewedData = getDeskewedData(False)
    deskewedData.to_csv('./alt-ed-metasurvey-wrangled-deskewed.csv')
