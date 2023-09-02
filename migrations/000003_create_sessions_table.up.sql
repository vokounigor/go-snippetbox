-- Create table sessions
CREATE TABLE IF NOT EXISTS sessions (
  token CHAR(43) PRIMARY KEY,
  data BLOB NOT NULL,
  expiry TIMESTAMP(6) NOT NULL
);

-- Add index on expiry if it doesn't exist.
SET @x := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME='sessions' AND INDEX_NAME='sessions_expiry_idx' AND TABLE_SCHEMA=DATABASE());
SET @sql := IF( @x > 0, 'SELECT ''Index exists.''', 'ALTER TABLE sessions ADD INDEX sessions_expiry_idx (expiry);');
PREPARE stmt FROM @sql;
EXECUTE stmt;

