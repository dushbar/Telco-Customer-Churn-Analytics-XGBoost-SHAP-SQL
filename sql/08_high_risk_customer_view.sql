USE TelcoChurnAnalytics;

DROP VIEW IF EXISTS analytics.vw_high_risk_churn_customers;
GO

CREATE VIEW analytics.vw_high_risk_churn_customers AS
SELECT
    customerID,
    gender,
    senior_citizen_group,
    Partner,
    Dependents,
    tenure,
    tenure_bucket,
    Contract,
    InternetService,
    PaymentMethod,
    OnlineSecurity,
    TechSupport,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM analytics.vw_telco_customer_base
WHERE Churn = 1
  AND MonthlyCharges >= 70;
GO


SELECT TOP 20 *
FROM analytics.vw_high_risk_churn_customers
ORDER BY MonthlyCharges DESC;