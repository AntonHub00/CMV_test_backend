# Clients and accounts system (backend)

## Requirements

MySQL version: 8.0.25.

## Setup

### Database

#### User creation and configuration

**Note**: This should be use only in a development environment. For production
use, set proper security configurations (password, permissions, etc.).

Create a user:

```sql
CREATE USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test123';
```

Grant permissions to that user:

```sql
GRANT ALL PRIVILEGES ON cmv_db.* TO 'test'@'localhost';
```

Reload grant tables:

```sql
FLUSH PRIVILEGES;
```

#### Execute initial MySQL script

**Note**: When executing this script the DB and all its data will be deleted if
the DB exists.

Login into MySQL:

```sh
mysql -u test -p # Press enter and introduce the password.
```

Execute de script:

```sql
-- You should pass the full path to the script.
-- Example: source /path/to/script/db_init_script.sql

source db_init_script.sql
```
