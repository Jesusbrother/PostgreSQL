-- Check SEQUENCEs for proximity to their maximum limit
SELECT schemaname             AS sequence_schema,
       sequencename           AS sequence_name,
       last_value             AS current_value,
       max_value,
       max_value - last_value AS remaining_space
    FROM pg_sequences
    JOIN
        pg_class
            ON pg_class.relname = pg_sequences.sequencename
    WHERE max_value IS NOT NULL
      AND (max_value - last_value) < 100000; -- Adjust this threshold as needed