# **SQL Search Conditions Reference Table**

| **Category** | **Operator/Keyword** | **Description** | **Example** |
|--------------|---------------------|-----------------|-------------|
| **Basic Comparison** | `=` | Equal to | `WHERE salary = 50000` |
| | `<>` or `!=` | Not equal to | `WHERE status <> 'inactive'` |
| | `>` | Greater than | `WHERE age > 18` |
| | `<` | Less than | `WHERE price < 100` |
| | `>=` | Greater than or equal | `WHERE quantity >= 10` |
| | `<=` | Less than or equal | `WHERE discount <= 20` |
| **Logical Operators** | `AND` | All conditions must be true | `WHERE age > 21 AND country = 'USA'` |
| | `OR` | At least one condition true | `WHERE status = 'active' OR status = 'pending'` |
| | `NOT` | Negates a condition | `WHERE NOT category = 'excluded'` |
| **Pattern Matching** | `LIKE` | Pattern matching with wildcards | `WHERE name LIKE 'Jo%'` |
| | `%` | Matches any sequence of characters | `WHERE email LIKE '%@gmail.com'` |
| | `_` | Matches any single character | `WHERE phone LIKE '555-___-____'` |
| **Range Conditions** | `BETWEEN` | Inclusive range (between two values) | `WHERE price BETWEEN 10 AND 100` |
| | `IN` | Match any value in a list | `WHERE country IN ('USA', 'Canada', 'UK')` |
| **NULL Handling** | `IS NULL` | Check for NULL values | `WHERE middle_name IS NULL` |
| | `IS NOT NULL` | Check for non-NULL values | `WHERE email IS NOT NULL` |
| **Advanced** | `EXISTS` | True if subquery returns rows | `WHERE EXISTS (SELECT 1 FROM orders)` |
| | `NOT EXISTS` | True if subquery returns no rows | `WHERE NOT EXISTS (SELECT 1 FROM deleted)` |
| | `ALL` | Compare to all values in subquery | `WHERE salary > ALL (SELECT salary FROM interns)` |
| | `ANY`/`SOME` | Compare to any value in subquery | `WHERE rating > ANY (SELECT rating FROM competitors)` |

---

## **Wildcard Characters for LIKE Operator**

| **Wildcard** | **Description** | **Example** | **Matches** | **Does Not Match** |
|--------------|-----------------|-------------|-------------|-------------------|
| `%` | Zero or more characters | `'SQL%'` | SQL, SQLite, SQLServer | MySQL, PostgreSQL |
| `_` | Exactly one character | `'_QL'` | SQL, AQL, &QL | MySQL, TSQL |
| `[charlist]` | Single character in set | `'[ABC]%'` | Apple, Banana, Cat | Dog, Elephant |
| `[^charlist]` | Single character not in set | `'[^ABC]%'` | Dog, Elephant | Apple, Banana |
| `[a-c]` | Single character in range | `'[A-C]at'` | Bat, Cat | Dat, Fat |

---

## **Operator Precedence Hierarchy**

| **Level** | **Operators** | **Description** |
|-----------|---------------|-----------------|
| 1 | `()` | Parentheses (highest priority) |
| 2 | `NOT` | Logical NOT |
| 3 | `=` `<>` `<` `>` `<=` `>=` `LIKE` `IN` `BETWEEN` `IS NULL` | Comparison operators |
| 4 | `AND` | Logical AND |
| 5 | `OR` | Logical OR (lowest priority) |

**Example of precedence:**
```sql
WHERE category = 'Electronics' OR category = 'Books' AND price > 100
-- Evaluates as: category = 'Electronics' OR (category = 'Books' AND price > 100)
```

---

## **Common Search Patterns by Data Type**

| **Data Type** | **Common Conditions** | **Example** |
|---------------|----------------------|-------------|
| **Numeric** | Range, equality, comparisons | `WHERE quantity BETWEEN 1 AND 100` |
| **String/Text** | Pattern matching, exact match | `WHERE name LIKE 'A%' AND LENGTH(name) > 3` |
| **Date/Time** | Date ranges, specific periods | `WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'` |
| **Boolean** | Direct true/false checks | `WHERE is_active = TRUE` |
| **NULL values** | IS NULL/IS NOT NULL | `WHERE deleted_at IS NULL` |

---

## **Performance Considerations Table**

| **Condition Type** | **Performance Impact** | **Recommendation** |
|-------------------|-----------------------|-------------------|
| **Equality (`=`) on indexed column** | ⭐⭐⭐⭐⭐ Excellent | Use indexed columns in WHERE |
| **Range (`BETWEEN`) on indexed column** | ⭐⭐⭐⭐ Good | Works well with B-tree indexes |
| **`LIKE` with leading wildcard (`%text`)** | ⭐ Poor | Avoid `LIKE '%text'` on large tables |
| **`LIKE` without leading wildcard (`text%`)** | ⭐⭐⭐ Good | Can use index for prefix matching |
| **Functions on columns (`UPPER(column) = 'TEXT'`)** | ⭐ Poor | Creates table scan, use indexed computed column |
| **`IN` with many values** | ⭐⭐ Fair | Consider JOIN for large lists |
| **`OR` conditions on different columns** | ⭐⭐ Fair | May use UNION for better performance |
| **`NOT` conditions** | ⭐⭐ Fair | Can be inefficient, use positive conditions when possible |

---

## **Common Mistakes & Corrections**

| **Mistake** | **Correction** | **Reason** |
|-------------|---------------|------------|
| `WHERE column = NULL` | `WHERE column IS NULL` | NULL is not equal to anything, even itself |
| `WHERE salary <> 50000` (excludes NULL) | `WHERE salary <> 50000 OR salary IS NULL` | NULL comparisons return UNKNOWN |
| `WHERE UPPER(name) = 'JOHN'` (slow) | Add computed column or use `WHERE name = 'JOHN'` | Functions prevent index usage |
| `WHERE date_column = '2024-01-01'` | `WHERE date_column >= '2024-01-01' AND date_column < '2024-01-02'` | Safer for datetime with time components |

---

## **Database-Specific Extensions**

| **Database** | **Special Operators** | **Example** |
|--------------|----------------------|-------------|
| **PostgreSQL** | `ILIKE` (case-insensitive LIKE) | `WHERE name ILIKE 'john%'` |
| **PostgreSQL** | `~` (regex match) | `WHERE name ~ '^A.*z$'` |
| **MySQL** | `REGEXP`/`RLIKE` | `WHERE name REGEXP '^[A-Z].*[0-9]$'` |
| **SQL Server** | `CONTAINS()` (full-text) | `WHERE CONTAINS(description, 'SQL AND database')` |
| **Oracle** | `CONTAINS()` | `WHERE CONTAINS(text, 'Oracle NEAR Database')` |

---

**Key Takeaways:**
1. Use `=` for exact matches, `LIKE` for patterns
2. Always use `IS NULL`/`IS NOT NULL` for NULL checks
3. Parentheses control evaluation order
4. Index-friendly conditions perform better
5. Consider data type when choosing operators
