# Database Clean-Up — Release Environment (SingleStore)

## Overview

This repository documents the investigation, evidence, approval, and execution of database clean-up activities on the Ireland Release SingleStore cluster (ew1r).

## Scope

| Ticket | Description |
|---|---|
| Remove Unneeded Databases in the Rel_Env | Review and remove additional databases on the Release environment that are no longer needed |

## Cluster Details

| Property | Value |
|---|---|
| Environment | Ireland Release (ew1r) |
| Master Aggregator | ew1r-aggr-03.rel.kurtosys-internal.net (10.77.6.161) |
| Child Aggregator | ew1r-aggr-04.rel.kurtosys-internal.net (10.77.2.255) |
| Leaf Nodes | ew1r-leaf-05, ew1r-leaf-06, ew1r-leaf-07, ew1r-leaf-08 |
| SingleStore Version | 8.5.18 |

## Repository Structure

```
README.md                          ← This file
runbook/
  database-drop-runbook.md         ← Full runbook — evidence, decisions, drop scripts
evidence/
  01-database-inventory.md         ← All databases, table counts, row counts
  02-schema-comparison.md          ← UDM1_Kurtosys vs UDM__ comparison
  03-dbadmin-comparison.md         ← DBAdmin variants comparison
  04-backup-confirmation.md        ← S3 and snapshot backup evidence
  05-orphaned-snapshots.md         ← Orphaned snapshot files on disk
decisions/
  decisions-log.md                 ← What was dropped, what was kept and why
```

## Databases in Scope

| Database | Decision | Reason |
|---|---|---|
| `information_schema` | KEEP | System database — never drop |
| `UDM__` | KEEP | Active — last modified June 2026 |
| `DBAdmin` | KEEP | Original — clean name, retained |
| `SearchTest` | KEEP | Contains 256 unique rows not in UDM__ — needs further investigation |
| `UDM1_Kurtosys` | DROP | Migration artefact — frozen Aug 2025, superseded by UDM__ |
| `DBAdmin_24062026_Instant` | DROP | Identical duplicate of DBAdmin, dated copy never used |
| `DBAdmin_24062026_Instant_direct` | DROP | Identical duplicate of DBAdmin, dated copy never used |
| `DBAdmin_24062026_standard` | DROP | Identical duplicate of DBAdmin, dated copy never used |
| `DBAdmin_24062026_standard_direct` | DROP | Identical duplicate of DBAdmin, dated copy never used |

## Status

| Phase | Status |
|---|---|
| Investigation | ✅ Complete |
| Evidence gathered | ✅ Complete |
| Backup confirmed | ✅ Complete — S3 backups confirmed today (2026-08-04) |
| Stakeholder approval | ⏳ Pending |
| Execution | ⏳ Pending approval |
| Post-drop verification | ⏳ Pending |
