
#### 1. Understand the counting

If a wagon has `n` passengers, then the number of ways to choose 2 of them is \( \binom{n}{2} = \frac{n(n-1)}{2} \).
We do this for each wagon and sum them.

#### 2. Example data

Passengers per wagon:

- Wagon 1: 2 passengers → \( \binom{2}{2} = 1 \)  
- Wagon 2: 1 passenger → \( \binom{1}{2} = 0 \)  
- Wagon 3: 0 passengers → \( \binom{0}{2} = 0 \)  
- Wagon 4: 3 passengers → \( \binom{3}{2} = 3 \)

Total = \( 1 + 0 + 0 + 3 = 4 \)

#### 3. SQL approach

We need:

1. Count passengers per wagon  
2. Compute \( \binom{n}{2} \) for each  
3. Sum them
   
#### Option 1 — GROUP BY and SUM formula

```sql
SELECT SUM(cnt * (cnt - 1) / 2) AS total_ways
FROM (
    SELECT wagon_id, COUNT(*) AS cnt
    FROM Passengers
    GROUP BY wagon_id
) AS passenger_counts;
```


#### Option 2 — Join with wagons to ensure even empty wagons are included (though empty contribute 0 anyway)

```sql
SELECT SUM(
    CASE 
        WHEN p_cnt IS NULL OR p_cnt < 2 THEN 0
        ELSE p_cnt * (p_cnt - 1) / 2
    END
) AS total_ways
FROM Wagons w
LEFT JOIN (
    SELECT wagon_id, COUNT(*) AS p_cnt
    FROM Passengers
    GROUP BY wagon_id
) pc ON w.id = pc.wagon_id;
```

But `SUM` of `NULL` is 0, so simpler:

```sql
SELECT SUM(
    COALESCE(p_cnt, 0) * (COALESCE(p_cnt, 0) - 1) / 2
) AS total_ways
FROM Wagons w
LEFT JOIN (
    SELECT wagon_id, COUNT(*) AS p_cnt
    FROM Passengers
    GROUP BY wagon_id
) pc ON w.id = pc.wagon_id;
```


But actually, if we **only need the sum over wagons with passengers**, the first query is fine. Empty wagons contribute 0 anyway.


Given the example data,  
using just the `Passengers` table:

```sql
SELECT SUM(cnt * (cnt - 1) / 2) AS total_ways
FROM (
    SELECT wagon_id, COUNT(*) AS cnt
    FROM Passengers
    GROUP BY wagon_id
) counts;
```


**Result:** 4.
**Final answer:**

```sql
SELECT SUM(cnt * (cnt - 1) / 2) AS total_ways
FROM (
    SELECT wagon_id, COUNT(*) AS cnt
    FROM Passengers
    GROUP BY wagon_id
) AS passenger_counts;
```
