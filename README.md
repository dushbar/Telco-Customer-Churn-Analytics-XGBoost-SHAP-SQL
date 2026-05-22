# Telco Customer Churn Analysis using Python, XGBoost, SHAP, and SQL Server

## Project Overview

This project analyzes customer churn for a telecom company using a complete analytics workflow: Python-based data cleaning and EDA, XGBoost churn prediction, SHAP model interpretation, and SQL Server business reporting.

The objective was not only to predict churn, but also to convert model findings into actionable business insights through SQL-based KPI views, segment analysis, tenure risk analysis, and revenue-at-risk prioritization.

---

## Dataset

The original Telco Customer Churn dataset contained:

- **7,043 customer records**
- **21 original columns**
- Target variable: **Churn**

During cleaning:

- `TotalCharges` was converted from text to numeric.
- 11 blank or invalid `TotalCharges` values were removed.
- Categorical variables were encoded for machine learning.
- A separate SQL-ready version was created with `customerID` retained for customer-level analysis.

The final SQL reporting dataset contained:

- **7,032 customer records**
- **1,869 churned customers**
- **5,163 retained customers**

---

## Tools and Technologies

- **Python**: pandas, NumPy, matplotlib, seaborn
- **Machine Learning**: XGBoost
- **Model Evaluation**: ROC-AUC, accuracy
- **Model Interpretation**: SHAP
- **Database and Analytics Layer**: SQL Server, SSMS
- **Business Reporting**: SQL views and analytical queries

---

## Python EDA and Feature Analysis

Initial exploratory analysis showed that churn was strongly associated with tenure, contract type, internet service, payment method, monthly charges, online security, and tech support.

ANOVA F-test results showed the strongest statistical differences between churned and retained customers for:

| Feature | F Statistic | p-value |
|---|---:|---:|
| tenure | 999.76 | 3.09e-205 |
| InternetService_Fiber optic | 732.44 | 1.65e-153 |
| Contract_Two year | 700.10 | 3.95e-147 |
| PaymentMethod_Electronic check | 698.59 | 7.87e-147 |
| MonthlyCharges | 274.09 | 2.02e-60 |
| OnlineSecurity_Yes | 209.99 | 6.56e-47 |
| TechSupport_Yes | 193.65 | 1.92e-43 |

These results supported the later SQL segmentation strategy around contract type, fiber optic service, payment method, tenure buckets, and support-service adoption.

---

## XGBoost Churn Prediction Model

An XGBoost classifier was trained to predict customer churn.

### Baseline Model

The baseline XGBoost model achieved:

- **Accuracy**: 78.82%
- **ROC-AUC**: 0.8043

### Tuned Model

Hyperparameter tuning was performed using validation ROC-AUC.

Best validation result:

- **Best validation ROC-AUC**: 0.8655

Best parameters:

```python
{
    "gamma": 1.7414,
    "learning_rate": 0.0796,
    "max_depth": 4,
    "subsample": 0.5753
}



## SQL Server Churn Analytics Insights

After completing Python EDA, XGBoost modeling, and SHAP interpretation, I built a SQL Server analytics layer to convert churn model findings into business reporting views.

### Key Findings

- The overall churn rate was **26.58%**, with churned customers representing **30.53% of monthly revenue**.
- Month-to-month customers had the highest churn rate at **42.71%**, contributing **120,847.10** in churned monthly revenue.
- Fiber optic customers had a churn rate of **41.89%** and contributed **114,300.05** in churned monthly revenue, making them a high-value, high-risk segment.
- Electronic check customers had the highest payment-method churn rate at **45.29%**, with **84,288.75** in churned monthly revenue.
- Customers in the **0–12 month tenure bucket** had the highest churn rate at **47.68%**, indicating that churn risk is concentrated in the early customer lifecycle.
- Customers without Online Security had a churn rate of **41.78%**, compared with **14.64%** for customers with Online Security.
- Customers without Tech Support had a churn rate of **41.65%**, compared with **15.20%** for customers with Tech Support.
- The highest revenue-risk segment was **Month-to-month + Fiber optic + Electronic check**, with a churn rate of **60.37%** and **68,281.50** in churned monthly revenue.

### Business Recommendations

- Prioritize month-to-month customers for contract upgrade offers and retention campaigns.
- Focus onboarding and engagement efforts on customers in their first 12 months.
- Investigate service, pricing, or satisfaction issues among fiber optic customers.
- Encourage electronic check customers to migrate to automatic payment methods.
- Bundle Online Security and Tech Support services for high-risk customers.
- Use revenue-at-risk prioritization to focus retention efforts on segments with both high churn and high revenue exposure.
