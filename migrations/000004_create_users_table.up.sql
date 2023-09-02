-- Create users table
CREATE TABLE IF NOT EXISTS users (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  hashed_password CHAR(60) NOT NULL,
  created DATETIME NOT NULL
);

-- Add constraint if it doesn't exist.
SET @x := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='users' AND CONSTRAINT_NAME='users_uc_email' AND TABLE_SCHEMA=DATABASE());
SET @sql := IF( @x > 0, 'SELECT ''Constraint exists.''', 'ALTER TABLE users ADD CONSTRAINT users_uc_email UNIQUE (email);');
PREPARE stmt FROM @sql;
EXECUTE stmt;

