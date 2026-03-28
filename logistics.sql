SELECT COUNT(*) 
FROM datacosupplychaindataset;

describe datacosupplychaindataset;

SELECT COUNT(*)
FROM datacosupplychaindataset
WHERE Sales IS NULL;

ALTER TABLE datacosupplychaindataset
DROP COLUMN `Customer Email`,
DROP COLUMN `Customer Password`,
DROP COLUMN `Product Image`,
DROP COLUMN `Product Description`;

-- How many orders are delivered on time, shipped early, or delivered late?
select `Delivery Status`, count(*)  as total_orders
from datacosupplychaindataset
group by `Delivery Status`; 

-- Which shipping mode is used most frequently? 
select `Shipping Mode`,count(*) as Total_shipping_mode
from datacosupplychaindataset
group by `Shipping Mode`;

-- Which shipping mode has the highest late deliveries?
select `Shipping Mode`, count(*) as Late_deliveries 
from datacosupplychaindataset
where `Delivery Status` = 'Late delivery'
group by `Shipping Mode`
ORDER BY `Late_deliveries` DESC;

-- Which regions have the highest number of orders?
select `Order Region`, count(*) as total_orderby_region
from datacosupplychaindataset
group by `Order Region`
order by total_orderby_region DESC;

-- Which regions experience the most delivery delays?
select `Order Region`, count(*) As late_orders
from datacosupplychaindataset
where `Delivery Status`= 'Late delivery'
group by `Order Region`
order by late_orders Desc;

-- Which countries generate the most sales?
select `Order Country`, sum(Sales) as total_sales
from datacosupplychaindataset
group by `Order Country`
order by total_sales desc;

-- Which markets generate the highest revenue?
select Market, sum(Sales) as total_sales
from datacosupplychaindataset
group by Market
order by total_sales Desc;

-- Which product categories have the highest sales?
SELECT `Category Name`, SUM(Sales) AS total_sales
FROM datacosupplychaindataset
GROUP BY `Category Name`
ORDER BY total_sales DESC;

-- Which product categories generate the highest profit?
SELECT `Category Name`, SUM(`Order Profit Per Order`) AS total_profit
FROM datacosupplychaindataset
GROUP BY `Category Name`
ORDER BY total_profit DESC;

-- Which products are sold the most by quantity?
SELECT `Product Name`, SUM(`Order Item Quantity`) AS total_quantity
FROM datacosupplychaindataset
GROUP BY `Product Name`
ORDER BY total_quantity DESC
LIMIT 10;

-- Which products generate the highest revenue?
SELECT `Product Name`, SUM(Sales) AS total_revenue
FROM datacosupplychaindataset
GROUP BY `Product Name`
ORDER BY total_revenue DESC
LIMIT 10;

-- What is the average scheduled shipping time for orders?
SELECT AVG(`Days for shipment (scheduled)`) AS avg_shipping_days
FROM datacosupplychaindataset;

-- Do late deliveries occur more often in certain shipping modes?
SELECT `Shipping Mode`, COUNT(*) AS late_orders
FROM datacosupplychaindataset
WHERE `Delivery Status` = 'Late delivery'
GROUP BY `Shipping Mode`
ORDER BY late_orders DESC;

-- Which customer segments place the most orders?
SELECT `Customer Segment`, COUNT(*) AS total_orders
FROM datacosupplychaindataset
GROUP BY `Customer Segment`
ORDER BY total_orders DESC;

-- Which cities have the highest order volume?
SELECT `Order City`, COUNT(*) AS total_orders
FROM datacosupplychaindataset
GROUP BY `Order City`
ORDER BY total_orders DESC
LIMIT 10;

-- Which states or regions generate the most profit?
SELECT `Order Region`, SUM(`Order Profit Per Order`) AS total_profit
FROM datacosupplychaindataset
GROUP BY `Order Region`
ORDER BY total_profit DESC;

-- How does discount affect total sales and profit?
SELECT `Order Item Discount Rate`,
SUM(Sales) AS total_sales,
SUM(`Order Profit Per Order`) AS total_profit
FROM datacosupplychaindataset
GROUP BY `Order Item Discount Rate`
ORDER BY `Order Item Discount Rate`;

-- Which orders have the highest profit per order?
SELECT `Order Id`, `Order Profit Per Order`
FROM datacosupplychaindataset
ORDER BY `Order Profit Per Order` DESC
LIMIT 10;

-- Which orders have negative profit (loss)?
SELECT `Order Id`, `Order Profit Per Order`
FROM datacosupplychaindataset
WHERE `Order Profit Per Order` < 0
ORDER BY `Order Profit Per Order`;

-- What percentage of orders have late delivery risk?
SELECT 
(SUM(`Late_delivery_risk`) / COUNT(*)) * 100 AS late_delivery_percentage
FROM datacosupplychaindataset;