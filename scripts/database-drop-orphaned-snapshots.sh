#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — All Nodes
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-06
# Run on each node via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# Nodes: ew1r-aggr-03, ew1r-aggr-04, ew1r-leaf-05,
#        ew1r-leaf-06, ew1r-leaf-07, ew1r-leaf-08
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(ls /var/lib/memsql/ | head -1)/data/snapshots"
HOSTNAME=$(hostname)

echo "--- Running on: $HOSTNAME ---"
echo "--- Orphaned snapshots to be deleted ---"
ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026"

# ============================================================
# Delete all DBAdmin_24062026 snapshots — applies to all nodes
# ============================================================
rm -f "$SNAPSHOT_DIR"/DBAdmin_24062026_*

# ============================================================
# Delete UDM1_Kurtosys snapshots — applies to all nodes
# ============================================================
rm -f "$SNAPSHOT_DIR"/UDM1_Kurtosys_*

# ============================================================
# Verify nothing was missed
# ============================================================
echo "--- Verifying cleanup ---"
REMAINING=$(ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026")
if [ -z "$REMAINING" ]; then
    echo "All orphaned snapshots deleted successfully."
else
    echo "WARNING — some files still remain:"
    echo "$REMAINING"
fi

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
