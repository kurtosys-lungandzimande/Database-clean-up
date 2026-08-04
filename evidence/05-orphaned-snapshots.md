# Evidence 05 — Orphaned Snapshot Files on Disk

> **Date confirmed:** 2026-07-28
> **Confirmed by:** Lunga Ndzimande
> **Server:** ew1r-aggr-04.rel.kurtosys-internal.net (i-0d36d94a301b8ddbc)
> **Access method:** EC2 Instance Connect

---

## What Are Orphaned Snapshots

SingleStore automatically creates snapshot files on disk when databases are snapshotted. When a database is dropped, the snapshot files on disk are NOT automatically deleted — they remain as orphaned files consuming disk space.

These orphaned snapshots must be manually deleted after the database drop.

---

## Full Snapshot Directory Listing

Command run on ew1r-aggr-04:

```bash
ls -lh /var/lib/memsql/11dbd517-1c12-42f7-87f1-ac38eb9a2ad4/data/snapshots/
```

Output:

```
total 38G
-rw------- 1 memsql memsql 173K Jun 24 13:56 DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840
-rw------- 1 memsql memsql 173K Jun 24 13:38 DBAdmin_24062026_Instant_snapshot_v1_0_1782840
-rw------- 1 memsql memsql 173K Jun 24 13:55 DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840
-rw------- 1 memsql memsql 173K Jun 24 13:33 DBAdmin_24062026_standard_snapshot_v1_0_1782840
-rw------- 1 memsql memsql 137K Jul 15  2025 DBAdmin_snapshot_v1_0_1758789
-rw------- 1 memsql memsql 137K Jul 15  2025 DBAdmin_snapshot_v1_0_1781617
-rw------- 1 memsql memsql 1.2M Aug  6  2025 SearchTest_snapshot_v1_0_1139
-rw------- 1 memsql memsql 1.2M Aug  6  2025 SearchTest_snapshot_v1_0_834
-rw------- 1 memsql memsql 6.2G Aug  6  2025 UDM1_Kurtosys_snapshot_v1_0_176143646078
-rw------- 1 memsql memsql 8.0G Aug 25  2025 UDM1_Kurtosys_snapshot_v1_0_176144118380
-rw------- 1 memsql memsql  12G Jul 24 10:29 UDM___snapshot_v1_0_176154955667
-rw------- 1 memsql memsql  12G Jul 28 09:33 UDM___snapshot_v1_0_176155093643
-rw------- 1 memsql memsql  54M Jul 28 10:36 cluster_snapshot_v1_0_15022222
-rw------- 1 memsql memsql  54M Jul 28 12:41 cluster_snapshot_v1_0_15024271
-rw------- 1 memsql memsql 4.1K Oct  7  2025 information_schema_snapshot_v1_0_0
-rw------- 1 memsql memsql 4.1K Jul 28 12:46 memsql_snapshot_v1_0_12972354
-rw------- 1 memsql memsql 4.1K Jul 28 14:11 memsql_snapshot_v1_0_12974405
```

---

## Orphaned Snapshots — Safe to Delete After DB Drop

| File | Size | Date | Action |
|---|---|---|---|
| UDM1_Kurtosys_snapshot_v1_0_176143646078 | 6.2 GB | 2025-08-06 | Delete after DROP DATABASE UDM1_Kurtosys |
| UDM1_Kurtosys_snapshot_v1_0_176144118380 | 8.0 GB | 2025-08-25 | Delete after DROP DATABASE UDM1_Kurtosys |
| DBAdmin_24062026_Instant_snapshot_v1_0_1782840 | 173K | 2026-06-24 | Delete after DROP DATABASE DBAdmin_24062026_Instant |
| DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840 | 173K | 2026-06-24 | Delete after DROP DATABASE DBAdmin_24062026_Instant_direct |
| DBAdmin_24062026_standard_snapshot_v1_0_1782840 | 173K | 2026-06-24 | Delete after DROP DATABASE DBAdmin_24062026_standard |
| DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840 | 173K | 2026-06-24 | Delete after DROP DATABASE DBAdmin_24062026_standard_direct |

**Total disk to be freed from orphaned snapshots: ~14.2 GB**

---

## Snapshots to KEEP — Do Not Touch

| File | Size | Reason |
|---|---|---|
| UDM___snapshot_v1_0_176154955667 | 12 GB | Active database — keep |
| UDM___snapshot_v1_0_176155093643 | 12 GB | Active database — keep |
| DBAdmin_snapshot_v1_0_1758789 | 137K | Active database — keep |
| DBAdmin_snapshot_v1_0_1781617 | 137K | Active database — keep |
| SearchTest_snapshot_v1_0_1139 | 1.2M | Under investigation — keep for now |
| SearchTest_snapshot_v1_0_834 | 1.2M | Under investigation — keep for now |
| cluster_snapshot_v1_0_* | 54M x2 | System snapshots — keep |
| information_schema_snapshot_v1_0_0 | 4.1K | System — keep |
| memsql_snapshot_v1_0_* | 4.1K x2 | System — keep |

---

## Disk Impact

| Before cleanup | After cleanup |
|---|---|
| 18 GB free (22%) | ~32 GB free (~41%) |

Deleting the orphaned snapshots frees ~14.2 GB on ew1r-aggr-04 which is currently the most disk-constrained node in the cluster.
