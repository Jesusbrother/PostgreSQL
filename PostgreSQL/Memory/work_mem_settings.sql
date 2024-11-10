-- Check work memory settings
SELECT name    AS parameter,
       setting AS current_value,
       unit,
       source
    FROM pg_settings
    WHERE name IN ('work_mem', 'maintenance_work_mem');