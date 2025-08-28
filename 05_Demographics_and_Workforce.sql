/*
Problem Statement:
Hospital management needs visibility into patient demographics and workforce distribution to optimize resource allocation, strengthen payer strategy, and ensure balanced care delivery across branches and specializations

Solution: Healthcare Demographics & Workforce Insights
*/

-- Counts patients grouped by gender to reveal demographic trends in the patient population.

SELECT
    COUNT(*) AS total_patients,
    p.gender
FROM patients p
GROUP BY p.gender;

-- Shows how many patients are associated with each insurance provider, useful for payer mix analysis.

SELECT
    COUNT(*) AS total_patients,
    p.insurance_provider
FROM patients p
GROUP BY p.insurance_provider;

-- Counts doctors in each hospital branch to highlight workforce distribution.

SELECT
    COUNT(*) AS total_doctors,
    d.hospital_branch
FROM doctors d
GROUP BY hospital_branch;

-- Summarizes the number of doctors by specialization, identifying strengths and potential gaps in expertise.

SELECT
    COUNT(*) AS total_doctors,
    d.specialization
FROM doctors d
GROUP BY d.specialization;

/*
Insights:
1️⃣ Observations / Insights
The hospital serves 50 patients, with a higher share of males (31) compared to females (19).

Insurance coverage is diverse, with MedCare Plus (18 patients) and WellnessCorp (16 patients) being the leading providers, while PulseSecure (10) and HealthIndia (6) cover fewer patients.

Workforce distribution shows Central Hospital has the highest doctor count (4), while Eastside and Westside Clinics each have 3 doctors, indicating relatively balanced staffing.

By specialization, Pediatrics dominates (5 doctors), suggesting strong child healthcare capacity, while Dermatology (3) and Oncology (2) have fewer specialists.

Overall, the data highlights a gender imbalance in patients, uneven insurance representation, and potential workforce gaps in specialized areas like oncology.
Results:
# 1. Patients by Gender
gender_data = {"M": 31, "F": 19}

# 2. Patients by Insurance Provider
insurance_data = {
    "WellnessCorp": 16,
    "HealthIndia": 6,
    "MedCare Plus": 18,
    "PulseSecure": 10
}

# 3. Doctors by Hospital Branch
branch_data = {
    "Westside Clinic": 3,
    "Eastside Clinic": 3,
    "Central Hospital": 4
}

# 4. Doctors by Specialization
specialization_data = {
    "Pediatrics": 5,
    "Dermatology": 3,
    "Oncology": 2
}
*/
