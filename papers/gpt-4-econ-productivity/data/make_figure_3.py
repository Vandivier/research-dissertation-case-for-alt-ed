import matplotlib.pyplot as plt
import pandas as pd

# Creating a DataFrame for the data
data = {
    'Date': pd.to_datetime(['2023-03', '2023-05', '2023-07', '2024-01']),
    'Plugin Count': [13, 83, 401, 1039]
}

df = pd.DataFrame(data)

# Plotting the data
plt.figure(figsize=(10, 6))
plt.plot(df['Date'], df['Plugin Count'], marker='o')
plt.title('ChatGPT Plugin Count Over Time')
plt.xlabel('Date')
plt.ylabel('Number of Plugins')
plt.grid(True)
plt.xticks(df['Date'])
plt.tight_layout()

plt.savefig('../figures/figure_3.png')

