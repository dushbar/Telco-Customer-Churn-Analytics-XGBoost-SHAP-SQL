USE TelcoChurnAnalytics;

--1. Churn by Online Security
DROP VIEW IF EXISTS analytics.vw_churn_by_online_security;
GO

CREATE VIEW analytics.vw_churn_by_online_security AS
SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue
FROM analytics.vw_telco_customer_base
GROUP BY OnlineSecurity;
GO

--Check
--SELECT *
--FROM analytics.vw_churn_by_online_security
--ORDER BY churn_rate_pct DESC;


--2. Churn by Tech Support
DROP VIEW IF EXISTS analytics.vw_churn_by_tech_support;
GO

CREATE VIEW analytics.vw_churn_by_tech_support AS
SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue
FROM analytics.vw_telco_customer_base
GROUP BY TechSupport;
GO

--Check
--SELECT *
--FROM analytics.vw_churn_by_tech_support
--ORDER BY churn_rate_pct DESC;