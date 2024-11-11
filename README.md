# PostgreSQL Scripts Collection


## Table of Contents

1. [Alerts](#alerts)
2. [Backups](#backups)
   - [Backup Logs](#backup-logs)
3. [Columns](#columns)
4. [Connections](#connections)
5. [CPU](#cpu)
6. [Disk I/O](#disk-io)
7. [Indexes](#indexes)
8. [Logs](#logs)
   - [Logrotate](#logrotate)
9. [Maintenance](#maintenance)
   - [Backup](#backup)
   - [Bloat](#bloat)
   - [Reindex](#reindex)
   - [Vacuum and Analize](#Vacuum_and_Analize)
10. [Memory](#Memory)
11. [Network](#Network)
12. [Query Optimization](#Query_Optimization)
13. [Replication](#Replication)
14. [Security](#Security)
15. [Statistics](#Statistics)
16. [Tables](#Tables)


---

## Alerts

Scripts for monitoring and alerting based on specific database conditions.

- `high_disk_IO_usage.sh`: Monitors high disk I/O usage.
- `bloat_tables.sql`: Identifies tables with high bloat.
- `conn_limit_per_user.sql`: Checks if users are near their connection limits.
- `db_near_tr_id_wraparound.sql`: Alerts if transaction IDs are near wraparound.
- `high_connections_usage.sql`: Monitors high usage of database connections.
- `high_CPU_and_MEM.sh`: Monitors high CPU and memory usage.
- `high_CPU_load_avg.sh`: Checks for high CPU load averages.
- `high_CPU.sh`: Monitors CPU usage.
- `large_log_files.sh`: Finds large log files that may need rotation.
- `long_run_transactions.sql`: Identifies long-running transactions.
- `low_free_space.sql`: Checks for low free space on the disk.

## Backups

Scripts to manage and verify backups, including checking disk space and archiving.

- `verify_WAL_archiving.sql`: Verifies that WAL archiving is functioning correctly.
- `create_base_backup.sh`: Creates a base backup of the database.
- `outdated_backups.sh`: Identifies outdated backups that may be removed.
- `backup_disk_space.sh`: Checks available disk space for backups.

### Backup Logs

Scripts to log backup details.

- `1_create_backup_log_table.sql`: Creates a table to log backup results.
- `2_record_backup_results.sh`: Records the results of backup operations.

## Columns

Scripts related to column management, including finding missing indexes and constraints.

- `missing_PK.sql`: Identifies tables missing a primary key.
- `duplicate_values_in_non_uniq_columns.sql`: Finds duplicate values in non-unique columns.
- `inconsistent_data_types.sql`: Checks for inconsistent data types.
- `int_columns_max_limit.sql`: Monitors integer columns nearing their maximum limits.
- `int_usage.py`: Python script to analyze integer column usage.
- `null_columns.sql`: Identifies columns with a high number of NULL values.
- `sequences_PG9.sql`: Checks sequence usage for PostgreSQL 9.x.
- `sequences_PG10_and_above.sql`: Checks sequence usage for PostgreSQL 10 and above.
- `uniqueness_columns.sql`: Verifies uniqueness constraints across columns.

## Connections

Scripts to monitor and manage database connections.

- `terminate_long_idle_conn.sql`: Terminates long idle connections.
- `active_connections_cnt.sql`: Counts active connections.
- `idle_connections.sql`: Identifies idle connections.
- `OS_monitor_conn.sh`: Monitors OS-level connections.
- `PGBOUNCER_monitor_log_conn.sh`: Monitors PgBouncer connections.

## CPU

Scripts focused on CPU monitoring and performance.

- `monitor_CPU_overall.sh`: Monitors overall CPU usage.
- `hich_CPU_usage_query.sql`: Identifies queries with high CPU usage.
- `track_CPU_load_avg.sh`: Tracks average CPU load over time.

## Disk I/O

Scripts for monitoring disk input/output activity.

- `tablespace_disk_usage.sql`: Checks disk usage for each tablespace.
- `high_disk_IO_query.sql`: Finds queries causing high disk I/O.
- `monitor_table_RW.sql`: Monitors read/write operations on tables.
- `monitor_temp_file_usage.sql`: Tracks usage of temporary files.
- `OS_monitor_disk_IO.sh`: Monitors disk I/O at the OS level.

## Indexes

Scripts for managing and analyzing index usage.

- `index_bloat_2.sql` and `index_bloat.sql`: Identifies index bloat.
- `index_duplicate_2.sql` and `index_duplicate.sql`: Finds duplicate indexes.
- `index_FK.sql`: Lists indexes on foreign keys.
- `index_need_add.sql`: Suggests indexes that may improve performance.
- `index_size.sql`: Lists the size of each index.
- `index_unused.sql`: Identifies unused indexes.

## Logs

Scripts to analyze and manage log files.

- `log_files_growth_over_time.sh`: Tracks the growth of log files over time.
- `most_common_logs_errors.sh`: Lists the most common errors in logs.
- `recent_logs_errors.sh`: Shows recent errors in logs.

### Logrotate

Instructions and configuration for log rotation using Logrotate.

- `README.md`: Provides Logrotate configuration guidelines for PostgreSQL logs.

## Maintenance

Scripts for various maintenance tasks to keep the database performing optimally.

### Backup

Scripts specifically for managing backups.

- `1_sctipt.sh`: Executes backup routines.
- `2_cron.txt`: Cron job configuration for daily backup execution.

### Bloat

Scripts to manage and reduce bloat in tables and indexes.

- `script.sh`: Runs maintenance to clean up table and index bloat.

### Reindex

Scripts to manage and automate reindexing for improved performance.

- `1_script.sh`: Performs reindexing operations.
- `2_cron.txt`: Cron job configuration for weekly reindex execution.

### Vacuum_and_Analyze

Scripts to manage and automate the vacuum and analyze processes, helping to keep table statistics up-to-date and minimize table bloat.

- `1_script.sh`: Executes vacuum and analyze routines for tables.
- `2_cron.txt`: Cron job configuration for weekly execution of vacuum and analyze tasks.

## Memory

Scripts for monitoring and optimizing memory usage, including cache hit ratios, buffer usage, and memory-intensive queries.

- `work_mem_settings.sql`: Suggests optimal settings for `work_mem` based on query usage.
- `buffer_usage.sql`: Analyzes buffer usage across queries to optimize memory usage.
- `cache_hit_ratio.sql`: Calculates the cache hit ratio to assess memory efficiency.
- `mem_intensive_queries.sql`: Identifies memory-intensive queries that may require optimization.
- `mem_usage.sh`: Monitors PostgreSQL memory usage.
- `sys_mem_usage.sh`: Tracks system memory usage, focusing on PostgreSQL processes.
- `temp_file_usage.sh`: Monitors temporary file usage, which may indicate insufficient memory allocation.

## Network

Scripts for monitoring network activity and managing connections, including tracking active connections, data transfer rates, and network usage.

- `data_transfer_rates.sql`: Monitors data transfer rates for queries (requires `pg_stat_statements`).
- `active_conn.sql`: Lists currently active connections.
- `check_max_conn_util.sql`: Checks maximum connection utilization to avoid overloading.
- `conn_by_IP.sql`: Groups connections by IP address to identify frequent sources.
- `idle_conn.sql`: Identifies idle connections that may need termination.
- `network_usage.sh`: Monitors network usage by PostgreSQL processes at the system level.

## Query_Optimization

Scripts designed to analyze and improve query performance by identifying long-running queries, missing indexes, and execution statistics.

- `find_missing_and_unused_indexes.sql`: Detects missing or unused indexes to optimize query performance.
- `long_run_queries.sql`: Lists long-running queries that may require optimization.
- `query_exec_statistics.sql`: Provides execution statistics for queries to identify resource-intensive operations.

## Replication

Scripts for monitoring and managing PostgreSQL replication, including replication slots, lag, and WAL archive status.

- `replication_slots_on_standby.sql`: Checks replication slots on the standby server.
- `master_repl_status.sql`: Shows replication status on the primary (master) server.
- `replica_lag_on_standby.sql`: Monitors replication lag on the standby server.
- `replication_heavy_queries.sql`: Identifies queries generating high WAL activity, impacting replication performance.
- `replication_performance_metrics.sql`: Provides performance metrics for each standby server.
- `replication_slot_status.sql`: Checks the status of replication slots on the primary server.
- `WAL_archive_status.sql`: Monitors the status of WAL archiving.
- `WAL_dir_size.sh`: Checks the size of the WAL directory to avoid excessive disk usage.
- `WAL_file_status.sql`: Displays the status and location of WAL files.

## Security

Scripts to monitor and enhance database security, including role management, auditing, password expiration, and SSL connections.

- `all_user_role.sql`: Lists all users and roles with their permissions.
- `check_role_table_permissions.sql`: Checks table-level permissions for roles.
- `find_SQL_injections_attempts.sql`: Detects potential SQL injection attempts.
- `get_superuser.sql`: Lists all superuser roles, identifying accounts with elevated privileges.
- `inherit_roles.sql`: Displays inheritance relationships among roles.
- `login_audit.sql`: Audits login attempts for security monitoring.
- `long_run_idle_conn.sql`: Identifies long-running idle connections that may be security risks.
- `monitor_pass_expired.sql`: Monitors roles with expired passwords to enforce security policies.
- `monitor_ssl_conn.sql`: Checks SSL connections to ensure secure data transmission.
- `recent_privil_changes.sql`: Tracks recent privilege changes for roles.
- `unused_roles.sql`: Identifies roles that are unused and can be cleaned up.

## Statistics

Scripts for monitoring and analyzing database statistics, including disk usage, cache hit ratio, transaction activity, and query execution times.

- `disk_usage_table_and_indexes.sql`: Monitors disk usage for tables and indexes.
- `cache_hit_ratio.sql`: Calculates the cache hit ratio to assess memory efficiency.
- `checkpoint_activity.sql`: Tracks checkpoint activity for performance tuning.
- `db_conn.sql`: Provides connection statistics and usage.
- `index_usage_and_effectiveness.sql`: Evaluates index usage and effectiveness.
- `table_usage_and_activity.sql`: Analyzes table usage and activity for optimization.
- `temp_file_usage.sql`: Tracks temporary file usage, indicating queries that may require more memory.
- `top_query_exec_time.sql`: Lists queries with the highest execution times.
- `track_WAL_stat.sql`: Monitors WAL statistics to ensure efficient logging and replication.
- `transactions_statistics.sql`: Provides statistics on transaction activity for workload analysis.

## Tables

Scripts focused on table management and optimization, including bloat, indexing, and usage statistics.

- `table_bloat.sql`: Identifies tables with significant bloat that may need vacuuming or reindexing.
- `table_excessive_indexes.sql`: Detects tables with an excessive number of indexes, which may slow down write operations.
- `table_large.sql`: Lists large tables to monitor storage usage.
- `table_missing_PK.sql`: Finds tables without a primary key, which may affect data integrity.
- `table_temp_files.sql`: Tracks temporary file usage by tables, indicating potential memory issues.
- `table_usage.sql`: Analyzes table usage for performance optimization.

---
