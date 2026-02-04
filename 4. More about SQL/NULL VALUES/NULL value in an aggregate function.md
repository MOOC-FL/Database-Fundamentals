#### NULL value in an aggregate function
- When an aggregate function contains an expression (such as a column value), the row is not counted if the expression value is `NULL`. For example, consider the following table `Employees`:
```text
id  name      company  salary
--  --------  -------  ------
1   Anna      Google   8000  
2   Liisa     Google   7500  
3   Kaaleppi  Amazon   NULL  
4   Uolevi    Amazon   NULL  
5   Maija     Google   9500  
```
- In the table, Google employees have a salary listed, but Amazon employees do not. The aggregate function `COUNT(salary)`only counts rows where a salary is listed:
```sql
SELECT COUNT(salary) FROM Employees WHERE company = 'Google';
```
```text
COUNT(salary)
-------------
3

```
```sql
SELECT COUNT(salary) FROM Employees WHERE company = 'Amazon';
```
```text
COUNT(salary)
-------------
0
```
- When we then calculate the sums of the salaries using the aggregate function `SUM(salary)`, we get the following results:
```sql
SELECT SUM(salary) FROM Employees WHERE company = 'Google';
```
```text
SUM(salary)
-----------
25000  
```
```sql
SELECT SUM(salary) FROM Employees WHERE company = 'Amazon';
```
```text
SUM(salary)
-----------
NULL
```
> This is a bit surprising, because one would also expect the empty `sum` to be 0 and not `NULL`.



