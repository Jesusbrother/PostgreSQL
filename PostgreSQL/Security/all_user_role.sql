-- List all users and roles with their privileges
SELECT rolname       AS role_name,
       rolsuper      AS is_superuser,
       rolcreaterole AS can_create_role,
       rolcreatedb   AS can_create_db,
       rolcanlogin   AS can_login,
       rolconnlimit  AS connection_limit
    FROM pg_roles
    ORDER BY rolname;