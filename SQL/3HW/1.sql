CREATE TABLE users (
  user_id BIGSERIAL PRIMARY KEY, -- идентификатор пользователя с автоматической генерацией
  birth_date DATE, -- дата рождения
  sex CHAR(1), -- пол - достаточно одной буквы (M или F)
  age INT -- возраст - достаточно типа INT
);

CREATE TABLE items (
  item_id BIGSERIAL PRIMARY KEY, -- идентификатор товара с автоматической генерацией
  description VARCHAR(255), -- для описания выбрал 255 символов
  -- В description думал над типом TEXT, но захотел ограничить описание товара
  price DECIMAL(10, 2), -- цена с точностью до 2 цифр после запятой
  category VARCHAR(50) -- для категории выбрал 50 символов (учитывая что это будет одно слово)
);

-- добавил поле rating_id для идентификации каждого рейтинга
CREATE TABLE ratings (
  rating_id BIGSERIAL PRIMARY KEY, -- идентификатор рейтинга с автоматической генерацией
  item_id INT,
  user_id INT,
  review TEXT, -- так как ревью пишут пользователи, не захотел их ограничивать
  rating INT, -- рейтинг можно ставить от 0 до 10
  FOREIGN KEY (item_id) REFERENCES items(item_id), -- связка ключей из таблиц users и items
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- введем некоторые ограничения на поля в наших таблицах 
ALTER TABLE users
ADD CONSTRAINT sex_check CHECK (sex = 'M' or sex = 'F'),  -- ограничение на использование других символов
ADD CONSTRAINT age_check check (age >= 0); -- ограничение на отрицательный возраст

ALTER TABLE items
ADD CONSTRAINT price_check CHECK (price >= 0);  -- ограничение на отрицательную цену

ALTER TABLE ratings
ADD CONSTRAINT rating_check CHECK (rating >= 0 and rating <= 10);  -- ограничение на рейтинг

-- #### генерируем значения для таблиц ####

-- users
INSERT INTO users (birth_date, sex)
SELECT
  ('1980-01-01'::DATE + random() * INTERVAL '25 year' + random() * INTERVAL '12 month' + random() * INTERVAL '1 day')::date as age,
  CASE WHEN random() < 0.5 THEN 'M' ELSE 'F' END
FROM generate_series(1, 20);

UPDATE users
SET age = EXTRACT(YEAR FROM AGE(current_date, birth_date)); -- я решил отдельной командой вычислить точный возраст пользователя

-- items
INSERT INTO items (description, price, category)
SELECT
  CASE floor(random() * 8)
    WHEN 0 THEN 'High-quality electronics'
    WHEN 1 THEN 'Stylish clothing for all occasions'
    WHEN 2 THEN 'A vast library of books for readers of all ages'
    WHEN 3 THEN 'A wide selection of books for all ages'
    WHEN 4 THEN 'Affordable gadgets and accessories'
    WHEN 5 THEN 'Unique and trendy items for you'
    WHEN 6 THEN 'Premium tech products for the modern enthusiast'
    WHEN 7 THEN 'Budget-friendly gadgets and cool accessories'
    ELSE 'Discover the latest trends in unique and stylish items'
  END,
  floor(random() * 10000)::DECIMAL,
  unnest(array['Sport', 'Electronic', 'Garden', 'House', 'School', 'Work', 'Books'])
FROM generate_series(1, 20)
LIMIT 20; -- ограничиваем добавление только 20 записей (иначе из-за unnest будет 140)

-- ratings
INSERT INTO ratings (item_id, user_id, review, rating)
SELECT
  generate_series,
  generate_series,
  CASE floor(random() * 8)
    WHEN 0 THEN 'Experience the future with our high-tech electronics!'
    WHEN 1 THEN 'Dress to impress with our stylish and fashionable clothing.'
    WHEN 2 THEN 'Dive into captivating stories with our diverse book collection.'
    WHEN 3 THEN 'Books for every age, interest, and imagination :)'
    WHEN 4 THEN 'Gadgets and accessories that enhance your daily life.'
    WHEN 5 THEN 'Discover unique and trendy items for a distinctive lifestyle.'
    WHEN 6 THEN 'Elevate your tech game with premium tech products :)'
    WHEN 7 THEN 'Smart choices for budget-friendly gadgets and accessories.'
    ELSE 'It was one of the most wonderful goods, what I have ever bought :)'
  END,
  floor(random() * 10)
FROM generate_series(1, 20);