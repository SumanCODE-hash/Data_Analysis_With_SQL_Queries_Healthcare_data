-- 🔹 Query 3: Appointments by Payment Method and Status with Avg + Median Cost
-- Purpose: Examine how payment methods (cash, insurance, card) vary across completed and scheduled appointments.
-- Insight: Supports revenue-cycle management and payment strategy optimization.

SELECT
    b.payment_method,
    status,
    COUNT(*) AS total_appointments,
    AVG(t.cost) AS avg_cost,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY t.cost) AS median_cost
FROM appointments a
LEFT JOIN treatments t ON t.appointment_id = a.appointment_id
LEFT JOIN billing b ON b.treatment_id = t.treatment_id
WHERE status IN ('Completed', 'Scheduled')
GROUP BY b.payment_method, status;



/*
Insights:
Payment Method Insights

Cash:

Costs moderate. Scheduled appointments slightly more expensive than completed.

Median > average → a few low-cost appointments lower the mean.

Credit Card:

Costs stable between completed and scheduled.

Average > median → some high-cost treatments inflate the mean.

Insurance:

Most expensive treatments. Completed appointments much costlier than scheduled.

Median > average → skewed by some lower-cost treatments.

Overall Trends

Cost ranking (completed appointments): Insurance > Credit Card > Cash

Scheduled appointments are slightly higher for Cash/Credit Card; for Insurance, completed appointments are higher.
Results:
[
  {
    "payment_method": "Cash",
    "status": "Completed",
    "total_appointments": "10",
    "avg_cost": 2311.172,
    "median_cost": 2726.665
  },
  {
    "payment_method": "Cash",
    "status": "Scheduled",
    "total_appointments": "15",
    "avg_cost": 2670.1306666666665,
    "median_cost": 2960.14
  },
  {
    "payment_method": "Credit Card",
    "status": "Completed",
    "total_appointments": "24",
    "avg_cost": 2559.800833333333,
    "median_cost": 2291.67
  },
  {
    "payment_method": "Credit Card",
    "status": "Scheduled",
    "total_appointments": "18",
    "avg_cost": 2540.6044444444447,
    "median_cost": 2212.705
  },
  {
    "payment_method": "Insurance",
    "status": "Completed",
    "total_appointments": "12",
    "avg_cost": 3296.1266666666666,
    "median_cost": 3884.435
  },
  {
    "payment_method": "Insurance",
    "status": "Scheduled",
    "total_appointments": "18",
    "avg_cost": 2591.325555555555,
    "median_cost": 2681.19
  }
]
*/