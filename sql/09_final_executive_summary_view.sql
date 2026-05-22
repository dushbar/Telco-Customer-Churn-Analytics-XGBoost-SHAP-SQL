USE TelcoChurnAnalytics;

DROP VIEW IF EXISTS analytics.vw_executive_churn_summary;
GO

CREATE VIEW analytics.vw_executive_churn_summary AS
WITH highest_contract AS (
    SELECT TOP 1
        Contract,
        churn_rate_pct
    FROM analytics.vw_churn_by_contract
    ORDER BY churn_rate_pct DESC
),
highest_internet AS (
    SELECT TOP 1
        InternetService,
        churn_rate_pct
    FROM analytics.vw_churn_by_internet_service
    ORDER BY churn_rate_pct DESC
),
highest_payment AS (
    SELECT TOP 1
        PaymentMethod,
        churn_rate_pct
    FROM analytics.vw_churn_by_payment_method
    ORDER BY churn_rate_pct DESC
)
SELECT
    'Overall Churn Rate' AS metric_name,
    CAST(churn_rate_pct AS VARCHAR(50)) + '%' AS metric_value,
    'Percentage of customers who churned' AS metric_description
FROM analytics.vw_churn_kpis

UNION ALL

SELECT
    'Monthly Revenue at Risk',
    CAST(churned_monthly_revenue AS VARCHAR(50)),
    'Monthly revenue associated with churned customers'
FROM analytics.vw_churn_kpis

UNION ALL

SELECT
    'Highest Churn Contract Type',
    Contract + ' - ' + CAST(churn_rate_pct AS VARCHAR(50)) + '%',
    'Contract category with the highest churn rate'
FROM highest_contract

UNION ALL

SELECT
    'Highest Churn Internet Service',
    InternetService + ' - ' + CAST(churn_rate_pct AS VARCHAR(50)) + '%',
    'Internet service category with the highest churn rate'
FROM highest_internet

UNION ALL

SELECT
    'Highest Churn Payment Method',
    PaymentMethod + ' - ' + CAST(churn_rate_pct AS VARCHAR(50)) + '%',
    'Payment method category with the highest churn rate'
FROM highest_payment;
GO


--Retention Action Priority View
DROP VIEW IF EXISTS analytics.vw_retention_action_priority;
GO

CREATE VIEW analytics.vw_retention_action_priority AS
SELECT
    Contract,
    InternetService,
    PaymentMethod,
    total_customers,
    churned_customers,
    churn_rate_pct,
    total_monthly_revenue,
    churned_monthly_revenue,
    revenue_at_risk_pct,

    CASE
        WHEN churn_rate_pct >= 40
             AND churned_monthly_revenue >= 10000
            THEN 'Critical Priority'

        WHEN churn_rate_pct >= 30
             AND churned_monthly_revenue >= 5000
            THEN 'High Priority'

        WHEN churn_rate_pct >= 20
             AND churned_monthly_revenue >= 2500
            THEN 'Medium Priority'

        ELSE 'Low Priority'
    END AS retention_priority
FROM analytics.vw_revenue_at_risk_segments;
GO


SELECT TOP 20
    Contract,
    InternetService,
    PaymentMethod,
    total_customers,
    churned_customers,
    churn_rate_pct,
    churned_monthly_revenue,
    revenue_at_risk_pct,
    retention_priority
FROM analytics.vw_retention_action_priority
WHERE total_customers >= 30
ORDER BY
    CASE retention_priority
        WHEN 'Critical Priority' THEN 1
        WHEN 'High Priority' THEN 2
        WHEN 'Medium Priority' THEN 3
        ELSE 4
    END,
    churned_monthly_revenue DESC;