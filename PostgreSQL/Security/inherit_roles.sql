-- List roles and their inherited roles
SELECT parent.rolname AS parent_role,
       child.rolname  AS inherited_role
    FROM pg_auth_members AS auth
    JOIN
        pg_roles         AS parent
            ON auth.roleid = parent.oid
    JOIN
        pg_roles         AS child
            ON auth.member = child.oid
    ORDER BY parent.rolname, inherited_role;