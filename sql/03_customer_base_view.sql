DROP VIEW IF EXISTS analytics.vw_telco_customer_base;
GO

CREATE VIEW analytics.vw_telco_customer_base AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    CASE 
        WHEN SeniorCitizen = 1 THEN 'Senior Citizen'
        ELSE 'Non-Senior Citizen'
    END AS senior_citizen_group,
    Partner,
    Dependents,
    tenure,
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_bucket,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn,
    CASE 
        WHEN Churn = 1 THEN 1
        ELSE 0
    END AS churn_flag,
    CASE 
        WHEN Churn = 0 THEN 1
        ELSE 0
    END AS retained_flag
FROM staging.telco_churn_import;
GO

--SELECT TOP 10 *
--FROM analytics.vw_telco_customer_base;