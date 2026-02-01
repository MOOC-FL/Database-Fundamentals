#### CASE
- The structure `CASE` allows you to create a conditional statement. It can have one or more `WHEN-parts` and an optional `ELSE-part`. For example, query
```sql
SELECT
  name,
  CASE WHEN price > 5 THEN 'kallis' ELSE 'halpa' END
FROM
  Products;
```
- retrieves the name of each product and whether the product is expensive or cheap. Here, a product is expensive if its price is over 5, and cheap otherwise.


#### **CASE EXPRESSION**
| Aspect | Simple CASE | Searched CASE | Notes |
|--------|-------------|---------------|-------|
| **Syntax Type** | `CASE x WHEN a THEN b ...` | `CASE WHEN condition THEN result ...` | Two different forms |
| **Use Case** | Equality comparisons | Complex conditions | Simple CASE for specific values |
| **Multiple Conditions** | ✅ Yes | ✅ Yes | Both support multiple WHEN |
| **ELSE Clause** | Optional | Optional | Default if no condition matches |
| **END Required** | ✅ Yes | ✅ Yes | Both must end with END |
| **Can Return NULL** | ✅ Yes (if no ELSE) | ✅ Yes (if no ELSE) | Without ELSE, returns NULL |
| **Example** | `CASE grade WHEN 'A' THEN 'Excellent'` | `CASE WHEN price > 5 THEN 'kallis'` | Your example uses searched CASE |


#### **CASE Execution**
```
CASE Expression:
    ↓
Evaluate WHEN condition 1
    ↓ True → Return THEN result 1
    ↓ False → Evaluate WHEN condition 2
                 ↓ True → Return THEN result 2
                 ↓ False → Continue...
    ↓ No conditions true → Return ELSE result (or NULL)
```

This table format helps you quickly compare and choose the right expression for your needs!
 
