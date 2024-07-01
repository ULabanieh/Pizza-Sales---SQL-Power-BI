SELECT * FROM pizza_sales

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

SELECT DATENAME(MONTH, order_date) AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC

SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS pct_sales
FROM pizza_sales 
GROUP BY pizza_category


-- Extra, not needed for requirements
SELECT pizza_category, SUM(total_price) AS total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS pct_sales
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- END of extra

SELECT pizza_size, SUM(total_price) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS pct_sales
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY pct_sales DESC


-- per quarter

SELECT pizza_size, SUM(total_price) AS total_sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2)) AS pct_sales
FROM pizza_sales 
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY pct_sales DESC

-- 5 Best Sellers & 5 Worst Sellers

SELECT TOP 5 pizza_name, SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC

SELECT TOP 5 pizza_name, SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC


SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC