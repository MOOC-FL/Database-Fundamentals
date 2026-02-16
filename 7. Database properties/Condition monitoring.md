#### Condition monitoring
- The benefit of conditions is that the database system enforces the conditions and refuses to make any additions or changes that violate them. Here is an example of this in SQLite:
```cmd
sqlite> CREATE TABLE Products (id INTEGER PRIMARY KEY,
   ...>                        name TEXT,
   ...>                        price INTEGER,
   ...>                        CHECK (price >= 0));
sqlite> INSERT INTO Products(name, price) VALUES ('retiisi', 4);
sqlite> INSERT INTO Products(name, price) VALUES ('selleri', 7);
sqlite> INSERT INTO Products(name, price) VALUES ('nauris', –2);
Error: CHECK constraint failed: Products
sqlite> SELECT * FROM Products;
1|retiisi|4
2|selleri|7
sqlite> UPDATE Products SET price = –2 WHERE id = 2;
Error: CHECK constraint failed: Products
```
- When we try to insert `Products` a row into the table where the price is negative, this violates the condition `price >= 0` and **SQLite** does not allow the row to be inserted but gives an error `CHECK constraint failed: Products`. The same thing happens if we try to change the price column of an existing row to negative afterwards.

