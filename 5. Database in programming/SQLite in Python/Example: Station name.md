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





