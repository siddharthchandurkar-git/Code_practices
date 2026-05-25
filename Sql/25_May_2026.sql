--1-DSSQL20065 EduTrack: Identify Assignments Submitted Closest to Exam Dates
select 
train_id,train_name,scheduled_departure,actual_departure,scheduled_arrival,actual_arrival
 from train_schedule
 where scheduled_arrival>actual_arrival and scheduled_departure<actual_departure
--2-DSSQL20071 Smart Rail: Canceled Trains with High Passenger Counts on Weekdays-
select 
train_name,passenger_count,date_of_journey
 from train_schedule
 where passenger_count >= 200 and cancelled_flag = 1 and weekday(date_of_journey)  in (0,1,2,3,4)
--3--DSSQL20075 Smart Rail: Trains Arriving on Different Days---
select train_name, scheduled_arrival, actual_arrival from train_schedule where date(scheduled_arrival) != date(actual_arrival)
--4--DSSQL20076. Smart Rail: Trains Completing Journeys Early on Public Holidays
select train_name,date_of_journey,scheduled_arrival,actual_arrival from train_schedule
where date(actual_arrival) in ('2024-06-15','2024-06-22')
and actual_arrival <= scheduled_arrival
--5--DSSQL20100 Gamer Hub: Low Win Teams with High Participation Fees
select team_name,region,matches_won,win_rate_percent,participation_fee_usd
 from esports_tournament
 where
 matches_won < 5 and
 win_rate_percent < 40.00 and
 participation_fee_usd > 3000 and
 region in ('NA','EU')

--6--DSSQL20101 SocialHub: Extract Comment Preview
select comment_id,user_name,left(comment_text,10) as comments from socialhub_comments

--7--DSSQL20008 Festival Ticket Analysis: Profitable Profits in India
--7-DSSQL20102 SocialHub: Filter Comments Containing Bugs
select comment_id,user_name,comment_text from socialhub_comments
where comment_text like '%the%'

--8-DSSQL20103 SocialHub: Extract User Mentions---
select 
 festival_name,sum(organizer_profit)
 from festivaldata
 where country = 'India'
 group by festival_name
 having avg(price) > 100  

--9--DSSQL20010. Festival Ticket Analysis: Top 3 Most Profitable Festivals--
SELECT 
    ticket_type,
    SUM(organizer_profit) AS total_profit
FROM festivaldata
WHERE country IN ('USA', 'India')
GROUP BY ticket_type
HAVING AVG(price) > 50
ORDER BY total_profit DESC
limit 3

--10-DSSQL20103 SocialHub: Extract User Mentions--
select comment_id,user_name,substring(mentions,2) as mentioned_id from socialhub_comments
where mentions is not null

--11-DSSQL20009 Profitable Festivals with Ticket Type Analysis
select country,max(organizer_profit) from festivaldata
group by country

--12-DSSQL20011. Movie Mania: Custom Ranking
select movie_name,avg(rating) as a from user_watch_activity
group by movie_name
order by a desc
 limit 5 offset 3

--13-DSSQL20013. Movie Mania: Second Most Engaged Sci-Fi Viewer
select user_name,sum(watch_time_minutes) as total_watch_time from user_watch_activity
where genre = 'Sci-Fi'
group by user_name
order by total_watch_time desc
limit 1 offset 1 

--14-DSSQL20014. Movie Mania: Top Genre Watched in Japan
select genre,sum(watch_time_minutes)as a from user_watch_activity
where country = 'Japan'
group by genre
order by a desc
limit 1 

--15--DSSQL20015. Movie Mania: Most Active Premium Users
select user_name,total_movies_watched  from user_watch_activity
where subscription_type  = 'Premium'
order by total_movies_watched desc limit 5

--16--DSSQL20018. Retail World: Top Revenue Generating Transactions
select 
payment_method, avg(transaction_value) a
 from payment_transactions
 group by payment_method
 order by a desc
 limit 1

--17--DSSQL20006. Festival Ticket Analysis: Top 5 Festivals
SELECT Festival_Name, Price
 FROM festivaldata
  ORDER BY Price
   desc LIMIT 5;

--18--DSSQL20007. Festival Ticket Analysis: Rank 6-10 Festivals
SELECT Festival_Name, Price
 FROM festivaldata
  ORDER BY Price
   desc LIMIT 5 offset 5;

--19--DSSQL20104. SocialHub: Reverse Negative Sentiment Comments
select comment_id,user_name,reverse(comment_text) as reversed_text from socialhub_comments
where sentiment = 'Negative'

--20--DSSQL20105. SocialHub: Replace Mentions Symbol
select comment_id,replace(mentions,'@','(at)') from socialhub_comments


