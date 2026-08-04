# Database Drop Runbook — Release Environment SingleStore

> **Status:** Pending Stakeholder Approval
> **Prepared by:** Lunga Ndzimande
> **Date:** 2026-08-04
> **Ticket:** Remove Unneeded Databases in the Rel_Env
> **Cluster:** Ireland Release — ew1r SingleStore

---

## Purpose

This runbook documents the investigation findings, evidence, approval requirements, and step-by-step execution plan for dropping 5 confirmed unnecessary databases from the Ireland Release SingleStore cluster.

This runbook must not be executed until written stakeholder approval is obtained.

---

## Why These Databases Are Being Dropped

### UDM1_Kurtosys

UDM1_Kurtosys was created on 2025-08-06 at 07:09 — exactly 3 hours after UDM__ was created on the same day. It was populated with data and never modified again after 2025-08-06 09:56. UDM__ has been actively maintained up to June 2026 and contains 34 additional tables that UDM1_Kurtosys does not have.

Investigation confirmed that every single table in UDM1_Kurtosys exists in UDM__ and UDM__ has more rows across every table. UDM1_Kurtosys is a migration artefact from August 2025 that was never cleaned up.

Keeping it wastes approximately 50–60 GB of disk space across the leaf nodes and contributes to the disk pressure on ew1r-aggr-04 which triggered a Zabbix disk space alert on 2026-07-28.

### DBAdmin_24062026_Instant, DBAdmin_24062026_Instant_direct, DBAdmin_24062026_standard, DBAdmin_24062026_standard_direct

All 4 databases are exact copies of DBAdmin created on 24 June 2026. They have identical schemas (18 tables each), identical row counts (only TableId has 152 rows — same across all 5 including the original DBAdmin), and identical last modified dates (2026-03-23).

These were created as part of a test or migration exercise on 24 June 2026 and were never used after creation. They serve no purpose and are consuming disk space and snapshot storage unnecessarily.

---

## Databases Kept and Why

| Database | Reason Kept |
|---|---|
| `information_schema` | Built-in SingleStore system database — must never be dropped |
| `UDM__` | Active — 249 tables, last modified June 2026, live application connections |
| `DBAdmin` | Original — retained as the clean canonical version |
| `SearchTest` | Contains 256 unique rows in Properties table not present in UDM__ — needs further investigation |

---

## Pre-Execution Checklist

- [ ] Written approval received from stakeholder
- [ ] No active connections to any of the 5 databases confirmed
- [ ] S3 backups confirmed current
- [ ] Disk snapshot files confirmed present
- [ ] Maintenance window agreed with team
- [ ] Post-drop verification plan in place

---

## Backup Confirmation

### S3 Backups — Confirmed 2026-08-04

| Database | S3 Bucket | Most Recent Backup | Size |
|---|---|---|---|
| `UDM1_Kurtosys` | ksys-ew1r-kapp-dbbackup | 2026-08-04 (today) | 4.3 GB |
| `DBAdmin_24062026_Instant` | ksys-ew1r-kapp-dbbackup | 2026-08-04 (today) | Confirmed |
| `DBAdmin_24062026_Instant_direct` | ksys-ew1r-kapp-dbbackup | 2026-08-04 (today) | Confirmed |
| `DBAdmin_24062026_standard` | ksys-ew1r-kapp-dbbackup | 2026-08-04 (today) | Confirmed |
| `DBAdmin_24062026_standard_direct` | ksys-ew1r-kapp-dbbackup | 2026-08-04 (today) | Confirmed |

### Disk Snapshots — Confirmed on ew1r-aggr-04

| Snapshot File | Size | Date |
|---|---|---|
| UDM1_Kurtosys_snapshot_v1_0_176143646078 | 6.2 GB | 2025-08-06 |
| UDM1_Kurtosys_snapshot_v1_0_176144118380 | 8.0 GB | 2025-08-25 |
| DBAdmin_24062026_Instant_snapshot_v1_0_1782840 | 173K | 2026-06-24 |
| DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840 | 173K | 2026-06-24 |
| DBAdmin_24062026_standard_snapshot_v1_0_1782840 | 173K | 2026-06-24 |
| DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840 | 173K | 2026-06-24 |

---

## Execution Steps

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

---

### Step 2 — Record Pre-Drop State

```sql
SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema IN (
    'UDM1_Kurtosys',
    'DBAdmin_24062026_Instant',
    'DBAdmin_24062026_Instant_direct',
    'DBAdmin_24062026_standard',
    'DBAdmin_24062026_standard_direct'
)
GROUP BY table_schema;
```

---

### Step 3 — Drop the Databases

Run one at a time. Confirm each succeeds before running the next.

```sql
DROP DATABASE DBAdmin_24062026_Instant;
```

```sql
DROP DATABASE DBAdmin_24062026_Instant_direct;
```

```sql
DROP DATABASE DBAdmin_24062026_standard;
```

```sql
DROP DATABASE DBAdmin_24062026_standard_direct;
```

```sql
DROP DATABASE UDM1_Kurtosys;
```

---

### Step 4 — Delete Orphaned Snapshot Files

Connect to ew1r-aggr-04 via EC2 Instance Connect. Run as root:

```bash
# Confirm files exist before deleting
ls -lh /var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/ | grep -E "UDM1_Kurtosys|DBAdmin_24062026"
```

```bash
# Delete UDM1_Kurtosys orphaned snapshots — frees 14.2 GB
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/UDM1_Kurtosys_snapshot_v1_0_176143646078"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/UDM1_Kurtosys_snapshot_v1_0_176144118380"
```

```bash
# Delete DBAdmin dated copy snapshots
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"
```

---

### Step 5 — Verify Disk Space Freed

```bash
df -h /
```

Expected: Available disk on ew1r-aggr-04 increases from current 18 GB free.

---

### Step 6 — Post-Drop Verification

```sql
-- Confirm databases are gone
SHOW DATABASES;
```

```sql
-- Confirm UDM__ and DBAdmin are still intact
SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema IN ('UDM__', 'DBAdmin')
GROUP BY table_schema;
```

---

## Rollback Plan

1. S3 backups available in `ksys-ew1r-kapp-dbbackup` — restore from today's backup
2. Disk snapshots available on ew1r-aggr-04
3. Contact DevOps to restore from S3 if needed

---

## Approval

| Role | Name | Approval | Date |
|---|---|---|---|
| Prepared by | Lunga Ndzimande | ✅ | 2026-08-04 |
| Manager / Stakeholder | | ⏳ Pending | |
| Application Team | | ⏳ Pending | |

---

## Execution Log

| Step | Action | Result | Time | Executed By |
|---|---|---|---|---|
| 1 | Confirm no active connections | | | |
| 2 | Record pre-drop state | | | |
| 3a | DROP DATABASE DBAdmin_24062026_Instant | | | |
| 3b | DROP DATABASE DBAdmin_24062026_Instant_direct | | | |
| 3c | DROP DATABASE DBAdmin_24062026_standard | | | |
| 3d | DROP DATABASE DBAdmin_24062026_standard_direct | | | |
| 3e | DROP DATABASE UDM1_Kurtosys | | | |
| 4 | Delete orphaned snapshot files | | | |
| 5 | Verify disk space freed | | | |
| 6 | Post-drop verification | | | |
