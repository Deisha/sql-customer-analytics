.headers on
.mode column
.width 30 12 12 14 14 12

-- ======================================================
-- Phase 4: Behavior-Based Predictive CLV
-- ======================================================

DROP TABLE IF EXISTS customer_clv;

CREATE TABLE customer_clv AS
WITH customer_activity AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        ROUND(SUM(order_value), 2) AS total_revenue,
        ROUND(AVG(order_value), 2) AS avg_order_value,
        MIN(transaction_date) AS first_purchase_date,
        MAX(transaction_date) AS last_purchase_date,
        CAST(
            julianday('now') - julianday(MAX(transaction_date))
            AS INT
        ) AS recency_days
    FROM transactions
    GROUP BY customer_id
),
customer_lifespan AS (
    SELECT
        customer_id,
        total_orders,
        total_revenue,
        avg_order_value,
        recency_days,
        CASE
            WHEN (
                (strftime('%Y', last_purchase_date) - strftime('%Y', first_purchase_date)) * 12 +
                (strftime('%m', last_purchase_date) - strftime('%m', first_purchase_date))
            ) = 0 THEN 1
            ELSE (
                (strftime('%Y', last_purchase_date) - strftime('%Y', first_purchase_date)) * 12 +
                (strftime('%m', last_purchase_date) - strftime('%m', first_purchase_date))
            )
        END AS lifespan_months
    FROM customer_activity
),
expected_lifespan AS (
    SELECT
        *,
        CASE
            WHEN total_orders >= 5 AND recency_days <= 60 THEN 12
            WHEN total_orders BETWEEN 2 AND 4 THEN 6
            ELSE 3
        END AS expected_future_months
    FROM customer_lifespan
)
SELECT
    customer_id,
    total_orders,
    total_revenue,
    avg_order_value,
    lifespan_months,
    recency_days,
    expected_future_months,

    ROUND(total_revenue * 1.0 / lifespan_months, 2) AS avg_monthly_revenue,

    ROUND(
        (total_revenue * 1.0 / lifespan_months) * expected_future_months,
        2
    ) AS estimated_clv

FROM expected_lifespan;
