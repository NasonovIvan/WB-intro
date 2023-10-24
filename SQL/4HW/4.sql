-- создадим view с параметрами бедных продавцов
drop view if EXISTS sellers_poor;
CREATE VIEW sellers_poor AS
	SELECT seller_id
    , MAX(TO_DATE(date_reg, 'DD-MM-YYYY')) as max_reg_date -- выбираем "самую свежую" дату регистрации
    , ROUND(avg(delivery_days)::NUMERIC, 2) as avg_delivery_days -- берем среднее от дней доставки за все время
    from sellers
    where category != 'Bedding'
    group by seller_id
    having count(category) < 2 and sum(revenue) <= 50000
    order by seller_id;
    
select seller_id
, EXTRACT(year from AGE(CURRENT_DATE, max_reg_date)) * 12 +
	EXTRACT(MONTH from AGE(CURRENT_DATE, max_reg_date)) as month_from_registration
, (select max(avg_delivery_days) - min(avg_delivery_days) as max_delivery_difference
	from sellers_poor) as max_delivery_difference -- вложенным запросом избегаем нулевого знаечние из-за группировки
from sellers_poor
GROUP BY seller_id, max_reg_date
order by seller_id;
