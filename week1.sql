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
      

    