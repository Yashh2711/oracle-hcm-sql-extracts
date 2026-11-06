# HDL Source Keys for Reference Data: Create and Maintain Grades

## Introduction
HCM Data Loader (HDL) uses pipe-delimited data files to create and maintain Oracle HCM business objects. This tutorial demonstrates an integration-owned source key with the Grade object. The file shape and Grade values are based on Oracle’s published example; names and codes are synthetic. This example was not executed in a tenant.

## Business Requirement
A source HR system owns grade reference data and needs stable identifiers so it can create grades and later update or reference them even if a user-facing name changes.

## Technical Explanation
An HDL data file has a component discriminator and ordered attributes on a `METADATA` line. Each data row uses an instruction such as `MERGE`. HDL uses the supplied key to find the record, then creates or updates according to existence and the component’s supported actions. The source key pair is `SourceSystemOwner` plus `SourceSystemId`. Oracle recommends source keys for integrations and migrations. If source and user keys are both present, the source key identifies the record, although required user-key attributes can still be needed on create.

## Prerequisites
- Confirm Grade attributes, keys, and supported actions in the target pod’s **View Business Objects** task.
- Register the chosen owner (Oracle’s example uses `VISION`) under lookup `HRC_SOURCE_SYSTEM_OWNER`, or use an already registered approved owner.
- Confirm GradeCode, SetCode, effective date, and ActiveStatus values for the destination configuration.
- Use a non-production pod, HDL access, UTF-8 text, and a ZIP with the `.dat` file at its root.

## Step-by-Step Implementation
1. Agree a stable, deterministic ID convention with the source-system owner.
2. Verify the exact component discriminator, attributes, key type, and required values in the target tenant.
3. Put the component layout on one `METADATA` line.
4. Supply each value in the exact metadata order on a `MERGE` line.
5. Save as `Grade.dat`, ZIP it, and submit through the tenant’s HDL process.
6. Review import and load results; fix rejected rows before promoting.
7. Reuse the same source owner and IDs on later updates and references.

## Complete Example
The layout and rows follow Oracle’s documented Grade example. Validate the schema and setup in the target pod before use.

```text
METADATA|Grade|SourceSystemOwner|SourceSystemId|GradeCode|SetCode|GradeName|EffectiveStartDate|ActiveStatus
MERGE|Grade|VISION|IC1|IND_CON_1|COMMON|Individual Contributor 1|2000/01/01|A
MERGE|Grade|VISION|IC2|IND_CON_2|COMMON|Individual Contributor 2|2000/01/01|A
MERGE|Grade|VISION|IC3|IND_CON_3|COMMON|Individual Contributor 3|2000/01/01|A
MERGE|Grade|VISION|MG1|MANAGER_1|COMMON|Manager 1|2000/01/01|A
MERGE|Grade|VISION|MG2|MANAGER_2|COMMON|Manager 2|2000/01/01|A
```

## Explanation of Important Statements
- `METADATA` introduces the component layout. `Grade` is its discriminator; attribute names are case-sensitive.
- `SourceSystemOwner` and `SourceSystemId` form a single source key. The integration should reuse that pair.
- `GradeCode` and `SetCode` are business-visible key values in the Oracle example. A source key does not remove functional requirements for creating the object.
- `MERGE` can create or update; it does not mean “always insert.”
- `EffectiveStartDate` and `ActiveStatus` appear in Oracle’s example. Check date-effective rules and field values against the current component definition.

## Expected Output
Illustrative reconciliation rows (synthetic; not an observed load result):

| SourceSystemOwner | SourceSystemId | GradeCode | SetCode | GradeName |
|---|---|---|---|---|
| VISION | IC1 | IND_CON_1 | COMMON | Individual Contributor 1 |
| VISION | IC2 | IND_CON_2 | COMMON | Individual Contributor 2 |
| VISION | MG1 | MANAGER_1 | COMMON | Manager 1 |

The tenant’s HDL import/load results determine whether a file actually succeeded.

## Common Errors and Troubleshooting
- **Unrecognized source owner:** confirm it is registered in `HRC_SOURCE_SYSTEM_OWNER` and that the value matches exactly.
- **Invalid discriminator or attribute:** compare with the current Grade component in View Business Objects; do not guess an attribute from another object.
- **Columns shifted:** count delimiters and ensure each row matches the metadata ordering.
- **Duplicate or unstable identifiers:** check uniqueness within the owner and confirm reruns reuse the source ID.
- **Invalid grade or set:** verify reference values and dates in the tenant’s setup.
- **Unexpected insert/update matching:** confirm the source-key pair and remove unintended competing key types. Oracle documents key precedence and says keys supplied together are not cross-validated.

## Best Practices
- Prefer stable source keys for records owned by an integration.
- Use the current tenant business-object definition, not a stale sample template.
- Document ID ownership and make generation repeatable.
- For updates, include changed attributes and the identifying key. Omitted fields remain unchanged; blank is not an explicit clear.
- Load reference data before dependent objects; review results between stages.
- Keep sample data synthetic and test in a non-production pod.

## Interview Questions and Answers
1. **What makes up an HDL source key?** `SourceSystemOwner` and `SourceSystemId` together.
2. **Why use a source key instead of a name or code?** User-key values can change; a stable source-owned ID supports later maintenance and references.
3. **Does MERGE always create?** No. HDL uses keys to identify the record and creates or updates when the operation is supported.
4. **What if multiple key types are supplied?** Oracle documents precedence as GUID, source key, surrogate ID, user key; HDL does not cross-check conflicting keys.
5. **How do you verify Grade attributes?** Use View Business Objects in the destination tenant and inspect the Grade component.
6. **How is an existing source key replaced?** Oracle documents using the Source Key business object and a `SourceKey.dat` file.

## Official Oracle Documentation
- [Build HCM Data Loader files](https://docs.oracle.com/en/cloud/saas/human-resources/facmh/build-hcm-data-loader-files.html)
- [HCM Data Loader Best Practices](https://docs.oracle.com/en/cloud/saas/human-resources/fahdl/hcm-data-loader-best-practices.html)
- [Supported Key Types](https://docs.oracle.com/en/cloud/saas/human-resources/fahdl/supported-key-types.html)
- [Create and Maintain Data with HCM Data Loader](https://docs.oracle.com/en/cloud/saas/human-resources/tutorial-hdl-load-files/index.html)
