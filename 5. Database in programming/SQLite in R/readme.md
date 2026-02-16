#### SQLite in R
- In `R`, the SQLite database is typically accessed `RSQLite` using a library that can be installed with the command `install.packages("RSQLite")`. The following code connects to the database and retrieves `Stations`information from the table using SQL queries:
```R
library(RSQLite)

db <- dbConnect(SQLite(), "bikes_2024.db")

result <- dbGetQuery(db, "SELECT id, name FROM Stations WHERE id = 5")
print(result)

result <- dbGetQuery(db, "SELECT id, name FROM Stations ORDER BY id LIMIT 10")
print(result)
```
- The code output is as follows:
```TEXT
 id      name
1  5 Sepänkatu

   id               name
1   1        Kaivopuisto
2   2    Laivasillankatu
3   3 Kapteeninpuistikko
4   4          Viiskulma
5   5          Sepänkatu
6   6    Hietalahdentori
7   7        Designmuseo
8   8 Vanha kirkkopuisto
9   9    Erottajan aukio
10 10        Kasarmitori
```
- Here `db` is a database object through which `SQL` commands can be executed using the function `dbGetQuery`. In this code, two `SELECT`commands are executed.
- The first `SELECT`command retrieves Stationsthe row with id number 5 from the table. The second `SELECT`command retrieves `Stations` the first ten rows from the table.
> Database file location
- A typical problem with code that uses a database is that the database file is located in a different location on the computer than the code expects it to be. If you can't get the above code to work, this is probably the reason.
- If the database file referenced in the code does not exist, the code creates a new empty database file. Since there is no table in this database Stations, any attempt to retrieve information from the table will fail.






