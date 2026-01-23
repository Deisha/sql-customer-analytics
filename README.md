# Customer Analytics & Predictive Lifetime Value Dashboard

## Project Overview
This project implements a **SQL-first customer analytics system** that moves beyond descriptive reporting into **predictive, decision-oriented analysis**.

Using transaction-level data, the project combines:
- Behavioral customer segmentation
- An explainable, forward-looking Customer Lifetime Value (CLV) model
- An executive-style Tableau dashboard
The goal is to help businesses answer **who to prioritize, who to retain, and where future customer value lies**, using transparent logic rather than black-box modeling.
---

## Business Questions Addressed
The analysis is designed to answer the following business-critical questions:
- How large is the customer base and how much revenue has been generated historically?
- Which customer segments contribute the most to **future value**, not just past revenue?
- Who are the highest-value individual customers?
- Which high-value customers are at risk of churn and require re-engagement?
- How should customers be prioritized for retention vs growth strategies?
---

## Dataset Description
- Source: **Synthetic transaction dataset** generated for analytical demonstration
- Total transactions: 750  
- Unique customers: 285  

Each transaction includes:
- Customer ID
- Transaction date
- Order value
- Product category
The dataset is intentionally designed to resemble real-world retail transaction data while remaining fully reproducible.

### Product Categories
Transactions are classified into the following product categories:
- Electronics
- Home
- Sports
- Clothing
- Beauty
These categories are used for category-level revenue analysis and exploratory insights.
---

## SQL-Based Analytics Workflow
SQL is the **primary analytics tool** in this project.
The workflow follows a layered approach:
1. **Schema definition**  
   - Normalized transaction table created in SQLite

2. **Core aggregations**  
   - Revenue, order counts, customer activity windows

3. **Behavioral metrics**  
   - Recency (days since last purchase)
   - Frequency (number of orders)
   - Monetary value (spend)

4. **Customer-level modeling**  
   - Customer 360 view
   - Segmentation logic
   - Predictive CLV estimation

Python is used only for:
- Loading CSV data into SQLite
- Exporting SQL outputs for visualization (no analytical logic)
---

## Customer Segmentation Framework
Customers are segmented using a **behavior-driven framework inspired by RFM analysis**.
Segments include:
- **High Value – Retain**  
  Customers with strong purchase history and high future value

- **Growth Potential – Upsell**  
  Customers showing promising engagement but not yet maximized

- **At Risk – Re-engage**  
  High-value customers with declining recency signals

- **Low Engagement**  
  Customers with limited activity and lower strategic priority

- **Loyal Customers**  
  Consistently active customers with stable behavior

Segmentation logic is implemented entirely in SQL and designed to support **actionable business decisions**, not just descriptive grouping.
---

## Predictive Customer Lifetime Value (CLV)
### CLV Definition
This project implements a **behavior-based predictive CLV model** that is intentionally explainable and assumption-driven.
Estimated CLV is calculated as:
Estimated CLV = Average Monthly Revenue × Expected Future Months

### Average Monthly Revenue
- Derived from historical transaction data
- Computed per customer using observed lifespan

### Expected Future Months (Behavior-Based)
Rather than using a fixed horizon, expected customer lifespan is derived from observed behavior:
- **High frequency & recent customers** → 12 months
- **Medium frequency customers** → 6 months
- **Low frequency or inactive customers** → 3 months

This approach provides a forward-looking proxy while avoiding speculative churn modeling.
---

## Interactive Dashboard (Tableau)
An interactive **Tableau Public dashboard** translates SQL outputs into executive-level insights.
### Dashboard Objectives
The dashboard is designed to:
- Summarize business scale and customer value
- Highlight mismatches between customer volume and value
- Identify actionable retention and growth opportunities

Product category analysis is included as foundational exploratory analysis but is intentionally excluded from the final dashboard to maintain a customer-centric decision focus.

### Key Components
- KPI cards:
  - Total Customers
  - Total Revenue
  - Total Estimated CLV

- Segment-level insights:
  - Total Estimated CLV by Segment
  - Segment Size vs Value bubble chart

- Customer-level prioritization:
  - Top Customers by Estimated CLV
  - At-Risk High-Value Customers (diagnostic table)

The dashboard emphasizes **clarity, hierarchy, and decision-making** over decorative visuals.
---

## Key Insights
- A small subset of customers contributes a disproportionate share of future value
- High-value customers are not always the most numerous segment
- Several high-CLV customers show declining engagement signals
- Segment-level value distribution differs significantly from customer counts
These insights directly support retention, upsell, and re-engagement strategies.
---

## Assumptions & Limitations
- The dataset is synthetic and used for analytical demonstration
- Predictive CLV is based on simplified behavioral assumptions
- No probabilistic churn or survival modeling is applied
- All assumptions are explicitly documented to ensure transparency
---

## Tools & Technologies
- SQL (SQLite)
- Tableau Public
- Python (Pandas, SQLAlchemy)
- VS Code
- Conda environment
---

## Repository Structure
sql-customer-analytics/
│
├── data/
│   └── raw_transactions.csv
│
├── notebooks/                
│   ├── generate_dataset.py
│   ├── load_to_sqlite.py
│   └── create_visuals.py
│
├── sql/
│   ├── schema.sql
│   ├── rfm_analysis.sql
│   ├── rfm_scoring.sql
│   ├── rfm_segmentation.sql
│   ├── clv_calculation.sql
│   ├── customer_360.sql
│   └── dashboard_exports.sql
│
├── visuals/
│   ├── dashboard/
│   ├── exploratory/
│   ├── foundational/
│   └── dashboard.png
│
└── README.md
---

## Final Note
This project prioritizes **business reasoning, explainability, and reproducibility** over model complexity.  
It is intended to reflect how customer analytics is applied in real-world decision-making environments.

## Tableau Link
https://public.tableau.com/views/CustomerAnalyticsandPredictiveCLVDashboard/CustomerAnalyticsPredictiveCLVDashboard?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
