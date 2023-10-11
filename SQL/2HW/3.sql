SELECT first_name
, last_name
FROM users
JOIN orders ON users.id = orders.user_id
WHERE TO_DATE(orders._order_date, 'DD/MM/YYYY') >= '2022-09-01'
	AND TO_DATE(orders._order_date, 'DD/MM/YYYY') <= '2022-11-30';

