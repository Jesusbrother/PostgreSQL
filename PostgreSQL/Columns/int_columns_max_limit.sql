-- Check INTEGER, SMALLINT, and BIGINT columns for proximity to their maximum limit
DO
$$
    DECLARE
        r               RECORD;
        max_value       BIGINT;
        limit_value     BIGINT;
        remaining_space BIGINT;
    BEGIN
        FOR r IN
            SELECT table_schema,
                   table_name,
                   column_name,
                   data_type
                FROM information_schema.columns
                WHERE data_type IN ('integer', 'smallint', 'bigint')
                  AND table_schema NOT IN ('pg_catalog', 'information_schema')
            LOOP
                -- Set the maximum limit based on data type
                IF r.data_type = 'integer' THEN
                    limit_value := 2147483647;
                ELSIF r.data_type = 'smallint' THEN
                    limit_value := 32767;
                ELSIF r.data_type = 'bigint' THEN
                    limit_value := 9223372036854775807;
                END IF;

                -- Execute dynamic SQL to get the maximum value in the column
                EXECUTE FORMAT('SELECT max(%I) FROM %I.%I', r.column_name, r.table_schema, r.table_name) INTO max_value;

                -- Calculate remaining space
                remaining_space := limit_value - COALESCE(max_value, 0);

                -- Output the results
                RAISE NOTICE 'Schema: %, Table: %, Column: %, Data Type: %, Current Max Value: %, Remaining Space: %',
                    r.table_schema, r.table_name, r.column_name, r.data_type, max_value, remaining_space;
            END LOOP;
    END
$$;