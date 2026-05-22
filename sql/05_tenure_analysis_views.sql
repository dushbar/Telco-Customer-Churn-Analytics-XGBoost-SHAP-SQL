Use TelcoChurnAnalytics

DROP VIEW IF EXISTS analytics.vw_churn_by_tenure_bucket;
GO

CREATE VIEW analytics.vw_churn_by_tenure_bucket AS
SELECT
    tenure_bucket,

    CASE
        WHEN tenure_bucket = '0-12 months' THEN 1
        WHEN tenure_bucket = '13-24 months' THEN 2
        WHEN tenure_bucket = '25-48 months' THEN 3
        WHEN tenure_bucket = '49+ months' THEN 4
    END AS tenure_bucket_sort,

    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS avg_monthly_charges,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue
FROM analytics.vw_telco_customer_base
GROUP BY tenure_bucket;
GO


--Check
--SELECT
--    tenure_bucket,
--    total_customers,
--    churned_customers,
--    churn_rate_pct,
--   avg_monthly_charges,
--    churned_monthly_revenue
--FROM analytics.vw_churn_by_tenure_bucket
--ORDER BY tenure_bucket_sort;

--Expected business pattern: newer customers,
--especially 0–12 months, should show much 
--higher churn.
