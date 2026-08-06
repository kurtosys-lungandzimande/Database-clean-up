#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — ew1r-leaf-08
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-06
# Run on ew1r-leaf-08 via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(ls /var/lib/memsql/ | head -1)/data/snapshots"

# Confirm files exist before deleting
echo "--- Orphaned snapshots to be deleted ---"
ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026"

# Delete UDM1_Kurtosys snapshots — frees ~15.5 GB
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176143646078"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176144118380"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_0_snapshot_v1_0_270615395119"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_6_snapshot_v1_0_274927358922"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_10_snapshot_v1_0_279204247524"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_14_snapshot_v1_0_279206351616"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_18_snapshot_v1_0_292088956377"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_18_snapshot_v1_0_292089379729"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_22_snapshot_v1_0_287794271377"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_22_snapshot_v1_0_287794696048"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_26_snapshot_v1_0_270617082993"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_26_snapshot_v1_0_270617189209"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_30_snapshot_v1_0_262047175564"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_30_snapshot_v1_0_262047175566"

# Delete DBAdmin_24062026 snapshots
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_0_snapshot_v1_0_18194229"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_6_snapshot_v1_0_18181747"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_10_snapshot_v1_0_18197826"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_14_snapshot_v1_0_18194856"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_18_snapshot_v1_0_18191112"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_22_snapshot_v1_0_18196918"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_26_snapshot_v1_0_18200543"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_30_snapshot_v1_0_18175713"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_0_snapshot_v1_0_18194229"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_6_snapshot_v1_0_18181747"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_10_snapshot_v1_0_18197826"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_14_snapshot_v1_0_18194856"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_18_snapshot_v1_0_18191112"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_22_snapshot_v1_0_18196918"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_26_snapshot_v1_0_18200543"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_30_snapshot_v1_0_18175713"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_0_snapshot_v1_0_18194269"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_6_snapshot_v1_0_18181776"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_10_snapshot_v1_0_18197864"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_14_snapshot_v1_0_18194891"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_18_snapshot_v1_0_18191144"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_22_snapshot_v1_0_18196943"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_26_snapshot_v1_0_18200571"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_30_snapshot_v1_0_18175750"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_0_snapshot_v1_0_18194269"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_6_snapshot_v1_0_18181776"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_10_snapshot_v1_0_18197864"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_14_snapshot_v1_0_18194891"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_18_snapshot_v1_0_18191144"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_22_snapshot_v1_0_18196943"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_26_snapshot_v1_0_18200571"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_30_snapshot_v1_0_18175750"

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
