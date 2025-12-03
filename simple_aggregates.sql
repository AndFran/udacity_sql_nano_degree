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
