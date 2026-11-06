# Repository Instructions

## Mission and audience
This repository is an Oracle Fusion Cloud HCM technical knowledge portfolio for an Oracle HCM Technical Consultant with 2+ years of experience. Write for HCM technical consultants, implementers, developers, and interviewers. Never imply the author delivered client work or implementations unless the owner explicitly supplies that fact.

## Scope
Cover Core HCM, HCM SQL, HDL/HSDL, Fast Formula, HCM Extracts, BI Publisher, OTBI, REST APIs, OIC, HCM security, Payroll, Absence, troubleshooting, data migration, and interview preparation. Do not add unrelated application content.

## Source and accuracy rules
- Use Oracle Help Center documentation as the primary source. Prefer the documentation for the current release and link to the specific page.
- Verify every Oracle object, column, API resource, payload attribute, HDL discriminator, METADATA attribute, and Fast Formula function against an official source before publishing it.
- Mark examples as **Oracle-documented**, **synthetic/illustrative**, or **requires tenant validation**. Do not claim a query or load was executed unless it was.
- Never fabricate error codes, output, configuration names, schema names, or supported actions. When a value is environment-specific, say how to confirm it in View Business Objects, REST API catalog, or the tenant.
- Protect personal data. All sample people, IDs, values, tenants, and output must be synthetic.

## Publication format
Every substantive publication must include these sections (adapt wording where the topic needs it):
1. Introduction
2. Business Requirement
3. Technical Explanation
4. Prerequisites
5. Step-by-Step Implementation
6. Complete Example (SQL/code/HDL where relevant)
7. Explanation of Important Statements
8. Expected Output (synthetic when output is illustrative)
9. Common Errors and Troubleshooting
10. Best Practices
11. Interview Questions and Answers (at least five questions with answers)
12. Official Oracle Documentation

Include assumptions, release/environment dependencies, security and performance considerations where relevant.

## Schedule, review, and Git discipline
- Follow PUBLICATION-CALENDAR.md and PUBLICATION-TRACKER.md. Target exactly two substantive publications per calendar week: one tutorial and one scenario/case study.
- Daily automation performs repository checks; it must not create an article on unscheduled days. On a scheduled day it may prepare one candidate draft and open a PR. Human review and merge are required for publication.
- Do not merge PRs or push directly to `main`. Make changes on a separate `codex/` branch and open a review PR.
- Search existing article titles and tracker entries before adding a topic. Do not create duplicate publications to make the schedule look active.
- If reliable official documentation is unavailable or the example cannot be validated, record a deferral in the tracker and preserve quality over schedule.
- Make focused, meaningful changes. Never create empty commits or claim checks passed unless they were run.
