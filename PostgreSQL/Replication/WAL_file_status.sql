-- View WAL file status and location
SELECT pg_current_wal_lsn()                         AS current_wal_lsn,
       pg_walfile_name(pg_current_wal_lsn())        AS current_wal_file,
       pg_walfile_name_offset(pg_current_wal_lsn()) AS wal_file_offset;