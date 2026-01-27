#### Table references
- The central idea in databases is that a row in one table can refer to a row in another table. This allows queries to be created that collect information from multiple tables based on references. In practice, the reference is usually the ID number of a row in the other table.
#### Example
- As an example, let's consider a situation where a database contains information about courses and their teachers. We assume that each course has one teacher and the same teacher can teach multiple courses.
- We store `Teachers` information about teachers in a table. Each teacher has an ID number that we can use to refer to them.
```sql
CREATE TABLE Teachers (
  id INTEGER PRIMARY KEY,
  name TEXT
);
```

## Multi-Table Queries in SQL

Multi-table queries combine data from multiple tables using **JOIN** operations. Here's a comprehensive guide:

## 1. **INNER JOIN**
Returns only matching rows from both tables.

```sql
SELECT employees.name, departments.department_name
FROM employees
INNER JOIN departments 
    ON employees.department_id = departments.id;
```

## 2. **LEFT JOIN (or LEFT OUTER JOIN)**
Returns all rows from left table + matching rows from right table.

```sql
SELECT employees.name, departments.department_name
FROM employees
LEFT JOIN departments 
    ON employees.department_id = departments.id;
```

## 3. **RIGHT JOIN (or RIGHT OUTER JOIN)**
Returns all rows from right table + matching rows from left table.

```sql
SELECT employees.name, departments.department_name
FROM employees
RIGHT JOIN departments 
    ON employees.department_id = departments.id;
```

## 4. **FULL OUTER JOIN**
Returns all rows when there's a match in either table.

```sql
SELECT employees.name, departments.department_name
FROM employees
FULL OUTER JOIN departments 
    ON employees.department_id = departments.id;
```

## 5. **CROSS JOIN**
Returns Cartesian product (all possible combinations).

```sql
SELECT employees.name, departments.department_name
FROM employees
CROSS JOIN departments;
```

## 6. **SELF JOIN**
Joining a table with itself.

```sql
SELECT e1.name AS employee, e2.name AS manager
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.id;
```

## 7. **Joining Multiple Tables**

```sql
SELECT 
    e.name AS employee_name,
    d.department_name,
    p.project_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN projects p ON e.project_id = p.id;
```

## 8. **Using Aliases**
```sql
SELECT emp.name, dept.name
FROM employees AS emp
JOIN departments AS dept ON emp.dept_id = dept.id;
```

## 9. **JOIN with WHERE Clause**
```sql
SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.location = 'New York';
```

## 10. **JOIN with Aggregate Functions**
```sql
SELECT 
    d.department_name,
    COUNT(e.id) AS employee_count,
    AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.department_name;
```

## 11. **NATURAL JOIN**
Joins tables on columns with same names (use with caution).

```sql
SELECT *
FROM employees
NATURAL JOIN departments;
```

## 12. **JOIN USING**
When column names are identical in both tables.

```sql
SELECT employees.name, departments.department_name
FROM employees
JOIN departments USING (department_id);
```

## Practical Example with Sample Data

```sql
-- Create sample tables
CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Insert sample data
INSERT INTO departments VALUES (1, 'Sales'), (2, 'IT'), (3, 'HR');
INSERT INTO employees VALUES 
    (1, 'John', 1, 50000),
    (2, 'Jane', 2, 60000),
    (3, 'Bob', 1, 55000),
    (4, 'Alice', NULL, 45000);

-- Complex multi-table query
SELECT 
    d.name AS department,
    e.name AS employee,
    e.salary,
    AVG(e2.salary) AS avg_department_salary
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
LEFT JOIN employees e2 ON d.id = e2.department_id
WHERE d.name = 'Sales'
GROUP BY d.name, e.name, e.salary;
```

## Best Practices:

1. **Use explicit JOIN syntax** instead of comma-separated tables
2. **Always specify JOIN conditions** to avoid Cartesian products
3. **Use table aliases** for better readability
4. **Consider NULL values** when using OUTER JOINs
5. **Use appropriate indexes** on join columns for performance
6. **Be mindful of NULLs** in foreign key columns

## Common Issues to Avoid:

- **Missing JOIN conditions** causing Cartesian products
- **Ambiguous column names** (use table prefixes)
- **Incorrect JOIN type** leading to missing or extra data
- **Performance issues** with large datasets (ensure proper indexing)

## Performance Tips:

```sql
-- Add indexes for frequently joined columns
CREATE INDEX idx_department_id ON employees(department_id);
CREATE INDEX idx_dept_id ON departments(id);

-- Use EXPLAIN to analyze query performance
EXPLAIN SELECT * FROM employees e JOIN departments d ON e.department_id = d.id;
```

Multi-table queries are fundamental in SQL for combining related data across normalized tables. The key is understanding which JOIN type matches your specific data retrieval needs.
