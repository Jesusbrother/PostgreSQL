-- Create a table to log backup status
CREATE TABLE IF NOT EXISTS backup_log (
    backup_id SERIAL PRIMARY KEY,
    backup_time TIMESTAMP DEFAULT now(),
    status VARCHAR(50),
    details TEXT
);