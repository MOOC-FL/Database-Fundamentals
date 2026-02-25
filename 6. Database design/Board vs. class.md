#### Board vs. class
- A database table definition describes what type of data can be stored in the table. For example, in the following table, `Movies` each row of the table contains the name of a movie and its release year:
```sql
CREATE TABLE Movies (
  id INTEGER PRIMARY KEY,
  name TEXT,
  release_year INTEGER
);

INSERT INTO Movies (name, release_year) VALUES ('Lumikki', 1937);
INSERT INTO Movies (name, release_year) VALUES ('Fantasia' 1940);
INSERT INTO Movies (name, release_year) VALUES ('Pinocchio', 1940);
```
- In many programming languages, a class definition describes what type of information the objects contain. For example, the following Python code defines a class `Movie` that contains the name of a movie and its release year. The code then adds objects to a list.
```py
@dataclass
class Movie:
    name: str
    release_year: int

movies = []
movies.append(Movie("Lumikki", 1937))
movies.append(Movie("Fantasia", 1940))
movies.append(Movie("Pinocchio", 1940))
```
- The definition of a database table is therefore similar to a programming class, and a single row in the table is close to an object created from the class.
#### One or multiple boards?
- In programming, all objects of the same type are based on the same class, and similarly in a database, all rows of the same type are in one table. This allows us to conveniently manipulate rows with SQL commands.
- For example, if you have a database of movies, a good solution is to store all the movies in the same table Movies:
```text
id  name       release_year
--  ---------  ------------
1   Lumikki    1937        
2   Fantasia   1940        
3   Pinocchio  1940        
4   Dumbo      1941        
5   Bambi      1942   
```
- From this table, we can search for movies from 1940, for example, like this:
```sql
SELECT name FROM Movies WHERE release_year = 1940;
```
- But what if we split the movies into multiple boards? For example, we could split the movies into boards by year. In this case, the board Movies1940would contain movies from 1940, and we could search for them like this:

- This solution works as long as we only want to search for movies from a certain year. However, the database becomes unwieldy if we want to do any other searches. For example, if we want to search for all movies from 1940–1950, we need several queries:
```sql
SELECT name FROM Movies1940;
SELECT name FROM Movies1941;
SELECT name FROM Movies1942;
...
SELECT name FROM Movies1950;
```
- However, when the movies are on the same board, we can figure it out with one query:
```sql
SELECT name FROM Movies WHERE release_year BETWEEN 1940 AND 1950;
```
- When the movies are in one table, we can process them in a variety of ways with individual SQL commands, which would not be possible if there were multiple tables.





