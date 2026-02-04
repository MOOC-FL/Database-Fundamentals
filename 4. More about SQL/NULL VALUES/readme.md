#### NULL values
- `NULL` is a special value that indicates that there is no data in a table column or that some part of the query did not return data. `NULL` is useful in certain situations, but can also cause surprises.
- By default, the SQLite interpreter displays `NULL`the value as empty:
```sql
sqlite> SELECT NULL;
```
However, `NULL` the value can be displayed with the interpreter command `.nullvalue`:
```sql
sqlite> .nullvalue NULL
sqlite> SELECT NULL;
NULL
```
- `NULL` is clearly different from the number 0. If `NULL` it appears as part of a calculation, the result of the entire calculation will be `NULL`.
```sql
sqlite> SELECT 5 + NULL;
NULL
sqlite> SELECT 2 * NULL + 1;
NULL
```
- Even a simple comparison will not produce a result if the comparison is `NULL`:
```sql
sqlite> SELECT 5 = NULL;
NULL
sqlite> SELECT 5 <> NULL;
NULL
```
- This is surprising, because usually the expressions aand bare either `a = b` or `a <> b`. However, we can use a special syntax to check `IS NULL`whether the expression is a value `NULL`:
```sql
sqlite> SELECT 5 IS NULL;
0
sqlite> SELECT NULL IS NULL;
1
```







