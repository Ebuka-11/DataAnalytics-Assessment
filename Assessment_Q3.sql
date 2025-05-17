-- Account Inactivity Alert
-- Objective: Identify active accounts with no inflow for over a year (365 days)

WITH last_txn_dates AS (
    SELECT 
        id AS plan_id,
        owner_id,
        CASE 
            WHEN is_regular_savings = 1 THEN 'Savings'
            WHEN is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        (
            SELECT MAX(created_at) 
            FROM savings_savingsaccount 
            WHERE savings_savingsaccount.owner_id = plans_plan.owner_id
        ) AS last_transaction_date
    FROM plans_plan
    WHERE is_active = TRUE
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATE_PART('day', CURRENT_DATE - last_transaction_date) AS inactivity_days
FROM last_txn_dates
WHERE last_transaction_date < CURRENT_DATE - INTERVAL '365 days';
