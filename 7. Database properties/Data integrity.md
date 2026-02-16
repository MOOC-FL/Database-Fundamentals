#### Data integrity
- Data integrity means that the information in a database is accurate and consistent. The primary responsibility for data quality lies with the user or application modifying the database, but the database designer can also influence the issue by adding conditions to tables that control the information entered into the database.

##### Column conditions
- When creating a table, we can add conditions to the columns that the database system monitors when adding and changing data. These conditions can be used to restrict the data that enters the database. Typical conditions are the following:
- [ ] UNIQUE
- [ ] NOT NULL and DEFAULT
- [ ] CHECK
##### UNIQUE
- A condition `UNIQUE` means that the column must have a different value in each row. For example, in the following table, the requirement is that each product has a different name:
```SQL
CREATE TABLE Products (
  id INTEGER PRIMARY KEY,
  name TEXT UNIQUE,
  price INTEGER
);
```
- The condition `UNIQUE` can also apply to multiple columns, in which case it is entered separately after the columns:
```sql
CREATE TABLE Products (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price INTEGER,
  UNIQUE(name, price)
);
```
> This means that there cannot be two rows in the table with the same name and the same price.
##### NOT NULL and DEFAULT
- The condition `NOT NULL` means that the column cannot contain a value `NULL`. For example, in the following table, the product price cannot be empty:
```sql
CREATE TABLE Products (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price INTEGER NOT NULL
);
```
- The parameter `DEFAULT` gives a certain default value to a column if its value is missing when inserting a row. For example, we can set a default value of 0 for price like this:
```sql
CREATE TABLE Products (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price INTEGER DEFAULT 0
);
```
##### CHECK
- A more common way to create a condition is to use the keyword `CHECK`, followed by any conditional expression. For example, in the following table, the condition `price >= 0` means that the price cannot be negative:
```sql
CREATE TABLE Products (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price INTEGER,
  CHECK (price >= 0)
);
```















