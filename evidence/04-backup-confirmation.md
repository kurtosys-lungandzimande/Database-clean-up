# Evidence 04 — Backup Confirmation

> **Date confirmed:** 2026-08-04
> **Confirmed by:** Lunga Ndzimande

---

## S3 Backups — ksys-ew1r-kapp-dbbackup

Checked directly in AWS Console on 2026-08-04.

| Database | Most Recent Backup File | Date | Size |
|---|---|---|---|
| UDM1_Kurtosys | UDM1_Kurtosys_20260804_090504.tar.gz | 2026-08-04 | 4.3 GB |
| UDM1_Kurtosys | UDM1_Kurtosys_20260804_080504.tar.gz | 2026-08-04 | 4.3 GB |
| UDM1_Kurtosys | UDM1_Kurtosys_20260804_070502.tar.gz | 2026-08-04 | 4.3 GB |
| UDM1_Kurtosys | UDM1_Kurtosys_20260804_060504.tar.gz | 2026-08-04 | 4.3 GB |
| DBAdmin_24062026_Instant | Confirmed present | 2026-08-04 | — |
| DBAdmin_24062026_Instant_direct | Confirmed present | 2026-08-04 | — |
| DBAdmin_24062026_standard | Confirmed present | 2026-08-04 | — |
| DBAdmin_24062026_standard_direct | Confirmed present | 2026-08-04 | — |

Backups are running every 30 minutes. Multiple copies available for today.

---

## Disk Snapshots — ew1r-aggr-04

Snapshot directory: `/var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/`

| Snapshot File | Size | Date |
|---|---|---|
| UDM1_Kurtosys_snapshot_v1_0_176143646078 | 6.2 GB | 2025-08-06 |
| UDM1_Kurtosys_snapshot_v1_0_176144118380 | 8.0 GB | 2025-08-25 |
| DBAdmin_24062026_Instant_snapshot_v1_0_1782840 | 173K | 2026-06-24 |
| DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840 | 173K | 2026-06-24 |
| DBAdmin_24062026_standard_snapshot_v1_0_1782840 | 173K | 2026-06-24 |
| DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840 | 173K | 2026-06-24 |

> Note: UDM1_Kurtosys disk snapshots are from Aug 2025. The database has been frozen since Aug 2025 so the data has not changed — the snapshot is still valid as a restore point.

---

## Protection Summary

| Database | S3 Backup | Disk Snapshot | Data in Active DB |
|---|---|---|---|
| UDM1_Kurtosys | ✅ Today | ✅ Aug 2025 | ✅ All data exists in UDM__ |
| DBAdmin_24062026_Instant | ✅ Today | ✅ Jun 2026 | ✅ Identical to DBAdmin |
| DBAdmin_24062026_Instant_direct | ✅ Today | ✅ Jun 2026 | ✅ Identical to DBAdmin |
| DBAdmin_24062026_standard | ✅ Today | ✅ Jun 2026 | ✅ Identical to DBAdmin |
| DBAdmin_24062026_standard_direct | ✅ Today | ✅ Jun 2026 | ✅ Identical to DBAdmin |

All 5 databases have 3 layers of protection before the drop.
