-- This query calculates the required disk I/O bandwidth based on read and write operations
-- per second and the average size of each read/write operation.
WITH
    io_load AS (SELECT 100  AS write_ops_per_sec,    -- Write operations per second
                       500  AS read_ops_per_sec,     -- Read operations per second
                       200  AS avg_write_size_bytes, -- Average size of each write operation in bytes
                       1024 AS avg_read_size_bytes -- Average size of each read operation in bytes
    )
SELECT write_ops_per_sec,
       read_ops_per_sec,
       avg_write_size_bytes,
       avg_read_size_bytes,

       -- Calculate required bandwidth for write operations
       (write_ops_per_sec * avg_write_size_bytes)                                                                    AS write_bandwidth_bytes_per_sec,
       ROUND((write_ops_per_sec * avg_write_size_bytes) / 1024.0 / 1024, 2)                                          AS write_bandwidth_mb_per_sec,

       -- Calculate required bandwidth for read operations
       (read_ops_per_sec * avg_read_size_bytes)                                                                      AS read_bandwidth_bytes_per_sec,
       ROUND((read_ops_per_sec * avg_read_size_bytes) / 1024.0 / 1024, 2)                                            AS read_bandwidth_mb_per_sec,

       -- Calculate total required bandwidth
       ROUND((write_ops_per_sec * avg_write_size_bytes + read_ops_per_sec * avg_read_size_bytes) / 1024.0 / 1024,
             2)                                                                                                      AS total_bandwidth_mb_per_sec
    FROM io_load;
