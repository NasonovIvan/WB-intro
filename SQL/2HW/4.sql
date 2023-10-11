ALTER TABLE orders
ADD discount INT,
ADD new_price REAL;
    
ALTER TABLE orders
ADD CONSTRAINT discount_check CHECK (discount >= 0 and discount <= 100);

UPDATE orders
SET discount = 0
, new_price = price;

UPDATE orders
SET new_price = price * 0.9
, discount = 10
WHERE user_id IN (
  SELECT user_id
  FROM orders
  WHERE price = (SELECT max(price) FROM orders));

SELECT * FROM orders;
