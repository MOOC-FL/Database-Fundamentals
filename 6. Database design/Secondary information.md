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




