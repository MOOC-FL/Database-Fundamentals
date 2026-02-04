#### NULL values
- `NULL` is a special value that indicates that there is no data in a table column or that some part of the query did not return data. `NULL` is useful in certain situations, but can also cause surprises.
- By default, the SQLite interpreter displays `NULL`the value as empty:
```sql
sqlite> SELECT NULL;
```
However, `NULL` the value can be displayed with the interpreter command `.nullvalue`:
```sql

```




