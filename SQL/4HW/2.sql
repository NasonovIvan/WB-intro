select ROUND(avg(price)::NUMERIC, 2) as avg_price
, category
from products p
where p.name like 'Hair%'
   or p.name like 'Home%'
group by category;