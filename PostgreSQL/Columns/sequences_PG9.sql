-- Check SEQUENCEs for proximity to their maximum limit for PostgreSQL versions below 10
SELECT n.nspname                  AS sequence_schema,
       c.relname                  AS sequence_name,
       s.last_value               AS current_value,
       s.max_value,
       s.max_value - s.last_value AS remaining_space
    FROM pg_class    c
    JOIN
        pg_namespace n
            ON n.oid = c.relnamespace
    JOIN
        pg_sequences s
            ON s.seqname = c.relname
    WHERE c.relkind = 'S'
      AND (s.max_value - s.last_value) < 100000; -- Adjust this threshold as needed