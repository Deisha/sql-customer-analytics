import pandas as pd
from sqlalchemy import create_engine

# Read CSV
df = pd.read_csv("data/raw_transactions.csv")

# Create SQLite database
engine = create_engine("sqlite:///transactions.db")

# Load data
df.to_sql("transactions", engine, if_exists="replace", index=False)

print("Data loaded into SQLite successfully.")
print(f"Rows loaded: {len(df)}")
