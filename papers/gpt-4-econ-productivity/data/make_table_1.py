import pandas as pd

# Load CSV files
df_main = pd.read_csv('./main.csv')
doc_data_df = pd.read_csv('./document_data.csv')

# Function to calculate average quality and standard deviation for a group of documents
def calculate_avg_quality_and_std(docs_list, df_main):
    quality_ratings = df_main[['doc{}_rating_quality'.format(doc) for doc in docs_list]].apply(pd.to_numeric, errors='coerce').stack()
    return quality_ratings.mean(), quality_ratings.std()

# Function to calculate average quality rating per topic
def calculate_avg_quality_per_topic(docs_list, df_main, doc_data_df):
    avg_quality_per_topic = {}
    for topic in doc_data_df['Topic'].unique():
        topic_docs = doc_data_df[doc_data_df['Topic'] == topic]['Document']
        relevant_docs = topic_docs[topic_docs.isin(docs_list)]
        if not relevant_docs.empty:
            quality_ratings = df_main[['doc{}_rating_quality'.format(doc) for doc in relevant_docs]].apply(pd.to_numeric, errors='coerce').stack()
            avg_quality_per_topic[topic] = quality_ratings.mean()
    return avg_quality_per_topic

# Splitting the data by author groups
gpt_authored_docs = doc_data_df[doc_data_df['Author'] == 'gpt']['Document']
non_gpt_authored_docs = doc_data_df[doc_data_df['Author'] != 'gpt']['Document']
phd_authors = doc_data_df[doc_data_df['Author_Credentials'] == 'PhD']['Author'].unique()
phd_authored_docs = doc_data_df[doc_data_df['Author'].isin(phd_authors)]['Document']
webservice_authors = ['edubirdie', 'customwritings']
webservice_authored_docs = doc_data_df[doc_data_df['Author'].isin(webservice_authors)]['Document']

# Calculating average quality, standard deviation, and performance spread for each group
groups = {
    'GPT Authors': gpt_authored_docs,
    'Non-GPT Authors': non_gpt_authored_docs,
    'PhD Authors': phd_authored_docs,
    'Webservice Providers': webservice_authored_docs
}

# Printing the markdown table
print('| Author Group | Best Performing Topic | Best Topic Avg. Quality | Worst Performing Topic | Worst Topic Avg. Quality | Performance Spread | Avg. Performance (Std. Dev.) |')
print('|--------------|----------------------|-------------------------|------------------------|--------------------------|--------------------|-----------------------------|')

for group_name, docs in groups.items():
    avg_quality_std = calculate_avg_quality_and_std(docs, df_main)
    avg_quality_per_topic = calculate_avg_quality_per_topic(docs, df_main, doc_data_df)
    best_topic = max(avg_quality_per_topic, key=avg_quality_per_topic.get)
    worst_topic = min(avg_quality_per_topic, key=avg_quality_per_topic.get)
    performance_spread = avg_quality_per_topic[best_topic] - avg_quality_per_topic[worst_topic]

    print(f'| {group_name} | {best_topic} | {avg_quality_per_topic[best_topic]:.2f} | {worst_topic} | {avg_quality_per_topic[worst_topic]:.2f} | {performance_spread:.2f} | {avg_quality_std[0]:.2f} (±{avg_quality_std[1]:.2f}) |')
