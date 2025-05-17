-- High-Value Customers with Multiple Products
-- Objective: Find customers with at least one funded savings and one funded investment plan,
-- sorted by total deposits (confirmed_amount)

SELECT 
    uc.id AS owner_id,
    uc.name,
    COUNT(DISTINCT CASE WHEN pp.is_regular_savings = 1 THEN pp.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN pp.is_a_fund = 1 THEN pp.id END) AS investment_count,
    SUM(ss.confirmed_amount / 100.0) AS total_deposits  -- Convert from kobo to naira
FROM users_customuser uc
LEFT JOIN plans_plan pp ON pp.owner_id = uc.id
LEFT JOIN savings_savingsaccount ss ON ss.owner_id = uc.id
WHERE pp.is_funded = TRUE
GROUP BY uc.id, uc.name
HAVING 
    COUNT(DISTINCT CASE WHEN pp.is_regular_savings = 1 THEN pp.id END) >= 1
    AND COUNT(DISTINCT CASE WHEN pp.is_a_fund = 1 THEN pp.id END) >= 1
ORDER BY total_deposits DESC;
