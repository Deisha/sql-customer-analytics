.headers on
.mode column
.width 25 8 10 12 8 8 8 

-- ======================================================
-- Phase 3: RFM-Based Customer Segmentation
-- ======================================================

DROP TABLE IF EXISTS rfm_segments;

CREATE TABLE rfm_segments AS
SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    rfm_score,

    CASE
        -- Best customers: recent, frequent, high spend
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3
            THEN 'High Value – Retain'

        -- Loyal but may not be top spenders
        WHEN r_score >= 3 AND f_score >= 3
            THEN 'Loyal Customers'

        -- High spenders who are becoming inactive
        WHEN r_score <= 2 AND m_score >= 3
            THEN 'At Risk – Re-engage'

        -- Low engagement overall
        WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2
            THEN 'Low Engagement'

        -- Everyone else
        ELSE 'Growth Potential – Upsell'
    END AS customer_segment

FROM rfm_scores;
