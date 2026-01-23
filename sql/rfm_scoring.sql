.headers on
.mode column
.width 14 10 10 10 10 10

-- ======================================================
-- Phase 2: RFM Scoring using Window Functions
-- ======================================================

DROP TABLE IF EXISTS rfm_scores;

CREATE TABLE rfm_scores AS
WITH rfm_ranked AS (
    SELECT
        customer_id,
        recency,
        frequency,
        monetary,

        -- Recency: lower is better, so order ASC
        NTILE(4) OVER (ORDER BY recency ASC) AS r_score,

        -- Frequency: higher is better
        NTILE(4) OVER (ORDER BY frequency DESC) AS f_score,

        -- Monetary: higher is better
        NTILE(4) OVER (ORDER BY monetary DESC) AS m_score

    FROM rfm_base
)
SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,

    -- Combined RFM score for easy ranking
    (r_score + f_score + m_score) AS rfm_score
FROM rfm_ranked;
