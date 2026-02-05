#### Position numbers
- Let's look at the table `Results` with players and their results:
```text
id  name      score
--  --------  -----
1   Aapeli    45   
2   Kaaleppi  115  
3   Liisa     120  
4   Maija     80   
5   Uolevi    120  
```
- The goal is to retrieve the rows in order of the result from largest to smallest and also report the rank of each row . One way to do this is to make a subquery that calculates how many rows have a better result, in which case the rank is one higher than the subquery result:
```sql
SELECT
  (SELECT COUNT(*) FROM Results WHERE score > R.score) + 1 AS place,
  name, score
FROM
  Results R
ORDER BY
  score DESC, name;
```
```text
place  name      score
-----  --------  -----
1      Liisa     120  
1      Uolevi    120  
3      Kaaleppi  115  
4      Maija     80   
5      Aapeli    45  
```
- Using the same idea, the ranking numbers can also be calculated so that everyone has a different ranking and in the case of a tie, alphabetical order determines the ranking:
```sql
SELECT
  (SELECT COUNT(*) FROM Results WHERE score > R.score OR
    (score = R.score AND name < R.name)) + 1 AS place,
  name, score
FROM
  Results R
ORDER BY
  score DESC, name;
```
```text
place  name      score
-----  --------  -----
1      Liisa     120  
2      Uolevi    120  
3      Kaaleppi  115  
4      Maija     80   
5      Aapeli    45 
```
- An alternative way to calculate the place values ​​is to use a window function , if the database used allows it. For example, in new versions of SQLite, the window function `RANK`can be used to calculate the same place values ​​as in the previous examples.
```sql
SELECT
  RANK() OVER (ORDER BY score DESC) place, name, score
FROM
  Results
ORDER BY
  place, name;
```
```text
place  name      score
-----  --------  -----
1      Liisa     120  
1      Uolevi    120  
3      Kaaleppi  115  
4      Maija     80   
5      Aapeli    45 
```
```sql
SELECT
  RANK() OVER (ORDER BY score DESC, name) place, name, score
FROM
  Results
ORDER BY
  place, name;
```
```text
place  name      score
-----  --------  -----
1      Liisa     120  
2      Uolevi    120  
3      Kaaleppi  115  
4      Maija     80   
5      Aapeli    45  
```
