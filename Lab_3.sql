--1
select name, city
from agents
where name = 'Smith' 
--2
select pid, name, quantity
from products
where priceusd > '1.25';
--3
select ordno, aid 
from orders;
--4
select name, city
from customers
where city = 'Dallas';
--5
select name, city
from agents
where city != 'New York' and city != 'Newark';
--6
select *
from products
where city != 'New York' and city != 'Newark' and priceusd > 1.00;
--7
select *
from orders
where mon = 'jan'or mon = 'mar';
--8
select *
from orders
where mon = 'feb' or dollars < 100;
--9
select *
from orders
where cid = 'c001';


