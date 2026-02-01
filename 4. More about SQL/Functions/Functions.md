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

ذذذ
```sql
SELECT * FROM Products ORDER BY RANDOM();
```
