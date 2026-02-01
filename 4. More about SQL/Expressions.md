#### Expressions
- An expression is a part of an SQL command that has a specific value. For example, in a query
```sql
SELECT price FROM Products WHERE name = 'retiisi';
```
- There are four expressions: `price`,` name`, `'retiisi'` and `name = 'retiisi'`. The expressions `price` and `name` get their values ​​from the column of the row, the expression 'retiisi'is a string constant, and the expression name = 'retiisi'is a boolean.
- We can build more complex expressions in the same way as in programming. For example, a query
```sql
SELECT price * 5 FROM Products;
```
- gives the price of each product in five times and the query
```sql
SELECT name FROM Products WHERE price % 2 = 0;
```
- searches for products with an even price.
- A good way to test the functionality of SQL expressions is to talk to the database by making queries that do not retrieve information from any table but only calculate the value of a specific expression. The conversation might look something like this:
```cmd
sqlite> SELECT 2 * (1 + 3);
8
sqlite> SELECT 'tes' || 'ti';
testi
sqlite> SELECT 3 < 5;
1
```
- The first query evaluates the expression `2 * (1 + 3)`. The second query uses `||` the operator to concatenate the strings `'tes'`and `'ti'`into the string `'testi'`. The third query determines `3 < 5` the value of the conditional expression. This shows that in SQLite, an integer represents a `boolean value: 1 `is true and 0 is false.
- Many things related to SQL expressions are familiar from programming:

1. calculations: `+`, `-`, `*`, `/`,`%`
2. comparing: `=`, `<>`, `<`, `<=`, `>`,`>=`
3. association of terms: `AND`, `OR`,`NOT`
In addition to these, however, SQL also has more special features that are sometimes useful to know. Here are some of them:





