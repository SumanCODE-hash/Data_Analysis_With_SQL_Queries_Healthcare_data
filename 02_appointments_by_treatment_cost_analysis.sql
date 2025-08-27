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