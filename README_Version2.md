---
# Healthcare Data Analysis with SQL Queries

## 🚀 Overview

This repository demonstrates advanced SQL analytics to uncover operational and financial insights from healthcare data—including patient appointments, treatments, and billing information. The analysis utilizes SQL joins, common table expressions (CTEs), and Python visualizations to support hospital management in making data-driven decisions.

---

## 🎯 Problem Statement

Hospitals face challenges in unifying patient appointments, treatment outcomes, and billing details. Without integrated data, it is difficult to:

- Monitor service delivery and clinical outcomes
- Identify potential revenue leakage and optimize financial oversight
- Assess operational efficiency holistically
- Analyze healthcare demographics and workforce distribution

---

## ❓ Key Analytical Questions

This project aims to answer:

- Which treatments are most prevalent for scheduled vs. completed appointments?
- How do payment statuses (Paid, Pending, Cancelled) correlate with appointment completion?
- Are specific treatments or payment methods linked to higher cancellation or non-payment rates?

---

## 🛠️ Tools Used

- **PostgreSQL** for database management and querying
- **SQL** for data analysis and integration
- **Python** (pandas, matplotlib, seaborn) for visualization and reporting

---

## 📊 Example SQL Queries

### 1. Appointment + Treatment + Billing + Patient Integration
Create a unified view for clinical and financial reporting.

```sql
SELECT
    a.appointment_id,
    reason_for_visit,
    status AS appointment_status,
    b.amount,
    b.payment_status,
    b.payment_method,
    t.treatment_type,
    t.cost,
    p.insurance_provider,
    CASE 
        WHEN status = 'Completed' THEN 'Done'
        WHEN status = 'Scheduled' THEN 'Upcoming'
        ELSE 'Other'
    END AS status_category
FROM appointments AS a
LEFT JOIN treatments t ON t.appointment_id = a.appointment_id
LEFT JOIN billing b ON b.treatment_id = t.treatment_id
LEFT JOIN patients p ON p.patient_id = a.patient_id
WHERE status IN ('Completed', 'Scheduled');
```

*Additional queries and visualizations are included below for deeper insights into costs, payment trends, and demographic distribution.*

---

## 📈 Visualizations & Insights

- Median and Average Treatment Cost by Type and Status *(see: Images/Medain_VS_Avg_Cost_treatment.png)*
- Payment Method Analysis by Status *(see: Images/Avg_Vs_Median_Cost_on_payment_method.png)*
- Insurance Provider Payment Risks *(see: Images/Patient_Payment_Status_by_Insurance_Provider.png)*
- Demographic and workforce breakdowns *(see: Images/Patients_by_Gender.png, Images/Doctors_by_Hospital_Branch.png, etc.)*

---

## 📝 Executive Summary

**Key Insights:**

- MRI and Chemotherapy drive major revenue, but unpaid appointments pose risks
- Insurance payments represent highest cost treatments; follow-up is needed for failed or pending payments
- Strong patient retention indicated by frequent follow-up visits
- Workforce analysis highlights specialization gaps and branch staffing imbalances

---

## 🚩 How to Use This Repository

1. **Clone the repository** and set up the sample database using provided SQL scripts.
2. **Run the SQL queries** in PostgreSQL to extract insights.
3. **Use the Python scripts** to generate visualizations and reports.
4. **Adapt queries** for your own hospital data and operational needs.

---

## 📌 Conclusion

This integrated SQL and Python analysis provides actionable intelligence for hospital management. Addressing payment failures and optimizing resource allocation will help improve both financial performance and patient care outcomes.

---

## 📬 Contact & Contributions

For questions, contributions, or suggestions, please [open an issue](https://github.com/SumanCODE-hash/Data_Analysis_With_SQL_Queries_Healthcare_data/issues) or contact the project maintainer.

---