## **JOIN Syntax in SQL**

### **1. Basic JOIN Types**

#### **INNER JOIN** (Default JOIN)
Returns matching records from both tables.
```sql
SELECT columns
FROM table1
INNER JOIN table2 
    ON table1.id = table2.table1_id;
```

#### **LEFT JOIN** (or LEFT OUTER JOIN)
Returns all records from the left table, matched records from right table.
```sql
SELECT columns
FROM table1
LEFT JOIN table2 
    ON table1.id = table2.table1_id;
```

#### **RIGHT JOIN** (or RIGHT OUTER JOIN)
Returns all records from the right table, matched records from left table.
```sql
SELECT columns
FROM table1
RIGHT JOIN table2 
    ON table1.id = table2.table1_id;
```

#### **FULL OUTER JOIN**
Returns all records when there's a match in either table.
```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2 
    ON table1.id = table2.table1_id;
```

#### **CROSS JOIN**
Returns Cartesian product (all possible combinations).
```sql
SELECT columns
FROM table1
CROSS JOIN table2;
```

### **2. Common JOIN Patterns**

#### **Simple JOIN with WHERE**
```sql
SELECT p.name, s.score
FROM Players p, Scores s
WHERE p.id = s.player_id;
```

#### **JOIN with Multiple Conditions**
```sql
SELECT *
FROM Orders o
JOIN OrderItems oi 
    ON o.id = oi.order_id 
    AND o.status = 'completed'
    AND oi.quantity > 5;
```

#### **JOIN Multiple Tables**
```sql
SELECT p.name, s.score, t.tournament_name
FROM Players p
JOIN Scores s ON p.id = s.player_id
JOIN Tournaments t ON s.tournament_id = t.id;
```

#### **Self JOIN**
```sql
SELECT e1.name AS Employee, e2.name AS Manager
FROM Employees e1
LEFT JOIN Employees e2 
    ON e1.manager_id = e2.id;
```

### **3. JOIN with Aliases**
```sql
SELECT p.name, s.score
FROM Players AS p
INNER JOIN Scores AS s 
    ON p.id = s.player_id;
```

### **4. JOIN with Aggregation**
```sql
SELECT p.name, AVG(s.score) as avg_score
FROM Players p
JOIN Scores s ON p.id = s.player_id
GROUP BY p.name;
```

### **5. JOIN Using USING Clause**
(When column names are identical in both tables)
```sql
SELECT *
FROM Employees e
JOIN Departments d USING (department_id);
```

### **6. NATURAL JOIN**
(Joins on all columns with the same name - use cautiously!)
```sql
SELECT *
FROM Players
NURAL JOIN Scores;
```

### **7. Practical Examples**

#### **Example 1: Basic JOIN**
```sql
-- Find all players and their scores
SELECT Players.name, Scores.score
FROM Players
INNER JOIN Scores ON Players.id = Scores.player_id;
```

#### **Example 2: LEFT JOIN with NULL check**
```sql
-- Find players with no scores
SELECT Players.name
FROM Players
LEFT JOIN Scores ON Players.id = Scores.player_id
WHERE Scores.id IS NULL;
```

#### **Example 3: Multiple JOINs with filtering**
```sql
-- Find players, their scores, and tournament info
SELECT 
    p.name,
    s.score,
    t.name as tournament,
    t.date
FROM Players p
JOIN Scores s ON p.id = s.player_id
JOIN Tournaments t ON s.tournament_id = t.id
WHERE t.date > '2024-01-01'
ORDER BY s.score DESC;
```

### **8. Performance Tips**

1. **Always use explicit JOIN conditions** (avoid comma-separated FROM clauses)
2. **Use appropriate JOIN types** (INNER JOIN is most efficient when you need matches only)
3. **Join on indexed columns** for better performance
4. **Filter early** with WHERE clause before JOIN when possible
5. **Avoid SELECT *** - specify only needed columns

### **9. Common JOIN Pitfalls**
```sql
-- ❌ Problem: Cartesian product (missing ON clause)
SELECT * FROM Players, Scores;  -- Returns 3×5=15 rows!

-- ✅ Solution: Always specify JOIN condition
SELECT * 
FROM Players 
JOIN Scores ON Players.id = Scores.player_id;  -- Returns 5 rows
```

### **10. Visual Summary**

```
INNER JOIN:      A ∩ B      (Only matches)
LEFT JOIN:       A ∪ (A∩B)  (All A + matches from B)
RIGHT JOIN:      (A∩B) ∪ B  (All B + matches from A)
FULL JOIN:       A ∪ B      (Everything from both)
CROSS JOIN:      A × B      (All combinations)
```

Choose the JOIN type based on whether you need all records from one or both tables, or only matching records.
