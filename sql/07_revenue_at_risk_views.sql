USE TelcoChurnAnalytics;

DROP VIEW IF EXISTS analytics.vw_revenue_at_risk_segments;
GO

CREATE VIEW analytics.vw_revenue_at_risk_segments AS
SELECT
    Contract,
    InternetService,
    PaymentMethod,

    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

    CAST(100.0 * SUM(churn_flag) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate_pct,

    CAST(SUM(MonthlyCharges) AS DECIMAL(12,2)) AS total_monthly_revenue,

    CAST(
        SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        AS DECIMAL(12,2)
    ) AS churned_monthly_revenue,

    CAST(
        100.0 * SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges ELSE 0 END)
        / NULLIF(SUM(MonthlyCharges), 0)
        AS DECIMAL(5,2)
    ) AS revenue_at_risk_pct
FROM analytics.vw_telco_customer_base
GROUP BY
    Contract,
    InternetService,
    PaymentMethod;
GO


--Check
--SELECT TOP 10
--    Contract,
--    InternetService,
--    PaymentMethod,
--    total_customers,
--    churned_customers,
--    churn_rate_pct,
--    total_monthly_revenue,
--    churned_monthly_revenue,
--    revenue_at_risk_pct
--FROM analytics.vw_revenue_at_risk_segments
--WHERE total_customers >= 30
--ORDER BY churned_monthly_revenue DESC;