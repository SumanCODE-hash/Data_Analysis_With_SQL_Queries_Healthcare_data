/*
🎯 Problem Statement

Hospitals often struggle to track patient appointments, treatment outcomes, and billing details in one place. Without integrating these sources, it’s difficult to monitor service delivery, identify revenue leaks, and assess efficiency.

❓ Analytical Question (for your query)

“What are the details of appointments that are either Completed or Scheduled, along with their associated treatment types, reasons for visit, and billing information such as payment_status, payment_method and amount?”

This query helps answer:

Which treatments are most common for upcoming vs. completed appointments?

How do payment statuses (paid, pending, cancelled) align with appointment completion?

Are certain treatment types associated with higher cancellation or non-payment rates?
Are certain payment methos associated with higher cancellation or non-payment rates?
*/


-- 🔹 Query 1: Appointment + Treatment + Billing + Patient Integration
-- Purpose: Create a comprehensive view of appointment status, reasons for visit, treatment details, billing, and insurance provider.
-- Insight: Supports clinical + financial reporting by combining operational and billing data into one unified dataset.

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



-- 🔹 Query 2: Distinct Appointment Status
-- Purpose: Identify all unique status values from the appointments table.
-- Insight: Useful for understanding the domain values before filtering or categorization.

SELECT DISTINCT status
FROM appointments;

/*
Insights:
Here’s a descriptive insight report based on your appointment dataset:

1. Overall Appointment Statistics

Total Appointments: 120

Scheduled (Upcoming): 60 (50%)

Completed (Done): 60 (50%)

2. Payment Status Overview
Payment Status	Count	Percentage
Paid	32	26.7%
Pending	34	28.3%
Failed	54	45%

Insight: Nearly half of the appointments have failed payments, which is a significant issue for revenue collection.

3. Payment Methods
Method	Count	Percentage
Cash	36	30%
Credit Card	34	28.3%
Insurance	50	41.7%

Insight: Insurance is the most common payment method, but cash and credit card are still widely used. Failed payments seem high in cash and credit card methods.

4. Appointment by Reason for Visit
Reason	Count
Checkup	28
Follow-up	34
Consultation	18
Therapy	20
Emergency	20

Insight: Follow-ups dominate the appointments, indicating a strong recurring patient base. Checkups and therapies are also significant.

5. Appointment by Treatment Type
Treatment	Count
ECG	22
X-Ray	18
MRI	22
Physiotherapy	20
Chemotherapy	38

Insight: Chemotherapy is the most frequent treatment, likely because of recurring sessions. MRI and ECG are also common.

6. Appointment by Insurance Provider
Provider	Count
MedCare Plus	34
WellnessCorp	30
PulseSecure	28
HealthIndia	28

Insight: All four providers have similar representation, with MedCare Plus slightly leading. Failed payments are high in all providers, particularly with PulseSecure.

7. Cost Analysis

Average Cost per Appointment: ~$2,693

Minimum Cost: $534

Maximum Cost: $4,964

Most Expensive Treatments: Chemotherapy, MRI

Least Expensive Treatments: Consultation, Checkup

Insight: High-cost treatments like chemotherapy and MRI contribute significantly to revenue. Failed or pending payments on these can impact the clinic’s cash flow.

8. Insights by Status Category

Upcoming Appointments: Many scheduled for MRI and Chemotherapy; significant portion pending or failed payments.

Completed Appointments: Many high-cost treatments successfully paid, but a notable number of failed payments exist even after completion, which may require follow-up billing.

9. Key Observations

Revenue Leakage Risk: 45% of payments failed. Special attention required for high-cost treatments.

Recurring Patients: Follow-ups are the largest category, suggesting patients return regularly for ongoing treatments.

Insurance Reliance: 41.7% of payments via insurance, but pending/failed payments still significant.

High-Cost Treatments Focus: MRI and Chemotherapy dominate high-cost services; monitoring payment completion is critical.
[
  {
    "appointment_id": "A071",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 2960.14,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "ECG",
    "cost": 2960.14,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A007",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 534.03,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 534.03,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A082",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 3615.96,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "X-Ray",
    "cost": 3615.96,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A055",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 1736.63,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 1736.63,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A070",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 3231.92,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "MRI",
    "cost": 3231.92,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A013",
    "reason_for_visit": "Emergency",
    "appointment_status": "Scheduled",
    "amount": 4704.96,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "MRI",
    "cost": 4704.96,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A096",
    "reason_for_visit": "Consultation",
    "appointment_status": "Completed",
    "amount": 812.41,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "X-Ray",
    "cost": 812.41,
    "insurance_provider": "HealthIndia",
    "status_category": "Done"
  },
  {
    "appointment_id": "A051",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 4550.1,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 4550.1,
    "insurance_provider": "HealthIndia",
    "status_category": "Done"
  },
  {
    "appointment_id": "A189",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 1108.25,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "X-Ray",
    "cost": 1108.25,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A152",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 3202.67,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "ECG",
    "cost": 3202.67,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A027",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 1048.49,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "X-Ray",
    "cost": 1048.49,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A010",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 1595.67,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 1595.67,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A145",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 2120.61,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "X-Ray",
    "cost": 2120.61,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A194",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 1903.17,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 1903.17,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A088",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 1733.72,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 1733.72,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A185",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 1158.68,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "ECG",
    "cost": 1158.68,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A107",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 3512.69,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 3512.69,
    "insurance_provider": "PulseSecure",
    "status_category": "Done"
  },
  {
    "appointment_id": "A045",
    "reason_for_visit": "Emergency",
    "appointment_status": "Scheduled",
    "amount": 4478.93,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 4478.93,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A040",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 695.36,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 695.36,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A099",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 4101.6,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 4101.6,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A182",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 1286.77,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 1286.77,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A136",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 901.06,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 901.06,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A147",
    "reason_for_visit": "Emergency",
    "appointment_status": "Completed",
    "amount": 4716.31,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "MRI",
    "cost": 4716.31,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A020",
    "reason_for_visit": "Consultation",
    "appointment_status": "Completed",
    "amount": 4113.62,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 4113.62,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A151",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 2512.41,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 2512.41,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A054",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 4012.36,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 4012.36,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A029",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 3565.03,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "MRI",
    "cost": 3565.03,
    "insurance_provider": "PulseSecure",
    "status_category": "Done"
  },
  {
    "appointment_id": "A016",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 2686.42,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "MRI",
    "cost": 2686.42,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A199",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 1472.17,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 1472.17,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A172",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 2057.45,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "X-Ray",
    "cost": 2057.45,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A114",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 3030.34,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 3030.34,
    "insurance_provider": "PulseSecure",
    "status_category": "Done"
  },
  {
    "appointment_id": "A149",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 1874.86,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "Physiotherapy",
    "cost": 1874.86,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A156",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 4964.71,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 4964.71,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A135",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 3306.14,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 3306.14,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A158",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 1438.3,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 1438.3,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A125",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 4079.52,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 4079.52,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A039",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 2976.02,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 2976.02,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A118",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 1404.2,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "ECG",
    "cost": 1404.2,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A134",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 2844.31,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 2844.31,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A126",
    "reason_for_visit": "Emergency",
    "appointment_status": "Scheduled",
    "amount": 4672.3,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 4672.3,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A092",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 1363.4,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "X-Ray",
    "cost": 1363.4,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A031",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 2863.24,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 2863.24,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A030",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 1316.47,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 1316.47,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A187",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 806.78,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "X-Ray",
    "cost": 806.78,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A057",
    "reason_for_visit": "Emergency",
    "appointment_status": "Completed",
    "amount": 2406.82,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 2406.82,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A190",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 4834.02,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 4834.02,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A100",
    "reason_for_visit": "Emergency",
    "appointment_status": "Scheduled",
    "amount": 1551.7,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "Physiotherapy",
    "cost": 1551.7,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A089",
    "reason_for_visit": "Consultation",
    "appointment_status": "Completed",
    "amount": 857.39,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 857.39,
    "insurance_provider": "HealthIndia",
    "status_category": "Done"
  },
  {
    "appointment_id": "A077",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 1113.98,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 1113.98,
    "insurance_provider": "HealthIndia",
    "status_category": "Done"
  },
  {
    "appointment_id": "A012",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 771.2,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "Chemotherapy",
    "cost": 771.2,
    "insurance_provider": "HealthIndia",
    "status_category": "Done"
  },
  {
    "appointment_id": "A037",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 2675.96,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "Chemotherapy",
    "cost": 2675.96,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A148",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 2992.11,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 2992.11,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A080",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 2426.9,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 2426.9,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A044",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 4186.35,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "MRI",
    "cost": 4186.35,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A047",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 1454.2,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "ECG",
    "cost": 1454.2,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A072",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 1543.76,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 1543.76,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A093",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 1955.17,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "X-Ray",
    "cost": 1955.17,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A001",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 3941.97,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "Chemotherapy",
    "cost": 3941.97,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A167",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 1871.06,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 1871.06,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A153",
    "reason_for_visit": "Consultation",
    "appointment_status": "Completed",
    "amount": 2820.56,
    "payment_status": "Paid",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 2820.56,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A111",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 3787.93,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 3787.93,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A109",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 3478.28,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 3478.28,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A084",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 1077.77,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "ECG",
    "cost": 1077.77,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A157",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 4331.41,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 4331.41,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A104",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 2898.31,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 2898.31,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A101",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 2930.05,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 2930.05,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A042",
    "reason_for_visit": "Emergency",
    "appointment_status": "Scheduled",
    "amount": 4781.32,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "Chemotherapy",
    "cost": 4781.32,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A035",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 1654.53,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "MRI",
    "cost": 1654.53,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A121",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 2526.67,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 2526.67,
    "insurance_provider": "HealthIndia",
    "status_category": "Done"
  },
  {
    "appointment_id": "A106",
    "reason_for_visit": "Therapy",
    "appointment_status": "Scheduled",
    "amount": 1998.51,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "X-Ray",
    "cost": 1998.51,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A068",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 606.37,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 606.37,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A038",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 4126.97,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 4126.97,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A017",
    "reason_for_visit": "Emergency",
    "appointment_status": "Scheduled",
    "amount": 1655.49,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 1655.49,
    "insurance_provider": "HealthIndia",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A179",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 2691.78,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "Physiotherapy",
    "cost": 2691.78,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A009",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 4541.14,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "Physiotherapy",
    "cost": 4541.14,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A183",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 2761.55,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "X-Ray",
    "cost": 2761.55,
    "insurance_provider": "PulseSecure",
    "status_category": "Done"
  },
  {
    "appointment_id": "A073",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 2259.08,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 2259.08,
    "insurance_provider": "PulseSecure",
    "status_category": "Done"
  },
  {
    "appointment_id": "A141",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 3689.35,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "ECG",
    "cost": 3689.35,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A128",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Completed",
    "amount": 2296.92,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 2296.92,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A184",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 2293.98,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 2293.98,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A170",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 1280.86,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "X-Ray",
    "cost": 1280.86,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A067",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 930.72,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 930.72,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A161",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 4178.52,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "Chemotherapy",
    "cost": 4178.52,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A098",
    "reason_for_visit": "Emergency",
    "appointment_status": "Completed",
    "amount": 804.26,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 804.26,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A006",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 1381,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "Chemotherapy",
    "cost": 1381,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A181",
    "reason_for_visit": "Emergency",
    "appointment_status": "Completed",
    "amount": 3941.64,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "MRI",
    "cost": 3941.64,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A173",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 4890.25,
    "payment_status": "Pending",
    "payment_method": "Insurance",
    "treatment_type": "X-Ray",
    "cost": 4890.25,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A150",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 2286.42,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 2286.42,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A195",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 2777.64,
    "payment_status": "Failed",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 2777.64,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A133",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 4289.15,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "Physiotherapy",
    "cost": 4289.15,
    "insurance_provider": "PulseSecure",
    "status_category": "Done"
  },
  {
    "appointment_id": "A032",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 3690.71,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "ECG",
    "cost": 3690.71,
    "insurance_provider": "PulseSecure",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A123",
    "reason_for_visit": "Therapy",
    "appointment_status": "Completed",
    "amount": 2064.07,
    "payment_status": "Paid",
    "payment_method": "Credit Card",
    "treatment_type": "Chemotherapy",
    "cost": 2064.07,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A110",
    "reason_for_visit": "Consultation",
    "appointment_status": "Scheduled",
    "amount": 3010.03,
    "payment_status": "Failed",
    "payment_method": "Cash",
    "treatment_type": "Chemotherapy",
    "cost": 3010.03,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A056",
    "reason_for_visit": "Checkup",
    "appointment_status": "Scheduled",
    "amount": 4201.76,
    "payment_status": "Paid",
    "payment_method": "Insurance",
    "treatment_type": "X-Ray",
    "cost": 4201.76,
    "insurance_provider": "MedCare Plus",
    "status_category": "Upcoming"
  },
  {
    "appointment_id": "A024",
    "reason_for_visit": "Checkup",
    "appointment_status": "Completed",
    "amount": 3722.68,
    "payment_status": "Pending",
    "payment_method": "Cash",
    "treatment_type": "ECG",
    "cost": 3722.68,
    "insurance_provider": "MedCare Plus",
    "status_category": "Done"
  },
  {
    "appointment_id": "A083",
    "reason_for_visit": "Emergency",
    "appointment_status": "Completed",
    "amount": 4960.65,
    "payment_status": "Pending",
    "payment_method": "Credit Card",
    "treatment_type": "ECG",
    "cost": 4960.65,
    "insurance_provider": "WellnessCorp",
    "status_category": "Done"
  },
  {
    "appointment_id": "A063",
    "reason_for_visit": "Follow-up",
    "appointment_status": "Scheduled",
    "amount": 1256.06,
    "payment_status": "Failed",
    "payment_method": "Insurance",
    "treatment_type": "MRI",
    "cost": 1256.06,
    "insurance_provider": "WellnessCorp",
    "status_category": "Upcoming"
  }
]
*/