USE store_medium;

SELECT * FROM product;
SELECT * FROM category;

-- Декартово произведение
SELECT * FROM product, category;
SELECT * FROM product CROSS JOIN category;
SELECT count(*) FROM product, category;

-- left outer join
select * from category as c left outer join product as p on p.category_id = c.category_id;
select c.category_name, p.product_name, p.price from category as c left outer join product as p on p.category_id = c.category_id;

-- right outer join
select * from product as p right outer join category as c on p.category_id = c.category_id;
select c.category_name, p.product_name, p.price from product as p right outer join category as c on p.category_id = c.category_id;

-- union
select * from product where price > 900
union
select * from product where price < 100;

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
    
-- Выведите список товаров с названиями товаров и названиями категорий, в том числе товаров,
-- не принадлежащих ни одной из категорий
SELECT good.name, category.name FROM good
	LEFT OUTER JOIN category_has_good ON good.id = category_has_good.good_id
    LEFT OUTER JOIN category ON category.id = category_has_good.category_id;
    
-- Выведите список товаров с названиями категорий, в том числе товаров,
-- не принадлежащих ни к одной из категорий, в том числе категорий не содержащих ни одного товара
SELECT good.name, category.name FROM good
	LEFT OUTER JOIN category_has_good ON good.id = category_has_good.good_id
    LEFT OUTER JOIN category ON category.id = category_has_good.category_id
UNION
SELECT good.name, category.name FROM good
	RIGHT OUTER JOIN category_has_good ON good.id = category_has_good.good_id
    RIGHT OUTER JOIN category ON category.id = category_has_good.category_id;
    
-- Выведите список всех источников клиентов и суммарный объем заказов по каждому источнику.
-- Результат должен включать также записи для источников, по которым не было заказов
SELECT source.name, sum(sale.sale_sum) FROM source
	LEFT OUTER JOIN client ON source.id = client.source_id
    LEFT OUTER JOIN sale ON client.id = sale.client_id
    GROUP BY source.name;

-- Выведите названия товаров, которые относятся к категории 'Cakes'
-- или фигурируют в заказах текущий статус которых 'delivering'.
-- Результат не должен содержать одинаковых записей
SELECT good.name FROM good
	INNER JOIN category_has_good ON good.id = category_has_good.good_id
    INNER JOIN category ON category.id = category_has_good.category_id WHERE category.name = "Cakes"
UNION
SELECT good.name FROM good
	INNER JOIN sale_has_good ON good.id = sale_has_good.good_id
    INNER JOIN sale ON sale.id = sale_has_good.sale_id
    INNER JOIN status ON status.id = sale.status_id WHERE status.name = "delivering";
    
-- Выведите список всех категорий продуктов и количество продаж товаров, относящихся к данной категории.
-- Под количеством продаж товаров подразумевается суммарное количество единиц товара данной категории,
-- фигурирующих в заказах с любым статусом.
SELECT category.name, count(sale.id) FROM category
	LEFT OUTER JOIN category_has_good ON category.id = category_has_good.category_id
    LEFT OUTER JOIN good ON good.id = category_has_good.good_id
    LEFT OUTER JOIN sale_has_good ON good.id = sale_has_good.good_id
    LEFT OUTER JOIN sale ON sale.id = sale_has_good.sale_id
    GROUP BY category.name;