import pandas as pd
import matplotlib.pyplot as plt

# Monthly Revenue
df = pd.read_csv("visuals/monthly_revenue.csv")
plt.figure()
plt.plot(df["month"], df["revenue"])
plt.xticks(rotation=45)
plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("visuals/monthly_revenue.png")
plt.show()

#One-Time vs Repeat Customers
df = pd.read_csv("visuals/customer_type_breakdown.csv")
plt.figure()
plt.bar(df["customer_type"], df["customer_count"])
for i, value in enumerate(df["customer_count"]):
    plt.text(i, value, str(value), ha="center", va="bottom")
plt.title("One-Time vs Repeat Customers")
plt.xlabel("Customer Type")
plt.ylabel("Number of Customers")
plt.tight_layout()
plt.savefig("visuals/customer_type_breakdown.png")
plt.show()

#Revenue by Category
df = pd.read_csv("visuals/category_revenue.csv")
plt.figure()
plt.bar(df["product_category"], df["revenue"])
for i, value in enumerate(df["revenue"]):
    plt.text(i, value, f"{value/1_000_000:.1f}M", ha="center", va="bottom")
plt.xticks(rotation=30)
plt.title("Revenue by Product Category")
plt.xlabel("Category")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("visuals/category_revenue.png")
plt.show()
