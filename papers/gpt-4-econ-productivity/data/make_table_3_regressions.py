import pandas as pd
import statsmodels.formula.api as smf
from statsmodels.iolib.summary2 import summary_col

# Load the data
new_data = pd.read_csv('./expanded.csv')

# Generating dummy variables for 'author' and 'author_credentials'
new_data = pd.get_dummies(new_data, columns=['author', 'author_credentials'], drop_first=True)

# Drop dummies collinear with `is_written_by_gpt`
new_data = new_data.drop(columns=['author_gpt', 'author_credentials_gpt'])

# Exclude 'doc_id' from the models
excluded_columns = ['quality_rating', 'doc_id']

# Model 1: Linear regression with participant fixed effects
participant_id_dummies = pd.get_dummies(new_data['participant_id'], prefix='participant_id', drop_first=True)
data_model_1 = pd.concat([new_data, participant_id_dummies], axis=1).drop(columns=['participant_id'])
model_1_excluded_columns = excluded_columns + ['participant_expects_gpt']
formula_model_1 = 'quality_rating ~ ' + ' + '.join(data_model_1.columns.difference(model_1_excluded_columns))
model_1 = smf.ols(formula_model_1, data=data_model_1).fit()

# Model 2: Curvilinear model (linear model plus squared attention and squared participant_assessed_gpt_likelihood)
data_model_2 = data_model_1.copy()
data_model_2['participant_attention_squared'] = data_model_2['participant_attention'] ** 2
data_model_2['participant_assessed_gpt_likelihood_squared'] = data_model_2['participant_assessed_gpt_likelihood'] ** 2
model_2_excluded_columns = excluded_columns + ['participant_expects_gpt']
formula_model_2 = 'quality_rating ~ ' + ' + '.join(data_model_2.columns.difference(model_2_excluded_columns))
model_2 = smf.ols(formula_model_2, data=data_model_2).fit()

# Model 3: Model with participant_expects_gpt instead of participant_assessed_gpt_likelihood and its squared term
data_model_3 = data_model_2.drop(columns=['participant_assessed_gpt_likelihood', 
                                          'participant_assessed_gpt_likelihood_squared'])
model_3_excluded_columns = excluded_columns
formula_model_3 = 'quality_rating ~ ' + ' + '.join(data_model_3.columns.difference(model_3_excluded_columns))
model_3 = smf.ols(formula_model_3, data=data_model_3).fit()

# Creating a summary table
summary_table = summary_col([model_1, model_2, model_3], stars=True, 
                            model_names=['Model 1 (Linear FE)', 
                                         'Model 2 (Curvilinear)', 
                                         'Model 3 (Expects GPT)'],
                            info_dict={'AIC': lambda x: f"{x.aic:.2f}"})

with open('../figures/table_3_regressions_raw.txt', 'w') as f:
    f.write(summary_table.as_text())
