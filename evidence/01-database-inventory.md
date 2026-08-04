# Evidence 01 — Database Inventory

> **Date collected:** 2026-08-04
> **Cluster:** Ireland Release — ew1r SingleStore
> **Collected by:** Lunga Ndzimande

---

## All Databases in Scope

Query run on ew1r-aggr-03 (Master Aggregator):

```sql
SELECT table_schema, COUNT(*) AS tables,
       ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 2) AS size_gb
FROM information_schema.tables
GROUP BY table_schema
ORDER BY size_gb DESC;
```

Results:

| table_schema | tables | size_gb |
|---|---|---|
| DBAdmin_24062026_standard | 18 | 0.00 |
| UDM__ | 249 | 0.00 |
| DBAdmin_24062026_standard_direct | 18 | 0.00 |
| DBAdmin_24062026_Instant_direct | 18 | 0.00 |
| SearchTest | 3 | 0.00 |
| DBAdmin | 18 | 0.00 |
| UDM1_Kurtosys | 215 | 0.00 |
| information_schema | 193 | 0.00 |
| DBAdmin_24062026_Instant | 18 | 0.00 |

> Note: All databases show 0.00 GB on the aggregator — expected. Actual row data lives on leaf nodes.

---

## Database Creation and Last Modified Dates

```sql
SELECT table_schema,
       MIN(create_time) AS first_created,
       MAX(create_time) AS last_modified
FROM information_schema.tables
WHERE table_schema IN (
    'DBAdmin', 'DBAdmin_24062026_Instant', 'DBAdmin_24062026_Instant_direct',
    'DBAdmin_24062026_standard', 'DBAdmin_24062026_standard_direct',
    'UDM1_Kurtosys', 'UDM__', 'SearchTest'
)
GROUP BY table_schema
ORDER BY last_modified DESC;
```

Results:

| table_schema | first_created | last_modified |
|---|---|---|
| UDM__ | 2025-08-06 04:39:06 | 2026-06-26 15:32:53 |
| DBAdmin_24062026_standard | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_standard_direct | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_Instant_direct | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_Instant | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| UDM1_Kurtosys | 2025-08-06 07:09:14 | 2025-08-06 09:56:08 |
| SearchTest | 2024-07-17 06:24:05 | 2024-07-22 13:49:02 |

**Key findings:**
- UDM__ is the only actively maintained database — last modified June 2026
- UDM1_Kurtosys frozen since August 2025
- All 5 DBAdmin databases have identical timestamps — confirmed copies
- SearchTest last touched July 2024

---

## Active Connections Check

```sql
SELECT * FROM information_schema.PROCESSLIST
WHERE DB IN (
    'UDM1_Kurtosys',
    'DBAdmin_24062026_Instant',
    'DBAdmin_24062026_Instant_direct',
    'DBAdmin_24062026_standard',
    'DBAdmin_24062026_standard_direct'
);
```

**Result: 0 rows — no active connections to any of the 5 databases marked for deletion.**
