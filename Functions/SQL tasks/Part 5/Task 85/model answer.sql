SELECT COUNT(*)
FROM Passengers AS A, Passengers AS B
WHERE A.id < B.id AND A.wagon_id = B.wagon_id;
