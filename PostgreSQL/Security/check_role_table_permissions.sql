-- Check table permissions in a specific schema
SELECT table_schema,
       table_name,
       privilege_type,
       grantee
    FROM information_schema.role_table_grants
    WHERE table_schema = 'public' -- Change to target schema
    ORDER BY table_name, grantee;