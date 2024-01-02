import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
import numpy as np

def create_expanded_dataset(main_file_path, doc_data_file_path, output_file_path):
    df_main = pd.read_csv(main_file_path)
    df_doc_data = pd.read_csv(doc_data_file_path)
    num_docs = 18
    expanded_data = []
    for index, row in df_main.iterrows():
        for doc_id in range(1, num_docs + 1):
            data = {
                'participant_id': row['participant_id'],
                'participant_education': row['education_lvl'],
                'participant_with_econ_degree': row['with_econ_degree'],
                'participant_attention': row['reported_attention'],
                'participant_assessed_writer_edu_level': row[f'doc{doc_id}_rating_writer_edu_level'],
                'participant_assessed_gpt_likelihood': row[f'doc{doc_id}_rating_gpt_author'],
                'quality_rating': row[f'doc{doc_id}_rating_quality']
            }
            doc_data_row = df_doc_data[df_doc_data['Document'] == doc_id]
            if not doc_data_row.empty:
                data.update({
                    'topic': doc_data_row.iloc[0]['Topic'],
                    'author': doc_data_row.iloc[0]['Author'],
                    'author_credentials': doc_data_row.iloc[0]['Author_Credentials']
                })
            expanded_data.append(data)
    df_expanded = pd.DataFrame(expanded_data)
    df_expanded.to_csv(output_file_path, index=False)

def run_regression_analysis(expanded_file_path):
    df_expanded = pd.read_csv(expanded_file_path)
    df_expanded['participant_attention_squared'] = df_expanded['participant_attention'] ** 2
    df_expanded['participant_assessed_gpt_likelihood_squared'] = df_expanded['participant_assessed_gpt_likelihood'] ** 2
    categorical_features = ['participant_id', 'participant_education', 'participant_with_econ_degree',
                            'participant_assessed_writer_edu_level', 'topic', 'author', 'author_credentials']
    numeric_features = ['participant_attention', 'participant_attention_squared', 
                        'participant_assessed_gpt_likelihood', 'participant_assessed_gpt_likelihood_squared', 'doc_id']
    preprocessor = ColumnTransformer(transformers=[
        ('cat', OneHotEncoder(handle_unknown='ignore'), categorical_features),
        ('num', 'passthrough', numeric_features)
    ])
    model = Pipeline(steps=[
        ('preprocessor', preprocessor),
        ('regressor', LinearRegression())
    ])
    X = df_expanded.drop(columns=['quality_rating'])
    y = df_expanded['quality_rating'].astype(float)
    model.fit(X, y)
    y_pred = model.predict(X)
    mse = mean_squared_error(y, y_pred)
    r2 = r2_score(y, y_pred)
    adj_r2 = 1 - (1-r2)*(len(y)-1)/(len(y)-X.shape[1]-1)
    return mse, r2, adj_r2

# File paths
main_file_path = 'path_to_main.csv'
doc_data_file_path = 'path_to_document_data.csv'
output_file_path = 'path_to_expanded.csv'

# Create the expanded dataset
create_expanded_dataset(main_file_path, doc_data_file_path, output_file_path)

# Run the regression analysis
mse, r2, adj_r2 = run_regression_analysis(output_file_path)
print(f'MSE: {mse}, R2: {r2}, Adjusted R2: {adj_r2}')
