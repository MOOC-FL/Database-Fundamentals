#### What is a database?
- A `database` is a collection of information on a computer that can be searched and the contents of which can be changed. Examples of databases include:
1. website user register
2. online store products and stock status
3. bank information about customers and account transactions
4. daily measured weather data in different locations
5. airline flight schedules and booking status
> Databases are enormous these days, and most people connect to numerous databases during a typical day.
#### Database challenges
- There are many challenges associated with the technical implementation of databases:
    -**Efficiency** Amount of data : A database can contain a large amount of data that is constantly being searched and modified. How can a database be implemented so that the data can be accessed efficiently?
    - **Concurrency** : A database usually has multiple users who can access and modify data at the same time. What should be considered in database implementation in this regard?
    - **Surprises** : The content of the database should remain reasonable even in unexpected situations. For example, what happens if the power goes out just as the data is being changed?
#### Database systems
- A database system maintains the contents of a database and provides the database user with functions that allow them to retrieve and modify information. Note that the term database is often used when referring to a database system.
- Most databases in use are based on the relational model and the SQL language, which we will learn about in this course. Examples of such database systems are `MySQL`, `PostgreSQL`, and `SQLite`. The theoretical basis of these databases was created in the 1970s.
- The term `NoSQL` refers to a database that is based on something other than the relational model and the SQL language. For example, `MongoDB` and `Redis` have gained popularity recently. However, we will not cover NoSQL databases much in this course.
```text
Database Systems
│
├── **Relational (SQL)**
│   │   Theory: Tables, Rows, Columns, ACID properties
│   │   Language: SQL
│   │
│   ├── Learning/Embedded: **SQLite**
│   ├── Common Servers: MySQL, PostgreSQL, Microsoft SQL Server
│
└── **NoSQL (Not-Only-SQL)**
    │   Focus: Scalability, Flexible Schemas, Specific Use Cases
    │
    ├── Document Stores: **MongoDB**
    ├── Key-Value Stores: **Redis**
    ├── Graph Databases: Neo4j
    └── Wide-Column Stores: Cassandra
```




