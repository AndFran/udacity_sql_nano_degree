
/*
Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.
 Do you notice any trends in the yearly sales totals?
*/


SELECT YEAR(occurred_at), SUM(total_amt_usd) AS total
FROM orders
GROUP BY YEAR(occurred_at)
ORDER BY total DESC;


/*
Which month did Parch & Posey have the greatest sales in terms of total dollars?
Are all months evenly represented by the dataset?
*/

SELECT MONTH(occurred_at), SUM(total_amt_usd) AS total
FROM orders
GROUP BY MONTH(occurred_at)
ORDER BY 2 DESC;



/*
Which year did Parch & Posey have the greatest sales in terms of the total number of orders?
Are all years evenly represented by the dataset?
*/

SELECT YEAR(occurred_at), COUNT(*) AS t
FROM orders
GROUP BY 1
ORDER BY 2 DESC




/*
Which month did Parch & Posey have the greatest sales in terms of the total number of orders?
Are all months evenly represented by the dataset?
*/

SELECT MONTH(occurred_at), COUNT(*) AS t
FROM orders
GROUP BY 1
ORDER BY 2 DESC


/*
In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/

SELECT MONTH(occurred_at),
       SUM(gloss_amt_usd) AS t
FROM orders
WHERE account_id = 1001
