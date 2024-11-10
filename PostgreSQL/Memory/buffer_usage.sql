-- Monitor shared buffer usage
SELECT name,
       setting,
       PG_SIZE_PRETTY(setting::BIGINT * PG_DATABASE_SIZE('your_database')::BIGINT / 1024) AS buffer_size
    FROM pg_settings
    WHERE name = 'shared_buffers';