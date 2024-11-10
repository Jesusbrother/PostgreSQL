-- Monitor tablespace disk usage
SELECT spcname                                                                                 AS tablespace_name,
       PG_SIZE_PRETTY(PG_TABLESPACE_SIZE(spcname))                                             AS tablespace_size,
       PG_SIZE_PRETTY(PG_TABLESPACE_SIZE(spcname) - PG_TABLESPACE_SIZE(spcname)::BIGINT * 0.8) AS free_space
    FROM pg_tablespace
    WHERE PG_TABLESPACE_SIZE(spcname) > PG_TABLESPACE_SIZE(spcname) * 0.8; -- Alert if over 80% capacity