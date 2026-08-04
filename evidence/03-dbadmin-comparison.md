# Evidence 03 — DBAdmin Variants Comparison

> **Date collected:** 2026-08-04
> **Collected by:** Lunga Ndzimande

---

## Row Count Comparison Across All DBAdmin Databases

```sql
SELECT table_schema, table_name, table_rows
FROM information_schema.tables
WHERE table_schema IN (
    'DBAdmin',
    'DBAdmin_24062026_Instant',
    'DBAdmin_24062026_Instant_direct',
    'DBAdmin_24062026_standard',
    'DBAdmin_24062026_standard_direct'
)
ORDER BY table_name, table_schema;
```

Results (showing only tables with data):

| table_schema | table_name | table_rows |
|---|---|---|
| DBAdmin | TableId | 152 |
| DBAdmin_24062026_Instant | TableId | 152 |
| DBAdmin_24062026_Instant_direct | TableId | 152 |
| DBAdmin_24062026_standard | TableId | 152 |
| DBAdmin_24062026_standard_direct | TableId | 152 |

All other tables (17 of 18) have 0 rows across all 5 databases.

**Finding: All 5 DBAdmin databases are identical — same schema, same row counts, same data.**

---

## Timestamp Comparison

| Database | First Created | Last Modified |
|---|---|---|
| DBAdmin | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_Instant | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_Instant_direct | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_standard | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |
| DBAdmin_24062026_standard_direct | 2023-10-05 11:53:57 | 2026-03-23 09:58:31 |

**Finding: All 5 databases have identical timestamps. The 4 dated copies (DBAdmin_24062026_*) were created on 24 June 2026 as test or migration copies and were never used after creation.**

---

## Decision

- `DBAdmin` — **KEEP** — original clean name
- `DBAdmin_24062026_Instant` — **DROP** — identical duplicate
- `DBAdmin_24062026_Instant_direct` — **DROP** — identical duplicate
- `DBAdmin_24062026_standard` — **DROP** — identical duplicate
- `DBAdmin_24062026_standard_direct` — **DROP** — identical duplicate
