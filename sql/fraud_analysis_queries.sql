-- creating new schema

Create schema finance;

USE finance;

--  Creating CREDIT CARD TRANSACTIONS TABLE 

CREATE TABLE cc_data (
 row_index INT PRIMARY KEY,
 trans_date_trans_time DATETIME,
 cc_num VARCHAR(20),
 merchant VARCHAR(100),
 category VARCHAR(50),
 amt DECIMAL(10,2),
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 gender VARCHAR(10),
 street VARCHAR(100),
 city VARCHAR(50),
 state VARCHAR(50),
 zip INT,
 latitude DECIMAL(9,6),
 longitude DECIMAL(9,6),
 city_pop INT,
 job VARCHAR(100),
 dob DATE,
 tans_num VARCHAR(50),
 unix_time BIGINT,
 merch_lat DECIMAL(9,6),
 merch_long DECIMAL(9,6),
 is_fraud TINYINT(1)
 );
 
 CREATE TABLE location_data (
  cc_number VARCHAR(20),
  latitude DECIMAL(9,6),
 longitude DECIMAL(9,6)
 );

-- Load data in the tables


-- total number of transactions 
 select count(*) as Total_transaction
 from cc_data;
 

 select count(*) from location_data;
 
 -- top 10 most frequent merchants in the cc_data table
 
 select merchant, count(*) as transaction_count from cc_data
 group by merchant
 order by transaction_count desc
 limit 10;
 
-- average transaction amount for each category

select category, avg(amt) as Average_spending
from cc_data
group by category
order by Average_spending desc; 

-- Fraudulent Transactions Count and Percentage

select count(*) as total_frauds, (count(*)*100/(select count(*) from cc_data)) as fraud_percentage
from cc_data
where is_fraud = 1;

-- Join Transactions with Location Data
SELECT 
    c.tans_num,
    c.cc_num,
    c.city,
    c.state,
    l.latitude,
    l.longitude
FROM cc_data c
JOIN location_data l
    ON c.cc_num = l.cc_number;
    
  -- City with Highest Population  
    SELECT 
    city, city_pop
FROM
    cc_data
ORDER BY city_pop DESC
LIMIT 1;

-- Earliest and Lastest Transaction dates

SELECT 
    MIN(trans_date_trans_time) AS earliest_transaction,
    MAX(trans_date_trans_time) AS latest_transaction
FROM
    cc_data;

-- Total Amount spent across all transactions

select sum(amt) as Total_Spent
from cc_data;

-- Number of Transactions per Category

select category, count(*) as transaction_count
from cc_data
group by category
order by transaction_count desc;

-- Average Transaction amount grouped by Gender

select gender , avg(amt) as Avg_transaction_amount
from cc_data
group by gender 
order by Avg_transaction_amount desc;

-- Highest Average transaction amount by day of week

select dayname(trans_date_trans_time) as day_of_week, avg(amt) as Avg_transaction_amount
from cc_data
group by day_of_week
order by Avg_transaction_amount desc
limit 1;