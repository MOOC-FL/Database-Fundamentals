#### Changes vs. queries

- [ ] Although it is ideal to have no duplicate data in a database, sometimes duplicate data is needed to make searches more efficient. Duplicate data makes it more difficult to modify the database but makes it easier to query.
- [ ] A common phenomenon in computer science is that we have to balance whether we want to change or retrieve information efficiently and how much space we can use. This is not only encountered in databases, but also in algorithm design, for example.
- [ ] If there is no duplicate data in the database, changes are easy because each piece of data is only in one place, meaning you only need to change one row in one table. Another advantage is that duplicate data does not take up space in the database. On the other hand, queries can be complex and slow because the desired data has to be gathered from different parts of the database.
- [ ] By adding duplicate data, we can speed up queries, but on the other hand, changes become more difficult because the changed data must be updated in multiple places. At the same time, the database space usage also increases due to duplicate data.
- [ ] There is no general rule for how much duplicate information to add, as this depends on the content of the database and the desired queries. A good approach is to start with no duplicate information and then add duplicate information as needed if the queries are not otherwise efficient enough.


| Aspect | Queries (SELECT) | Changes (INSERT/UPDATE/DELETE) |
|--------|------------------|--------------------------------|
| **Purpose** | Read data | Modify data |
| **Data Impact** | None | Permanent changes |
| **Return Value** | Result set (rows) | Count of affected rows |
| **Locks** | Shared (usually) | Exclusive (usually) |
| **Transaction Effect** | Can be part of transaction | Must be committed/rolled back |
| **Performance Impact** | Minimal on structure | Can affect indexes, triggers |
| **Undo** | Not needed | Possible via ROLLBACK |








