USE TelcoChurnAnalytics;
GO

--1. Overall Churn KPI View
DROP VIEW IF EXISTS analytics.vw_churn_kpis;
GO

CREATE VIEW analytics.vw_churn_kpis AS
SELECT
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,
    CAST(AVG(TotalCharges) AS DECIMAL(10,2)) AS avg_total_charges,

    CAST(SUM(MonthlyCharges) AS DECIMAL(12,2)) AS total_monthly_revenue,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue,

    CAST(
        100.0 * SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        / NULLIF(SUM(MonthlyCharges), 0)
        AS DECIMAL(5,2)
    ) AS monthly_revenue_at_risk_pct
FROM analytics.vw_telco_customer_base;
GO


--2. Churn by Contract Type
DROP VIEW IF EXISTS analytics.vw_churn_by_contract;
GO

CREATE VIEW analytics.vw_churn_by_contract AS
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue
FROM analytics.vw_telco_customer_base
GROUP BY Contract;
GO
--Expected business pattern: month-to-month customers 
--should have the highest churn rate.
--SELECT *
--FROM analytics.vw_churn_by_contract
--ORDER BY churn_rate_pct DESC;

--3. Churn by Internet Service
DROP VIEW IF EXISTS analytics.vw_churn_by_internet_service;
GO

CREATE VIEW analytics.vw_churn_by_internet_service AS
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue
FROM analytics.vw_telco_customer_base
GROUP BY InternetService;
GO


--Check
--SELECT *
--FROM analytics.vw_churn_by_internet_service
--ORDER BY churn_rate_pct DESC;


--4. Churn by Payment Method
DROP VIEW IF EXISTS analytics.vw_churn_by_payment_method;
GO

CREATE VIEW analytics.vw_churn_by_payment_method AS
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue
FROM analytics.vw_telco_customer_base
GROUP BY PaymentMethod;
GO

--Check
--SELECT *
--FROM analytics.vw_churn_by_payment_method
--ORDER BY churn_rate_pct DESC;

--Expected business pattern: 
--electronic check customers usually have the highest churn rate.