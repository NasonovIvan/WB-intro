SELECT ROUND(avg(price)::NUMERIC, 2) AS avg_price
, category
FROM products p
WHERE p.name LIKE 'Hair%'
   OR p.name LIKE 'Home%'
GROUP BY category;