-- =========================================
-- Blinkit Sales Analysis Project
-- Step 1: Organize Your SQL Queries
-- Objective: Analyze sales, product performance, and outlet performance using SQL
-- Dataset: blinkit_data
-- =========================================

-- Use Database
CREATE DATABASE IF NOT EXISTS blinkit;
USE blinkit;

-- Preview Dataset
-- Insight: Get an initial look at the dataset to understand structure and available columns
SELECT * FROM blinkit_data;


-- ===============================
-- 1️⃣ Overall KPIs
-- Purpose: High-level performance metrics for management
-- Metrics: Total Sales, Average Sales, Number of Items, Average Rating (Outlet Year 2022)
-- ===============================

-- Total Sales in Millions for outlets established in 2022
SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022;

-- Average Sales for outlets established in 2022
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022;

-- Number of Items Sold for outlets established in 2022
SELECT COUNT(*) AS Number_Of_Items
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022;

-- Average Rating for outlets established in 2022
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022;


-- ===============================
-- 2️⃣ Category-Level Analysis
-- Purpose: Understand performance by product characteristics
-- Metrics: Total Sales, Average Sales, Number of Items, Average Rating
-- ===============================

-- Total Sales by Fat Content
-- Insight: Understand impact of fat content on sales and ratings
SELECT Item_Fat_Content,
       CAST(SUM(Total_Sales)/100000 AS DECIMAL(10,2)) AS Total_Sales_Millions,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
       COUNT(*) AS Number_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Millions DESC;

-- Total Sales by Item Type (Top 5)
-- Insight: Identify which item types are driving revenue
SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS Number_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022
GROUP BY Item_Type
ORDER BY Total_Sales DESC
LIMIT 5;


-- ===============================
-- 3️⃣ Outlet Analysis
-- Purpose: Analyze outlet-level performance and characteristics
-- Metrics: Total Sales, Average Sales, Number of Items, Average Rating
-- ===============================

-- Fat Content by Outlet Location Type
-- Insight: Compare sales by fat content across outlet locations
SELECT Outlet_Location_Type,
       SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END) AS LowFat_Sales,
       SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END) AS Regular_Sales,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
       COUNT(*) AS Number_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales ASC;

-- Total Sales by Outlet Establishment Year
-- Insight: Evaluate how the outlet's age influences sales
SELECT Outlet_Establishment_Year,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
       COUNT(*) AS Number_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

-- Total Sales by Outlet Size (Percentage Contribution)
-- Insight: Assess correlation between outlet size and total sales
SELECT Outlet_Size,
       SUM(Total_Sales) AS Total_Sales,
       ROUND(SUM(Total_Sales) / SUM(SUM(Total_Sales)) OVER() * 100, 2) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Total Sales by Outlet Location
-- Insight: Geographic distribution of sales
SELECT Outlet_Location_Type,
       SUM(Total_Sales) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- All Metrics by Outlet Type
-- Insight: Comprehensive KPI view for each outlet type
SELECT Outlet_Type,
       SUM(Total_Sales) AS Total_Sales,
       ROUND(SUM(Total_Sales) / SUM(SUM(Total_Sales)) OVER() * 100, 2) AS Sales_Percentage,
       AVG(Total_Sales) AS Avg_Sales,
       COUNT(*) AS Number_Of_Items,
       AVG(Rating) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
select *from blinkit_data;
