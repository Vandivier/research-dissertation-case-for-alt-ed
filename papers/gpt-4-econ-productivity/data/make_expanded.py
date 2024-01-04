import pandas as pd

def create_expanded_dataset(main_file_path, doc_data_file_path, output_file_path):
    # Load the datasets
    df_main = pd.read_csv(main_file_path)
    df_doc_data = pd.read_csv(doc_data_file_path)

    # Number of documents
    num_docs = 18

    # Maps for new columns
    author_to_participant_id_map = {
        'b': '31',
        't': '29',
        'p': '28'
    }

    topic_to_march_gpt_model_map = {
        'macro_health': True,
        'remote_work': True
    }

    # List to hold expanded data
    expanded_data = []

    # Iterate over each row in the main dataframe
    for index, row in df_main.iterrows():
        participant_id = row['participant_id']
        participant_education = row['education_lvl']
        participant_with_econ_degree = row['with_econ_degree']
        participant_attention = row['reported_attention']
        for doc_id in range(1, num_docs + 1):
            # Extracting data for each document
            quality_rating_col = f'doc{doc_id}_rating_quality'
            edu_level_col = f'doc{doc_id}_rating_writer_edu_level'
            gpt_likelihood_col = f'doc{doc_id}_rating_gpt_author'
            quality_rating = row.get(quality_rating_col, None)
            assessed_writer_edu_level = row.get(edu_level_col, None)
            assessed_gpt_likelihood = row.get(gpt_likelihood_col, None)

            # Fetch document-specific data
            doc_data = df_doc_data[df_doc_data['Document'] == doc_id]
            topic, author, author_credentials = None, None, None
            if not doc_data.empty:
                topic = doc_data.iloc[0]['Topic']
                author = doc_data.iloc[0]['Author']
                author_credentials = doc_data.iloc[0]['Author_Credentials']

            # Calculate new boolean columns
            is_participant_the_author = author_to_participant_id_map.get(author, '') == str(participant_id)
            is_march_gpt_model = topic_to_march_gpt_model_map.get(topic, False)
            is_written_by_gpt = author == 'gpt'
            participant_expects_gpt = assessed_gpt_likelihood and assessed_gpt_likelihood >= 6

            # Add a row for each document
            expanded_data.append({
                'participant_id': participant_id,
                'participant_assessed_writer_edu_level': assessed_writer_edu_level,
                'participant_assessed_gpt_likelihood': assessed_gpt_likelihood,
                'participant_education': participant_education,
                'participant_with_econ_degree': participant_with_econ_degree,
                'participant_attention': participant_attention,
                'doc_id': doc_id,
                'quality_rating': quality_rating,
                'topic': topic,
                'author': author,
                'author_credentials': author_credentials,
                'is_participant_the_author': is_participant_the_author,
                'is_march_gpt_model': is_march_gpt_model,
                'is_written_by_gpt': is_written_by_gpt,
                'participant_expects_gpt': participant_expects_gpt
            })

    # Convert expanded data to DataFrame
    df_expanded = pd.DataFrame(expanded_data)

    # Save the expanded dataset to a CSV file
    df_expanded.to_csv(output_file_path, index=False)

# File paths
main_file_path = './main.csv'
doc_data_file_path = './document_data.csv'
output_file_path = './expanded.csv'

# Create the expanded dataset
create_expanded_dataset(main_file_path, doc_data_file_path, output_file_path)
