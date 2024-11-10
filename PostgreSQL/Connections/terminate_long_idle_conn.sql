-- Create a function to kill idle connections that exceed a time limit
CREATE OR REPLACE FUNCTION kill_long_idle_connections(idle_limit INTERVAL DEFAULT '30 minutes',
                                                      exclude_users TEXT[] DEFAULT ARRAY ['postgres'])
    RETURNS VOID
    LANGUAGE plpgsql
AS
$$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT pid
            FROM pg_stat_activity
            WHERE state = 'idle'
              AND NOW() - state_change > idle_limit
              AND usename != ALL (exclude_users)
        LOOP
            PERFORM PG_TERMINATE_BACKEND(rec.pid);
            RAISE NOTICE 'Terminated idle connection with PID %', rec.pid;
        END LOOP;
END;
$$;

-- Example usage to terminate idle connections longer than 30 minutes
SELECT kill_long_idle_connections('30 minutes', ARRAY ['postgres']);