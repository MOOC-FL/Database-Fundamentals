# **SQL ORDER BY Reference Tables**

## **Basic ORDER BY Syntax**

| **Clause** | **Description** | **Example** |
|------------|----------------|-------------|
| `ORDER BY column` | Sort by column in ascending order (default) | `ORDER BY last_name` |
| `ORDER BY column ASC` | Explicit ascending sort | `ORDER BY salary ASC` |
| `ORDER BY column DESC` | Descending sort | `ORDER BY hire_date DESC` |
| `ORDER BY col1, col2` | Multiple column sort | `ORDER BY department, salary DESC` |
| `ORDER BY position` | Sort by column position in SELECT | `ORDER BY 3, 1` |

---

## **Sorting Data Types**

| **Data Type** | **Sort Order** | **Example** | **Notes** |
|---------------|----------------|-------------|-----------|
| **Numbers** | Natural numeric order | `ORDER BY price` | `1, 2, 10, 100` |
| **Strings** | Alphabetical (collation dependent) | `ORDER BY name` | `A, B, C, a, b, c` |
| **Dates** | Chronological | `ORDER BY birth_date` | `1990-01-01, 2020-12-31` |
| **NULL Values** | First or last (DB dependent) | `ORDER BY column NULLS FIRST` | Most DBs put NULLs first in ASC |
| **Booleans** | FALSE (0), TRUE (1) | `ORDER BY is_active` | `FALSE, TRUE` |

---

## **Multi-Column Sorting Priority**

| **Order** | **Column 1** | **Column 2** | **Result** | **Visualization** |
|-----------|--------------|--------------|------------|-------------------|
| 1 | Department (ASC) | Salary (DESC) | Sorts by department first, then high to low salary within each department | `Dept A: $100K, $80K, $60K`<br>`Dept B: $90K, $70K` |
| 2 | Last Name (ASC) | First Name (ASC) | Alphabetical by last name, then first name for same last names | `Smith, Alice`<br>`Smith, Bob`<br>`Wilson, Carol` |
| 3 | Year (DESC) | Month (ASC) | Most recent year first, months in chronological order | `2024: Jan, Feb, Mar`<br>`2023: Jan, Feb` |
| 4 | Category (ASC) | Price (ASC) | By category, then cheapest first | `Books: $10, $15, $20`<br>`Electronics: $100, $200` |

**Example:**
```sql
SELECT first_name, last_name, department, salary
FROM employees
ORDER BY department ASC, salary DESC, last_name ASC;
```

---

## **NULL Handling in ORDER BY**

| **Database** | **Default NULL Order (ASC)** | **Default NULL Order (DESC)** | **Explicit Control** |
|--------------|-----------------------------|-------------------------------|----------------------|
| **MySQL** | NULLs first | NULLs last | `ORDER BY column ASC NULLS FIRST` |
| **PostgreSQL** | NULLs last | NULLs first | `ORDER BY column NULLS FIRST/LAST` |
| **SQL Server** | NULLs first | NULLs last | Not directly supported (use CASE) |
| **Oracle** | NULLs last | NULLs first | `ORDER BY column NULLS FIRST/LAST` |
| **SQLite** | NULLs first | NULLs last | Not directly supported |

**Workaround for all DBs:**
```sql
-- Put NULLs last in ascending order
ORDER BY 
    CASE WHEN column IS NULL THEN 1 ELSE 0 END,
    column ASC

-- Put NULLs first in ascending order  
ORDER BY
    CASE WHEN column IS NULL THEN 0 ELSE 1 END,
    column ASC
```

---

## **Advanced ORDER BY Features**

| **Feature** | **Syntax** | **Description** | **Example** |
|-------------|------------|-----------------|-------------|
| **Expression** | `ORDER BY expression` | Sort by calculated value | `ORDER BY salary * 12` |
| **Function** | `ORDER BY function()` | Sort by function result | `ORDER BY LENGTH(name)` |
| **Alias** | `ORDER BY alias` | Sort by column alias | `SELECT salary*12 AS annual ORDER BY annual` |
| **Position** | `ORDER BY n` | Sort by SELECT position | `SELECT name, salary ORDER BY 2 DESC` |
| **Conditional** | `ORDER BY CASE` | Custom sort logic | `ORDER BY CASE department WHEN 'IT' THEN 1 ELSE 2 END` |
| **Random** | `ORDER BY RAND()` | Random ordering | `ORDER BY RAND()` (MySQL) |
| **External List** | `ORDER BY FIELD()` | Sort by custom list | `ORDER BY FIELD(status, 'High', 'Medium', 'Low')` |

**Custom Sort Example:**
```sql
SELECT task_name, priority 
FROM tasks
ORDER BY 
    CASE priority 
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2 
        WHEN 'Low' THEN 3
        ELSE 4
    END,
    task_name;
```

---

## **Performance Considerations**

| **Scenario** | **Performance Impact** | **Recommendation** |
|--------------|-----------------------|-------------------|
| **ORDER BY indexed column** | ⭐⭐⭐⭐⭐ Excellent | Fast, uses index for sorting |
| **ORDER BY non-indexed column** | ⭐⭐ Fair | May require full table sort |
| **ORDER BY with LIMIT** | ⭐⭐⭐⭐ Good | Can stop early if using index |
| **ORDER BY expression/function** | ⭐ Poor | Prevents index usage, computes for each row |
| **ORDER BY multiple columns** | Varies | Composite indexes help if columns match |
| **ORDER BY with large result sets** | ⭐⭐ Fair | Consider paging with LIMIT/OFFSET |

**Indexing Strategy:**
```sql
-- Good: Index supports ORDER BY
CREATE INDEX idx_name ON employees(last_name, first_name);
SELECT * FROM employees ORDER BY last_name, first_name;

-- Bad: No index support  
SELECT * FROM employees ORDER BY UPPER(last_name);
```

---

## **Pagination with ORDER BY**

| **Method** | **Syntax** | **Use Case** | **Performance** |
|------------|------------|--------------|-----------------|
| **LIMIT/OFFSET** | `ORDER BY ... LIMIT n OFFSET m` | Traditional paging | Slower for deep pages |
| **Keyset Pagination** | `WHERE id > last_id ORDER BY id LIMIT n` | Infinite scroll | Consistent performance |
| **ROW_NUMBER()** | `WITH cte AS (SELECT ..., ROW_NUMBER() OVER(ORDER BY ...))` | Complex sorting | Good for ranked data |
| **FETCH FIRST** | `ORDER BY ... OFFSET n ROWS FETCH NEXT m ROWS ONLY` | ANSI SQL standard | Similar to LIMIT |

**Keyset Pagination Example:**
```sql
-- First page
SELECT * FROM products 
ORDER BY created_at DESC, id 
LIMIT 20;

-- Next page (better performance)
SELECT * FROM products 
WHERE (created_at, id) < ('2024-01-01', 100)
ORDER BY created_at DESC, id 
LIMIT 20;
```

---

## **Database-Specific ORDER BY Features**

| **Database** | **Unique Feature** | **Syntax** | **Description** |
|--------------|-------------------|------------|-----------------|
| **MySQL** | `ORDER BY FIELD()` | `ORDER BY FIELD(status, 'New', 'In Progress', 'Done')` | Custom sort order |
| **PostgreSQL** | `ORDER BY ... NULLS FIRST/LAST` | `ORDER BY price NULLS LAST` | Explicit NULL placement |
| **SQL Server** | `ORDER BY ... OFFSET FETCH` | `ORDER BY name OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY` | ANSI paging syntax |
| **Oracle** | `ORDER BY column NULLS FIRST` | `ORDER BY commission NULLS FIRST` | NULLs at beginning |
| **SQLite** | `ORDER BY RANDOM()` | `ORDER BY RANDOM()` | Random ordering |

---

## **Common ORDER BY Patterns**

| **Pattern** | **SQL Example** | **Result** |
|-------------|-----------------|------------|
| **Recent First** | `ORDER BY created_at DESC` | Newest records first |
| **Alphabetical** | `ORDER BY last_name ASC, first_name ASC` | A to Z sorting |
| **Price: Low to High** | `ORDER BY price ASC` | Cheapest first |
| **Price: High to Low** | `ORDER BY price DESC` | Most expensive first |
| **Priority Order** | `ORDER BY priority ASC, due_date ASC` | High priority first, then earliest due |
| **Random Sample** | `ORDER BY RAND() LIMIT 10` | 10 random records |
| **Top N per Group** | `WITH ranked AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY dept ORDER BY salary DESC) ...)` | Highest salary in each department |

---

## **ORDER BY with JOINs and Aggregates**

| **Scenario** | **Example** | **Notes** |
|--------------|-------------|-----------|
| **With JOIN** | `SELECT e.name, d.dept_name FROM employees e JOIN departments d ORDER BY d.dept_name, e.name` | Sort by joined table columns |
| **With GROUP BY** | `SELECT department, COUNT(*) FROM employees GROUP BY department ORDER BY COUNT(*) DESC` | Sort by aggregate result |
| **With Window Functions** | `SELECT name, salary, RANK() OVER(ORDER BY salary DESC) FROM employees` | Window ORDER BY different from query ORDER BY |
| **With UNION** | `SELECT name FROM table1 UNION SELECT name FROM table2 ORDER BY name` | ORDER BY applies to final result |

---

## **ORDER BY Execution Order**

| **Step** | **Clause** | **ORDER BY Relevance** |
|----------|------------|------------------------|
| 1 | FROM/JOIN | Tables identified |
| 2 | WHERE | Rows filtered |
| 3 | GROUP BY | Groups created |
| 4 | HAVING | Groups filtered |
| 5 | SELECT | Columns projected |
| 6 | **ORDER BY** | **Rows sorted** |
| 7 | LIMIT/OFFSET | Rows limited |

**Key Rule:** ORDER BY can use column aliases from SELECT because it executes after SELECT.

---

## **Common Mistakes & Solutions**

| **Mistake** | **Problem** | **Solution** |
|-------------|------------|--------------|
| `ORDER BY UPPER(name)` | Can't use index, slow on large tables | Add functional index or computed column |
| Missing ORDER BY with LIMIT | Non-deterministic results | Always use ORDER BY with LIMIT |
| `ORDER BY RAND()` on large table | Very slow | Use alternative random sampling methods |
| Conflicting ORDER BY in views/subqueries | Outer ORDER BY overrides inner | Understand execution order |
| `ORDER BY` with `DISTINCT` | Columns must appear in SELECT | Include sort columns in SELECT |

**Example of deterministic pagination:**
```sql
-- Non-deterministic (avoid)
SELECT * FROM users LIMIT 10 OFFSET 20;

-- Deterministic (good)
SELECT * FROM users 
ORDER BY id  -- or another unique column
LIMIT 10 OFFSET 20;
```

---

## **Quick Reference Cheat Sheet**

| **Task** | **SQL Pattern** |
|----------|-----------------|
| Sort A-Z | `ORDER BY column ASC` |
| Sort Z-A | `ORDER BY column DESC` |
| Sort by multiple columns | `ORDER BY col1 ASC, col2 DESC` |
| Sort by calculation | `ORDER BY price * quantity DESC` |
| Put NULLs last | `ORDER BY column IS NULL, column ASC` |
| Custom sort order | `ORDER BY CASE WHEN column='A' THEN 1 ... END` |
| Random order | `ORDER BY RAND()` (DB specific) |
| Top N records | `ORDER BY score DESC LIMIT 10` |
| Pagination | `ORDER BY id LIMIT 10 OFFSET 20` |
| Sort by alias | `SELECT price*1.1 AS total ORDER BY total` |

**Best Practices:**
1. Always use ORDER BY with LIMIT for deterministic results
2. Sort by indexed columns when possible
3. Be explicit about ASC/DESC
4. Consider NULL placement
5. Use keyset pagination for large datasets
6. Test sort performance with real data volumes
