use billing_simple;

select payer_email, sum from billing;
select * from billing where sum>900 and currency not in ('CHF','GBP');

-- Выведите поступления денег от пользователя с email 'vasya@mail.com'.
-- В результат включите все столбцы таблицы и не меняйте порядка их вывода. 
select * from billing where payer_email='vasya@mail.com';
