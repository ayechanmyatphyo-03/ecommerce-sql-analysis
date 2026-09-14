-- E-commerce SQL Analysis Portfolio Project
-- Author: Aye Chan Myat Phyo
-- Database: SQLite

-- 1. Overall Sales Performance
SELECT
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_items;

-- 2. Top 5 Products by Revenue
SELECT
    p.product_name,
    ROUND(SUM(oi.revenue), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 3. Revenue and Profit by Category
SELECT
    p.category,
    ROUND(SUM(oi.revenue), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 4. Revenue by Customer Segment
SELECT
    c.segment,
    ROUND(SUM(oi.revenue), 2) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_revenue DESC;

-- 5. Revenue by Region
SELECT
    c.region,
    ROUND(SUM(oi.revenue), 2) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC;

-- 6. Monthly Revenue Trend
SELECT
    strftime('%Y-%m', o.order_date) AS month,
    ROUND(SUM(oi.revenue), 2) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY month;

-- 7. Top 10 Customers by Spend
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.revenue), 2) AS total_spend
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spend DESC
LIMIT 10;

-- 8. Revenue by Sales Channel
SELECT
    o.sales_channel,
    ROUND(SUM(oi.revenue), 2) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
GROUP BY o.sales_channel
ORDER BY total_revenue DESC;

-- 9. Product Profit Margin
SELECT
    p.product_name,
    ROUND(SUM(oi.revenue), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND(
        SUM(oi.profit) * 100.0 / SUM(oi.revenue),
        2
    ) AS profit_margin_percent
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY profit_margin_percent DESC;

-- 10. Best-Performing Month
SELECT
    strftime('%Y-%m', o.order_date) AS month,
    ROUND(SUM(oi.revenue), 2) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY total_revenue DESC
LIMIT 1;
