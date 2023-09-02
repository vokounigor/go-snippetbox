-- Create a `snippets` table.
CREATE TABLE IF NOT EXISTS snippets (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  content TEXT NOT NULL,
  created DATETIME NOT NULL,
  expires DATETIME NOT NULL
);

-- Add an index on the created column if it doesn't exist.
SET @x := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME='snippets' AND INDEX_NAME='idx_snippets_created' AND TABLE_SCHEMA=DATABASE());
SET @sql := IF( @x > 0, 'SELECt ''Index exists.''', 'ALTER TABLE snippets ADD INDEX idx_snippets_created (created);');
PREPARE stmt FROM @sql;
EXECUTE stmt;
