# REST Rehire Scenario: Add a Work Relationship

## Introduction
Oracle documents rehire as a scenario where a returning worker receives a new work relationship. This case study describes how to locate the worker resource, inspect current relationships, and submit the new relationship using the Workers REST child resource. It follows Oracle’s documented payload pattern; the example has not been executed.

## Business Requirement
A previously separated person is rehired. The integration must identify the existing worker, preserve historical relationship data, and create a new relationship effective on the approved rehire date with the required assignment details.

## Technical Explanation
The documented Workers resource base is `/hcmRestApi/resources/11.13.18.05/workers`. Each worker instance uses an Oracle-generated `workersUniqID`; clients must obtain it through the Workers collection and must not generate it. Work relationships are a child collection. Oracle’s rehire guidance says to retrieve the relationship collection, then POST the new relationship to `workers/{workersUniqID}/child/workRelationships`.

The request includes an effective date header. Worker create/update processing may involve cross-product postprocessing and take several minutes. Oracle directs bulk loads to HDL and bulk extracts to HCM Extracts.

## Prerequisites
- Non-production Fusion pod and an integration user with appropriate REST privileges and person data access.
- Approved rehire date and verified legal employer, worker type, business unit, location, action, manager and other required values.
- Confirm current date-effective history and business approval to rehire.
- Confirm resource version, required fields, and extensions in the tenant REST catalog.
- Use HTTPS and an approved secret store/client credential mechanism. Never commit passwords, tokens, or real worker data.

## Step-by-Step Implementation
1. GET the Workers collection. Use the tenant-supported query/filter and returned links to locate the person.
2. Copy the exact `workersUniqID` from the resource response. Do not substitute a person number.
3. GET that worker’s `child/workRelationships` collection and review the existing relationships.
4. Prepare the new relationship body and effective date from the approved transaction.
5. POST once to the child collection. Before retrying a timeout, reconcile whether the first request succeeded.
6. Review the response, allow for postprocessing, and verify the resulting work relationship and assignment in Fusion.

## Complete Example
Oracle documents this endpoint and payload structure. The duplicate `LegalEmployerName` property in its page’s sample has been removed here. Replace every placeholder and validate all reference values and required fields in the target tenant.

```http
GET https://<fusion-host>/hcmRestApi/resources/11.13.18.05/workers/<workersUniqID>/child/workRelationships
Accept: application/json
```

```http
POST https://<fusion-host>/hcmRestApi/resources/11.13.18.05/workers/<workersUniqID>/child/workRelationships
Content-Type: application/vnd.oracle.adf.resourceitem+json
REST-Framework-Version: 4
Effective-Of: RangeStartDate=2026-11-12
```

```json
{
  "LegalEmployerName": "Vision Corporation",
  "WorkerType": "E",
  "EnterpriseSeniorityDate": "2026-11-12",
  "LegalEmployerSeniorityDate": "2026-11-12",
  "PrimaryFlag": true,
  "assignments": [
    {
      "BusinessUnitName": "Vision Central",
      "LocationCode": "Pleasanton - CA",
      "ActionCode": "HIRE_ADD_WORK_RELATION",
      "AssignmentName": "Accounting",
      "AssignmentNumber": "<tenant-approved-assignment-number>",
      "managers": [{
        "ManagerAssignmentNumber": "<existing-manager-assignment-number>",
        "ManagerType": "LINE_MANAGER"
      }],
      "workMeasures": [
        { "Value": 1.0, "Unit": "FTE" },
        { "Value": 1, "Unit": "HEAD" }
      ]
    }
  ]
}
```

Use an approved REST client or secret store for authentication. Oracle’s example demonstrates HTTP Basic syntax; follow the authentication mechanism and policies configured by your organization. Do not put credentials in a shell command, script, or source file.

## Explanation of Important Statements
- The versioned path is copied from Oracle’s documentation; confirm the target pod’s supported API version.
- `workersUniqID` is an Oracle-generated hash key. Get it from the Workers response.
- `Effective-Of` supplies date-effective operation information; the start date must match the approved transaction.
- `LegalEmployerName`, `WorkerType`, `PrimaryFlag`, `assignments`, `managers`, and `workMeasures` follow Oracle’s published sample. Their values are tenant-dependent.
- `HIRE_ADD_WORK_RELATION` is the action shown in the Oracle example, not a guarantee that every tenant exposes or permits that action.
- Generated identifiers in a response should be read from Oracle responses/links, not fabricated in a later request.

## Expected Output
Oracle’s example shows a created response (HTTP 201) with period-of-service and nested assignment details. Actual status, generated IDs, and populated attributes depend on tenant configuration and postprocessing. This article gives an expected shape only, not a tested result.

## Common Errors and Troubleshooting
- **Cannot address worker:** retrieve the exact instance key from the Workers collection; a person number is not the documented hash key.
- **Authorization/access failure:** check both REST privileges and data access to the person.
- **Invalid reference values:** verify the legal employer, business unit, location, action code, manager, and units in the target pod.
- **Effective-date validation failure:** compare the header date with the approved transaction and existing history.
- **Duplicate after retry:** check whether the initial POST committed before resending. Reconcile first; a POST is not automatically safe to repeat.
- **Response accepted but assignment not yet visible:** allow for cross-product postprocessing, then verify the transaction before triggering dependent processing.

## Best Practices
- Use least-privilege integration access and keep credentials out of logs, source, and command history.
- Resolve worker keys from Oracle responses.
- Validate request shape and reference values in the tenant’s REST catalog.
- Keep a correlation/reconciliation record without unnecessary personal data or secrets.
- Build retries around transaction outcome and reconciliation.
- Use HDL for bulk loading and HCM Extracts for bulk extraction.

## Interview Questions and Answers
1. **What is `workersUniqID`?** Oracle’s hash key for a worker resource instance, obtained from the Workers resource.
2. **Why is work relationship a child endpoint?** Oracle models relationships under a worker and documents the rehire POST on that child collection.
3. **What does `Effective-Of` represent?** Effective-date operation details such as the range start date.
4. **Should REST be the default for a bulk hire load?** No. Oracle directs bulk loads to HDL.
5. **Why not blindly retry a timed-out POST?** The first request may have committed despite a lost response, creating a duplicate on retry.
6. **Can one request payload be reused unchanged across tenants?** No. Required attributes, reference values, security, and extensions must be verified in the destination release and pod.

## Official Oracle Documentation
- [Add a Work Relationship](https://docs.oracle.com/en/cloud/saas/human-resources/farws/Add_a_Work_Relationship.html)
- [Workers REST Endpoints](https://docs.oracle.com/en/cloud/saas/human-resources/farws/api-workers.html)
- [REST API for Oracle Fusion Cloud HCM](https://docs.oracle.com/en/cloud/saas/human-resources/farws/)
