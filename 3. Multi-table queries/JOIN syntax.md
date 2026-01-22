#### JOIN syntax
- So far, we have retrieved information from `tables` by listing the tables in the query `FROM` part, which usually works well. However, sometimes we need `JOIN` the syntax, which is useful when the query result appears to be “missing” information.
###### Questionnaire methods
- Below are two ways to implement the same query, first using the familiar method and then using `JOIN` the -syntax.
```sql
SELECT
  Courses.name, Teachers.name
FROM
  Courses, Teachers
WHERE
  Courses.teacher_id = Teachers.id;
```
```sql
SELECT
  Courses.name, Teachers.name
FROM
  Courses JOIN Teachers ON Courses.teacher_id = Teachers.id;
```
- `JOIN` In the syntax, a word appears between the table names `JOIN` and, in addition, the condition that connects the rows of the tables is given in a separate ONpart.

- In this case, `JOIN` the -syntax is just an alternative way to execute the query and does not bring anything new. However, we will see next how we can extend the syntax so that it gives us new possibilities in queries.
#### Example
- As an example, let's consider a situation where the database contains the familiar tables `Courses`and `Teachers`, but `Courses` one of the `courses` in the table is missing a `teacher`:
```text
id  name              teacher_id
--  ----------------  ----------
1   Laskennan mallit  3         
2   Tietoverkot       1         
3   Graduseminaari    1         
4   PHP-ohjelmointi   NULL      
5   Neuroverkot       3   
```

