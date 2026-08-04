# Decisions Log — Release Environment Database Clean-Up

> **Last updated:** 2026-08-04
> **Prepared by:** Lunga Ndzimande

---

## Summary

| Database | Decision | Status |
|---|---|---|
| `information_schema` | KEEP | Final |
| `UDM__` | KEEP | Final |
| `DBAdmin` | KEEP | Final |
| `SearchTest` | KEEP — pending investigation | On hold |
| `UDM1_Kurtosys` | DROP | Pending approval |
| `DBAdmin_24062026_Instant` | DROP | Pending approval |
| `DBAdmin_24062026_Instant_direct` | DROP | Pending approval |
| `DBAdmin_24062026_standard` | DROP | Pending approval |
| `DBAdmin_24062026_standard_direct` | DROP | Pending approval |

---

## Detailed Decisions

### information_schema — KEEP
Built-in SingleStore system database. Contains metadata about all databases, tables, and columns. Must never be dropped.

### UDM__ — KEEP
Active production database. 249 tables. Last modified June 2026. Live application connections confirmed. This is the current version of the UDM database and is the superset of UDM1_Kurtosys.

### DBAdmin — KEEP
Original DBAdmin database created 2023-10-05. Retained as the clean canonical version. All 4 dated copies are identical to this database.

### SearchTest — KEEP (pending investigation)
Despite the name, SearchTest contains real application data — 7,436 rows in the Properties table including KAPP property definitions (ISIN codes, Reuters codes, pricing types etc.) for clientId 2. Additionally, 256 rows exist in SearchTest.Properties that are not present in UDM__.Properties. This database cannot be dropped until the application team confirms what this data is and whether it is safe to remove. Also confirmed present in the production environment — requires cross-environment investigation.

### UDM1_Kurtosys — DROP
- Created 2025-08-06 at 07:09 — 3 hours after UDM__ on the same day
- Never modified after 2025-08-06 09:56
- Every table exists in UDM__ — UDM1_Kurtosys is a subset
- UDM__ has more rows across every single table
- No active connections confirmed
- S3 backup confirmed today (2026-08-04)
- Disk snapshots confirmed (Aug 2025)
- Confirmed migration artefact — safe to drop

### DBAdmin_24062026_Instant — DROP
- Identical schema to DBAdmin (18 tables)
- Identical row counts (TableId = 152 rows, all others = 0)
- Identical timestamps to DBAdmin
- Created 24 June 2026 as a dated copy — never used after creation
- S3 backup confirmed today (2026-08-04)
- Disk snapshot confirmed (Jun 2026)
- Safe to drop

### DBAdmin_24062026_Instant_direct — DROP
Same reasons as DBAdmin_24062026_Instant. Identical in every way.

### DBAdmin_24062026_standard — DROP
Same reasons as DBAdmin_24062026_Instant. Identical in every way.

### DBAdmin_24062026_standard_direct — DROP
Same reasons as DBAdmin_24062026_Instant. Identical in every way.

---

## Open Items

| Item | Owner | Status |
|---|---|---|
| Stakeholder approval for 5 drops | Manager / Application team | ⏳ Pending |
| SearchTest investigation — who owns it, what is clientId 2, what are the 256 unique rows | Application team | ⏳ Pending |
| SearchTest exists in prod — confirm if related to Rel SearchTest | Application team | ⏳ Pending |
