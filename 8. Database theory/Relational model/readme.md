#### Relational model
- SQL databases are based on the relational model, the theoretical basis of which was created in the 1970s. In 1970, EF Codd introduced both the idea of ​​a relational database and a general-purpose database query language in his article A relational model of data for large shared data banks .
- Compared to previous databases, the strength of the relational model was its
  -  **simplicity:** using the same clear model, it is possible to present many types of information naturally and implement diverse queries.
- But what exactly does a relation mean? One simple example of a relation is a binary relation.
<
<or “less than”. This relation defines a set of pairs, each pair of which
(
a
,
b
)
( a ,b )the condition applies
a
<
b
a<bWhen the consideration is restricted to positive integers, this set looks like this:

<p align="center">
  <img src="https://github.com/MOOC-FL/Media/blob/main/Database%20Fundementals/Database%20Theory/Screenshot%202026-03-03%20113334.png" alt="">
</p>

- A binary relation is two-position, meaning that each element of the relation is a pair. More generally, it can be defined as
k
k-local relation, where each element of the relation is a set of forms
(
x
1
,
x
2
,
…
,
x
k
)
( x 
1
​
 ,x 
2
​
 ,…,x 
k
​
 ).
- In a relational database, a relation represents a collection of data that has a specific structure. For example, the following relation contains information about products:

<p align="center">
  <img src="https://github.com/MOOC-FL/Media/blob/main/Database%20Fundementals/Database%20Theory/Screenshot%202026-03-03%20113356.png" alt="">
</p>
- This relation is three-position and its attributes are:
    - *i d*: product id number
    - *name*​: product name
    - *price​*​​: product price
- For example, in the plural
(
1
,
r
e
t
I
I
s
I
,
7
)
( 1 ,re t i i s i ,7 )attribute
I
d
i dthere is
1
1, attribute
of
a
m
e
name​there is
r
e
t
I
I
s
I
re t i i s iand attribute
p
r
I
c
e
price​​​there is
7
7.
> The above relation corresponds to a database table Productswith information about products:

| id | name   | price |
|----|--------|-------|
| 1  | radish | 7     |
| 2  | carrot | 5     |
| 3  | turnip | 4     |
| 4  | swede  | 8     |
| 5  | celery | 4     |

- A relation is a mathematical way of describing the contents of a database table as a set. Each tuple in a relation corresponds to one row in the table, and the number of attributes in the tuple is the same as the number of columns in the table.








  
