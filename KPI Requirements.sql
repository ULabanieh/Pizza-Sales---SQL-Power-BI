SELECT *
FROM pizza_sales;

SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS average_order_value
FROM pizza_sales

SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS total_orders  
FROM pizza_sales

SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS average_pizzas_per_order
FROM pizza_sales