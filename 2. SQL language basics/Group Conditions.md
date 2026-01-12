# SQL Grouping: GROUP BY Clause Explained

The `GROUP BY` clause in SQL is used to group rows that have the same values in specified columns, allowing you to perform aggregate functions on each group.

## Basic Syntax

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition
GROUP BY column1
ORDER BY column1;
```

## Common Aggregate Functions

| Function | Description |
|----------|-------------|
| `COUNT()` | Returns the number of rows |
| `SUM()` | Returns the sum of values |
| `AVG()` | Returns the average value |
| `MAX()` | Returns the maximum value |
| `MIN()` | Returns the minimum value |

## Examples

### 1. Basic GROUP BY
```sql
-- Count employees in each department
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;
```

### 2. GROUP BY with Multiple Columns
```sql
-- Count orders by customer and status
SELECT customer_id, status, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id, status;
```

### 3. GROUP BY with WHERE Clause
```sql
-- Average salary by department for employees hired after 2020
SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE hire_date > '2020-01-01'
GROUP BY department;
```

### 4. GROUP BY with HAVING Clause
```sql
-- Departments with more than 10 employees
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 10;
```

## HAVING vs WHERE

| WHERE | HAVING |
|-------|--------|
| Filters rows BEFORE grouping | Filters groups AFTER grouping |
| Cannot use aggregate functions | Can use aggregate functions |
| Applies to individual rows | Applies to grouped results |

## Practical Examples

### Sales Analysis
```sql
-- Total sales by product category
SELECT 
    category,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_order_value
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;
```

### Monthly Sales Report
```sql
-- Monthly sales totals
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS monthly_total,
    COUNT(*) AS order_count
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY year, month;
```

### Customer Analysis
```sql
-- Customers with high average order value
SELECT 
    customer_id,
    COUNT(*) AS total_orders,
    AVG(order_total) AS avg_order_value,
    SUM(order_total) AS lifetime_value
FROM orders
GROUP BY customer_id
HAVING AVG(order_total) > 1000
ORDER BY lifetime_value DESC;
```

## Important Rules

1. **All non-aggregated columns in SELECT must be in GROUP BY**
   ```sql
   -- CORRECT
   SELECT department, location, AVG(salary)
   FROM employees
   GROUP BY department, location;
   
   -- INCORRECT (location not in GROUP BY)
   SELECT department, location, AVG(salary)
   FROM employees
   GROUP BY department;  -- Error!
   ```

2. **GROUP BY Execution Order**
   ```
   FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
   ```

3. **GROUP BY with Expressions**
   ```sql
   -- Group by calculated column
   SELECT 
       CASE 
           WHEN age < 30 THEN 'Under 30'
           WHEN age BETWEEN 30 AND 50 THEN '30-50'
           ELSE 'Over 50'
       END AS age_group,
       COUNT(*) AS count
   FROM users
   GROUP BY 
       CASE 
           WHEN age < 30 THEN 'Under 30'
           WHEN age BETWEEN 30 AND 50 THEN '30-50'
           ELSE 'Over 50'
       END;
   ```

## Advanced Grouping

### ROLLUP (Hierarchical Totals)
```sql
-- Get subtotals and grand total
SELECT 
    department, 
    job_title,
    SUM(salary) AS total_salary
FROM employees
GROUP BY ROLLUP(department, job_title);
```

### GROUPING SETS
```sql
-- Multiple grouping levels in one query
SELECT 
    department,
    job_title,
    location,
    COUNT(*) AS employee_count
FROM employees
GROUP BY GROUPING SETS (
    (department, job_title),
    (department, location),
    (job_title, location),
    ()
);
```

## Performance Tips

1. **Index columns used in GROUP BY** for faster grouping
2. **Filter with WHERE before GROUP BY** to reduce rows
3. **Be selective with GROUP BY columns** - fewer columns = better performance
4. **Use APPROXIMATE functions** for large datasets when exact counts aren't critical
   ```sql
   SELECT department, APPROX_COUNT_DISTINCT(employee_id)
   FROM large_table
   GROUP BY department;
   ```

## Common Mistakes to Avoid

1. **Forgetting non-aggregated columns in GROUP BY**
2. **Using HAVING without GROUP BY** (valid but often misunderstood)
3. **Confusing WHERE and HAVING**
4. **Grouping by unnecessary columns**
5. **Ignoring NULL values in grouping columns** (NULLs form their own group)

Would you like me to elaborate on any specific aspect of SQL grouping or provide examples for a particular use case?
