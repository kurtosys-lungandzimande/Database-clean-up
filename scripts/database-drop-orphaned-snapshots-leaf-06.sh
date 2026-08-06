#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — ew1r-leaf-06
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-06
# Run on ew1r-leaf-06 via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(ls /var/lib/memsql/ | head -1)/data/snapshots"

# Confirm files exist before deleting
echo "--- Orphaned snapshots to be deleted ---"
ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026"

# Delete UDM1_Kurtosys snapshots — frees ~17.5 GB
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176143646078"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176144118380"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_2_snapshot_v1_0_292090493228"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_4_snapshot_v1_0_274910258660"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_8_snapshot_v1_0_231959061287"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_12_snapshot_v1_0_279206334104"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_12_snapshot_v1_0_279206334106"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_16_snapshot_v1_0_287795877580"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_16_snapshot_v1_0_287795877582"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_20_snapshot_v1_0_257729982318"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_20_snapshot_v1_0_257729982320"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_24_snapshot_v1_0_257730323281"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_24_snapshot_v1_0_257730774393"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_28_snapshot_v1_0_266320757908"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_28_snapshot_v1_0_266321178973"

# Delete DBAdmin_24062026 snapshots
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_2_snapshot_v1_0_18197745"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_4_snapshot_v1_0_18186000"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_8_snapshot_v1_0_18173529"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_12_snapshot_v1_0_18193057"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_16_snapshot_v1_0_18195815"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_20_snapshot_v1_0_18197973"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_24_snapshot_v1_0_18197238"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_28_snapshot_v1_0_18189987"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_2_snapshot_v1_0_18197745"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_4_snapshot_v1_0_18186000"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_8_snapshot_v1_0_18173529"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_12_snapshot_v1_0_18193057"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_16_snapshot_v1_0_18195815"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_20_snapshot_v1_0_18197973"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_24_snapshot_v1_0_18197238"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_28_snapshot_v1_0_18189987"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_2_snapshot_v1_0_18197773"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_4_snapshot_v1_0_18186032"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_8_snapshot_v1_0_18173558"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_12_snapshot_v1_0_18193110"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_16_snapshot_v1_0_18195856"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_20_snapshot_v1_0_18198005"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_24_snapshot_v1_0_18197274"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_28_snapshot_v1_0_18190013"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_2_snapshot_v1_0_18197773"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_4_snapshot_v1_0_18186032"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_8_snapshot_v1_0_18173558"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_12_snapshot_v1_0_18193110"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_16_snapshot_v1_0_18195856"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_20_snapshot_v1_0_18198005"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_24_snapshot_v1_0_18197274"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_28_snapshot_v1_0_18190013"

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
