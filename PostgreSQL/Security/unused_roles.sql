-- Find roles that have not logged in recently
SELECT pg_authid.rolname       AS role_name,
       pg_authid.rolcanlogin   AS can_login,
       pg_authid.rolvaliduntil AS expiration_date
    FROM pg_authid
    LEFT JOIN
        pg_stat_activity
            ON pg_authid.oid = pg_stat_activity.usesysid
    WHERE pg_authid.rolcanlogin = TRUE
      AND pg_stat_activity.usesysid IS NULL
    ORDER BY pg_authid.rolname;