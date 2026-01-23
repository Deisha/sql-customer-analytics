.headers on
.mode column
.width 25 25 12 14 14 12

-- ======================================================
-- Phase 5: Customer 360 View (Decision Layer)
-- ======================================================

DROP TABLE IF EXISTS customer_360;

CREATE TABLE customer_360 AS
SELECT
    s.customer_id,

    -- RFM metrics
    s.recency,
    s.frequency,
    s.monetary,
    s.r_score,
    s.f_score,
    s.m_score,
    s.rfm_score,

    -- Business segment
    s.customer_segment,

    -- CLV metrics
    c.total_orders,
    c.total_revenue,
    c.avg_order_value,
    c.lifespan_months,
    c.recency_days,
    c.expected_future_months,
    c.avg_monthly_revenue,
    c.estimated_clv

FROM rfm_segments s
JOIN customer_clv c
    ON s.customer_id = c.customer_id;
