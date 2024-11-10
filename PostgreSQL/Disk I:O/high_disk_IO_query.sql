-- Identify queries with high disk I/O based on shared and temp blocks read/written
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

SELECT u.usename             AS user,
       d.datname             AS database,
       s.calls,
       s.shared_blks_read    AS shared_blocks_read,
       s.shared_blks_written AS shared_blocks_written,
       s.temp_blks_read      AS temp_blocks_read,
       s.temp_blks_written   AS temp_blocks_written,
       LEFT(s.query, 100)    AS query_sample -- Show first 100 characters of the query
    FROM pg_stat_statements s
    JOIN
        pg_database         d
            ON s.dbid = d.oid
    JOIN
        pg_user             u
            ON s.userid = u.usesysid
    ORDER BY (s.shared_blks_read + s.shared_blks_written + s.temp_blks_read + s.temp_blks_written) DESC
    LIMIT 10; -- Show top 10 queries by I/O