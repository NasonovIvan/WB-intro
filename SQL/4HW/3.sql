drop view if EXISTS sellers_items;
CREATE VIEW sellers_items AS
	SELECT seller_id
	, count(category) as total_categ
	, ROUND(avg(rating)::NUMERIC, 2) as avg_rating
	, sum(revenue) as total_revenue
    from sellers
    where category != 'Bedding'
    group by seller_id
    order by seller_id;
    
select seller_id
, total_categ
, avg_rating
, total_revenue
, (case when total_categ > 1 and total_revenue > 50000 then 'rich' else 'poor' end) as seller_type
from sellers_items;
