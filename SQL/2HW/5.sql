DELETE FROM orders
WHERE STATUS = 'cancel_order' OR items > 4;
