# Publication Tracker

A candidate in a PR is **in review**, not published. Change its status to **Published** and record the merge date after the PR is merged. Each calendar week has two planned slots. The daily workflow prepares only a due slot and never pushes to `main`.

| Date | Type | Title | Official source URLs | Status | Article path |
|---|---|---|---|---|---|
| 2026-11-10 | Tutorial | HDL: Create and Maintain Reference Data with Stable Source Keys | https://docs.oracle.com/en/cloud/saas/human-resources/facmh/build-hcm-data-loader-files.html, https://docs.oracle.com/en/cloud/saas/human-resources/fahdl/hcm-data-loader-best-practices.html, https://docs.oracle.com/en/cloud/saas/human-resources/fahdl/supported-key-types.html | Draft in initial PR | articles/hdl-source-keys-reference-data.md |
| 2026-11-13 | Scenario | REST: Add a Work Relationship for a Rehire | https://docs.oracle.com/en/cloud/saas/human-resources/farws/Add_a_Work_Relationship.html, https://docs.oracle.com/en/cloud/saas/human-resources/farws/api-workers.html | Draft in initial PR | articles/rest-rehire-work-relationship.md |
| 2026-11-17 | Tutorial | Effective-Dated Assignment Reporting: Join and Date-Filter Design | https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perallassignmentsm-25478.html | Scheduled | articles/effective-dated-assignment-reporting.md |
| 2026-11-20 | Scenario | Troubleshooting: Why a Worker Appears More Than Once in a Report | https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perallassignmentsm-25478.html | Scheduled | articles/scenario-duplicate-worker-report-rows.md |
| 2026-11-24 | Tutorial | HCM Extracts: Data Groups, Records, Attributes, and Delivery | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/hcm-extracts-data-structure.md |
| 2026-11-27 | Scenario | Extract Scenario: Changes-Only Employee Feed Reconciliation | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/scenario-changes-only-extract.md |
| 2026-12-01 | Tutorial | BI Publisher: Build a Parameterized HCM Data Model | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/bi-publisher-parameterized-hcm-model.md |
| 2026-12-04 | Scenario | SQL Case Study: Current Primary Assignment with Synthetic Rows | https://docs.oracle.com/en/cloud/saas/human-resources/oedmh/perallassignmentsm-25478.html | Scheduled | articles/scenario-current-primary-assignment.md |
| 2026-12-08 | Tutorial | OTBI: Subject Areas, Analysis Filters, and Role-Based Access | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/otbi-subject-areas-filters-access.md |
| 2026-12-11 | Scenario | Troubleshooting: OTBI Analysis Returns No Worker Rows | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/scenario-otbi-no-worker-rows.md |
| 2026-12-15 | Tutorial | Fast Formula: Inputs, Contexts, Return Values, and Validation | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/fast-formula-inputs-contexts-validation.md |
| 2026-12-18 | Scenario | Formula Case Study: Derive an Illustrative Eligibility Flag | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/scenario-fast-formula-eligibility-flag.md |
| 2026-12-22 | Tutorial | HSDL: Spreadsheet Load Lifecycle and Validation | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/hsdl-spreadsheet-load-lifecycle.md |
| 2026-12-25 | Scenario | HDL Migration Scenario: Resolve Parent-Reference Load Order | https://docs.oracle.com/en/cloud/saas/human-resources/fahdl/supported-key-types.html | Scheduled | articles/scenario-hdl-parent-reference-order.md |
| 2026-12-29 | Tutorial | HCM REST: Read Workers Safely with Pagination and Field Selection | https://docs.oracle.com/en/cloud/saas/human-resources/farws/api-workers.html | Scheduled | articles/rest-workers-pagination-fields.md |
| 2027-01-01 | Scenario | OIC Scenario: Retry and Reconcile a Transient HCM REST Failure | https://docs.oracle.com/en/cloud/saas/human-resources/farws/api-workers.html | Scheduled | articles/scenario-oic-rest-retry-reconcile.md |
| 2027-01-05 | Tutorial | HCM Security: Roles, Privileges, and Data Access Overview | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/hcm-security-roles-privileges-data-access.md |
| 2027-01-08 | Scenario | Security Case Study: Diagnose Missing Person Data by Access Layer | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/scenario-security-missing-person-data.md |
| 2027-01-12 | Tutorial | Absence Reporting: Effective Dates and Absence Entry Concepts | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/absence-reporting-effective-dates.md |
| 2027-01-15 | Scenario | Troubleshooting: Reconcile an Absence Entry to a Report | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/scenario-absence-report-reconciliation.md |
| 2027-01-19 | Tutorial | Payroll Technical Concepts: Flow Results and Reporting Boundaries | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/payroll-flow-results-reporting.md |
| 2027-01-22 | Scenario | SQL Case Study: Validate a Payroll Results Extract at a High Level | https://docs.oracle.com/en/cloud/saas/human-resources/ | Scheduled | articles/scenario-payroll-results-reconciliation.md |
| 2027-01-26 | Tutorial | HCM Data Migration: Reconciliation Controls and Restart Strategy | https://docs.oracle.com/en/cloud/saas/human-resources/fahdl/hcm-data-loader-best-practices.html | Scheduled | articles/hcm-migration-reconciliation-restart.md |
| 2027-01-29 | Scenario | Interview Case Study: Design a Worker Integration with Auditable Recovery | https://docs.oracle.com/en/cloud/saas/human-resources/farws/api-workers.html | Scheduled | articles/scenario-worker-integration-interview.md |

## Status definitions
- **Scheduled**: planned; no article is approved or published.
- **Draft in initial PR**: prepared in the foundation PR; review is pending.
- **Draft PR**: generated for a scheduled slot and awaiting review.
- **Published**: human-reviewed and merged; record the merge date in the title/status cell or add a publication date note.
- **Deferred**: moved because adequate authoritative research or validation was unavailable; keep the slot visible and do not create filler.
