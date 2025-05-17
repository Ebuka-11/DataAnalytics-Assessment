-- Transaction Frequency Analysis
-- Objective: Calculate the average number of transactions per customer per month,
-- and categorize customers into frequency buckets

WITH transaction_counts AS (
    SELECT 
        owner_id,
        DATE_TRUNC('month', created_at) AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, DATE_TRUNC('month', created_at)
),
monthly_avg AS (
    SELECT 
        owner_id,
        AVG(txn_count) AS avg_txn_per_month
    FROM transaction_counts
    GROUP BY owner_id
),
categorized AS (
    SELECT
        CASE
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txn_per_month
    FROM monthly_avg
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;
