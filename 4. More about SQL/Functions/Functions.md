#### Functions
- Functions can appear as part of expressions, just like in programming. Here are some examples of SQLite functions:
Here's the content converted to Markdown format:

| Function | Description |
|----------|-------------|
| `ABS(x)` | Absolute value of a number |
| `LENGTH(s)` | Length of string `s` |
| `LOWER(s)` | String `s` in lowercase |
| `MAX(x, y)` | The larger of the numbers `x` and `y` |
| `MIN(x, y)` | The smaller of the numbers `x` and `y` |
| `RANDOM()` | Random number |
| `ROUND(x, d)` | Number `x` rounded to `d` decimal precision |
| `SUBSTR(s, a, b)` | Characters of string `s` starting from position `a`, taking `b` characters |
| `UPPER(s)` | String `s` in uppercase |

- The following query searches for products with six letters in their names (such as turnip and turnip).
```sql
SELECT * FROM Products WHERE LENGTH(name) = 6;
```
- The following query groups products by the first letter and reports the quantities of products starting with each letter.
```sql
SELECT
  SUBSTR(name, 1, 1), COUNT(*)
FROM
  Products
GROUP BY
  SUBSTR(name, 1, 1);
```
- The following query returns the rows in random order because the order is not based on the contents of any column but on a random value.
```sql
SELECT * FROM Products ORDER BY RANDOM();
```
