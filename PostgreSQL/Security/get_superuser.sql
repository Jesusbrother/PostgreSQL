-- List all superusers
SELECT rolname AS superuser_name
    FROM pg_roles
    WHERE rolsuper = TRUE
    ORDER BY rolname;