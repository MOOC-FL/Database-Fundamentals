#### Example: Destination stations
- The following code asks the user for the starting station and date, and then finds all the destination stations where a journey that started from the starting station ended on the given date.
```R
library(RSQLite)

db <- dbConnect(SQLite(), "bikes_2024.db")

find_destinations <- function(station_name, date) {
  sql <- "
    SELECT DISTINCT B.name
    FROM Stations AS A, Stations AS B, Trips AS T
    WHERE
      T.start_station_id = A.id AND
      T.end_station_id = B.id AND
      A.name = ? AND
      T.start_time LIKE ?
    ORDER BY B.name
  "
  res <- dbGetQuery(db, sql, params = list(station_name, paste0(date, "%")))
  res$name
}

station_name <- readline(prompt = "Anna aseman nimi: ")
date <- readline(prompt = "Anna päivämäärä: ")

destinations <- find_destinations(station_name, date)
cat("Kohteiden määrä:", length(destinations), "\n")
for (destination in destinations) {
  cat(destination, "\n")
}
```
 - Here is an example of how the code works:
```text
Anna aseman nimi: Syystie
Anna päivämäärä: 2024-05-16
Kohteiden määrä: 5
A.I. Virtasen aukio
Ala-Malmin tori
Huhtakuja
Pukinmäen asema
Vanha Tapanilantie
```
- The command is given two parameters, which are placed `?` at the characters in the order they are given in the list. The first element of the list goes `?` at the first character and the second element goes `?` at the second character. Since the parameters are strings, they are placed `'` inside the characters in `SQL`.
- Trips starting on a specific date can be found `LIKE` using the `-` syntax by restricting the search so that the column `start_time` value must start with the given date. The function `paste0`adds a character after the date `%`, indicating that any time can follow the date.



