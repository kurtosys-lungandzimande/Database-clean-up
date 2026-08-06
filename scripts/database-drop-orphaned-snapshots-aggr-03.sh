#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — ew1r-aggr-03
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-06
# Run on ew1r-aggr-03 via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(ls /var/lib/memsql/ | head -1)/data/snapshots"

# Confirm files exist before deleting
echo "--- Orphaned snapshots to be deleted ---"
ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026"

# Delete UDM1_Kurtosys snapshot — frees ~8.0 GB
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176144118380"

# Delete DBAdmin_24062026 snapshots
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
