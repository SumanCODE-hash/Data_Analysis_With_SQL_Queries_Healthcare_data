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

