-- Monitor temporary file usage by database
SELECT datname                                                                    AS database_name,
       temp_files                                                                 AS temp_file_count,
       PG_SIZE_PRETTY(temp_bytes)                                                 AS temp_file_size,
       temp_files * 100 / (temp_files + COALESCE(xact_commit + xact_rollback, 1)) AS temp_files_ratio_pct,
       (NOW() - stats_reset)                                                      AS stats_since_reset
    FROM pg_stat_database
    WHERE temp_files > 0
    ORDER BY temp_bytes DESC;