#### Implementation of references
  1. **One-to-many relationship**

     - Consider a database that stores courses and teachers. There is a one-to-many relationship between the tables: each course has one teacher,while one teacher can have many courses. We can create the tables in the database like this:
```sql
CREATE TABLE Teachers (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE Courses (
  id INTEGER PRIMARY KEY,
  name TEXT,
  teacher_id INTEGER REFERENCES Teachers
);
```

- In a table, `Courses`a column `teacher_id`refers to a table `Teachers`, meaning it contains the id number of a teacher. The reference is expressed `REFERENCES` with the -adjective, which says that the integer in the column refers to the table `Teachers`.
- We could put information on the boards like this:
```sql
INSERT INTO Teachers (name) VALUES ('Kaila');
INSERT INTO Teachers (name) VALUES ('Kivinen');
INSERT INTO Teachers (name) VALUES ('Laaksonen');

INSERT INTO Courses (name, teacher_id) VALUES ('Tietoverkot', 1);
INSERT INTO Courses (name, teacher_id) VALUES ('Graduseminaari', 1);
INSERT INTO Courses (name, teacher_id) VALUES ('PHP-ohjelmointi', 3);
INSERT INTO Courses (name, teacher_id) VALUES ('Neuroverkot', 2);
```
  2. **Many-to-many relationship**

     - Let's then consider a situation where multiple teachers can jointly organize a course. This is a many-to-many relationship, because a course can have multiple teachers and a teacher can have multiple courses.
     - Now a table `Teachers` row can be related to multiple table `Courses` rows, and a table `Courses` row can be related to multiple table `Teachers` rows. Since a database row cannot contain a list of references, we cannot add references directly to either table, but we must create a new table for the references:
```sql
CREATE TABLE Teachers (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE Courses (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE CourseTeachers (
  course_id INTEGER REFERENCES Courses,
  teacher_id INTEGER REFERENCES Teachers
);
```
> The change from before is that the table `Courses` no longer references the table `Teachers`, but instead there is a new table in the database `CourseTeachers` that references both tables. Each row in this table describes one relationship of the form ***“course id is taught by teacher id ”***.

For example, we could express that there are two teachers in the course like this:
```sql
INSERT INTO Teachers (name) VALUES ('Laaksonen');
INSERT INTO Teachers (name) VALUES ('Luukkainen');

INSERT INTO Courses (name) VALUES ('PHP-ohjelmointi');
INSERT INTO Courses (name) VALUES ('Neuroverkot');

INSERT INTO CourseTeachers VALUES (1, 1);
INSERT INTO CourseTeachers VALUES (1, 2);
INSERT INTO CourseTeachers VALUES (2, 1);
```
- This means that Laaksonen and Luukkainen will teach PHP programming in the course. In addition, Laaksonen will teach Neural Networks in the course.
- Note that we could also use this solution in the previous situation where there is always exactly one teacher in a course. In this case, however, there would be a kind of useless table in the database.







