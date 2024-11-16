-- Solve the problem of "ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired"
ALTER SESSION ENABLE PARALLEL DDL;
ALTER SESSION SET DDL_LOCK_TIMEOUT= 600;