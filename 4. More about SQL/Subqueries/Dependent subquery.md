#### Dependent subquery
- It is also possible to implement a subquery so that its operation depends on the row being processed in the main query. This is the case in the following query:
```sql
SELECT
  name,
  score,
  (SELECT COUNT(*) FROM Results WHERE score > R.score) AS better_count
FROM
  Results R;
```
- **This query calculates for each player how many other players' scores are better than the player's own score. For example, the answer for Maija is 3, because Uolevi, Liisa and Kaalepi have better scores. The query gives the following result:**
```text
name      score  better_count
--------  -----  ------------
Uolevi    120    0           
Maija     80     3           
Liisa     120    0           
Aapeli    45     4           
Kaaleppi  115    2    
```
- Because the table `Results` plays two roles in the subquery, the table in the main query is given the name `R`. This makes it clear in the subquery that we want to calculate rows that have a better result than the result of the row being processed in the main query.
#### Here is yet another example of a dependent subquery:
```sql
SELECT
  name
FROM
  Results R
WHERE
  (SELECT COUNT(*) FROM Results WHERE score < R.score) >= 1;
```
- This query finds players who have a better score than some other player. Here, the subquery counts how many players have a worse score, and the query condition is that the subquery score is at least one. The query results in:
```text
name
----------
Uolevi    
Maija     
Liisa     
Kaaleppi  
```
> In this case, the query returns all players except Aapeli, who has the worst result.
- SQL also has a keyword `EXISTS`that indicates whether a subquery returns at least one row. This allows the previous query to be written more clearly:
```sql
SELECT
  name
FROM
  Results R
WHERE
  EXISTS (SELECT * FROM Results WHERE score < R.score);
```



