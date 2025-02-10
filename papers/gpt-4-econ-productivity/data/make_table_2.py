import pandas as pd
import statsmodels.formula.api as smf
from statsmodels.iolib.summary2 import summary_col

# Load the data
data = pd.read_csv('./expanded.csv')

# Convert 'is_written_by_gpt' from boolean to numeric (0 and 1)
data['is_written_by_gpt'] = data['is_written_by_gpt'].astype(int)

# Generating dummy variables for 'participant_assessed_writer_edu_level' and 'participant_id'
data = pd.get_dummies(data, columns=['participant_assessed_writer_edu_level', 'participant_id'], drop_first=True)

# Model 1 (including participant effects)
included_columns_with_participant = data.columns[data.columns.str.startswith('participant_assessed_writer_edu_level_') | 
                                                  data.columns.str.startswith('participant_id_')]
formula_with_participant = 'is_written_by_gpt ~ ' + ' + '.join(included_columns_with_participant)
model_with_participant = smf.ols(formula_with_participant, data=data).fit()

# Model 2 (excluding participant effects)
included_columns_without_participant = data.columns[data.columns.str.startswith('participant_assessed_writer_edu_level_')]
formula_without_participant = 'is_written_by_gpt ~ ' + ' + '.join(included_columns_without_participant)
model_without_participant = smf.ols(formula_without_participant, data=data).fit()

# Creating a summary table
summary_table = summary_col([model_with_participant, model_without_participant], stars=True, 
                            model_names=['Model 1 (With Participant Effects)', 
                                         'Model 2 (Without Participant Effects)'],
                            info_dict={'AIC': lambda x: f"{x.aic:.2f}"})

# Save the summary table to a text file
with open('../figures/table_2_assessed_ed_raw.txt', 'w') as f:
    f.write(summary_table.as_text())
