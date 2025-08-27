-- 🔹 Query 2: Appointments by Treatment Type and Status with Avg + Median Cost
-- Purpose: Aggregate insights at the treatment level, split by appointment status.
-- Insight: Reveals cost trends, helps compare resource utilization between upcoming and completed appointments.

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

/*
Insights:
2️⃣ Observations / Insights

Chemotherapy

Scheduled appointments are more expensive than completed ones.

Suggests either newer treatments are costlier or upcoming sessions are billed differently.

ECG

Completed ECGs are higher cost than scheduled ones.

Could indicate additional tests or follow-ups during completed appointments.

MRI

Completed MRIs are more expensive on average than scheduled.

Median cost also higher, showing consistency in high-cost usage.

Physiotherapy

Costs are relatively stable across scheduled and completed appointments.

Slightly higher average for scheduled sessions.

X-Ray

Scheduled appointments are cheaper than completed ones.

Completed sessions may include additional services or repeat imaging.

3️⃣ Patterns & Potential Actions

Cost Trends: Some treatments (e.g., Chemotherapy, MRI) show increasing cost for scheduled appointments, suggesting upcoming billing could be higher.

Resource Planning: MRI and Chemotherapy have high-cost variance; hospitals may plan budget allocations accordingly.

Service Optimization: ECG and X-Ray completed appointments cost more; may need audit for efficiency or additional charges.
Results:
[
  {
    "treatment_type": "Chemotherapy",
    "status": "Completed",
    "total_appointments": "13",
    "avg_cost": 2107.42,
    "median_cost": 1472.17
  },
  {
    "treatment_type": "Chemotherapy",
    "status": "Scheduled",
    "total_appointments": "14",
    "avg_cost": 2931.0821428571426,
    "median_cost": 2842.995
  },
  {
    "treatment_type": "ECG",
    "status": "Completed",
    "total_appointments": "11",
    "avg_cost": 2867.805454545454,
    "median_cost": 2898.31
  },
  {
    "treatment_type": "ECG",
    "status": "Scheduled",
    "total_appointments": "9",
    "avg_cost": 2210.1744444444444,
    "median_cost": 1543.76
  },
  {
    "treatment_type": "MRI",
    "status": "Completed",
    "total_appointments": "8",
    "avg_cost": 3467.6674999999996,
    "median_cost": 3753.335
  },
  {
    "treatment_type": "MRI",
    "status": "Scheduled",
    "total_appointments": "10",
    "avg_cost": 2934.0469999999996,
    "median_cost": 3080.985
  },
  {
    "treatment_type": "Physiotherapy",
    "status": "Completed",
    "total_appointments": "10",
    "avg_cost": 2699.7419999999997,
    "median_cost": 2492.88
  },
  {
    "treatment_type": "Physiotherapy",
    "status": "Scheduled",
    "total_appointments": "8",
    "avg_cost": 2819.6800000000003,
    "median_cost": 2910.165
  },
  {
    "treatment_type": "X-Ray",
    "status": "Completed",
    "total_appointments": "4",
    "avg_cost": 2604.845,
    "median_cost": 2358.36
  },
  {
    "treatment_type": "X-Ray",
    "status": "Scheduled",
    "total_appointments": "10",
    "avg_cost": 1960.2069999999999,
    "median_cost": 1680.955
  }
]
*/
