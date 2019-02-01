USE store_medium;

SELECT * FROM product;
SELECT * FROM category;

-- Декартово произведение
SELECT * FROM product, category;
SELECT * FROM product CROSS JOIN category;
SELECT count(*) FROM product, category;

-- Вывод списка продуктов с наименованием категории для каждого
SELECT 
    p.product_name, p.price, c.category_name
FROM
    product AS p
        INNER JOIN
    category AS c ON p.category_id = c.category_id;
    
-- Внешние соединения
SELECT * FROM category AS c
	LEFT OUTER JOIN product AS p ON c.category_id = p.category_id;
SELECT * FROM product AS p
	RIGHT OUTER JOIN category AS c ON c.category_id = p.category_id;

-- Выборка из нескольких источников и объединение
-- Самые дорогие и самые дешевые товары в БД
SELECT * FROM product WHERE price > 900
	UNION SELECT * FROM product WHERE price < 100;


use store;

-- Выведите все позиций списка товаров принадлежащие какой-либо категории
-- с названиями товаров и названиями категорий. Список должен быть отсортирован
-- по названию товара, названию категории.
SELECT good.name, category.name FROM category_has_good
	INNER JOIN good ON category_has_good.good_id = good.id
    INNER JOIN category ON category_has_good.category_id = category.id
    ORDER BY good.name, category.name;
    
-- Выведите список клиентов (имя, фамилия) и количество заказов данных клиентов, имеющих статус "new"
SELECT client.first_name, client.last_name, count(1) AS new_sale_num FROM client
	INNER JOIN sale ON client.id = sale.client_id
    INNER JOIN status ON sale.status_id = status.id WHERE status.name = "new"
    GROUP BY client.first_name, client.last_name;