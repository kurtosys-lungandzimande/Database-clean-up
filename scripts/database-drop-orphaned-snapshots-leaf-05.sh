#!/bin/bash
# ============================================================
# Orphaned Snapshot Cleanup — ew1r-leaf-05
# Ticket: Remove Unneeded Databases in the Rel_Env
# Prepared by: Lunga Ndzimande
# Date: 2026-08-06
# Run on ew1r-leaf-05 via SSM Session Manager as root
# DO NOT RUN before DROP DATABASE steps are complete
# ============================================================

SNAPSHOT_DIR="/var/lib/memsql/$(ls /var/lib/memsql/ | head -1)/data/snapshots"

# Confirm files exist before deleting
echo "--- Orphaned snapshots to be deleted ---"
ls -lh "$SNAPSHOT_DIR" | grep -E "UDM1_Kurtosys|DBAdmin_24062026"

# Delete UDM1_Kurtosys snapshots — frees ~14.9 GB
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176143646078"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_snapshot_v1_0_176144118380"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_3_snapshot_v1_0_283500915489"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_7_snapshot_v1_0_304975565498"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_11_snapshot_v1_0_279205327181"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_15_snapshot_v1_0_257731195284"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_19_snapshot_v1_0_270615648715"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_19_snapshot_v1_0_270616128800"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_23_snapshot_v1_0_253435517937"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_23_snapshot_v1_0_253435977754"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_27_snapshot_v1_0_270615586386"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_27_snapshot_v1_0_270616020718"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_31_snapshot_v1_0_287794515567"
rm -f "$SNAPSHOT_DIR/UDM1_Kurtosys_31_snapshot_v1_0_287794741721"

# Delete DBAdmin_24062026 snapshots
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_snapshot_v1_0_1782840"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_3_snapshot_v1_0_18190336"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_7_snapshot_v1_0_18197288"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_11_snapshot_v1_0_18196316"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_15_snapshot_v1_0_18191691"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_19_snapshot_v1_0_18173730"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_23_snapshot_v1_0_18190883"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_27_snapshot_v1_0_18195818"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_31_snapshot_v1_0_18180727"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_3_snapshot_v1_0_18190336"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_7_snapshot_v1_0_18197288"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_11_snapshot_v1_0_18196316"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_15_snapshot_v1_0_18191691"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_19_snapshot_v1_0_18173730"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_23_snapshot_v1_0_18190883"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_27_snapshot_v1_0_18195818"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_Instant_direct_31_snapshot_v1_0_18180727"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_3_snapshot_v1_0_18190364"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_7_snapshot_v1_0_18197314"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_11_snapshot_v1_0_18196346"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_15_snapshot_v1_0_18191736"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_19_snapshot_v1_0_18173763"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_23_snapshot_v1_0_18190919"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_27_snapshot_v1_0_18195850"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_31_snapshot_v1_0_18180758"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_3_snapshot_v1_0_18190364"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_7_snapshot_v1_0_18197314"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_11_snapshot_v1_0_18196346"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_15_snapshot_v1_0_18191736"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_19_snapshot_v1_0_18173763"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_23_snapshot_v1_0_18190919"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_27_snapshot_v1_0_18195850"
rm -f "$SNAPSHOT_DIR/DBAdmin_24062026_standard_direct_31_snapshot_v1_0_18180758"

# Verify disk space freed
echo "--- Disk usage after cleanup ---"
df -h /
