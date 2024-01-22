import pandas as pd
from scipy.stats import chi2_contingency

# Load data
df_main = pd.read_csv('./main.csv')
doc_data_df = pd.read_csv('./document_data.csv')

# Re-identifying the groups and topics
economic_topics = ['austrian_neoclassical', 'macro_health', 'remote_work']
economic_docs = doc_data_df[doc_data_df['Topic'].isin(economic_topics)]['Document']

phd_authors = doc_data_df[doc_data_df['Author_Credentials'] == 'PhD']['Author'].unique()
phd_authored_docs = doc_data_df[doc_data_df['Author'].isin(phd_authors)]['Document']
masters_authored_docs = doc_data_df[(doc_data_df['Author_Credentials'] == 'Masters') | (doc_data_df['Document'] == 6)]['Document']

# Re-extracting the distribution of perceived education levels for each group
def get_perceived_edu_level_distribution(docs, df_main):
    perceived_edu_levels = df_main[['doc{}_rating_writer_edu_level'.format(doc) for doc in docs]].stack()
    return perceived_edu_levels.value_counts()

phd_perceived_edu_distribution = get_perceived_edu_level_distribution(phd_authored_docs, df_main)
masters_perceived_edu_distribution = get_perceived_edu_level_distribution(masters_authored_docs, df_main)

# Creating the contingency table and performing the chi-square test
contingency_table = pd.DataFrame({
    'PhD': phd_perceived_edu_distribution,
    'Masters': masters_perceived_edu_distribution
}).fillna(0)

chi2, p, dof, expected = chi2_contingency(contingency_table)

chi2, p
