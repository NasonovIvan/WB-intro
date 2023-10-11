alter table orders
add discount INT,
add new_price REAL;
    
alter table orders
add CONSTRAINT discount_check CHECK (discount >= 0 and discount <= 100);

update orders
set discount = 0
, new_price = price;

update orders
set new_price = price * 0.9
, discount = 10
where user_id in (
  select user_id
  from orders
  where price = (select max(price) from orders));

select * from orders;
