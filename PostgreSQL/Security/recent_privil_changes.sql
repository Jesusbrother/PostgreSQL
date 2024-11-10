-- Identify recent changes in privileges
SELECT grantor,
       grantee,
       privilege_type,
       is_grantable,
       table_catalog,
       table_schema,
       table_name
    FROM information_schema.role_table_grants
    ORDER BY grantor, grantee;