select 
  count(distinct last_name) as customers_count 
from 
  public.customers c;

--Решение первой задачи 5 шага
select 
	e.first_name ||' '|| e.last_name as name ,
	count(s.quantity) as operation,
	sum(s.quantity * p.price) as income
from sales s 
left join employees e 
on s.sales_person_id = e.employee_id 
left join products p 
on s.product_id = p.product_id 
group by 1
order by income desc
limit 10
;

--Решение второй задачи 5 шага 
select 
	e.first_name ||' '|| e.last_name as name ,
	round(avg(s.quantity * p.price),0) as average_income
from sales s 
left join employees e 
on s.sales_person_id = e.employee_id 
left join products p 
on s.product_id = p.product_id 
group by 1
having avg(s.quantity * p.price) < ( -- Поздапрос, вычисляющий среднею выручку за сделку по всем продавцам
select round(avg(s.quantity * p.price),0) as average_income
from sales s 
left join employees e 
on s.sales_person_id = e.employee_id 
left join products p 
on s.product_id = p.product_id 
)
order by average_income asc 
;

--Решение третей задачи 5 шага
with inc as (
select 
e.first_name ||' '|| e.last_name as name,
extract(isodow from sale_date) as num_day,
round(sum(quantity*price),0) as income,
to_char(sale_date, 'day') as weekday
from sales s 
left join employees e 
on s.sales_person_id = e.employee_id 
left join products p 
on s.product_id = p.product_id 
group by 1, 2, 4
order by  
	extract(isodow from sale_date), 
	name
)
select inc.name, inc.weekday, inc.income
from inc

--Решение первой задачи 6 шага
select 
	case 
	when age between 10 and 15 then '10-15' 
	when age between 16 and 25 then '16-25'
	when age between 26 and 40 then '26-40'
	when age > 40 then '40+' end as age_category, 
 	count(age) as count 
from 
  customers c 
group by 
	1
order by 
  age_category;

--Решение второй задачи 6 шага
select 
	to_char(sale_date, 'YYYY-MM') as date,
	count(distinct customer_id) as tota_customers,
	sum(quantity * price) as income
from sales s
left join products p 
on s.product_id = p.product_id 
group by 
	1
order by 
	date;

--Решение третей задачи 6 шага
select distinct on (c.customer_id) c.first_name ||' '|| c.last_name as customer, 
sale_date, 
e.first_name ||' '|| e.last_name as seller
from sales s
left join employees e
on s.sales_person_id = e.employee_id 
left join customers c 
on s.customer_id = c.customer_id 
left join products p
on s.product_id = p.product_id
where price = 0
order by c.customer_id, sale_date;

  

