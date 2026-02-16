#### Example: Station name
- The following code asks the user for the station ID number and uses it to retrieve the station name from the database:
```py
import sqlite3

db = sqlite3.connect("bikes_2024.db")

station_id = input("Anna aseman id-numero: ")
result = db.execute("SELECT name FROM Stations WHERE id = ?", [station_id])
station_name = result.fetchone()[0]
print("Aseman nimi:", station_name)

```
The code execution might look like this:
```text
Anna aseman id-numero: 42
Aseman nimi: Haapaniemenkatu
```
- Here, the query contains a parameter `?` whose value is `station_id` the id number in the variable. The code shows how to `execute` provide the parameter values ​​as a list when calling the method.
- In this case, the method `fetchone` returns a `tuple` with one element. The contents of this element are retrieved into a variable `[]` using the -syntax, where `0` means to retrieve the first element of the tuple.
- Another weakness of the code is that it does not take into account the situation where there is no station with the given id number in the database:
```py
Anna aseman id-numero: 666
Traceback (most recent call last):
  File "test.py", line 7, in <module>
    station_name = result.fetchone()[0]
                   ~~~~~~~~~~~~~~~~~^^^
TypeError: 'NoneType' object is not subscriptable

```
- In this situation, the method `fetchone` returns the value `None`, making it impossible to retrieve the first element of the tuple. We can handle this situation, for example, using the `try`/ construct:`except`
```py
import sqlite3

db = sqlite3.connect("bikes_2024.db")

station_id = input("Anna aseman id-numero: ")
result = db.execute("SELECT name FROM Stations WHERE id = ?", [station_id])

try:
    station_name = result.fetchone()[0]
    print("Aseman nimi:", station_name)
except TypeError:
    print("Asemaa ei löytynyt")
```
- Now the code gives a clear message that the drive was not found:
```text
Anna aseman id-numero: 666
Asemaa ei löytynyt
```
- Here is another implementation where the database search is performed `find_station_name` via a function. This function returns the name of the drive or the string `--` if the drive was not found.
```py
import sqlite3

db = sqlite3.connect("bikes_2024.db")

def find_station_name(station_id):
    result = db.execute("SELECT name FROM Stations WHERE id = ?",
                        [station_id])
    result_row = result.fetchone()
    return result_row[0] if result_row else "--"

station_id = input("Anna aseman id-numero: ")

station_name = find_station_name(station_id)
print("Aseman nimi:", station_name)
```
- Now the code works as follows:
```text
Anna aseman id-numero: 42
Aseman nimi: Haapaniemenkatu
Anna aseman id-numero: 666
Aseman nimi: --
```



