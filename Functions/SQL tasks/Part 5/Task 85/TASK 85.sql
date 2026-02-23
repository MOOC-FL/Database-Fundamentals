SELECT IFNULL(SUM(cnt * (cnt - 1) / 2),0) AS total_ways
FROM (
    SELECT wagon_id, COUNT(*) AS cnt
    FROM Passengers
    GROUP BY wagon_id
) AS passenger_counts;
