#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — All Nodes
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-13
# Run on each node via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# Nodes: ew1r-aggr-03, ew1r-aggr-04, ew1r-leaf-05,
#        ew1r-leaf-06, ew1r-leaf-07, ew1r-leaf-08
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(find /var/lib/memsql/ -maxdepth 1 -mindepth 1 -type d | head -1)/data/snapshots"
NODE_NAME=$(hostname)

echo "--- Running on: $NODE_NAME ---"
echo "--- Orphaned snapshots to be deleted ---"
find "$SNAPSHOT_DIR" -maxdepth 1 -name "UDM1_Kurtosys_*" -ls

# ============================================================
# Delete UDM1_Kurtosys snapshots — applies to all nodes
# Note: DBAdmin_24062026_* snapshots already cleaned 2026-08-06
# ============================================================
rm -f "$SNAPSHOT_DIR"/UDM1_Kurtosys_*

# ============================================================
# Verify nothing was missed
# ============================================================
echo "--- Verifying cleanup ---"
REMAINING=$(find "$SNAPSHOT_DIR" -maxdepth 1 -name "UDM1_Kurtosys_*")
if [ -z "$REMAINING" ]; then
    echo "All orphaned snapshots deleted successfully."
else
    echo "WARNING — some files still remain:"
    echo "$REMAINING"
fi

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
