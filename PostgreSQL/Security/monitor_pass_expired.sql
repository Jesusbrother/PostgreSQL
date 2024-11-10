-- Check roles with expired passwords
SELECT rolname       AS role_name,
       rolvaliduntil AS password_expiration
    FROM pg_authid
    WHERE rolvaliduntil IS NOT NULL
      AND rolvaliduntil < NOW();