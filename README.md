# Project Overview
---
This project combines SQL and Power BI to create a beautiful dashboard with data on the performance of a pizza restaurant's sales. We will look at the problem statement and create a dashboard that adapts to the requirements from the stakeholder and shows the information needed. The project is divided into 2 parts, the first part is the SQL queries which will give us the basis of the data that will later be used for the visualizations and dashboard. 

The data used for this project is from the year 2015.

Here is a walkthrough video of the dashboard and its different parts:

https://github.com/user-attachments/assets/6ba89698-afca-443d-b3d6-bd3ba8294c30

## Problem Statement
---
### KPIs Requirement
---
We need to analyze key indicators for our pizza sales data to gain insights into our business performance. Specifically, we want to calculate the following metrics:

1. **Total Revenue:** The sum of the total price of all pizza orders
2. **Average Order Value:** The average amount spent per order, calculated by dividing the total revenue by the total number of orders
3. **Total Pizzas Sold:** The sum of the quantities of all pizzas sold
4. **Total Orders:** The total number of orders placed
5. **Average Pizzas per Order:** The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders

### Charts Requirement
---
We would like to visualize various aspects of our pizza sales data to gain insights and understand key trends. We have identified the following requirements for creating charts:
1. **Daily Trend for Total Orders:** Create a bar chart that displays the daily trend of total orders over a specific time period. This chart will help us identify any patterns or fluctuations in order volumes on a daily basis
2. **Monthly Trend for Total Orders:** Create a line chart that illustrates the hourly trend of total orders throughout the day. This chart will allow us to identify peak hours or periods of high order activity
3. **Percentage of Sales by Pizza Category:** Create a pie chart that shows the distribution of sales across different pizza categories. This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.
4. **Percentage of Sales by Pizza Size:** Generate a pie chart that represents the percentage of sales attributed to different pizza sizes. This chart will help us understand customer preferences for pizza sizes and their impact on sales
5. **Total Pizzas Sold by Pizza Category:** Create a funnel chart that presents the total number of pizzas sold for each pizza category. This chart will allow us to compare the sales performance of different pizza categories.
6. **Top 5 Best Sellers by Revenue, Total Quantity and Total Orders:** Create a bar chart highlighting the top 5 best-selling pizzas based on the Revenue, Total Quantity, Total Orders. This chart will help us identify the most popular pizza options.
7. **Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders:** Create a bar chart showcasing the bottom 5 worst-selling pizzas based on the Revenue, Total Quantity, Total Orders. This chart will enable us to identify underperforming or less popular pizza options.

# SQL Queries
---
## Import CSV into SSMS
---
This project's SQL Queries part was done using SQL Server Management Studio 20. To import the data into SSMS follow these steps:

1. Create a new database by right clicking on the "Databases" folder in the "Object Explorer" and select "New Database..."
2. Name the database "PizzaSales" or anything else you wish and click OK
3. Right click on the newly created database and go to tasks, then select "Import Flat File..." from the dropdown
4. Click Next on Introduction step
5. Browse the "pizza_sales.csv" file location on your PC and click Next
6. Check the data in the "Preview Data" prompt and click Next
7. In the "Modify Columns" prompt, make sure you have the [following data types selected](ADD IMAGE LINK HERE "1446-02-04 16_28_03) and click Next
8. Click on Finish and wait for dataset to load

## Import XLSX into SSMS
---
Alternatively, you can choose to import the dataset file in .xlsx (Excel) format. The steps to do so are as follows: 

1. Open "SQL Server 2022 Import and Export Data"
2. Click on Next
3. In the "Choose a Data Source" prompt, select "Microsoft Excel" and browse the file location in your computer and click on Next
4. In the "Choose a Destination" prompt, select "Microsoft OLE DB Driver for SQL Server" 
5. Verify that the server name is correct, and select which database you want to import the dataset into (I recommend creating a new database called "PizzaSales")
6. In the "Specify Table Copy or Query" prompt, select "Copy data from one or more tables or views" and click on Next
7. Select the table(s) you want to import and click on Next
8. In the "Save and Run Package" prompt, select "Run immediately" and click on Next. Then wait for the process to finish.
## Queries for KPI Requirements
---
### 1. **Total Revenue**
```SQL
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;
```

Output:

![[Picture1.png]]

### 2. **Average Order Value**

```SQL
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS average_order_value
FROM pizza_sales
```

Output:

![[Picture2.png]]

### 3. **Total Pizzas Sold**

```SQL
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
```

Output:

![[Picture3.png]]

### 4. **Total Orders**
```SQL
SELECT COUNT(DISTINCT order_id) AS total_orders  
FROM pizza_sales
```

![[Picture4.png]]
### 5. **Average Pizzas per Order**
```SQL
SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS average_pizzas_per_order
FROM pizza_sales
```

Output:

![[Picture5.png]]

## Queries for Charts Requirements
---
### 1. **Daily Trend for Total Orders**

```SQL
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
```

Output:
![[Picture6.png]]
### 2. **Monthly Trend for Total Orders**

```SQL
SELECT DATENAME(MONTH, order_date) AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC
```

Output:
![[Picture7.png]]
### 3. **Percentage of Sales by Pizza Category**

```SQL
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS pct_sales
FROM pizza_sales 
GROUP BY pizza_category
```


Output:
![[Picture8.png]]
### 4. **Percentage of Sales by Pizza Size**

```SQL
SELECT pizza_size, SUM(total_price) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS pct_sales
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY pct_sales DESC
```


Output:
![[Picture9.png]]
### 5. **Total Pizzas Sold by Pizza Category**

```SQL
SELECT pizza_category, SUM(total_price) AS total_sales
FROM pizza_sales 
GROUP BY pizza_category
```


Output:
![[1446-02-06 09_06_51-Charts Requirements.sql - DESKTOP-UI79E1N_MSSQLSERVER01.PizzaSales (DESKTOP-UI79.png]]


### 6. **Top 5 Best Sellers by Revenue, Total Quantity and Total Orders**

```SQL
SELECT TOP 5 pizza_name, SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC
```

Output:
![[Picture10.png]]
![[Picture11.png]]
![[Picture12.png]]
### 7. **Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders**

```SQL
SELECT TOP 5 pizza_name, SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC
```


Output:
![[Picture13.png]]
![[Picture14.png]]
![[Picture15.png]]

# Power BI Visualizations
---
## Import Dataset from MS SQL Server
---
Here I will explain a bit of the process of creating the different visualizations. First of all, here is how I imported the data into Power BI from MS SQL Server:
1. Click on "Import data from SQL Server"
2. Write the server name and database name and click Next
3. Select the table(s) you want to import (in this case 1 table named pizza_sales)
4. Review the data and click on "Load" if everything seems fine
5. You can check your full imported data in the "Data view" tab 

## Data Cleaning with Power Query
---
Alright, so our dataset is imported, now it's time to do some data cleaning using Power Query Editor. Here is the steps I've take in regards to cleaning the dataset and have it prepared for creating the visualizations:

1. Replaced the abbreviations of pizza sizes in the pizza_size column with the following:
	1. S –> Regular
	2. M –> Medium
	3. L –> Large
	4. XL –> X-Large
	5. XXL –> XX-Large
2. Extracted the day of the week and month in new columns from the order_date column using the "Date" option in the "Add Column" ribbon

Other than these, the dataset is clean and can be worked with, so next step is to start building the visualizations

## Visualizations
---
Before starting to build the visualizations, I created all the measures that are going to be used for the purpose of the visualizations using DAX functions. The measures basically represent each of the KPI Requirements outlined previously. These measures are the following:

```DAX
Total Revenue = SUM(pizza_sales[total_price])
```

```DAX
Total Orders = DISTINCTCOUNT(pizza_sales[order_id])
```

```DAX
Avg Order Value = [Total Revenue]/[Total Orders]
```

```DAX
Total Pizzas Sold = SUM(pizza_sales[quantity])
```

```DAX
Avg Pizzas per Order = [Total Pizzas Sold]/[Total Orders]
```

Now, let's get into taking a look at our visualizations in more detail. 

### KPI Cards
---
Showcases our KPIs on the top of our dashboard using the new card visual in Power BI. The cards display the value on top and the parameter or KPI on the bottom and they are center aligned. I added shadow and glow and an accent bar on the left side to give it some style. I also added some images to provide a visual clarification and appeal to what each KPI signifies.

![[1446-02-08 19_16_24-Pizza Sales Report (Final).png]]


### Daily Trend for Total Orders
---
A bar chart that uses the Order Day and Total Orders measures to showcase the distribution of pizza orders by day of the week. The formatting consists of removing gridlines (applied also to all following visuals), using a gradient conditional formatting to give a darker tone to the bar of the day with higher sales and a lighter tone to the bar of the day with lower sales. Finally, customized the chart title and text formatting. 

The bars are sorted in the correct order of weekdays starting on Sunday and ending on Saturday. To do this sorting, I created a new measure by creating a new column that assigns a number to each day name in the desired order.

![[1446-02-08 19_25_32-Pizza Sales Report (Final).png]]

### Monthly Trend for Total Orders
---
An area line chart that uses the Order Month and Total Orders measures to showcase the distribution of pizza orders by months of the year. To sort the data by month, I extracted in a new column the month number and then sorted the chart by the Month Number column in ascending order. Removed guidelines as in the previous chart, changed the colors to make it more appealing and added data labels to illustrate better the number of orders per each month.


![[1446-02-12 09_33_50-Pizza Sales Report (Final).png]]


### % of Sales by Pizza Category
---
A pie chart that showcases the percentage of sales by each Pizza category (Classic, Supreme, Chicken, Veggie)

![[1446-02-12 09_58_15-Pizza Sales Report (Final).png]]

### % of Sales by Pizza Size
---
A pie chart that showcases the percentage of sales by each Pizza size (Large, Medium, Regular, X-Large, XX-Large)

![[1446-02-12 09_59_16-Pizza Sales Report (Final).png]]

### Total Pizzas Sold by Pizza Category
---
A funnel chart that showcases the total number of sales by pizza category. Used conditional formatting to color the bars and highlight the highest value. Adjusted the text formatting and I displayed the numbers as full value instead of rounding to something like 15k.

![[1446-02-12 10_16_49-Pizza Sales Report (Final).png]]


### **Top 5 Best Sellers by Revenue, Total Quantity and Total Orders**
---
3 horizontal bar charts that showcase the top 5 pizzas in 3 parameters: Revenue (the pizzas that generated the most revenue for the restaurant), Total Quantity (the pizzas with the highest number of units sold) and Total Orders (the pizzas with the highest number of orders placed). I used different color gradients for each of these parameters to distinguish them from each other and keep consistency with the charts for bottom 5 pizzas on the same parameter

![[1446-02-12 10_23_50-Pizza Sales Report (Final).png]]



### **Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders**
---
3 horizontal bar charts that showcase the bottom 5 pizzas in 3 parameters: Revenue (the pizzas that generated the least revenue for the restaurant), Total Quantity (the pizzas with the lowest number of units sold) and Total Orders (the pizzas with the lowest number of orders placed). I used different color gradients for each of these parameters to distinguish them from each other and keep consistency with the charts for top 5 pizzas on the same parameter.

![[1446-02-12 10_24_52-Pizza Sales Report (Final).png]]
