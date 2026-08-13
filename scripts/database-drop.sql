-- ============================================================
-- Database Drop Script — Release Environment SingleStore
-- Ticket: Remove Unneeded Databases in the Rel_Env
-- Prepared by: Lunga Ndzimande
-- Date: 2026-08-13
-- Status: Approved — Jacobus van Heerden confirmed 2026-08-13
-- Remaining: UDM1_Kurtosys only (DBAdmin_24062026_* dropped 2026-08-06)
-- ============================================================


-- ============================================================
-- STEP 1 — Confirm no active connections
-- Expected: 0 rows. If any rows return — STOP and investigate.
-- ============================================================

SELECT * FROM information_schema.PROCESSLIST
WHERE DB = 'UDM1_Kurtosys';


-- ============================================================
-- STEP 2 — Record pre-drop state
-- ============================================================

SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'UDM1_Kurtosys'
GROUP BY table_schema;


-- ============================================================
-- STEP 3 — Drop databases (run one at a time)
-- Confirm each succeeds before running the next
-- ============================================================

-- DBAdmin_24062026_* databases already dropped 2026-08-06
DROP DATABASE UDM1_Kurtosys;


-- ============================================================
-- STEP 4 — Post-drop verification
-- Confirm dropped databases are gone
-- Confirm UDM__ and DBAdmin are still intact
-- ============================================================

SHOW DATABASES;

SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema IN ('UDM__', 'DBAdmin')
GROUP BY table_schema;


-- ============================================================
-- STEP 5 — Delete orphaned snapshot files
-- Run on ew1r-aggr-04 via EC2 Instance Connect as root
-- See: database-drop-orphaned-snapshots.sh
-- ============================================================
