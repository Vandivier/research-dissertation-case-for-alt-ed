import pandas as pd
import numpy as np
import statsmodels.api as sm
import statsmodels.formula.api as smf
from tabulate import tabulate

def run_regression_analysis_and_create_table(expanded_file_path):
    # Load the expanded dataset
    df_expanded = pd.read_csv(expanded_file_path)

    # Preparing the data for regression analysis with fixed effects
    categorical_features = ['participant_id', 'participant_education', 'participant_with_econ_degree',
                            'participant_assessed_writer_edu_level', 'topic', 'author', 'author_credentials']
    df_expanded[categorical_features] = df_expanded[categorical_features].astype(str)

    # Adding squared features
    df_expanded['participant_attention_squared'] = df_expanded['participant_attention'] ** 2
    df_expanded['participant_assessed_gpt_likelihood_squared'] = df_expanded['participant_assessed_gpt_likelihood'] ** 2

    # Formulas for the regression models
    formula_original = 'quality_rating ~ participant_education + participant_with_econ_degree + ' 
                       'participant_assessed_writer_edu_level + participant_attention + '
                       'topic + author + author_credentials + C(participant_id) - 1'
    formula_curvilinear = formula_original + ' + np.power(participant_attention, 2) + '
                          'np.power(participant_assessed_gpt_likelihood, 2)'

    # Running the regression models
    model_original_fixed = smf.ols(formula=formula_original, data=df_expanded).fit()
    model_curvilinear_fixed = smf.ols(formula=formula_curvilinear, data=df_expanded).fit()

    # Convert the summary to a DataFrame and then to markdown
    summary_df_original = pd.DataFrame(model_original_fixed.summary().tables[1])
    markdown_table_original = tabulate(summary_df_original, headers='keys', tablefmt='pipe', showindex=False)

    summary_df_curvilinear = pd.DataFrame(model_curvilinear_fixed.summary().tables[1])
    markdown_table_curvilinear = tabulate(summary_df_curvilinear, headers='keys', tablefmt='pipe', showindex=False)

    return markdown_table_original, markdown_table_curvilinear

# File path
expanded_file_path = 'path_to_expanded.csv'

# Generate regression tables in markdown format
markdown_table_original, markdown_table_curvilinear = run_regression_analysis_and_create_table(expanded_file_path)
print(markdown_table_original)
print(markdown_table_curvilinear)
