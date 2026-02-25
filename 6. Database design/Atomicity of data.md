#### Atomicity of data
- Principle : Each column in a database table contains a single, or atomic, piece of information, such as a single number or a single string. A column cannot contain a list of information.
- This principle makes it easier to manipulate the database using SQL commands: when each piece of data is in its own column, the data can be referenced conveniently.
- You can store a list in a database by creating a table where each row is a single item in the list, like the table above `CourseTeachers`. But why can't we just store the list in a single column? The following example will clarify the point.
#### Example
##### Step 1:
- We want to store the students' exam results in a database. The exam has four tasks, each worth 0–6 points. We could try storing the scores like this:
```text
student_id  points 
----------  -------
1           6,5,1,4
2           3,6,6,6
3           6,4,0,6
```
- The idea is that the column `points` contains a string containing a list of dots separated by commas. However, this solution violates the principle that each column contains a single piece of information. What is wrong with this solution?
- The problem with this solution is that it is cumbersome to try to access the scores in SQL commands because the scores are contained within a string. For example, if we want to calculate the total score for each student, we would need a query like this:
```sql
SELECT student_id,
       SUBSTR(points, 1, 1) + SUBSTR(points, 3, 1) +
       SUBSTR(points, 5, 1) + SUBSTR(points, 7, 1) AS total_points
FROM Results;
```
- Here, the function `SUBSTR` extracts a substring from a string at a specific point. However, the query is cumbersome and also only works when there are exactly four points and they are single digits. We need a better way to store the points.
##### Step 2:
- The following table has four columns for the points, allowing us to process them one by one:
```text
student_id  points1  points2  points3  points4
----------  -------  -------  -------  -------
1           6        5        1        4
2           3        6        6        6
3           6        4        0        6
```
Thanks to this, we can already implement the survey more conveniently:
```sql
SELECT student_id,
       points1 + points2 + points3 + points4 AS total_points
FROM Results;
```
This solution is clearly an improvement, but it still has problems. Even though the scores are in different columns, the assumption is still that there are exactly four tasks. If the number of tasks changes, we have to change the table structure and all the SQL commands related to the scores, which is not a good situation.
##### Step 3:
When we want to store a list in a database, a good solution is to store each item in the list on its own row. In this example, we can create a table where each row represents a specific student's score on a specific assignment:
```text
student_id  task_id  points
----------  -------  ------
1           1        6     
1           2        5     
1           3        1     
1           4        4     
2           1        3     
2           2        6     
2           3        6     
2           4        6     
3           1        6     
3           2        4     
3           3        0     
3           4        6    
```
Now we can retrieve each student's total score like this:
```sql
SELECT student_id, SUM(points) AS total_points
FROM Results
GROUP BY student_id;
```
- This is a general-purpose query, meaning it works equally well regardless of the number of tasks. We can use a function to calculate the sum `SUM` instead of having to list all the tasks ourselves.
- Note that the number of rows in the table has increased significantly as a result of the change. However, this should not be a cause for alarm: database systems are designed to work well even with a large number of rows in the table.

#### What is atomic information?
- The concept of atomic data is not well defined. Clearly a list is not atomic data, but then is a string with several words?
- For example, consider a situation where a table column contains the user's name. Is this bad design because the first and last names are in the same column?
```text
id  name          
--  --------------
1   Anna Virtanen 
2   Maija Korhonen
3   Pasi Lahtinen 
```
We could also store the first and last name separately like this:
```text
id  first_name  last_name
--  ----------  ---------
1   Anna        Virtanen 
2   Maija       Korhonen 
3   Pasi        Lahtinen 
```
- Which table is better depends on the situation. If the system specifically needs to search for information based on first or last name (for example, find all users whose first name is Anna), the latter table is better. However, this is often not the case and there is nothing wrong with storing first and last names in the same column.
- Similarly, if a message sent by a user is stored in a database, it may contain many words, meaning that in a way the message is a list of words, but it is still a good solution to store the entire message in one column, because the message is processed as a single entity in the database. It would be a very bad solution to “atomically” divide the words of the message into their own columns.
- It is worth thinking about it this way: if some information needs to be processed separately in SQL commands, then it is atomic information that should be in its own column. If the information is not referenced in SQL commands, it can be in the column as part of a larger entity.













