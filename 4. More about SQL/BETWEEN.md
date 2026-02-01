#### BETWEEN
- The expression `x BETWEEN a AND b` is true if `x` there is at least `a` and at most `b`. For example, the query
```sql
SELECT * FROM Products WHERE price BETWEEN 4 AND 6;
```
- searches for products with a price of at least 4 and at most 6. Of course, we can also write a query that works in the same way like this:
```sql
SELECT * FROM Products WHERE price >= 4 AND price <= 6;
```
#### CASE
- The structure `CASE` allows you to create a conditional statement. It can have one or more `WHEN-parts` and an optional `ELSE-part`. For example, query
```sql
SELECT
  name,
  CASE WHEN price > 5 THEN 'kallis' ELSE 'halpa' END
FROM
  Products;
```
- retrieves the name of each product and whether the product is expensive or cheap. Here, a product is expensive if its price is over 5, and cheap otherwise.


