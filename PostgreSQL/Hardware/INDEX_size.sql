-- This query estimates the required storage for an index based on the number of rows and
-- the average size of each index entry.
WITH
    index_estimation AS (SELECT 500000000::bigint AS num_rows, -- Expected number of rows in the table
                                200       AS index_entry_size_bytes -- Average size of each index entry in bytes
    )
SELECT num_rows,
       index_entry_size_bytes,

       -- Calculate the required storage for the index in bytes
       (num_rows * index_entry_size_bytes)                                  AS index_size_bytes,

       -- Convert the storage size to MB and GB for better readability
       ROUND((num_rows * index_entry_size_bytes) / 1024.0 / 1024, 2)        AS index_size_mb,
       ROUND((num_rows * index_entry_size_bytes) / 1024.0 / 1024 / 1024, 2) AS index_size_gb
    FROM index_estimation;
