SELECT city, count(age)
FROM users
GROUP BY city
ORDER BY count(age) DESC;

SELECT city
, SUM(CASE WHEN age >=0 AND age <=20 THEN 1 ELSE 0 END) AS young
, SUM(CASE WHEN age >=21 AND age <=49 THEN 1 ELSE 0 END) AS adult
, SUM(CASE WHEN age >=50 THEN 1 ELSE 0 END) AS old
FROM users
GROUP BY city;
