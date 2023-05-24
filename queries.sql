select 
  count(distinct last_name) as customers_count 
from 
  public.customers c;

--Решение первой задачи 5 шага
select 
  concat(e.first_name, ' ', e.last_name) as name, 
  count(s.quantity) as operation, 
  sum(s.quantity * p.price) as income 
from 
  sales s 
  left join employees e on s.sales_person_id = e.employee_id 
  left join products p on s.product_id = p.product_id 
group by 
  e.first_name, 
  e.last_name 
order by 
  income desc
  limit 10;
  
  --Решение второй задачи 5 шага
select 
  concat(e.first_name, ' ', e.last_name) as name, 
  round(
    avg(s.quantity * p.price), 
    0
  ) as average_income 
from 
  sales s 
  left join employees e on s.sales_person_id = e.employee_id 
  left join products p on s.product_id = p.product_id 
group by 
  e.first_name, 
  e.last_name 
order by 
  average_income asc;
  
  --Решение третей задачи 5 шага
select 
  concat(e.first_name, ' ', e.last_name) as name, 
  to_char(sale_date, 'day') as weekday, 
  round(
    sum(s.quantity * p.price), 
    0
  ) as income 
from 
  sales s 
  left join employees e on s.sales_person_id = e.employee_id 
  left join products p on s.product_id = p.product_id 
group by 
  sale_date, 
  e.first_name, 
  e.last_name 
order by 
  s.sale_date;

