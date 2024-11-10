# Log Rotation Using Logrotate for PostgreSQL

Log rotation helps manage PostgreSQL log files by periodically rotating, compressing, and retaining them for a specified number of days. This process helps avoid large log files that can consume excessive disk space and keeps logs organized.

## Setting Up Log Rotation with Logrotate

To automatically rotate PostgreSQL logs, you can create a configuration file in `/etc/logrotate.d/`. Follow the steps below to set up log rotation.

### Step 1: Create a Logrotate Configuration File

1. Open a terminal and create a configuration file for PostgreSQL logs:

    ```bash
    sudo nano /etc/logrotate.d/postgresql
    ```

2. Add the following configuration:

    ```text
    /var/log/postgresql/*.log {
        daily
        missingok
        rotate 7
        compress
        delaycompress
        notifempty
        copytruncate
    }
    ```

### Explanation of Configuration Options

- **`/var/log/postgresql/*.log`**: Specifies the path to the PostgreSQL log files. Adjust this path if your logs are stored in a different location.

- **`daily`**: Rotates logs every day.

- **`missingok`**: Ignores missing log files without showing an error.

- **`rotate 7`**: Retains up to 7 rotated logs, so older logs are deleted after 7 days.

- **`compress`**: Compresses rotated log files to save disk space.

- **`delaycompress`**: Delays compression until the next rotation cycle, keeping the most recent rotated log uncompressed for easier access.

- **`notifempty`**: Skips rotation if the log file is empty.

- **`copytruncate`**: Truncates the log file in place after copying, instead of moving the log file. This is important for PostgreSQL since it continues to write to the same file.

### Step 2: Test the Logrotate Configuration

To test the configuration without actually rotating logs, run:

```bash
sudo logrotate -d /etc/logrotate.d/postgresql