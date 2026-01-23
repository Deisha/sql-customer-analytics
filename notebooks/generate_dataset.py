import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Reproducibility
random.seed(42)
np.random.seed(42)

# Parameters
NUM_CUSTOMERS = 300
START_DATE = datetime(2023, 1, 1)
END_DATE = datetime(2024, 12, 31)

# Product categories with realistic price ranges (INR)
categories = {
    "Electronics": (8000, 60000),
    "Clothing": (500, 5000),
    "Home": (1000, 15000),
    "Beauty": (300, 4000),
    "Sports": (800, 10000)
}

rows = []
transaction_id = 1

for customer_id in range(1, NUM_CUSTOMERS + 1):
    # Signup date before transactions
    signup_date = START_DATE + timedelta(
        days=random.randint(0, (END_DATE - START_DATE).days - 180)
    )

    # Purchase frequency distribution
    num_transactions = np.random.choice(
        [1, 2, 3, 4, 5, 8, 12],
        p=[0.40, 0.20, 0.15, 0.10, 0.08, 0.05, 0.02]
    )

    transaction_dates = sorted([
        signup_date + timedelta(days=random.randint(0, 365))
        for _ in range(num_transactions)
    ])

    for t_date in transaction_dates:
        if t_date > END_DATE:
            continue

        category = random.choice(list(categories.keys()))
        low, high = categories[category]

        order_value = round(
            np.random.normal((low + high) / 2, (high - low) / 6), 2
        )
        order_value = max(low, min(order_value, high))

        rows.append([
            transaction_id,
            customer_id,
            t_date.date(),
            signup_date.date(),
            category,
            order_value
        ])

        transaction_id += 1

# Create DataFrame
df = pd.DataFrame(rows, columns=[
    "transaction_id",
    "customer_id",
    "transaction_date",
    "signup_date",
    "product_category",
    "order_value"
])

# Save CSV to data/ folder (IMPORTANT: no ../)
df.to_csv("data/raw_transactions.csv", index=False)

print("Synthetic dataset generated successfully.")
print(f"Total transactions: {len(df)}")
