USE TelcoChurnAnalytics;

--check
SELECT TOP 10 * FROM
staging.telco_churn_import;


--check row count
SELECT COUNT(*) AS total_rows
FROM staging.telco_churn_import;


--Duplicate customer check
SELECT 
    customerID,
    COUNT(*) AS record_count
FROM staging.telco_churn_import
GROUP BY customerID
HAVING COUNT(*) > 1;

--Null Check
SELECT
    SUM(CASE WHEN customerID IS NULL THEN 1 ELSE 0 END) AS null_customerID,
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS null_tenure,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS null_monthly_charges,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total_charges,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS null_churn
FROM staging.telco_churn_import;

--Churn Value Check
SELECT 
    Churn,
    COUNT(*) AS customer_count
FROM staging.telco_churn_import
GROUP BY Churn;

--Range Checks
SELECT
    MIN(tenure) AS min_tenure,
    MAX(tenure) AS max_tenure,
    MIN(MonthlyCharges) AS min_monthly_charges,
    MAX(MonthlyCharges) AS max_monthly_charges,
    MIN(TotalCharges) AS min_total_charges,
    MAX(TotalCharges) AS max_total_charges
FROM staging.telco_churn_import;