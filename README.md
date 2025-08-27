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
## Query 2: Appointments by Treatment Type and Status with Avg + Median Cost
-- Purpose: Aggregate insights at the treatment level, split by appointment status.
-- Insight: Reveals cost trends, helps compare resource utilization between upcoming and completed appointments.

```sql
SELECT
    t.treatment_type,
    status,
    COUNT(*) AS total_appointments,
    AVG(t.cost) AS avg_cost,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY t.cost) AS median_cost
FROM appointments a
LEFT JOIN treatments t ON t.appointment_id = a.appointment_id
LEFT JOIN billing b ON b.treatment_id = t.treatment_id
WHERE status IN ('Completed', 'Scheduled')
GROUP BY t.treatment_type, status;
```
---
### Vizualization
!(Images/Medain_VS_Avg_Cost_treatment.png)
## Key Insights

### 1. Appointment Statistics

| Metric               | Count | Percentage |
|----------------------|-------|------------|
| Total Appointments    | 120   | 100%       |
| Scheduled (Upcoming)  | 60    | 50%        |
| Completed (Done)      | 60    | 50%        |

### 2. Payment Status Overview

| Status   | Count | Percentage |
|----------|-------|------------|
| Paid     | 32    | 26.7%      |
| Pending  | 34    | 28.3%      |
| Failed   | 54    | 45%        |

*Nearly half of the appointments have failed payments, posing notable revenue risks.*

### 3. Payment Methods Distribution

| Method      | Count | Percentage |
|-------------|-------|------------|
| Cash        | 36    | 30%        |
| Credit Card | 34    | 28.3%      |
| Insurance   | 50    | 41.7%      |

*Insurance is the leading payment method but failed payments are high among cash and credit card users.*

### 4. Reason for Visit Breakdown

| Reason       | Count |
|--------------|-------|
| Follow-up    | 34    |
| Checkup      | 28    |
| Therapy      | 20    |
| Emergency    | 20    |
| Consultation | 18    |

*Follow-ups dominate, signaling strong patient retention.*

### 5. Treatment Type Frequency

| Treatment     | Count |
|---------------|-------|
| Chemotherapy  | 38    |
| ECG           | 22    |
| MRI           | 22    |
| Physiotherapy | 20    |
| X-Ray         | 18    |

*Chemotherapy treatments are most frequent, likely due to recurring sessions.*

### 6. Insurance Provider Counts

| Provider       | Count |
|----------------|-------|
| MedCare Plus   | 34    |
| WellnessCorp   | 30    |
| PulseSecure    | 28    |
| HealthIndia    | 28    |

*All providers show similar patient coverage; failed payments are widespread.*

### 7. Cost Analysis

| Metric                      | Value ($) |
|-----------------------------|-----------|
| Average Cost per Appointment | ~2,693    |
| Minimum Cost                 | 534       |
| Maximum Cost                 | 4,964     |

*Expensive treatments like Chemotherapy and MRI drive major revenue but pose financial risk if unpaid.*

### 8. Appointment Status Insights

- **Upcoming:** Frequent high-cost treatments like MRI and Chemotherapy with many pending or failed payments.
- **Completed:** Most payments successful but a concerning number remain unpaid, requiring follow-up.

### 9. Payment Method Cost Insights

- **Cash:** Moderate costs; scheduled appointments slightly more expensive than completed; median cost > average (skewed by low cost).
- **Credit Card:** Stable costs between completed and scheduled; average > median (skewed by high cost).
- **Insurance:** Highest cost treatments; completed appointments costlier than scheduled; median > average (skewed by low cost).

**Overall Cost Ranking (Completed Appointments):**  
`Insurance > Credit Card > Cash`

Scheduled appointment costs are higher for Cash and Credit Card, while Insurance costs dominate completed appointments.

---

## Conclusion

This integrated SQL analysis highlights critical operational and financial patterns in hospital appointment and billing datasets. Addressing payment failures, especially in high-cost treatments, and monitoring payment methods closely can help improve revenue collection and patient care efficiency.

---

Feel free to clone the repo and adapt the SQL queries to your own healthcare datasets for similar insights!
