# Content Roadmap

## Portfolio outcomes
Build a practical Oracle Fusion Cloud HCM technical library that demonstrates verified platform knowledge, clear implementation reasoning, and responsible handling of tenant-specific behavior. Every article is educational and uses synthetic examples; it does not claim customer-project experience.

## Topic tracks
1. **Core HCM and security:** enterprise structures, people, work relationships, assignments, date effectivity, roles, and data access.
2. **SQL and reporting:** effective-dated joins, primary assignment selection, manager hierarchy, payroll/absence reporting, BI Publisher data models, OTBI subject areas, and performance.
3. **Data loading and migration:** HDL/HSDL file shape, source keys, dependencies, reconciliation, error handling, and migration sequencing.
4. **Rules and extracts:** Fast Formula contexts and database items, HCM Extract definitions, delivery, incremental processing, and troubleshooting.
5. **Integrations:** REST resources, Atom feeds, OIC orchestration, authentication patterns, pagination, retries, and error recovery.
6. **Troubleshooting and interviews:** repeatable diagnostic playbooks and scenario-based technical questions with sourced answers.

## 12-week plan
The dated two-publication calendar is maintained in [PUBLICATION-CALENDAR.md](PUBLICATION-CALENDAR.md). It rotates through the tracks and reserves one tutorial and one practical scenario each week. The initial pair is drafted in this PR for review; scheduled publication dates remain in the tracker.

## Article workflow
1. Select the next calendar slot and check the tracker and existing article titles for overlap.
2. Research Oracle Help Center documentation for the relevant release and object/resource.
3. Draft with the standard article sections in AGENTS.md.
4. Label code as documented or illustrative and explain tenant validation points.
5. Check official links, required sections, five answered interview questions, and consistency with the topic slot.
6. Submit a separate-branch PR. A human reviews technical accuracy and merges when ready.
7. Update the tracker after merge. A PR draft is not counted as published until merged.

## Scope limits
- Never invent Fusion table/view names, REST attributes or paths, HDL attributes, formula functions, or product setup options.
- For direct database examples, identify the reporting surface (for example, BI Publisher/OTBI or an approved reporting replica) and validate object access in the relevant environment.
- State when behavior depends on release, enabled features, security roles, legislation, or customer configuration.
- No real employee data or secrets belong in this repository.
