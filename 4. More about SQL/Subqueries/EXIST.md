
#### Basic Syntax
```sql
SELECT columns
FROM table
WHERE EXISTS (subquery);
```

#### Simple Example
Find customers who have placed at least one order:

```sql
SELECT customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```


#### 1. **Returns Boolean Value**
- `TRUE` if subquery returns ≥ 1 row
- `FALSE` if subquery returns 0 rows

#### 2. **Correlated vs. Non-Correlated**

**Correlated** (references outer query):
```sql
SELECT employee_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.manager_id = e.employee_id
    AND p.status = 'Active'
);
```

**Non-Correlated** (independent):
```sql
SELECT product_name
FROM products
WHERE EXISTS (
    SELECT 1
    FROM inventory
    WHERE quantity > 100
);
```

#### 3. **Performance Benefits**
- Stops processing as soon as first match is found
- Often more efficient than `IN` or `JOIN` for existence checks

#### Common Use Cases

#### 1. **Existence Checks**
```sql
-- Employees with dependents
SELECT first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents d
    WHERE d.employee_id = e.employee_id
);
```

#### 2. **NOT EXISTS for Absence**
```sql
-- Products never ordered
SELECT product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);
```

#### 3. **Complex Conditions**
```sql
-- Customers with orders > $1000 in 2024
SELECT customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_date >= '2024-01-01'
    AND o.total_amount > 1000
);
```

#### Comparison with Other Methods

#### EXISTS vs IN
```sql
-- EXISTS (usually faster for large datasets)
SELECT * FROM table1 t1
WHERE EXISTS (SELECT 1 FROM table2 t2 WHERE t2.id = t1.id);

-- IN
SELECT * FROM table1
WHERE id IN (SELECT id FROM table2);
```

#### EXISTS vs JOIN
```sql
-- EXISTS (returns distinct rows from main table)
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM projects p WHERE p.emp_id = e.id);

-- JOIN (may return duplicate rows)
SELECT DISTINCT e.* 
FROM employees e
JOIN projects p ON p.emp_id = e.id;
```

#### Best Practices

1. **Use `SELECT 1` (or `SELECT *`) in subquery** - Only existence matters, not data
2. **Correlate properly** - Ensure subquery references outer query correctly
3. **Use for existence checks only** - Not for fetching data
4. **Consider `NOT EXISTS` over `NOT IN`** - `NOT EXISTS` handles NULLs better

#### Advanced Examples

#### Multiple Conditions
```sql
-- Customers with both pending and shipped orders
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o1
    WHERE o1.customer_id = c.customer_id
    AND o1.status = 'Pending'
)
AND EXISTS (
    SELECT 1 FROM orders o2
    WHERE o2.customer_id = c.customer_id
    AND o2.status = 'Shipped'
);
```

#### Nested EXISTS
```sql
-- Departments with employees having specific skills
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
    AND EXISTS (
        SELECT 1
        FROM employee_skills es
        WHERE es.employee_id = e.employee_id
        AND es.skill = 'SQL'
    )
);
```

`EXISTS` is particularly useful when you need to check for the existence of related records without actually needing data from those related tables.
