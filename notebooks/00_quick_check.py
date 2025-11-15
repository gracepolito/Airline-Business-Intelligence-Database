import pandas as pd
df = pd.read_csv("/Users/gracepolito/Desktop/Master of Data Science/691 Applied Data Science/Airline Business Intelligence Database/data/bts_flights_2024.csv")
print("shape:", df.shape)
print("columns:", df.columns.tolist())
print("nSample rows:")
print(df.head())