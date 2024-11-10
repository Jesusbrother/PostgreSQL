-- indexes to be added (with reason)
WITH
    index_usage           AS (SELECT sut.relid,
                                     CURRENT_DATABASE()                    AS database,
                                     sut.schemaname::TEXT                  AS schema_name,
                                     sut.relname::TEXT                     AS table_name,
                                     sut.seq_scan                          AS table_scans,
                                     sut.idx_scan                          AS index_scans,
                                     PG_TOTAL_RELATION_SIZE(relid)         AS table_bytes,
                                     ROUND((sut.n_tup_ins + sut.n_tup_del + sut.n_tup_upd + sut.n_tup_hot_upd) /
                                           (seq_tup_read::NUMERIC + 2), 2) AS writes_per_scan
                                  FROM pg_stat_user_tables sut),
    index_counts          AS (SELECT sut.relid,
                                     COUNT(*) AS index_count
                                  FROM pg_stat_user_tables sut
                                  LEFT OUTER JOIN pg_indexes
                                          ON sut.schemaname = pg_indexes.schemaname AND
                                             sut.relname = pg_indexes.tablename
                                  GROUP BY relid),
    too_many_table_scans   AS (SELECT 'REASON: too many table scans'::TEXT    AS reason,
                                     database,
                                     schema_name,
                                     table_name,
                                     table_scans,
                                     PG_SIZE_PRETTY(table_bytes) AS table_size,
                                     writes_per_scan,
                                     index_count,
                                     table_bytes
                                  FROM index_usage
                                  JOIN index_counts
                                          USING (relid)
                                  WHERE table_scans > 1000
                                    AND table_scans > (index_scans * 2)
                                    AND table_bytes > 32000000
                                    AND writes_per_scan < (1.0)
                                  ORDER BY table_scans DESC),
    no_index_scans        AS (SELECT 'REASON: scans with no index'::TEXT  AS reason,
                                     database,
                                     schema_name,
                                     table_name,
                                     table_scans,
                                     PG_SIZE_PRETTY(table_bytes) AS table_size,
                                     writes_per_scan,
                                     index_count,
                                     table_bytes
                                  FROM index_usage
                                  JOIN index_counts
                                          USING (relid)
                                  WHERE table_scans > 100
                                    AND table_scans > (index_scans)
                                    AND index_count < 2
                                    AND table_bytes > 32000000
                                    AND writes_per_scan < (1.0)
                                  ORDER BY table_scans DESC),
    big_tables_scans AS (SELECT 'REASON: big table scans'::TEXT     AS reason,
                                     database,
                                     schema_name,
                                     table_name,
                                     table_scans,
                                     PG_SIZE_PRETTY(table_bytes) AS table_size,
                                     writes_per_scan,
                                     index_count,
                                     table_bytes
                                  FROM index_usage
                                  JOIN index_counts
                                          USING (relid)
                                  WHERE table_scans > 100
                                    AND table_scans > (index_scans / 10)
                                    AND table_bytes > 1000000000
                                    AND writes_per_scan < (1.0)
                                  ORDER BY table_bytes DESC),
    no_writes_scans       AS (SELECT 'REASON: no writes scans'::TEXT    AS reason,
                                     database,
                                     schema_name,
                                     table_name,
                                     table_scans,
                                     PG_SIZE_PRETTY(table_bytes) AS table_size,
                                     writes_per_scan,
                                     index_count,
                                     table_bytes
                                  FROM index_usage
                                  JOIN index_counts
                                          USING (relid)
                                  WHERE table_scans > 100
                                    AND table_scans > (index_scans / 4)
                                    AND table_bytes > 32000000
                                    AND writes_per_scan < (0.1)
                                  ORDER BY writes_per_scan ASC)
SELECT reason,
       database,
       schema_name,
       table_name,
       table_scans,
       table_size,
       writes_per_scan,
       index_count
    FROM too_many_table_scans
UNION ALL
SELECT reason,
       database,
       schema_name,
       table_name,
       table_scans,
       table_size,
       writes_per_scan,
       index_count
    FROM no_index_scans
UNION ALL
SELECT reason,
       database,
       schema_name,
       table_name,
       table_scans,
       table_size,
       writes_per_scan,
       index_count
    FROM big_tables_scans
UNION ALL
SELECT reason,
       database,
       schema_name,
       table_name,
       table_scans,
       table_size,
       writes_per_scan,
       index_count
    FROM no_writes_scans;
