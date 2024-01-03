import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.iolib.summary2 import summary_col

# Re-loading the dataset due to the reset of the code execution state
new_data = pd.read_csv('./expanded.csv')

# Construct the 'participant_expects_gpt' variable as a boolean
new_data['participant_expects_gpt'] = new_data['participant_assessed_gpt_likelihood'] >= 6

# Model 1: Linear regression with participant fixed effects
participant_id_dummies = pd.get_dummies(new_data['participant_id'], prefix='participant_id', drop_first=True)
data_model_1 = pd.concat([new_data, participant_id_dummies], axis=1).drop(columns=['participant_id'])
formula_model_1 = 'quality_rating ~ ' + ' + '.join(data_model_1.columns.difference(['quality_rating']))
model_1 = smf.ols(formula_model_1, data=data_model_1).fit()

# Model 2: Curvilinear model (linear model plus squared attention and squared participant_assessed_gpt_likelihood)
data_model_2 = data_model_1.copy()
data_model_2['participant_attention_squared'] = data_model_2['participant_attention'] ** 2
data_model_2['participant_assessed_gpt_likelihood_squared'] = data_model_2['participant_assessed_gpt_likelihood'] ** 2
formula_model_2 = 'quality_rating ~ ' + ' + '.join(data_model_2.columns.difference(['quality_rating']))
model_2 = smf.ols(formula_model_2, data=data_model_2).fit()

# Model 3: Model with participant_expects_gpt instead of participant_assessed_gpt_likelihood and its squared term
data_model_3 = data_model_2.drop(columns=['participant_assessed_gpt_likelihood', 
                                          'participant_assessed_gpt_likelihood_squared'])
formula_model_3 = 'quality_rating ~ ' + ' + '.join(data_model_3.columns.difference(['quality_rating']))
model_3 = smf.ols(formula_model_3, data=data_model_3).fit()

# Creating a summary table
summary_table = summary_col([model_1, model_2, model_3], stars=True, 
                            model_names=['Model 1 (Linear FE)', 
                                         'Model 2 (Curvilinear)', 
                                         'Model 3 (Expects GPT)'],
                            info_dict={'AIC': lambda x: f"{x.aic:.2f}"})

summary_text = summary_table.as_text()
print(summary_text)
