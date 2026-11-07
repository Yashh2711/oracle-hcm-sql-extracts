/*
  US new-hire report — hire-date snapshot
  Bind variables (DATE): :P_FROM_DATE, :P_TO_DATE
  Validate access, bind handling, and object availability in the target reporting environment.
*/
WITH
hire_periods AS (
    SELECT ppos.person_id,
           ppos.period_of_service_id,
           ppos.date_start AS hire_date
      FROM per_periods_of_service ppos
     WHERE ppos.date_start >= TRUNC(:P_FROM_DATE)
       AND ppos.date_start <  TRUNC(:P_TO_DATE) + 1
),
us_legislation AS (
    SELECT DISTINCT pplf.person_id,
                    pplf.effective_start_date,
                    pplf.effective_end_date
      FROM per_people_legislative_f pplf
     WHERE pplf.legislation_code = 'US'
),
assignment_candidates AS (
    SELECT hp.person_id,
           hp.period_of_service_id,
           hp.hire_date,
           paam.assignment_id,
           paam.assignment_number,
           paam.assignment_type,
           paam.assignment_status_type_id,
           paam.primary_flag,
           paam.organization_id,
           paam.business_unit_id,
           paam.job_id,
           paam.location_id,
           ROW_NUMBER() OVER (
               PARTITION BY hp.period_of_service_id
               ORDER BY CASE paam.primary_flag WHEN 'Y' THEN 0 ELSE 1 END,
                        paam.effective_start_date DESC,
                        paam.effective_sequence DESC,
                        paam.assignment_id
           ) AS assignment_rank
      FROM hire_periods hp
      JOIN per_all_assignments_m paam
        ON paam.person_id = hp.person_id
       AND paam.period_of_service_id = hp.period_of_service_id
       AND paam.assignment_type = 'E'
       AND paam.effective_latest_change = 'Y'
       AND hp.hire_date BETWEEN paam.effective_start_date
                            AND paam.effective_end_date
),
hire_name AS (
    SELECT pn.person_id,
           pn.display_name,
           pn.effective_start_date,
           pn.effective_end_date
      FROM per_person_names_f_v pn
     WHERE pn.name_type = 'GLOBAL'
)
SELECT hp.hire_date,
       papf.person_number,
       hp.person_id,
       ac.period_of_service_id,
       ac.assignment_id,
       ac.assignment_number,
       ac.assignment_type,
       ac.assignment_status_type_id,
       ac.primary_flag,
       hn.display_name,
       dept.name AS department_name,
       ac.business_unit_id,
       ac.job_id,
       ac.location_id,
       sal.salary_amount,
       sal.currency_code
  FROM hire_periods hp
  JOIN us_legislation usl
    ON usl.person_id = hp.person_id
   AND hp.hire_date BETWEEN usl.effective_start_date
                        AND usl.effective_end_date
  JOIN per_all_people_f papf
    ON papf.person_id = hp.person_id
   AND hp.hire_date BETWEEN papf.effective_start_date
                        AND papf.effective_end_date
  JOIN assignment_candidates ac
    ON ac.period_of_service_id = hp.period_of_service_id
   AND ac.assignment_rank = 1
  LEFT JOIN hire_name hn
    ON hn.person_id = hp.person_id
   AND hp.hire_date BETWEEN hn.effective_start_date
                        AND hn.effective_end_date
  LEFT JOIN per_departments dept
    ON dept.organization_id = ac.organization_id
   AND hp.hire_date BETWEEN dept.effective_start_date
                        AND dept.effective_end_date
  LEFT JOIN cmp_salary sal
    ON sal.assignment_id = ac.assignment_id
   AND hp.hire_date BETWEEN sal.date_from AND sal.date_to
 ORDER BY hp.hire_date, papf.person_number, ac.assignment_id;
