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
```
SELECT
  Courses.name, Teachers.name
FROM
  Courses JOIN Teachers ON Courses.teacher_id = Teachers.id;
```

