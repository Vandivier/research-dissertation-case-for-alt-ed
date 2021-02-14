
import matplotlib.pyplot as plt

import analysis_1_vars_and_regression as GetVars

df = GetVars.getData()

# ref: https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.boxplot.html
# ref: https://matplotlib.org/3.3.3/gallery/pyplots/boxplot_demo_pyplot.html
plt.boxplot(df.favor_alt_creds, vert=False)
plt.show()
