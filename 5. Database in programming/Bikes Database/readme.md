#### Bikes Database
The database contains the following two tables:
```sql
CREATE TABLE Stations (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE Trips (
    id INTEGER PRIMARY KEY,
    start_time TEXT,
    end_time TEXT,
    start_station_id INTEGER REFERENCES Stations,
    end_station_id INTEGER REFERENCES Stations,
    distance INTEGER,
    duration INTEGER
);
```
- The table `Stations` contains information about city bike stations. The table has two columns: `id`(id number) and `name`(station name).
- The table `Trips`contains information about trips. The table has the following columns:
  1. `id`: id number
  2. `start_time`: trip start time (in the format yyyy-mm-ddThh:mm:ss)
  3. `end_time`: trip end time (in format yyyy-mm-ddThh:mm:ss)
  4. `start_station_id`: starting station id number
  5. `end_station_id`: end station id number
  6. `distance`: distance traveled (in meters)
  7. `duration`: trip duration (in seconds)
- We can examine the contents of the database through the SQLite interpreter as follows:
```cmd
$ sqlite3 bikes_2024.db
sqlite> .tables
Stations  Trips
sqlite> SELECT COUNT(*) FROM Stations;
458
sqlite> SELECT COUNT(*) FROM Trips;
2585668
sqlite> SELECT * FROM Stations LIMIT 10;
1|Kaivopuisto
2|Laivasillankatu
3|Kapteeninpuistikko
4|Viiskulma
5|Sepänkatu
6|Hietalahdentori
7|Designmuseo
8|Vanha kirkkopuisto
9|Erottajan aukio
10|Kasarmitori
sqlite> SELECT * FROM Trips WHERE id = 100;
100|2024-04-01T10:05:03|2024-04-01T10:26:19|119|259|4627|1271
sqlite> SELECT name FROM Stations WHERE id = 119;
Gebhardinaukio
sqlite> SELECT name FROM Stations WHERE id = 259;
Petter Wetterin tie
sqlite> .quit
```
- Based on this, the database contains 458 stations and 2585668 trips. For example, the trip with ID number 100 started at Gebhardinaukio and ended at Petter Wetterin tie. The trip was 4.6 kilometers long and took just over 21 minutes.
- Next, let's see how we can process this database using Python and R.

 

