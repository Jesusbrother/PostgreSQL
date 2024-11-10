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

---
