DROP view IF EXISTS sellers_items;
CREATE VIEW sellers_items AS
	SELECT seller_id
	, count(category) AS total_categ
	, ROUND(avg(rating)::NUMERIC, 2) AS avg_rating
	, sum(revenue) AS total_revenue
    FROM sellers
    WHERE category != 'Bedding'
    GROUP BY seller_id
    ORDER BY seller_id;
    
SELECT seller_id
, total_categ
, avg_rating
, total_revenue
, (CASE WHEN total_categ > 1 AND total_revenue > 50000 THEN 'rich' ELSE 'poor' END) AS seller_type
FROM sellers_items;
