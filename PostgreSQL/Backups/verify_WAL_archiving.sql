SELECT archived_count AS archived_wals,
       failed_count   AS failed_wals
    FROM pg_stat_archiver
    WHERE failed_count > 0;