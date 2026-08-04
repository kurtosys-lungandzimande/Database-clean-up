# Database Clean-Up — Release Environment SingleStore
## Consolidated Summary

> **Status:** Pending Stakeholder Approval
> **Prepared by:** Lunga Ndzimande
> **Date:** 2026-08-04
> **Ticket:** Remove Unneeded Databases in the Rel_Env
> **Cluster:** Ireland Release — ew1r SingleStore (Master Aggregator: ew1r-aggr-03 / Child Aggregator: ew1r-aggr-04)

---

## Decision Summary

| Database | Decision | Reason |
|---|---|---|
| `information_schema` | KEEP | Built-in system database — must never be dropped |
| `UDM__` | KEEP | Active — 249 tables, last modified June 2026, live connections |
| `DBAdmin` | KEEP | Original canonical version |
| `SearchTest` | KEEP — on hold | 256 unique rows not in UDM__ — needs application team investigation |
| `UDM1_Kurtosys` | DROP — pending approval | Migration artefact, frozen Aug 2025, fully superseded by UDM__ |
| `DBAdmin_24062026_Instant` | DROP — pending approval | Identical copy of DBAdmin, never used after creation |
| `DBAdmin_24062026_Instant_direct` | DROP — pending approval | Identical copy of DBAdmin, never used after creation |
| `DBAdmin_24062026_standard` | DROP — pending approval | Identical copy of DBAdmin, never used after creation |
| `DBAdmin_24062026_standard_direct` | DROP — pending approval | Identical copy of DBAdmin, never used after creation |

---

## Why These Databases Are Being Dropped

### UDM1_Kurtosys

- Created 2025-08-06 at 07:09 — exactly 3 hours after UDM__ was created on the same day
- Never modified after 2025-08-06 09:56 — frozen for nearly a year
- Every single table in UDM1_Kurtosys exists in UDM__ — 0 tables unique to UDM1_Kurtosys
- UDM__ has more rows across every table — it is the superset
- No active connections confirmed
- Confirmed migration artefact — was never cleaned up after the migration completed

### DBAdmin_24062026_Instant / Instant_direct / standard / standard_direct

- All 4 are exact copies of DBAdmin — same schema (18 tables), same row counts, same timestamps
- Only table with data is TableId (152 rows) — identical across all 5 DBAdmin databases
- Created 24 June 2026 as test or migration copies — never used after creation
- Serve no purpose and consume unnecessary disk and snapshot storage

---

## Evidence

### Database Inventory

| Database | Tables | Created | Last Modified |
|---|---|---|---|
| UDM__ | 249 | 2025-08-06 04:39 | 2026-06-26 15:32 |
| UDM1_Kurtosys | 215 | 2025-08-06 07:09 | 2025-08-06 09:56 |
| DBAdmin | 18 | 2023-10-05 11:53 | 2026-03-23 09:58 |
| DBAdmin_24062026_Instant | 18 | 2023-10-05 11:53 | 2026-03-23 09:58 |
| DBAdmin_24062026_Instant_direct | 18 | 2023-10-05 11:53 | 2026-03-23 09:58 |
| DBAdmin_24062026_standard | 18 | 2023-10-05 11:53 | 2026-03-23 09:58 |
| DBAdmin_24062026_standard_direct | 18 | 2023-10-05 11:53 | 2026-03-23 09:58 |
| SearchTest | 3 | 2024-07-17 06:24 | 2024-07-22 13:49 |

Active connections check confirmed: **0 active connections** to any of the 5 databases marked for drop.

### UDM1_Kurtosys vs UDM__ — Row Count Comparison (top tables)

| Table | UDM__ rows | UDM1_Kurtosys rows |
|---|---|---|
| ApplicationTemplateAsset | 58,606 | 51,230 |
| RolePermission | 19,431 | 18,640 |
| FundList | 17,522 | 17,437 |
| Sequence | 10,000 | 10,000 |
| UserRole | 8,840 | 7,855 |
| Properties | 8,357 | 7,676 |
| ApplicationAsset | 6,855 | 6,213 |

UDM__ has more rows across every single table. UDM1_Kurtosys contains no data that does not already exist in UDM__ in greater quantity.

### DBAdmin Variants — All Identical

| Database | TableId rows | All other tables |
|---|---|---|
| DBAdmin | 152 | 0 |
| DBAdmin_24062026_Instant | 152 | 0 |
| DBAdmin_24062026_Instant_direct | 152 | 0 |
| DBAdmin_24062026_standard | 152 | 0 |
| DBAdmin_24062026_standard_direct | 152 | 0 |

Same schema, same data, same timestamps across all 5.

### Backup Confirmation — 2026-08-04

| Database | S3 Backup | Disk Snapshot | Data also in |
|---|---|---|---|
| UDM1_Kurtosys | ✅ Today (4.3 GB, multiple copies) | ✅ Aug 2025 | ✅ UDM__ (superset) |
| DBAdmin_24062026_Instant | ✅ Today | ✅ Jun 2026 | ✅ DBAdmin (identical) |
| DBAdmin_24062026_Instant_direct | ✅ Today | ✅ Jun 2026 | ✅ DBAdmin (identical) |
| DBAdmin_24062026_standard | ✅ Today | ✅ Jun 2026 | ✅ DBAdmin (identical) |
| DBAdmin_24062026_standard_direct | ✅ Today | ✅ Jun 2026 | ✅ DBAdmin (identical) |

S3 bucket: `ksys-ew1r-kapp-dbbackup` — backups running every 30 minutes, multiple copies available.

All 5 databases have **3 layers of protection** before the drop.

### Orphaned Snapshots on Disk (ew1r-aggr-04)

Snapshot directory: `/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/`

Confirmed live on 2026-08-04:

| Snapshot File | Size | Action |
|---|---|---|
| UDM1_Kurtosys_snapshot_v1_0_176143646078 | 6.2 GB | Delete after DROP |
| UDM1_Kurtosys_snapshot_v1_0_176144118380 | 8.0 GB | Delete after DROP |
| DBAdmin_24062026_Instant_snapshot_v1_0_1782840 | 173K | Delete after DROP |
| DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840 | 173K | Delete after DROP |
| DBAdmin_24062026_standard_snapshot_v1_0_1782840 | 173K | Delete after DROP |
| DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840 | 173K | Delete after DROP |

**Total orphaned snapshot disk to be freed: ~14.2 GB**

Note: SingleStore does not automatically delete snapshot files when a database is dropped — these must be manually removed after execution.

---

## Execution Plan

### Pre-Execution Checklist

- [ ] Written approval received from stakeholder
- [ ] No active connections confirmed (query below)
- [ ] S3 backups confirmed current
- [ ] Maintenance window agreed with team

### Step 1 — Confirm No Active Connections

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

Expected: 0 rows. If any rows return — stop and investigate.

### Step 2 — Drop the Databases

Run one at a time. Confirm each succeeds before running the next.

```sql
DROP DATABASE DBAdmin_24062026_Instant;
DROP DATABASE DBAdmin_24062026_Instant_direct;
DROP DATABASE DBAdmin_24062026_standard;
DROP DATABASE DBAdmin_24062026_standard_direct;
DROP DATABASE UDM1_Kurtosys;
```

### Step 3 — Delete Orphaned Snapshot Files

Connect to ew1r-aggr-04 via EC2 Instance Connect. Run as root:

```bash
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/UDM1_Kurtosys_snapshot_v1_0_176143646078"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/UDM1_Kurtosys_snapshot_v1_0_176144118380"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"
```

### Step 4 — Post-Drop Verification

```sql
-- Confirm databases are gone
SHOW DATABASES;

-- Confirm UDM__ and DBAdmin are still intact
SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema IN ('UDM__', 'DBAdmin')
GROUP BY table_schema;
```

```bash
# Confirm disk space freed
df -h /
```

Expected: ew1r-aggr-04 free disk increases from ~18 GB to ~32 GB.

### Rollback Plan

1. Restore from S3 — `ksys-ew1r-kapp-dbbackup` — today's backup available
2. Restore from disk snapshot on ew1r-aggr-04
3. Contact DevOps if S3 restore is needed

---

## Open Items

| Item | Owner | Status |
|---|---|---|
| Stakeholder approval to proceed with 5 drops | Manager / Application team | ⏳ Pending |
| SearchTest — confirm who owns it, what clientId 2 is, what the 256 unique rows are | Application team | ⏳ Pending |
| SearchTest also exists in prod — confirm if related | Application team | ⏳ Pending |

---

## Approval

| Role | Name | Approval | Date |
|---|---|---|---|
| Prepared by | Lunga Ndzimande | ✅ | 2026-08-04 |
| Stakeholder | | ⏳ Pending | |
