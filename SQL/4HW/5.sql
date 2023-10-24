SELECT seller_id
, STRING_AGG(category, '-' ORDER BY category) AS category_pair -- используем STRING_AGG для соединения строк
FROM sellers
WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD-MM-YYYY')) = 2022
GROUP BY seller_id
HAVING count(category) = 2 AND sum(revenue) > 75000
ORDER BY seller_id;
