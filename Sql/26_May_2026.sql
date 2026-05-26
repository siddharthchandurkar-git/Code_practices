--1--DSSQL20201. Books and Suppliers: Complete Details
select b.Book_ID,b.title,b.genre,b.price,s.supplier_name,s.country,s.phone_number
 from book_details b 
left join suppliers s
on b.supplier_id = s.supplier_id

--2--DSSQL20202. Books and Suppliers: Complete Details
select
 distinct s.supplier_name,s.country,s.phone_number 
 from suppliers s
left join book_details b
on s.supplier_id = b.supplier_id
where b.genre = 'Fiction'

--3--DSSQL20207. Revenue by Supplier
select s.supplier_name,s.country,sum(b.price) as total_revenue from suppliers s
left join book_details b
on s.supplier_id = b.supplier_id
group by s.supplier_id

--4--DSSQL20020. Retail World: Unsatisfied Customers
select  customer_name,round(avg(customer_rating),2) as average_rating
from payment_transactions
group by customer_name
having avg(customer_rating) < 4

--5--DSSQL20035. Hotel Haven: Revenue across Cities
select city,sum(total_amount) as total_revenue
 from hotelbookings
 where feedback_score >= 7 and total_guests >= 2
 group by city
having count(booking_id) >= 3

order by total_revenue desc


--6--DSSQL20154. Indian Influencers: Replace Hashtag Symbol
select post_id, replace(Hashtags,'#','HASHTAG-') as replaced_tags
from indian_influencers

--7--DSSQL20055. Delivery Dash: Evening Revenue Analysis
select sum(order_amount) as evening_revenue from deliverydash
where
hour(order_delivered_timestamp) is not null and
 hour(order_delivered_timestamp) between 18 and 23

--8--DSSQL20056. Delivery Dash: Day with Maximum Revenue
select date(order_delivered_timestamp) as Delivery_date,sum(order_amount) as total_revenue
 from deliverydash
 group by Delivery_date
 order by total_revenue desc
 limit 1

--9--DSSQL20057. Delivery Dash: Weekend Deliveries
select order_id,customer_name,order_delivered_Timestamp,city
from DeliveryDash
where weekday(order_delivered_timestamp) in(5,6)

--10--DSSQL20106. SocialHub: Filter Hashtags Containing ‘Photo’
select comment_id,hashtags from socialhub_comments
where hashtags like '%work%'


--11--DSSQL20107. SocialHub: Combine Username and Location
select user_name, concat(user_name,' (', user_location,')') as combined from socialhub_comments

--12--DSSQL20031. Hotel Haven: Revenue Analysis by Room Type
select room_type,sum(total_amount) as total_revenue
from hotelbookings
group by room_type
order by total_revenue desc

--13--DSSQL20032. Hotel Haven: Breakfast Impact on Feedback
select 
case
 when breakfast_included = 1 then 'with breakfast'
 else 'without breakfast'
 end as breakfast_status,
 avg(feedback_score)

 from hotelbookings
 group by breakfast_status

--14--DSSQL20042. BookReviews: High Rated Books
select genre,avg(rating),sum(sales_amount)
 from bookreviews
 where genre like 'R%'
 group by genre
 having avg(rating) >=4
 order by avg(rating) desc

--15--DSSQL20043. BookReviews: Masterpieces
select author_name, sum(sales_count) as total_sales_count
from bookreviews
where review_text like '%masterpiece%'
group by author_name
having sum(sales_count) > 150
order by total_sales_count desc

--16--DSSQL20044. BookReviews: High Revenue Publishers
select publisher,sum(sales_amount) as total_sales_amount,sum(sales_count) as total_sales_count 
from bookreviews
where review_text like '%Fantastic%' or review_text like '%Thrilling%'
group by publisher
having total_sales_amount>3000 and total_sales_count > 100
order by total_sales_amount desc

--17--DSSQL20045. BookReviews: High Revenue Positive Feedback
select book_title,genre,sum(sales_amount) as total_amount,avg(rating) as average_rating
 from bookreviews
where review_text like  '%plot%' or review_text like  '%inspiring%'
and genre = 'Science'
group by book_title, genre
having total_amount > 3000
order by total_amount desc

--18--DSSQL20048. Fitness Flex: Customer Satisfaction Based on Trainer Engagement
select 
trainer_session,avg(satisfaction_rating),
case
    when avg(satisfaction_rating) >= 4.5 then 'Excellent'
    when avg(satisfaction_rating) between 3.5 and 4.5 then 'Good'
    else 'Needs Improvement'
    end as Rating_quality
 from workoutanalytics
 group by trainer_session

--19--DSSQL20049. Fitness Flex: High-Value Workout Session Analysis
select 
workout_id,session_type,workout_duration,session_revenue,
case
    when session_revenue > 40 and workout_duration > 60 then 'High Value'
    else 'Regular Value'
    end as value_category
 from workoutanalytics


--20--DSSQL20019. Retail World: Segment Customers by Spending Behavior
select customer_name,sum(transaction_value) as total_spending,
case
    when sum(transaction_value) > 2000 then 'High Spend'
    when sum(transaction_value) > 1000 then 'Medium Spend'
    else 'Low Spend'
    end as spending_buckets
 from payment_transactions
 group by customer_name