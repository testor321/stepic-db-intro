use billing_simple;

select payer_email, sum from billing;
select * from billing where sum>900 and currency not in ('CHF','GBP');

-- Выведите поступления денег от пользователя с email 'vasya@mail.com'.
-- В результат включите все столбцы таблицы и не меняйте порядка их вывода. 
select * from billing where payer_email='vasya@mail.com';

-- insert
insert into billing values (
'alex@mail.com' ,
'leo@mail.com' , 
'500.00' ,
'MYR' ,
'2010-08-20' ,
'Here are some money for you')
;

-- select
select * from billing
where payer_email='alex@mail.com' and recipient_email='leo@mail.com' and sum='500.00';

-- insert
insert into billing (
payer_email, recipient_email, sum, currency, billing_date
)
values (
'alex@mail.com' ,
'leo@mail.com' , 
'500.00' ,
'MYR' ,
'2010-08-20'
)
;

-- update
update billing set currency = 'USD' where payer_email='alex@mail.com' and recipient_email='leo@mail.com' and sum='500.00';

-- Добавьте в таблицу одну запись о платеже со следующими значениями:
-- email плательщика: 'pasha@mail.com'
-- email получателя: 'katya@mail.com'
-- сумма: 300.00
-- валюта: 'EUR'
-- дата операции: 14.02.2016
-- комментарий: 'Valentines day present)'
insert into billing values (
'pasha@mail.com' ,
'katya@mail.com' , 
'300.00' ,
'EUR' ,
'2016-02-14' ,
'Valentines day present)')
;

-- Измените адрес плательщика на 'igor@mail.com' для всех записей таблицы, где адрес плательщика 'alex@mail.com'.
select count(payer_email) from billing where payer_email='alex@mail.com';
select * from billing where payer_email='alex@mail.com';

update billing set payer_email = 'igor@mail.com' where payer_email='alex@mail.com';

-- Удалите из таблицы записи, где адрес плательщика или адрес получателя установлен в неопределенное значение или пустую строку.
DELETE FROM billing WHERE payer_email IS NULL OR payer_email = "" OR recipient_email IS NULL OR recipient_email = "";

DELETE FROM billing
	WHERE NULLIF(payer_email, ' ') IS NULL
	OR NULLIF(recipient_email, ' ') IS NULL;
    
DELETE FROM billing 
WHERE (payer_email is null or payer_email = '') or
      (recipient_email is null or recipient_email = '');
      
use project_simple;
select * from project;

-- Число проектов в базе
SELECT count(project_name) FROM project;

-- Средний бюджет
SELECT avg(budget) FROM project;

-- Сколько в дней уходит на выполнение проектов
SELECT
	project_name,
    project_start,
	project_finish,
    datediff(project_finish, project_start)
FROM project WHERE project_finish > project_start;

-- Сколько дней в среднем
SELECT avg(datediff(project_finish, project_start)) FROM project
	WHERE project_finish > project_start;

-- Минимальная и максимальная длительность проекта в днях
SELECT
	min(datediff(project_finish, project_start)),
	max(datediff(project_finish, project_start))
FROM project WHERE project_finish > project_start;

-- Группировка
SELECT
	client_name,
    min(datediff(project_finish, project_start)) AS min_days,
    avg(datediff(project_finish, project_start)) AS avg_days,
    max(datediff(project_finish, project_start)) AS max_days
FROM project WHERE project_finish > project_start
GROUP BY client_name
ORDER BY max_days DESC;

-- Выведите общее количество заказов компании.
SELECT count(project_name) FROM project;

-- Выведите в качестве результата одного запроса общее количество заказов,
-- сумму стоимостей (бюджетов) всех проектов, средний срок исполнения заказа в днях.
SELECT
	count(project_name),
    sum(budget),
    avg(datediff(project_finish, project_start)) as duration
FROM project;
    
use store_simple;

-- Сколько различных товаров в каждой категории
SELECT
	category,
    count(product_name) AS quantity
FROM store
GROUP BY category
ORDER BY quantity DESC;

-- Общая выручка магазина
SELECT
	sum(price*sold_num) AS revenue
FROM store;

-- Наиболее популярные категории товаров
SELECT
	category,
    sum(sold_num) AS sold
FROM store
GROUP BY category
ORDER BY sold DESC;

-- 10 наиболее популярных товаров
SELECT
	product_name,
    sold_num
FROM store
ORDER BY sold_num DESC
LIMIT 10;

-- Выведите количество товаров в каждой категории, результат должен содержать два столбца:
--	 название категории
--	 количество товаров в данной категории
SELECT
	category,
	count(product_name)
FROM store
GROUP BY category;

-- Выведите 5 категорий товаров, продажи которых принесли наибольшую выручку.
-- Под выручкой понимается сумма произведений стоимости товара на количество проданных единиц. Результат должен содержать два столбца: 
--	название категории
--	выручка от продажи товаров в данной категории
SELECT
	category,
    sum(price*sold_num) AS revenue
FROM store
GROUP BY category
ORDER BY revenue DESC
LIMIT 5;
