## Database Schema

### Stations Table
| Column | Type | Constraint |
|--------|------|------------|
| id | INTEGER | PRIMARY KEY |
| name | TEXT | |

### Trips Table
| Column | Type | Constraint |
|--------|------|------------|
| id | INTEGER | PRIMARY KEY |
| start_time | TEXT | |
| end_time | TEXT | |
| start_station_id | INTEGER | REFERENCES Stations |
| end_station_id | INTEGER | REFERENCES Stations |
| distance | INTEGER | |
| duration | INTEGER | |

## Subtask 1 (4 points)

| Function | Description | Example Result |
|----------|-------------|----------------|
| `trips_from_station(station_name)` | Number of trips started from a given station | "Intiankatu" → 8535 |
| `trips_to_station(station_name)` | Number of trips completed to a given station | "Intiankatu" → 8448 |

## Subtask 2 (5 points)

### `longest_distance_trips(limit)` — Results for limit = 5

| Departure station | Destination station | Distance (m) |
|-------------------|---------------------|--------------|
| Erottaja Square | Union Street | 655225 |
| Gunillantie | Workshop Helsinki | 425905 |
| Pajamäki | Paloheinä Library | 393434 |
| Tupasaarentie | Marjaniementie | 277991 |
| Pitäjänmäki Station | Workshop Helsinki | 262121 |

### `longest_duration_trips(limit)` — Results for limit = 5

| Departure station | Destination station | Duration (s) |
|-------------------|---------------------|--------------|
| Lintulahdenkatu | Marjaniementie | 6286982 |
| Tupasaarentie | Marjaniementie | 4649106 |
| Ehrenströmintie | Workshop Helsinki | 4396006 |
| Matinkyläntie | Paciuskari | 4000567 |
| Yours truly | Trumpet alley | 3987658 |

> **Side note:** This information does not seem plausible — the longest trip is 655 km and the longest duration is 72 days.
## Subtask 3 (6 points)

### `trips_during_month(month)` — Results (1 = January, 2 = February, …)

| Month | Number of trips |
|-------|-----------------|
| April | 167960 |
| May | 448518 |
| June | 469132 |
| July | 455422 |
| August | 492348 |
| September | 340507 |
| October | 211781 |

### `trips_during_weekday(day)` — Results (1 = Monday, 2 = Tuesday, …)

| Day | Number of trips |
|-----|-----------------|
| Monday | 379173 |
| Tuesday | 423740 |
| Wednesday | 405657 |
| Thursday | 406417 |
| Friday | 367325 |
| Saturday | 311952 |
| Sunday | 291404 |

## Subtask 4 (7 points)

### `most_popular_start_stations(limit)` — Results for limit = 5

| Station | Number of departures |
|---------|----------------------|
| Baltic Sea Market | 50441 |
| Töölönlahdenkatu | 36382 |
| Railway Square / West | 32415 |
| Pasila Station | 30910 |
| Fishing port (M) | 28352 |

### `least_popular_start_stations(limit)` — Results for limit = 5

| Station | Number of departures |
|---------|----------------------|
| Relay Box test station | 9 |
| Workshop Helsinki | 26 |
| Puistola VPK | 393 |
| Rainbow Road | 418 |
| Jakomäentie | 481 |

> **Note:** "Relay Box test station" appears to be a test station and "Workshop Helsinki" may be a bike depot, so the actual least popular starting station could be "Puistola VPK".

## Subtask 5 (8 points)

### `largest_differences(limit)` — Results for limit = 5

| Station | Trips begun | Completed trips | Difference |
|---------|-------------|-----------------|------------|
| Pasila Station | 30910 | 26670 | 4240 |
| Bear Park | 9686 | 8018 | 1668 |
| Sompasaari | 21604 | 23158 | 1554 |
| Vallila depot | 6068 | 4647 | 1421 |
| Signal Bridge | 5905 | 4550 | 1355 |

> *Note: The difference for Sompasaari appears inverted in the source data (21604 − 23158 = −1554, but listed as 1554). The table above reproduces the assignment's stated values.*

## Points Summary

| Subtask | Description | Points |
|---------|-------------|--------|
| 1 | Trips from/to station | 4 |
| 2 | Longest distance/duration trips | 5 |
| 3 | Trips by month/weekday | 6 |
| 4 | Most/least popular start stations | 7 |
| 5 | Largest start/end differences | 8 |
| **Total** | | **30** |
