# Clients and accounts system (backend)

## Requirements

- MySQL version: 8.0.25.
- Node.js version: 14.17.3.

## Setup

**General notes**:

- I assume you are working in a Unix-like system.
- All the shell commands should be executed in the root of the project.

### Database

#### User creation and configuration

**Note**: This should be use only in a development environment. For production
use, set proper security configurations (password, permissions, etc.).

To execute the following commands log into MySQL with a user with proper
permissions.

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

Log into MySQL:

```sh
mysql -u test -p # Press enter and introduce the password.
```

Execute the script:

```sql
source db_init_script.sql
```

### Backend (ExpressJS)

#### Install the dependencies

```sh
npm install
```

#### Run the project in development mode

```sh
npm run dev
```