import pandas as pd
import matplotlib.pyplot as plt

# Load CSV files
df_main = pd.read_csv('./main.csv')
doc_data_df = pd.read_csv('./document_data.csv')

# Identifying economic paper topics (excluding the LLM paper topic)
economic_topics = ['austrian_neoclassical', 'macro_health', 'remote_work']
economic_docs = doc_data_df[doc_data_df['Topic'].isin(economic_topics)]['Document']

# Splitting the data into GPT, PhD, and Master's authored papers
gpt_authored_docs = doc_data_df[doc_data_df['Author'] == 'gpt']['Document']
phd_authors = doc_data_df[doc_data_df['Author_Credentials'] == 'PhD']['Author'].unique()
phd_authored_docs = doc_data_df[doc_data_df['Author'].isin(phd_authors)]['Document']
masters_authored_docs = doc_data_df[(doc_data_df['Author_Credentials'] == 'Masters') | (doc_data_df['Document'] == 6)]['Document']

# Function to extract perceived education level distribution
def get_perceived_edu_level_distribution(docs, df_main):
    perceived_edu_levels = df_main[['doc{}_rating_writer_edu_level'.format(doc) for doc in docs]].stack()
    return perceived_edu_levels.value_counts()

# Getting the distribution of perceived education levels for each group
gpt_perceived_edu_distribution = get_perceived_edu_level_distribution(gpt_authored_docs, df_main)
phd_perceived_edu_distribution = get_perceived_edu_level_distribution(phd_authored_docs, df_main)
masters_perceived_edu_distribution = get_perceived_edu_level_distribution(masters_authored_docs, df_main)

# Labels for the pie charts
labels = ['Undergraduate or Lower (U)', 'Master\'s Level (M)', 'Ph.D. or Higher (P)']

# Creating the pie charts
fig, axs = plt.subplots(1, 3, figsize=(21, 7))
axs[0].pie(gpt_perceived_edu_distribution, labels=labels, autopct='%1.1f%%', startangle=140)
axs[0].set_title('GPT-Authored Papers')

axs[1].pie(phd_perceived_edu_distribution, labels=labels, autopct='%1.1f%%', startangle=140)
axs[1].set_title('Ph.D.-Authored Papers')

axs[2].pie(masters_perceived_edu_distribution, labels=labels, autopct='%1.1f%%', startangle=140)
axs[2].set_title('Master\'s-Authored Papers')

plt.suptitle('Perceived Education Levels for Economic Paper Topics')
plt.show()
