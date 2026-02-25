#### Secondary information
- *Principle* : Every piece of information is in exactly one place in the database. There is no information in the database that can be calculated or inferred based on other content in the database.
- By following this principle, updating the contents of the database is easy, because the update only needs to be made in one place and does not affect other parts of the database.
##### Example 1
- We store messages sent by users to the system in the following table `Messages`:
```text
id  user        message       
--  ----------  --------------
1   Anna123     Missä olet?   
2   Joulupukki  Bussissa vielä
3   Anna123     Meneekö kauan?
4   Joulupukki  5 min        
```
- This is a working solution, but it is difficult to update the database if a user decides to change their name. For example, if Anna123 wants to change her name, the change must be made to every message she has sent.
- A better solution is to implement the database so that the user name is only in one place. A natural place for this is the table `Users` that contains the users:
```text
id  name      
--  ----------
1   Anna123   
2   Joulupukki
```
In other tables, the user ID number is only referenced, which is immutable information. For example, the table `Messages` now looks like this:
```text
id  user_id  message       
--  -------  --------------
1   1        Missä olet?   
2   2        Bussissa vielä
3   1        Meneekö kauan?
4   2        5 min    
```
- After this, changing the user's name is easy because the change is only made `Users` to one row in the table and the change is immediately updated everywhere because the other tables still refer to the correct row.
- This complicates queries because information must be retrieved from multiple tables, but the solution is still good overall.
> **Still repetitive?**
- Despite the recent change, there may still be some repetition in the database. For example, in the following scenario, users send the same message “Hello!” Should the database structure be improved?
```text
id  user_id  message
--  -------  -------
1   1        Hei!   
2   2        Hei!   
```
- In this case, it would not be a good idea to implement a database so that if two users send a message with the same content, the message content is only stored in one place.
- Even though the messages have the same content, they are separate messages that are not intended to refer to the same thing. If user 1 changes the content of a message, the change should not be reflected in user 2's message, even if it currently has the same content.
##### Example 2
- We store information about students' achievements in a database. The database can be used to query how many credits a student has completed.
- In the following database, information is stored for each student about how many credits they have completed. The table `Students` contains:
```text
id  name    total_credits
--  ------  -------------
1   Maija   20           
2   Uolevi  10           
```
The table, `Completionsin` turn, has the following lines:
```text
id  student_id  course_id  credits
--  ----------  ---------  -------
1   1           1          5      
2   1           2          5      
3   1           4          10     
4   2           1          5      
5   2           3          5     
```
We can easily retrieve a student's total credits like this:
```sql
SELECT total_credits FROM Students WHERE name = 'Maija';
```
- However, the database contains secondary information: the contents of a table `Students` column`total_credit` scan be calculated `Completions` using the table. For example, the number of credits Maija has in the 20 table `Students` can also be calculated as the sum of 5 + 5 + 10 from the table `Completions`.
- The problem is that when adding an achievement, you must both add a new row to the table `Completions` and update the total number of credits in the table `Students`. If the update is forgotten or fails, conflicting information will be entered into the database.
- We get rid of the duplicate data by deleting the column `total_credits` from the table `Students`:
```text
id  name  
--  ------
1   Maija 
2   Uolevi
```
As a result of this change, it is more difficult to determine a student's total number of credits, because the information must be calculated based on the achievements:
```sql
SELECT SUM(Completions.credits) AS total_credits
FROM Completions, Students
WHERE Completions.student_id = Students.id AND Students.name = 'Maija';
```
However, this is a good change overall, because now we can worry-free change the grades on the board `Completions` and be confident that we will always get up-to-date information about the student's credits.
















