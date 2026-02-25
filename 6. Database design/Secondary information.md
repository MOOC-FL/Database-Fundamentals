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






