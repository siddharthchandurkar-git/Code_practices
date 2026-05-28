--1--DSSQL20164. Indian Influencers: Replace Spaces with Underscores
select post_id, replace(post_content,' ','_') from indian_influencers

--2--DSSQL20204. Suppliers of Pre-2000 Books
select distinct s.supplier_name,s.country,s.phone_number  from suppliers s
left join book_details b
on s.supplier_id = b.supplier_id
where publication_year < 2000

--3--DSSQL20208. Books Supplied by USA-Based Suppliers
select b.book_id,b.title,b.genre,b.price,s.supplier_name from book_details b
left join suppliers s
on b.supplier_id = s.supplier_id
where s.country = 'USA'

--4--DSSQL20210. Books and Suppliers: USA Based Suppliers of Pre-2000 Books
select b.book_id,b.title,b.publication_year,s.supplier_name,s.country from book_details b
left join suppliers s
on b.supplier_id = s.supplier_id
where s.country = 'USA' and b.publication_year < 2000

--5--DSSQL20211. Employee and Mentor Relationship
select a.employee_id,a.employee_name,a.position as employee_position,b.employee_name as mentor
 from employees_company a
  join  employees_company b 
  on a.mentor_id = b.employee_id
  where a.mentor_id  is not null

--6--DSSQL20212. Employees Without Mentors
select employee_id,employee_name,position as employee_position,department
 from employees_company
 where mentor_id is null

--7--DSSQL20221. Order and Customer Details
select o.order_id,o.order_date,o.order_amount,c.customer_name,c.email
 from online_orders o
 left join ecustomers c
 on o.customer_id = c.customer_id
 where o.customer_id is not null

--8--DSSQL20222. High-Value Orders by Customers
select c.customer_name,o.order_id,o.order_amount from ecustomers c
left join online_orders o 
on c.customer_id = o.customer_id
where o.order_amount > 2000


--9--DSSQL20223. Customer and Order Details
select c.customer_id,c.customer_name,o.order_id,o.order_amount from ecustomers c
left join online_orders o on c.customer_id = o.customer_id

--10--DSSQL20224. Customers Without Orders
select c.customer_name,c.Email from ecustomers c
left join online_orders o on c.customer_id = o.customer_id
where o.customer_id is null

--11--DSSQL20225. Orders and Customer Details
select o.order_id,o.order_amount,c.customer_name,c.email from ecustomers c  
left join online_orders o
on c.customer_id = o.customer_id

--12--DSSQL20226. Guest User Orders
select o.order_id,o.order_amount,o.payment_method from online_orders o 
left join ecustomers c 
on o.customer_id = c.customer_id
where o.customer_id is null

--13--DSSQL20228. Unmatched Customers and Orders
SELECT c.customer_id, c.customer_name AS unmatched_customer, o.order_id AS unmatched_order 
FROM ecustomers c LEFT JOIN online_orders o ON c.customer_id = o.customer_id 
WHERE o.customer_id IS NULL;

--14--DSSQL20230. Mismatched Country and Payment Method
SELECT o.order_id, c.customer_name, c.country, o.payment_method
 FROM ecustomers c
 JOIN online_orders o
 ON c.customer_id = o.customer_id 
WHERE (c.country = 'India' AND o.payment_method NOT IN ('UPI', 'Net Banking'))
 OR 
(c.country != 'India' AND o.payment_method NOT IN ('Credit Card', 'Debit Card'));


--15--DSSQL20036. Hotel Haven: Platinum Members
select guest_name,city,sum(total_amount) as total_revenue
 from hotelbookings
 where membership_level = 'Platinum' 
 and total_amount > 10000
 and breakfast_included =1
 group by guest_name,city having avg(total_amount) > 15000
 order by total_revenue desc

--16--DSSQL20033. Hotel Haven: Identify High-Spending Guests
select guest_name,total_amount,membership_level
from hotelbookings
order by total_amount desc
limit 5

--17--DSSQL20041. BookReviews: Loveable Books
select  book_title, sum(sales_amount) as total_sales_amount,sum(sales_count) as total_sales_count,publisher
from bookreviews 
where book_title like '%love%' or book_title like '%heart%'
group by 1,4
having sum(sales_amount) > 3000 and sum(sales_count) > 100
order by total_sales_amount desc

--18--DSSQL20050. Fitness Flex: Personal Trainer Engagement Impact Analysis
select trainer_session,sum(calories_burned) as total_calories_burned,
count(workout_id) as total_number_of_sessions,
case
    when sum(calories_burned) > 4000 then 'High Impact'
    when sum(calories_burned) > 2000 then 'Medium Impact'
    else 'Low Impact' end as 'Trainer Impact'
    from workoutAnalytics
    where trainer_session ='Y'
    group by trainer_session

--19--DSSQL20058. Delivery Dash: Total Delivery Time by Agent
select delivery_agent,sum(timestampdiff(minute,order_placed_timestamp,order_delivered_timestamp))
 as total_delivery_time_minutes
 from deliverydash
 group by delivery_agent
 order by total_delivery_time_minutes desc

--20--DSSQL20114. Global Concert Tour: Quarterly Revenue
select year(concert_date) as concert_year,quarter(concert_date) as concert_quarter,
sum(revenue) as total_revenue
from global_concert_tour
group by concert_year,concert_quarter