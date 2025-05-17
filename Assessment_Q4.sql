-- Customer Lifetime Value (CLV) Estimation
-- Objective: Estimate customer CLV using account tenure and transaction volume

WITH total_txns AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_amount
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure_data AS (
    SELECT 
        id AS customer_id,
        name,
        DATE_PART('month', AGE(CURRENT_DATE, date_joined)) AS tenure_months
    FROM users_customuser
),
clv_calc AS (
    SELECT 
        td.customer_id,
        td.name,
        td.tenure_months,
        tt.total_transactions,
        (tt.total_amount * 0.001) / NULLIF(tt.total_transactions, 0) AS avg_profit_per_transaction
    FROM tenure_data td
    JOIN total_txns tt ON td.customer_id = tt.owner_id
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND((total_transactions::decimal / NULLIF(tenure_months, 0)) * 12 * avg_profit_per_transaction / 100.0, 2) AS estimated_clv
FROM clv_calc
ORDER BY estimated_clv DESC;
