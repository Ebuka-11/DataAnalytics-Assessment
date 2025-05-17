# DataAnalytics-Assessment

This repository contains SQL solutions for a Data Analyst assessment that evaluates the ability to write queries for business problems involving customer transactions, segmentation, and metrics analysis.

## Questions & Approaches

### Q1: High-Value Customers with Multiple Products
**Goal**: Identify customers with both a funded savings and funded investment plan, sorted by deposit volume.  
**Approach**:  
- Join `plans_plan` and `savings_savingsaccount` with `users_customuser`
- Use conditional aggregation to count savings and investment plans
- Filter with `HAVING` clause and order by total deposits

---

### Q2: Transaction Frequency Analysis
**Goal**: Segment customers by transaction frequency per month.  
**Approach**:  
- Aggregate monthly transaction counts per customer
- Compute average per customer
- Categorize based on thresholds using a CASE statement

---

### Q3: Account Inactivity Alert
**Goal**: Flag accounts with no transaction in the last 365 days.  
**Approach**:  
- Get the latest transaction date from `savings_savingsaccount`
- Match it to active plans in `plans_plan`
- Filter using date difference over 365 days

---

### Q4: Customer Lifetime Value Estimation
**Goal**: Estimate CLV based on tenure and transaction volume  
**Approach**:  
- Calculate tenure in months using `date_joined`
- Count total transactions and compute average profit (0.1%)
- Estimate CLV with the given formula

---

## Challenges

- Dealing with transaction values stored in kobo (converted to naira)
- Ensuring `NULLIF` to avoid divide-by-zero errors in CLV
- Approximating tenure in months accurately using `AGE` function

---

## Notes

- All amount fields are normalized to naira (divided by 100)
- Indexes or performance tuning were not in scope of this test
- PostgreSQL dialect assumed (functions like `DATE_PART`, `AGE`, `DATE_TRUNC` used)

---

## Author
Prepared as part of a technical SQL assessment for a Data Analyst role.
