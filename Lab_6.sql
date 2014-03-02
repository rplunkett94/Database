--1
select name, city
from customers
where city = (select city
		from products
		where quantity =(select max(quantity)
				from products))
limit 1

--2

select name, city
from customers
where city = (select city
		from products
		where quantity =(select max(quantity)
				from products))

--3
select *
from products 
where priceUSD >(select AVG(priceUSD)
		from products) 

--4
select customers.name, orders.pid, orders.dollars
from customers, orders, products
where orders.pid = products. pid
AND orders.cid = customers.cid
AND orders.dollars = orders.dollars
order by dollars desc

--5
select customers.cid, customers.name, coalesce(sum(orders.qty), 0)
from customers
	left outer join orders
		on orders.cid = customers.cid
group by customers.cid, customers.name
order by customers.cid

--6
select customers.name, products.name, agents.name
from customers, products, agents, orders
where agents.city = 'New York'
AND orders.cid = customers.cid
AND orders.aid = agents.aid 
AND orders.pid = products.pid 

--7
select orders.dollars, (orders.qty*products.priceUSD)-(orders.qty*products.priceUSD*(customers.discount*.01)) 	
from orders, products, customers
where orders.cid = customers.cid
AND orders.pid = products.pid
