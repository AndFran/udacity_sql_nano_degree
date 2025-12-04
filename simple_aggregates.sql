/*Find the total amount of poster_qty paper ordered in the orders table.*/

SELECT SUM(poster_qty) AS poster_qty FROM orders;


/*Find the total amount of standard_qty paper ordered in the orders table.*/

SELECT SUM(standard_qty) AS standard_qty FROM orders;


/*Find the total dollar amount of sales using the total_amt_usd in the orders table.*/

SELECT SUM(total_amt_usd) AS total_amt_usd FROM orders;


/*Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the
orders table. This should give a dollar amount for each order in the table.*/

SELECT id, standard_amt_usd + gloss_amt_usd AS total_stan_gloss FROM orders;


/*Find the standard_amt_usd per unit of standard_qty paper.
Your solution should use both aggregation and a mathematical operator.*/

SELECT SUM(standard_amt_usd) / SUM(standard_qty) AS stan_price_per_unit
FROM orders;


/*When was the earliest order ever placed? You only need to return the date.*/
SELECT MIN(occurred_at) AS earliest FROM orders;

/*Try performing the same query as in question 1 without using an aggregation function.*/
SELECT occurred_at FROM orders
ORDER BY occurred_at ASC
LIMIT 1;


/*When did the most recent (latest) web_event occur?*/
SELECT MAX(occurred_at) AS earliest FROM web_events

/*Try to perform the result of the previous query without using an aggregation function.*/
SELECT occurred_at FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/*Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean
amount of each paper type purchased per order. Your final answer should have 6 values -
one for each paper type for the average number of sales, as well as the average amount.*/
SELECT COUNT(standard_amt_usd) / SUM(standard_amt_usd) AS avg_stand_usd,
COUNT(gloss_amt_usd) / SUM(gloss_amt_usd) AS avg_gloss_usd,
COUNT(poster_amt_usd) / SUM(poster_amt_usd) AS avg_poster_usd,

COUNT(standard_qty) / SUM(standard_qty) AS avg_standard_qty,
COUNT(gloss_qty) / SUM(gloss_qty) AS avg_gloss_qty,
COUNT(poster_qty) / SUM(poster_qty) AS avg_poster_qty

FROM orders;


/*Via the video, you might be interested in how to calculate the MEDIAN. Though this
 is more advanced than what we have covered so far try finding - what is the MEDIAN
 total_usd spent on all orders?*/

SELECT total AS median
FROM
(SELECT total,
ROW_NUMBER() OVER(ORDER BY total) AS rn,
COUNT(*) OVER() AS total_rows
FROM orders
ORDER BY total) AS stats
WHERE stats.rn IN ( (total_rows + 1) / 2, (total_rows + 2) / 2)




/*Which account (by name) placed the earliest order? Your solution should have the account name
and the date of the order.*/

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;


/*Find the total sales in usd for each account. You should include two columns -
the total sales for each company's orders in usd and the company name.*/
SELECT a.name, SUM(o.total) as total
FROM orders AS o
INNER JOIN accounts AS a
WHERE o.account_id = a.id
GROUP BY a.name
ORDER BY a.name


/*Via what channel did the most recent (latest) web_event occur, which account was
associated with this web_event? Your query should return only three values - the date,
channel, and account name.*/

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;


/*Find the total number of times each type of channel from the web_events was used.
Your final table should have two columns - the channel and the number of times the channel was used.*/
SELECT channel, COUNT(channel) AS use_count
FROM web_events
GROUP BY channel;


/*Who was the primary contact associated with the earliest web_event?*/
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;


/*What was the smallest order placed by each account in terms of total usd.
Provide only two columns - the account name and the total usd. Order from smallest dollar
amounts to largest.*/
SELECT MIN(o.total) as lowest_amount_per_account, a.name
FROM orders AS o
INNER JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY lowest_amount_per_account


/*Find the number of sales reps in each region. Your final table should have two
columns - the region and the number of sales_reps. Order from the fewest reps to most reps.*/
SELECT r.name, COUNT(sr.id) AS sr_count
FROM sales_reps AS sr
INNER JOIN region AS r
ON sr.region_id = r.id
GROUP BY r.id, r.name
ORDER BY sr_count ASC



/*For each account, determine the average amount of each type of paper they purchased across their
orders. Your result should have four columns - one for the account name and one for the average
quantity purchased for each of the paper types for each account.*/
SELECT a.name, a.id,
AVG(o.standard_qty) AS standard_qty,
AVG(o.gloss_qty) AS gloss_qty,
AVG(o.poster_qty) AS poster_qty
 FROM accounts AS a
INNER JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name, a.id
ORDER BY a.name;



/*For each account, determine the average amount spent per order on each paper type.
Your result should have four columns - one for the account name and one for the average
amount spent on each paper type.*/
SELECT a.name, a.id,
AVG(o.standard_amt_usd) AS standard_amt_usd,
AVG(o.gloss_amt_usd) AS gloss_amt_usd,
AVG(o.poster_amt_usd) AS poster_amt_usd
 FROM accounts AS a
INNER JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name, a.id
ORDER BY a.name;


/*Determine the number of times a particular channel was used in the web_events table for
each sales rep. Your final table should have three columns - the name of the sales rep,
the channel, and the number of occurrences. Order your table with the highest number of
occurrences first.*/
SELECT sr.id, sr.name, COUNT(we.channel) AS channel_count
FROM accounts AS a
INNER JOIN web_events AS we
ON a.id = we.account_id
INNER JOIN sales_reps AS sr
ON a.sales_rep_id = sr.id
GROUP BY sr.id, sr.name
ORDER BY channel_count DESC;





/*Determine the number of times a particular channel was used in the web_events table
for each region. Your final table should have three columns - the region name, the channel,
and the number of occurrences. Order your table with the highest number of occurrences first.*/
SELECT r.id, r.name, COUNT(we.channel) AS channel_count
FROM accounts AS a
INNER JOIN web_events AS we
ON a.id = we.account_id
INNER JOIN sales_reps AS sr
ON a.sales_rep_id = sr.id
INNER JOIN region AS r
ON sr.region_id = r.id
GROUP BY r.id, r.name
ORDER BY channel_count DESC;



