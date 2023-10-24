-- создадим view с параметрами бедных продавцов
DROP view IF EXISTS sellers_poor;
CREATE VIEW sellers_poor AS
	SELECT seller_id
    , MAX(TO_DATE(date_reg, 'DD-MM-YYYY')) AS max_reg_date -- выбираем "самую свежую" дату регистрации
    , ROUND(avg(delivery_days)::NUMERIC, 2) AS avg_delivery_days -- берем среднее от дней доставки за все время
    FROM sellers
    WHERE category != 'Bedding'
    GROUP BY seller_id
    HAVING count(category) < 2 AND sum(revenue) <= 50000
    ORDER BY seller_id;
    
SELECT seller_id
, EXTRACT(year FROM AGE(CURRENT_DATE, max_reg_date)) * 12 +
	EXTRACT(MONTH FROM AGE(CURRENT_DATE, max_reg_date)) AS month_from_registration
, (SELECT MAX(avg_delivery_days) - MIN(avg_delivery_days) AS max_delivery_difference
	FROM sellers_poor) AS max_delivery_difference -- вложенным запросом избегаем нулевого значения из-за группировки
FROM sellers_poor
GROUP BY seller_id, max_reg_date
ORDER BY seller_id;
