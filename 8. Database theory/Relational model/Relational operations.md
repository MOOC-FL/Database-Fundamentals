#### Relational operations
- Relational operations allow you to create new relations from existing relations. This is similar to an SQL query that creates a table from a table or tables. The three main relational operations are **projection**, **restriction**, and **join**.
##### Projection
- Projection​​​ **Π** forms a relation that contains certain attributes of the original relation. Examples:
<p align="center">
  <img src="https://github.com/MOOC-FL/Media/blob/main/Database%20Fundementals/Database%20Theory/Screenshot%202026-03-03%20123639.png" alt="">
</p>

<p align="center">
  <img src="https://github.com/MOOC-FL/Media/blob/main/Database%20Fundementals/Database%20Theory/Screenshot%202026-03-03%20123700.png" alt="">
</p>

>  Note that any repeating tuples are filtered out of the projection because the projection is a relation, i.e. a set. 

- Therefore, in the projection
**Π prIce(P)Π**
  - price​​​​
 ( P )There are only four plurals because two products have the same price.
  - A projection corresponds to an SQL query that retrieves specific columns from a table. For example, a projection **Πofame(P)Π name​(P)** corresponds to a SQL query `SELECT name FROM Products`.
