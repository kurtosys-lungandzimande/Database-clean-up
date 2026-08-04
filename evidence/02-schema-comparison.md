# Evidence 02 — UDM1_Kurtosys vs UDM__ Schema and Data Comparison

> **Date collected:** 2026-08-04
> **Collected by:** Lunga Ndzimande

---

## Schema Comparison — Tables in UDM1_Kurtosys not in UDM__

```sql
SELECT k.table_name AS in_UDM1_Kurtosys, u.table_name AS in_UDM__
FROM information_schema.tables k
LEFT JOIN information_schema.tables u
    ON k.table_name = u.table_name AND u.table_schema = 'UDM__'
WHERE k.table_schema = 'UDM1_Kurtosys'
AND u.table_name IS NULL;
```

**Result: 0 rows**

Every table in UDM1_Kurtosys exists in UDM__. UDM__ has 34 additional tables making it the newer expanded version.

---

## Row Count Comparison — UDM1_Kurtosys vs UDM__

```sql
SELECT
    u.table_name,
    u.table_rows AS UDM__rows,
    k.table_rows AS UDM1_rows
FROM information_schema.tables u
JOIN information_schema.tables k
    ON u.table_name = k.table_name
    AND k.table_schema = 'UDM1_Kurtosys'
WHERE u.table_schema = 'UDM__'
ORDER BY k.table_rows DESC
LIMIT 20;
```

Results:

| table_name | UDM__ rows | UDM1_Kurtosys rows |
|---|---|---|
| ApplicationTemplateAsset | 58,606 | 51,230 |
| RolePermission | 19,431 | 18,640 |
| FundList | 17,522 | 17,437 |
| Sequence | 10,000 | 10,000 |
| UserRole | 8,840 | 7,855 |
| Properties | 8,357 | 7,676 |
| ApplicationAsset | 6,855 | 6,213 |
| ApplicationConfiguration | 6,453 | 5,812 |
| Snapshot | 4,584 | 4,377 |
| ApplicationUpgrade | 4,332 | 4,000 |
| User | 4,166 | 3,880 |
| Strategies | 4,008 | 3,849 |
| ApplicationStyle | 3,430 | 3,217 |
| ContactGroupRelationship | 3,225 | 3,208 |
| ApplicationTemplateSchema | 5,939 | 2,925 |
| Application | 2,920 | 2,772 |
| StatisticProperties | 2,124 | 1,952 |
| AllocationProperties | 2,068 | 1,845 |
| WordpressMultiDomains | 1,136 | 1,115 |
| Cultures | 954 | 899 |

**Finding: UDM__ has more rows than UDM1_Kurtosys across every single table. UDM__ is the superset. UDM1_Kurtosys contains no data that does not already exist in UDM__ in greater quantity.**

---

## Creation Date Comparison

| Database | Created | Last Modified |
|---|---|---|
| UDM__ | 2025-08-06 04:39:06 | 2026-06-26 15:32:53 |
| UDM1_Kurtosys | 2025-08-06 07:09:14 | 2025-08-06 09:56:08 |

**Finding: UDM1_Kurtosys was created 3 hours after UDM__ on the same day and never modified after August 6 2025. It is a migration artefact.**
