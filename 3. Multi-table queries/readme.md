#### Table references
- The central idea in databases is that a row in one table can refer to a row in another table. This allows queries to be created that collect information from multiple tables based on references. In practice, the reference is usually the ID number of a row in the other table.
#### Example
- As an example, let's consider a situation where a database contains information about courses and their teachers. We assume that each course has one teacher and the same teacher can teach multiple courses.
- We store `Teachers` information about teachers in a table. Each teacher has an ID number that we can use to refer to them.
```sql
CREATE TABLE Teachers (
  id INTEGER PRIMARY KEY,
  name TEXT
);
```


