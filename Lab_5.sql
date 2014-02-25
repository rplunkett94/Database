--1 
select customers.cid, agents.city
from 	orders, 
	customers, 
	agents
where customers.name = 'Basics' 
and orders.cid = customers.cid
and orders.aid = agents.aid

--2
select products.pid, agents.aid
from orders, customers, products, agents
where customers.city = 'Kyoto'
and orders.cid = customers.cid
and orders.aid = agents.aid
and orders.pid = products.pid

--3
select *
from customers
where cid not in (select cid
		from orders)

--4
select customers.cid, customers.name 
from customers left outer join orders
on customers.cid = orders.cid
where orders.cid is null 

--5
select distinct customers.name, agents.name 
from orders, customers, agents
where customers.city = agents.city
and orders.cid = customers.cid
and orders.aid = agents.aid

--6
select customers.name, agents.name, customers.city
from customers inner join agents 
on agents.city = customers.city

--7
select customers.name, customers.city, sum(products.quantity)
from customers
left join products on products.city = customers.city
group by customers.name, customers.city
order by sum(products.quantity)
limit 1