-- ============================================================
-- Database Drop Script — Release Environment SingleStore
-- Ticket: Remove Unneeded Databases in the Rel_Env
-- Prepared by: Lunga Ndzimande
-- Date: 2026-08-04
-- Status: Pending Stakeholder Approval
-- DO NOT EXECUTE without written approval
-- ============================================================


-- ============================================================
-- STEP 1 — Confirm no active connections
-- Expected: 0 rows. If any rows return — STOP and investigate.
-- ============================================================

SELECT * FROM information_schema.PROCESSLIST
WHERE DB IN (
    'UDM1_Kurtosys',
    'DBAdmin_24062026_Instant',
    'DBAdmin_24062026_Instant_direct',
    'DBAdmin_24062026_standard',
    'DBAdmin_24062026_standard_direct'
);


-- ============================================================
-- STEP 2 — Record pre-drop state
-- ============================================================

SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema IN (
    'UDM1_Kurtosys',
    'DBAdmin_24062026_Instant',
    'DBAdmin_24062026_Instant_direct',
    'DBAdmin_24062026_standard',
    'DBAdmin_24062026_standard_direct'
)
GROUP BY table_schema;


-- ============================================================
-- STEP 3 — Drop databases (run one at a time)
-- Confirm each succeeds before running the next
-- ============================================================

DROP DATABASE DBAdmin_24062026_Instant;

DROP DATABASE DBAdmin_24062026_Instant_direct;

DROP DATABASE DBAdmin_24062026_standard;

DROP DATABASE DBAdmin_24062026_standard_direct;

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
