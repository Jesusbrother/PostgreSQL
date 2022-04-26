-->> find function and procedures, contained text <<--
SELECT
    nspname   -- schema / схема
    , proname -- procedure name / имя процедуры
    , prosrc  -- procedure body / код процедуры
FROM
    pg_catalog.pg_proc pr
        JOIN pg_catalog.pg_namespace ns
             ON ns.oid = pr.pronamespace
WHERE
    prosrc ILIKE '%DATE_TRUNC%' -- text filtering / фильтр на текст
    AND nspname IN ('test', 'public') -- schema filtering / фильтр на схемы
;