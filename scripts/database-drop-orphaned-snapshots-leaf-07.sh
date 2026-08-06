#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — ew1r-leaf-07
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-06
# Run on ew1r-leaf-07 via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(ls /var/lib/memsql/ | head -1)/data/snapshots"

# Confirm files exist before deleting
echo "--- Orphaned snapshots to be deleted ---"
ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026"

# Delete UDM1_Kurtosys snapshots — frees ~15.5 GB
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176143646078"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176144118380"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_1_snapshot_v1_0_279205923717"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_5_snapshot_v1_0_262025258976"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_9_snapshot_v1_0_262025546704"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_13_snapshot_v1_0_266319815992"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_17_snapshot_v1_0_283499251177"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_17_snapshot_v1_0_283499775910"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_21_snapshot_v1_0_266319844402"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_21_snapshot_v1_0_266320276316"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_25_snapshot_v1_0_257728852699"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_25_snapshot_v1_0_257729289147"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_29_snapshot_v1_0_287795272737"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_29_snapshot_v1_0_287795759341"

# Delete DBAdmin_24062026 snapshots
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_1_snapshot_v1_0_18195379"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_5_snapshot_v1_0_18198144"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_9_snapshot_v1_0_18200223"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_13_snapshot_v1_0_18182785"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_17_snapshot_v1_0_18194697"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_21_snapshot_v1_0_18198423"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_25_snapshot_v1_0_18196963"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_29_snapshot_v1_0_18173141"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_1_snapshot_v1_0_18195379"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_5_snapshot_v1_0_18198144"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_9_snapshot_v1_0_18200223"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_13_snapshot_v1_0_18182785"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_17_snapshot_v1_0_18194697"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_21_snapshot_v1_0_18198423"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_25_snapshot_v1_0_18196963"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_29_snapshot_v1_0_18173141"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_1_snapshot_v1_0_18195410"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_5_snapshot_v1_0_18198191"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_9_snapshot_v1_0_18200253"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_13_snapshot_v1_0_18182810"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_17_snapshot_v1_0_18194736"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_21_snapshot_v1_0_18198463"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_25_snapshot_v1_0_18196995"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_29_snapshot_v1_0_18173184"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_1_snapshot_v1_0_18195410"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_5_snapshot_v1_0_18198191"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_9_snapshot_v1_0_18200253"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_13_snapshot_v1_0_18182810"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_17_snapshot_v1_0_18194736"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_21_snapshot_v1_0_18198463"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_25_snapshot_v1_0_18196995"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_29_snapshot_v1_0_18173184"

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
