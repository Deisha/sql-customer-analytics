-- =========================================================
-- DASHBOARD EXPORTS
-- Final SQL outputs used for Tableau dashboard and reporting
-- =========================================================

.mode csv
.headers on

-- =========================================================
-- 1. FOUNDATIONAL BUSINESS METRICS
-- =========================================================

-- Total Revenue
DROP TABLE IF EXISTS total_revenue;
CREATE TABLE total_revenue AS
SELECT
    ROUND(SUM(order_value), 2) AS total_revenue
FROM transactions;

.output visuals/foundational/total_revenue.csv
SELECT * FROM total_revenue;
.output stdout


-- Monthly Revenue Trend
DROP TABLE IF EXISTS monthly_revenue;
CREATE TABLE monthly_revenue AS
SELECT
    strftime('%Y-%m', transaction_date) AS month,
    ROUND(SUM(order_value), 2) AS revenue
FROM transactions
GROUP BY month
ORDER BY month;

.output visuals/exploratory/monthly_revenue.csv
SELECT * FROM monthly_revenue;
.output stdout


-- =========================================================
-- 2. CUSTOMER BEHAVIOR & EXPLORATORY ANALYSIS
-- =========================================================

-- One-Time vs Repeat Customers
DROP TABLE IF EXISTS customer_type_breakdown;
CREATE TABLE customer_type_breakdown AS
WITH customer_orders AS (
    SELECT customer_id, COUNT(*) AS order_count
    FROM transactions
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type;

.output visuals/exploratory/customer_type_breakdown.csv
SELECT * FROM customer_type_breakdown;
.output stdout


-- Revenue by Product Category
DROP TABLE IF EXISTS category_revenue;
CREATE TABLE category_revenue AS
SELECT
    product_category,
    ROUND(SUM(order_value), 2) AS revenue
FROM transactions
GROUP BY product_category
ORDER BY revenue DESC;

.output visuals/foundational/category_revenue.csv
SELECT * FROM category_revenue;
.output stdout


-- =========================================================
-- 3. COHORT & RETENTION ANALYSIS
-- =========================================================

-- Cohort Retention
DROP TABLE IF EXISTS cohort_retention;
CREATE TABLE cohort_retention AS
WITH cohorts AS (
    SELECT
        customer_id,
        strftime('%Y-%m', signup_date) AS cohort_month,
        strftime('%Y-%m', transaction_date) AS activity_month
    FROM transactions
)
SELECT
    cohort_month,
    activity_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM cohorts
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;

.output visuals/foundational/cohort_retention.csv
SELECT * FROM cohort_retention;
.output stdout


-- =========================================================
-- 4. CUSTOMER SEGMENTATION & VALUE (DASHBOARD CORE)
-- =========================================================

-- Customer Segment Breakdown
.output visuals/dashboard/customer_segment_summary.csv
SELECT
    customer_segment,
    COUNT(*) AS customers
FROM customer_360
GROUP BY customer_segment
ORDER BY customers DESC;
.output stdout


-- Segment Value Summary (Revenue & Predictive CLV)
.output visuals/dashboard/segment_value_summary.csv
SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(SUM(estimated_clv), 2) AS total_clv,
    ROUND(AVG(estimated_clv), 2) AS avg_clv
FROM customer_360
GROUP BY customer_segment
ORDER BY total_clv DESC;
.output stdout


-- =========================================================
-- 5. CUSTOMER PRIORITIZATION (ACTIONABLE OUTPUTS)
-- =========================================================

-- Top Customers by Estimated CLV
.output visuals/dashboard/top_customers_by_clv.csv
SELECT
    customer_id,
    customer_segment,
    estimated_clv,
    total_orders,
    monetary
FROM customer_360
ORDER BY estimated_clv DESC
LIMIT 20;
.output stdout


-- At-Risk High-Value Customers
.output visuals/dashboard/at_risk_customers.csv
SELECT
    customer_id,
    customer_segment,
    recency,
    frequency,
    monetary,
    estimated_clv
FROM customer_360
WHERE customer_segment = 'At Risk – Re-engage'
ORDER BY estimated_clv DESC;
.output stdout


-- =========================================================
-- 6. FULL CUSTOMER 360 EXPORT
-- =========================================================

.output visuals/dashboard/customer_360.csv
SELECT *
FROM customer_360;
.output stdout
