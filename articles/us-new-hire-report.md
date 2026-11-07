# US New-Hire Report in Oracle Fusion HCM (SQL)

## Introduction

This report returns employee work relationships that start within a supplied date range and are associated with US legislation. It shows hire date, person and assignment identifiers, assignment type and status identifier, assignment number, primary flag, name, department, related organization identifiers, and salary with currency.

The SQL is an **illustrative, Oracle-documented-object example**. It has not been executed against a Fusion tenant. Validate object access and behavior in the target BI Publisher data model or reporting environment.

## Business Requirement

An HR reporting team needs a new-hire listing for a selected period, including the employee's hire-date assignment and salary details. “US” means a row in PER_PEOPLE_LEGISLATIVE_F with LEGISLATION_CODE = 'US' effective on the hire date. This is a legislation filter; it does not mean US citizenship, residence, or work location.

## Technical Explanation

The report uses PER_PERIODS_OF_SERVICE.DATE_START as the work-relationship start date. A rehire creates a later period of service and therefore appears as another hire event. PER_ALL_ASSIGNMENTS_M supplies the employment assignment in effect on that date. Department, person name, legislative record, person number, and salary are also checked against the hire date so the row represents a consistent hire-date snapshot.

The query selects one assignment per period of service. It prefers a primary assignment, then the latest effective start and sequence. If a business definition requires every concurrent assignment, remove the ranking filter and confirm the desired output grain.

## Prerequisites

- Run in a Fusion reporting context that grants access to the required secured objects.
- Configure P_FROM_DATE and P_TO_DATE as date parameters. The range includes both calendar dates.
- Confirm US legislation code values and name type GLOBAL match the tenant's data.
- Confirm salary visibility is appropriate for the report audience.
- Validate the reporting data source's supported objects and bind-variable syntax.

## Step-by-Step Implementation

1. Create a BI Publisher data model or equivalent SQL reporting object.
2. Add date parameters P_FROM_DATE and P_TO_DATE.
3. Paste the SQL below and set parameter data types to Date.
4. Grant only the appropriate report roles access to salary and person data.
5. Validate with synthetic or approved test records covering a hire, a rehire, a missing salary, and an assignment change on the hire date.
6. Compare a sample with the worker and salary pages in the tenant before promoting it.

## Complete SQL Example

See the companion [SQL file](../sql/us-new-hire-report.sql).

## Explanation of Important Statements

- DATE_START and the half-open date range (greater than or equal to start, less than end plus one) include all times on the end date without applying a function to the stored date column.
- PERIOD_OF_SERVICE_ID links the hire event to its assignment, avoiding confusion between a rehire and the person's first-ever hire.
- ASSIGNMENT_TYPE = 'E' limits selection to employee assignments. Confirm assignment-type codes against tenant configuration and release documentation.
- EFFECTIVE_LATEST_CHANGE = 'Y' and the effective-date predicate select the effective assignment row on the hire date.
- ROW_NUMBER makes the one-assignment-per-work-relationship output grain explicit and prioritizes the primary assignment.
- The LEFT JOIN to salary preserves a hire when a salary row is unavailable or not visible. Salary and currency are null in that case.
- Salary is not annualized. The amount uses its configured salary basis or frequency; do not compare values across salary bases without normalization.
- PER_DEPARTMENTS.NAME is joined by the assignment organization ID and effective date.

## Expected Output (Synthetic)

Illustrative output only; values are invented and have not been queried from an Oracle environment.

| HIRE_DATE | PERSON_NUMBER | PERSON_ID | PERIOD_OF_SERVICE_ID | ASSIGNMENT_ID | ASSIGNMENT_TYPE | DEPARTMENT_NAME | SALARY_AMOUNT | CURRENCY_CODE |
|---|---:|---:|---:|---:|---|---|---:|---|
| 2026-10-05 | 900104 | 50104 | 71004 | 81004 | E | People Operations | 82000 | USD |

## Common Errors and Troubleshooting

- **Duplicate people:** Check the report grain. This SQL returns one ranked employee assignment for each period of service; remove or adjust ranking only when multiple rows are intended.
- **Missing department:** Confirm the assignment has an organization ID and that the department is effective on the hire date.
- **Missing salary:** Confirm a salary row covers the hire date, and that the reporting user can access compensation data. A missing row is retained by design.
- **Unexpected US inclusion or exclusion:** Confirm the effective-dated legislative record and agree whether US means legislation, legal employer, residence, or work location.
- **Invalid bind variable:** Bind syntax can differ by reporting interface. Configure BI Publisher parameters and verify the exact generated bind names.
- **Assignment type differs:** Check assignment-type values supported in the tenant. This example includes E only.
- **Name is null:** Verify an effective GLOBAL name record exists; the name join is optional.

## Best Practices

- Use least-privilege report access, especially for salary.
- Keep date filters sargable and use parameters rather than hard-coded dates.
- Agree on report grain and how simultaneous assignments and rehires are counted.
- Label salary basis and frequency in a production report; amount plus currency alone may not explain the pay period.
- Test hire-date edge cases and reconcile results with the HCM application.
- Use a secured reporting source and follow tenant data retention and privacy policy.

## Interview Questions and Answers

1. **Why use PERIOD_OF_SERVICE_ID as part of the assignment join?**  
   It ties an assignment to a particular work relationship, including a later rehire period, instead of treating the person as having only one hire event.

2. **Why use a half-open hire-date range?**  
   Greater-than-or-equal start and less-than end-plus-one includes the full end calendar date without applying TRUNC to the stored date column.

3. **What does the US predicate mean here?**  
   It filters the effective-dated person legislative record to legislation code US. It does not filter citizenship, home address, or work location.

4. **Why is salary an outer join?**  
   The hire row remains visible when a salary record is absent, inaccessible, or not effective on the hire date.

5. **Does SALARY_AMOUNT always represent annual pay?**  
   No. It is stored according to the configured salary basis. A production report should expose salary basis and frequency or calculate annualized pay using a documented, tenant-validated approach.

6. **How would you report every assignment for a new hire?**  
   Remove the assignment_rank = 1 restriction, define the intended assignment-date logic, and accept that one work relationship may produce multiple rows.

## Official Oracle Documentation

- [PER_ALL_ASSIGNMENTS_M](https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perallassignmentsm-25478.html) — assignment identifiers, type, dates, sequence, and latest-change indicator.
- [Worker work relationship attributes](https://docs.oracle.com/en/cloud/saas/human-resources/faiau/attributes-for-worker-work-relationship.html) — work relationship date and identifier concepts.
- [PER_PEOPLE_F](https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perpeoplef-6356.html) — person identifiers, person number, and effective dates.
- [PER_PERSON_NAMES_F_V](https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perpersonnamesfv-7315.html) — effective-dated person names.
- [PER_DEPARTMENTS](https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perdepartments-6479.html) — department view, name, and effective-date join logic.
- [CMP_SALARY](https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/cmpsalary-23581.html) — salary amount, currency, assignment, and effective period.
- [Oracle Fusion HCM Analytics reference](https://docs.oracle.com/cd/G55130_01/trans/G49538-03/reference-fusion-hcm-analytics.pdf) — Oracle-documented use of PER_PEOPLE_LEGISLATIVE_F and LEGISLATION_CODE; verify objects in the target reporting environment.
