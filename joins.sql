/*Provide a table for all web_events associated with the account name of Walmart.
There should be three columns. Be sure to include the primary_poc, time of the event and the channel for each event.
Additionally, you might choose to add a fourth column to ensure only Walmart events were chosen.*/

SELECT a.primary_poc, we.occurred_at, we.channel FROM
web_events AS we
INNER JOIN accounts AS a
ON we.account_id = a.id
WHERE a.name = 'Walmart';



/*Provide a table that provides the region for each sales_rep along with their associated accounts.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to the account name.*/

SELECT r.name AS region_name, sr.name AS sales_rep_name, a.name As account_name FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON sr.region_id = r.id
ORDER BY a.name;




/*Provide the name for each region for every order, as well as the account name and the unit price
they paid (total_amt_usd/total) for the order. Your final table should have 3 columns:
region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01)
to assure not dividing by zero.*/


SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd/o.total
FROM orders AS o
INNER JOIN accounts AS a
ON o.account_id = a.id
INNER JOIN sales_reps AS sr
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id;




Provide a table that displays the region for each sales_rep along with their associated accounts.
 This time only for the Midwest region. Your final table should include three columns:
 the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z)
 according to the account name.

SELECT r.name AS region, sr.name AS sales_rep, a.name AS account FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id
WHERE r.name = 'Midwest'
ORDER BY a.name;


Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name AS region, sr.name AS sales_rep, a.name AS account FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id
WHERE r.name = 'Midwest' AND sr.name LIKE 'S%'
ORDER BY a.name;


Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
 Your final table should include three columns: the region name, the sales rep name, and the account name.
 Sort the accounts alphabetically (A-Z) according to the account name.


SELECT r.name AS region, sr.name AS sales_rep, a.name AS account FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id
WHERE r.name = 'Midwest' AND sr.name LIKE '% K%'
ORDER BY a.name;



Provide the name for each region for every order, as well as the account name and the unit
price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the
standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name,
and unit price. In order to avoid a division by zero error, adding .01 to the denominator
here is helpful total_amt_usd/(total+0.01).

SELECT r.name AS region, a.name AS account, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id
INNER JOIN orders AS o
ON o.account_id = a.id
ORDER BY a.name;


Provide the name for each region for every order, as well as the account name and the unit price
they paid (total_amt_usd/total) for the order. However, you should only provide the results if the
standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should
have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01)).


SELECT r.name AS region, a.name AS account, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id
INNER JOIN orders AS o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price ASC;


Provide the name for each region for every order, as well as the account name and the unit price
they paid (total_amt_usd/total) for the order. However, you should only provide the results if the
standard order quantity exceeds 100 and the poster order quantity exceeds 50.
Your final table should have 3 columns: region name, account name, and unit price. Sort for the
largest unit price first. In order to avoid a division by zero error,
adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01)).



SELECT r.name AS region, a.name AS account, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM sales_reps AS sr
INNER JOIN accounts AS a
ON sr.id = a.sales_rep_id
INNER JOIN region AS r
ON r.id = sr.region_id
INNER JOIN orders AS o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price DESC;


What are the different channels used by account id 1001? Your final table should have only 2 columns: account name
and the different channels.

SELECT DISTINCT we.channel, a.name FROM accounts AS a
INNER JOIN web_events as we
ON a.id = we.account_id
WHERE a.id = 1001;

Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at,
account name, order total, and order total_amt_usd.

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd FROM orders AS o
INNER JOIN accounts AS a
ON a.id = o.account_id
WHERE YEAR(o.occurred_at) = 2015;    -- WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'







