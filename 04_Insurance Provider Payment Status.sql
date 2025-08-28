/*
Problem Statement:

Management wants to assess insurance-linked revenue risks by analyzing how different insurance providers are performing in terms of payment status
(Paid, Pending, Failed). This helps identify providers with high pending or failed claims, guiding collection prioritization and follow-up actions to secure revenue.
*/

-- 🔹 Query 4: Insurance Provider Payment Status Breakdown
-- Purpose: Show how payments are distributed across insurance providers.
-- Insight: Highlights providers with high Pending/Failed payments, along with avgerage and medianl billing amounr,
helping prioritize follow-ups and assess revenue-at-risk by insurance partner.

    
```sql
SELECT
    COUNT (*)  AS total_patients,
    p.insurance_provider,
    b.payment_status,
    AVG(b.amount) AS billed_amount,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY b.amount) AS median_billed_amount
FROM patients p
LEFT JOIN billing b ON b.patient_id = p.patient_id
WHERE b.payment_method = 'Insurance'
GROUP BY p.insurance_provider, b.payment_status
ORDER BY total_patients DESC;
```
/*
Insights:
1️⃣ Observations / Insights
MedCare Plus insurance shows a high number of pending patient payments with the lowest median billed amounts, while paid and failed payments both have elevated billed values,
indicating inconsistency in collection success. PulseSecure’s paid and pending claims reflect higher median amounts, suggesting more expensive services but also increased 
payment risk.WellnessCorp and HealthIndia face challenges with failed and pending payments at relatively high median values, highlighting the need for targeted follow-up
and improved reimbursement processes to protect cash flow.

Results:
[
  {
    "total_patients": "12",
    "insurance_provider": "MedCare Plus",
    "payment_status": "Pending",
    "billed_amount": 2186.6474999999996,
    "median_billed_amount": 1581.4650000000001
  },
  {
    "total_patients": "11",
    "insurance_provider": "MedCare Plus",
    "payment_status": "Paid",
    "billed_amount": 3100.3536363636363,
    "median_billed_amount": 3288.15
  },
  {
    "total_patients": "10",
    "insurance_provider": "MedCare Plus",
    "payment_status": "Failed",
    "billed_amount": 2996.761,
    "median_billed_amount": 3276.755
  },
  {
    "total_patients": "6",
    "insurance_provider": "WellnessCorp",
    "payment_status": "Failed",
    "billed_amount": 2981.538333333334,
    "median_billed_amount": 3091.635
  },
  {
    "total_patients": "5",
    "insurance_provider": "PulseSecure",
    "payment_status": "Paid",
    "billed_amount": 3592.572,
    "median_billed_amount": 3690.71
  },
  {
    "total_patients": "5",
    "insurance_provider": "PulseSecure",
    "payment_status": "Pending",
    "billed_amount": 3245.042,
    "median_billed_amount": 3615.96
  },
  {
    "total_patients": "4",
    "insurance_provider": "WellnessCorp",
    "payment_status": "Pending",
    "billed_amount": 3521.8725,
    "median_billed_amount": 3815.66
  },
  {
    "total_patients": "4",
    "insurance_provider": "WellnessCorp",
    "payment_status": "Paid",
    "billed_amount": 2072.435,
    "median_billed_amount": 1720.335
  },
  {
    "total_patients": "3",
    "insurance_provider": "HealthIndia",
    "payment_status": "Failed",
    "billed_amount": 3460.1699999999996,
    "median_billed_amount": 2844.31
  },
  {
    "total_patients": "2",
    "insurance_provider": "PulseSecure",
    "payment_status": "Failed",
    "billed_amount": 2179.985,
    "median_billed_amount": 2179.985
  },
  {
    "total_patients": "2",
    "insurance_provider": "HealthIndia",
    "payment_status": "Pending",
    "billed_amount": 1327,
    "median_billed_amount": 1327
  }
]
*/



