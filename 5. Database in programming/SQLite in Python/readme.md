#### SQLite in Python
- The Python standard library includes a module sqlite3that allows you to access an SQLite database. The following code connects to the database and retrieves Stationsinformation from the table using SQL queries:
```python
import sqlite3

db = sqlite3.connect("bikes_2024.db")

result = db.execute("SELECT id, name FROM Stations WHERE id = 5")
print(result.fetchone())

result = db.execute("SELECT id, name FROM Stations ORDER BY id LIMIT 10")
print(result.fetchall())
```
- The code output is as follows:
```text
(5, 'Sepänkatu')
[(1, 'Kaivopuisto'), (2, 'Laivasillankatu'), (3, 'Kapteeninpuistikko'), (4, 'Viiskulma'), (5, 'Sepänkatu'), (6, 'Hietalahdentori'), (7, 'Designmuseo'), (8, 'Vanha kirkkopuisto'), (9, 'Erottajan aukio'), (10, 'Kasarmitori')]
```
- Here `db` is a database object through which SQL commands can be executed using the method `execute.` In this code, two `SELECT`commands are executed.
- The first `SELECT` command retrieves `Stations` the row with `id` number `5` from the table. Since the query returns one row, the method is used `fetchone`, which returns one row as a `tuple`.
- The second `SELECT`command retrieves `Stations` the first ten rows from the table. Now we use the method `fetchall`, which returns a `list` where each `tuple` corresponds to one row in the table.
> Database file location
- A typical problem with code that uses a database is that the database file is located in a different location on the computer than the code expects it to be. If you can't get the above code to work, this is probably the reason.
- If the database file referenced in the code does not exist, the code creates a new empty database file. Since there is no table in this database `Stations`, any attempt to retrieve information from the table will fail.
Here are the essential Python codes and patterns you need to work with SQL commands using `sqlite3`:

####  **The Essential 5 Commands**

#### 1. **Connect to Database**
```python
import sqlite3

# Connect to a file (creates if doesn't exist)
conn = sqlite3.connect('mydatabase.db')

# Or create in memory (temporary)
conn = sqlite3.connect(':memory:')
```

#### 2. **Create a Cursor**
```python
cursor = conn.cursor()  # Needed to execute SQL commands
```

#### 3. **Execute SQL Commands**
```python
# For single commands
cursor.execute("SQL STATEMENT HERE")

# For multiple commands at once
cursor.executescript("""
    SQL STATEMENT 1;
    SQL STATEMENT 2;
""")

# For multiple rows of data
data = [('Alice', 30), ('Bob', 25)]
cursor.executemany("INSERT INTO users VALUES (?, ?)", data)
```

#### 4. **Save Changes (Commit)**
```python
conn.commit()  # CRITICAL! Without this, changes are lost
```

#### 5. **Close Connection**
```python
conn.close()  # Always close when done
```

####  **Complete Template for Any SQL Command**

```python
import sqlite3

try:
    # 1. CONNECT
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    
    # 2. EXECUTE YOUR SQL COMMAND
    cursor.execute("YOUR SQL COMMAND HERE")
    
    # 3. SAVE if making changes
    conn.commit()
    
    # 4. FETCH results if it's a SELECT query
    results = cursor.fetchall()  # or fetchone(), fetchmany()
    
except sqlite3.Error as e:
    print(f"Database error: {e}")
    conn.rollback()  # Undo changes on error
    
finally:
    # 5. ALWAYS CLOSE
    if conn:
        conn.close()
```

####  **The 4 SQL Operations (CRUD)**

#### **CREATE (INSERT)**
```python
# Single row
cursor.execute("INSERT INTO users (name, age) VALUES (?, ?)", ('Alice', 30))

# Multiple rows
users = [('Bob', 25), ('Charlie', 35)]
cursor.executemany("INSERT INTO users (name, age) VALUES (?, ?)", users)

# Must commit
conn.commit()
```

#### **READ (SELECT)**
```python
# Get one row
cursor.execute("SELECT * FROM users WHERE id = ?", (1,))
user = cursor.fetchone()  # Returns one row or None

# Get all rows
cursor.execute("SELECT * FROM users")
all_users = cursor.fetchall()  # Returns list of tuples

# Get specific number of rows
cursor.execute("SELECT * FROM users")
first_three = cursor.fetchmany(3)  # Returns up to 3 rows
```

#### **UPDATE**
```python
cursor.execute("UPDATE users SET age = ? WHERE name = ?", (31, 'Alice'))
conn.commit()
print(f"Updated {cursor.rowcount} rows")  # How many rows changed
```

#### **DELETE**
```python
cursor.execute("DELETE FROM users WHERE age < ?", (18,))
conn.commit()
print(f"Deleted {cursor.rowcount} rows")
```

####  **Quick Reference: Most Used Patterns**

#### **Safe Parameter Passing (ALWAYS use this)**
```python
# GOOD - Prevents SQL injection
cursor.execute("SELECT * FROM users WHERE name = ? AND age = ?", ('Alice', 30))

# BAD - Never do this!
cursor.execute(f"SELECT * FROM users WHERE name = '{name}'")  # DANGER!
```

#### **Get Column Names with Results**
```python
conn.row_factory = sqlite3.Row  # Enables column name access
cursor = conn.cursor()
cursor.execute("SELECT name, age FROM users")
row = cursor.fetchone()
print(row['name'])  # Access by column name instead of index
```

#### **Check if Table Exists**
```python
cursor.execute("""
    SELECT name FROM sqlite_master 
    WHERE type='table' AND name=?
""", ('users',))
exists = cursor.fetchone() is not None
```

#### **Get Last Inserted ID**
```python
cursor.execute("INSERT INTO users (name) VALUES (?)", ('Dave',))
new_id = cursor.lastrowid
print(f"New user ID: {new_id}")
```

#### **Count Rows Affected**
```python
cursor.execute("UPDATE users SET age = age + 1")
updated_count = cursor.rowcount
print(f"Updated {updated_count} rows")
```

#### 

```python
import sqlite3
from contextlib import closing

def execute_sql(sql, params=(), fetch=False):
    """Safe SQL execution function"""
    conn = None
    try:
        conn = sqlite3.connect('database.db')
        conn.row_factory = sqlite3.Row  # Optional: for named columns
        with closing(conn.cursor()) as cursor:
            cursor.execute(sql, params)
            
            if sql.strip().upper().startswith('SELECT'):
                return cursor.fetchall()  # Return results for SELECT
            else:
                conn.commit()  # Save changes for INSERT/UPDATE/DELETE
                return cursor.rowcount  # Return number of rows affected
                
    except sqlite3.Error as e:
        print(f"Error: {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        if conn:
            conn.close()

# Usage examples:
# results = execute_sql("SELECT * FROM users WHERE age > ?", (25,), fetch=True)
# rows_affected = execute_sql("UPDATE users SET age = ? WHERE name = ?", (30, 'Alice'))
```

####
```python
# ❌ WRONG: Forgetting to commit
cursor.execute("INSERT INTO users VALUES ('Alice')")
# Changes lost when connection closes!

# ✅ RIGHT: Always commit after changes
cursor.execute("INSERT INTO users VALUES ('Alice')")
conn.commit()

# ❌ WRONG: Using string formatting
cursor.execute(f"SELECT * FROM users WHERE name = '{name}'")  # SQL injection risk!

# ✅ RIGHT: Using parameter placeholders
cursor.execute("SELECT * FROM users WHERE name = ?", (name,))

# ❌ WRONG: Not closing connections
conn = sqlite3.connect('db.sqlite')
# ... do stuff ...
# Connection stays open!

# ✅ RIGHT: Use 'with' for auto-closing
with sqlite3.connect('db.sqlite') as conn:
    cursor = conn.cursor()
    # ... do stuff ...
# Connection auto-closes here

# ✅ OR manually close
conn = sqlite3.connect('db.sqlite')
try:
    # ... do stuff ...
finally:
    conn.close()
```










