-- Analyze transaction statistics
SELECT datname                                                                  AS database_name,
       xact_commit                                                              AS commits,
       xact_rollback                                                            AS rollbacks,
       ROUND((xact_rollback::NUMERIC / (xact_commit + xact_rollback)) * 100, 2) AS rollback_ratio
    FROM pg_stat_database
    WHERE datname = 'your_database';