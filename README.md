# Healthcare Data Analysis with SQL Queries

This project applies SQL analytics to healthcare data encompassing patient appointments, treatments, and billing information. Using advanced SQL techniques including **joins**, **common table expressions (CTEs)**, and **CASE expressions**, the analysis provides actionable insights into hospital operations, patient care, and revenue management.

---

## 🎯 Problem Statement

Hospitals often face challenges tracking patient appointments, treatment outcomes, and billing details in a unified manner. Without integrating these critical data sources, it is difficult to:

- Monitor service delivery effectively
- Identify potential revenue leakage
- Assess operational efficiency comprehensively

---

## ❓ Analytical Questions

This analysis focuses on retrieving details of appointments that are either **Completed** or **Scheduled**, combined with their associated treatment types, reasons for visit, and billing information including payment status, payment method, and amount paid.

The query aims to answer the following questions:

- Which treatments are most common for upcoming (Scheduled) versus completed appointments?
- How do payment statuses (Paid, Pending, Cancelled) correlate with appointment completion status?
- Are certain treatment types associated with higher cancellation or non-payment rates?
- Are certain payment methods linked to increased cancellation or non-payment rates?

---

## Key Features

- Integration of multiple healthcare data sources via SQL joins
- Use of Common Table Expressions (CTEs) for modular and readable queries
- Application of CASE logic to categorize costs and flag patient risk levels
- Detailed insights into revenue streams, payment patterns, and operational performance indicators

---

This repository includes SQL scripts for healthcare analytics that can be adapted for hospital data systems aiming to enhance patient care tracking and financial oversight.

## Query 1: Appointment + Treatment + Billing + Patient Integration
-- Purpose: Create a comprehensive view of appointment status, reasons for visit, treatment details, billing, and insurance provider.
-- Insight: Supports clinical + financial reporting by combining operational and billing data into one unified dataset.

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
