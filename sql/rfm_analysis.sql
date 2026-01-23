.headers on
.mode column
.width 14 10 10 12

-- ======================================================
-- Phase 1: RFM Base Metrics
-- ======================================================

DROP TABLE IF EXISTS rfm_base;

CREATE TABLE rfm_base AS
WITH last_transaction AS (
    SELECT
        MAX(transaction_date) AS reference_date
    FROM transactions
),
customer_metrics AS (
    SELECT
        t.customer_id,
        MAX(t.transaction_date) AS last_purchase_date,
        COUNT(*) AS frequency,
        ROUND(SUM(t.order_value), 2) AS monetary
    FROM transactions t
    GROUP BY t.customer_id
)
SELECT
    c.customer_id,
    CAST(
        julianday(l.reference_date) - julianday(c.last_purchase_date)
        AS INTEGER
    ) AS recency,
    c.frequency,
    c.monetary
FROM customer_metrics c
CROSS JOIN last_transaction l;

