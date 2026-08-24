CREATE DATABASE IF NOT EXISTS ecommerce_dynamic_pricing_db;
USE ecommerce_dynamic_pricing_db;

DROP TABLE IF EXISTS fact_orders;
DROP TABLE IF EXISTS competitor_prices;
DROP TABLE IF EXISTS dim_products;

CREATE TABLE dim_products (
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(150) NOT NULL,
category VARCHAR(50) NOT NULL,
base_cost DECIMAL(10,2) NOT NULL,
current_list_price DECIMAL(10,2) NOT NULL,
stock_level INT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE competitor_prices (
competitor_price_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT NOT NULL,
competitor_name VARCHAR(100) NOT NULL,
competitor_price DECIMAL(10,2) NOT NULL,
scraped_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_competitor_product
FOREIGN KEY (product_id)
REFERENCES dim_products(product_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE fact_orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT NOT NULL,
quantity_sold INT NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
discount_applied DECIMAL(5,2) DEFAULT 0.00,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_order_product
FOREIGN KEY(product_id)
REFERENCES dim_products(product_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- ==========================================
-- 1. POPULATING DIM_PRODUCTS (Expanded Catalog)
-- ==========================================
INSERT INTO dim_products (product_name, category, base_cost, current_list_price, stock_level) VALUES
-- Electronics
('Wireless Noise-Canceling Headphones', 'Electronics', 45.00, 120.00, 140),
('Mechanical Gaming Keyboard', 'Electronics', 30.00, 75.00, 180),
('Ultra-Wide 4K Gaming Monitor', 'Electronics', 210.00, 499.99, 45),
('USB-C Multi-Port Hub', 'Electronics', 12.00, 35.00, 320),
('Ergonomic Vertical Mouse', 'Electronics', 18.00, 49.99, 210),
('True Wireless Earbuds', 'Electronics', 22.00, 69.99, 250),
('Smart Home Security Camera', 'Electronics', 35.00, 89.99, 115),
('Portable Bluetooth Speaker', 'Electronics', 25.00, 59.99, 190),
('10000mAh Fast Power Bank', 'Electronics', 15.00, 39.99, 275),
('RGB Gaming Headset Stand', 'Electronics', 10.00, 29.99, 160),

-- Furniture & Office
('Ergonomic Office Chair', 'Furniture', 85.00, 220.00, 60),
('Electric Height-Adjustable Desk', 'Furniture', 150.00, 380.00, 30),
('LED Desk Lamp with USB Charger', 'Furniture', 14.00, 39.99, 150),
('Minimalist Bookshelf', 'Furniture', 40.00, 110.00, 50),
('Executive Leather Guest Chair', 'Furniture', 95.00, 249.99, 25),
('Under-Desk Foot Rest', 'Furniture', 11.00, 29.99, 140),
('Cable Management Tray Kit', 'Furniture', 8.00, 21.99, 220),

-- Home & Kitchen
('Stainless Steel Water Bottle', 'Home & Kitchen', 8.00, 25.00, 400),
('Smart Digital Kitchen Scale', 'Home & Kitchen', 10.00, 29.99, 180),
('Insulated Travel Coffee Mug', 'Home & Kitchen', 9.00, 24.99, 230),
('One-Touch Coffee Maker', 'Home & Kitchen', 45.00, 99.99, 85),
('Air Fryer 4L Capacity', 'Home & Kitchen', 55.00, 129.99, 70),
('Drip Glass Teapot with Infuser', 'Home & Kitchen', 12.00, 32.99, 130),
('Non-Stick Cast Iron Skillet', 'Home & Kitchen', 20.00, 54.99, 90),
('Electric Food Dehydrator', 'Home & Kitchen', 38.00, 89.99, 40);


-- ==========================================
-- 2. POPULATING COMPETITOR_PRICES (Market Scrapes)
-- ==========================================
INSERT INTO competitor_prices (product_id, competitor_name, competitor_price) VALUES
-- Product 1
(1, 'TechGlobal Store', 125.00), (1, 'MegaMarket Online', 115.00), (1, 'AlphaRetail', 130.00),
-- Product 2
(2, 'TechGlobal Store', 79.99), (2, 'AlphaRetail', 72.50), (2, 'GadgetHub', 74.50),
-- Product 3
(3, 'MegaMarket Online', 489.99), (3, 'DisplayPro', 510.00), (3, 'TechGlobal Store', 499.00),
-- Product 4
(4, 'AlphaRetail', 38.00), (4, 'MegaMarket Online', 32.00), (4, 'GadgetHub', 34.99),
-- Product 5
(5, 'TechGlobal Store', 52.00), (5, 'OfficeDepot Direct', 48.00),
-- Product 6
(6, 'MegaMarket Online', 65.00), (6, 'AudioWorld', 72.00), (6, 'TechGlobal Store', 69.99),
-- Product 7
(7, 'SmartHome Direct', 95.00), (7, 'MegaMarket Online', 85.00),
-- Product 8
(8, 'AudioWorld', 55.00), (8, 'AlphaRetail', 62.00),
-- Product 9
(9, 'GadgetHub', 42.00), (9, 'MegaMarket Online', 38.50),
-- Product 10
(10, 'TechGlobal Store', 27.99), (10, 'AlphaRetail', 31.00),
-- Product 11
(11, 'OfficePro Kenya', 235.00), (11, 'Global Furnishings', 210.00), (11, 'MegaMarket Online', 225.00),
-- Product 12
(12, 'OfficePro Kenya', 395.00), (12, 'Global Furnishings', 370.00),
-- Product 13
(13, 'HomeEssentials', 42.00), (13, 'MegaMarket Online', 37.50),
-- Product 14
(14, 'Global Furnishings', 115.00), (14, 'HomeEssentials', 105.00),
-- Product 15
(15, 'OfficePro Kenya', 260.00), (15, 'Global Furnishings', 239.99),
-- Product 16
(16, 'OfficeDepot Direct', 32.50), (16, 'HomeEssentials', 28.00),
-- Product 17
(17, 'OfficePro Kenya', 24.00), (17, 'GadgetHub', 19.99),
-- Product 18
(18, 'HomeEssentials', 28.00), (18, 'MegaMarket Online', 24.00), (18, 'SuperMart', 26.00),
-- Product 19
(19, 'HomeEssentials', 32.00), (19, 'MegaMarket Online', 28.50),
-- Product 20
(20, 'HomeEssentials', 26.00), (20, 'SuperMart', 22.99),
-- Product 21
(21, 'MegaMarket Online', 95.00), (21, 'HomeEssentials', 105.00),
-- Product 22
(22, 'MegaMarket Online', 135.00), (22, 'HomeEssentials', 125.00), (22, 'SuperMart', 139.99),
-- Product 23
(23, 'SuperMart', 35.00), (23, 'HomeEssentials', 30.00),
-- Product 24
(24, 'KitchenWorld', 59.99), (24, 'MegaMarket Online', 52.00),
-- Product 25
(25, 'KitchenWorld', 94.99), (25, 'SuperMart', 85.00);


-- ==========================================
-- 3. POPULATING FACT_ORDERS (Dense Transactions)
-- ==========================================
INSERT INTO fact_orders (product_id, quantity_sold, unit_price, discount_applied) VALUES
(1, 2, 120.00, 0.00), (1, 1, 120.00, 10.00), (1, 4, 120.00, 5.00),
(2, 4, 75.00, 5.00), (2, 2, 75.00, 0.00),
(3, 1, 499.99, 0.00), (3, 1, 499.99, 25.00),
(4, 10, 35.00, 2.00), (4, 5, 35.00, 0.00), (4, 12, 35.00, 5.00),
(5, 3, 49.99, 5.00), (5, 1, 49.99, 0.00),
(6, 6, 69.99, 10.00), (6, 2, 69.99, 0.00),
(7, 3, 89.99, 5.00), (7, 5, 89.99, 10.00),
(8, 4, 59.99, 0.00), (8, 2, 59.99, 4.00),
(9, 8, 39.99, 2.00), (9, 3, 39.99, 0.00),
(10, 5, 29.99, 0.00),
(11, 1, 220.00, 10.00), (11, 2, 220.00, 0.00),
(12, 1, 380.00, 20.00), (12, 1, 380.00, 0.00),
(13, 5, 39.99, 0.00), (13, 3, 39.99, 5.00),
(14, 2, 110.00, 15.00), (14, 1, 110.00, 0.00),
(15, 2, 249.99, 10.00),
(16, 6, 29.99, 2.00),
(17, 9, 21.99, 0.00),
(18, 15, 25.00, 2.00), (18, 8, 25.00, 0.00), (18, 20, 25.00, 3.00),
(19, 4, 29.99, 3.00), (19, 7, 29.99, 0.00),
(20, 7, 24.99, 2.00), (20, 3, 24.99, 0.00),
(21, 3, 99.99, 10.00), (21, 5, 99.99, 0.00),
(22, 2, 129.99, 15.00), (22, 4, 129.99, 0.00),
(23, 6, 32.99, 2.00),
(24, 3, 54.99, 5.00),
(25, 2, 89.99, 10.00);


SELECT * FROM dim_products;
SELECT * FROM competitor_prices;
SELECT * FROM fact_orders;

-- seeing if orders paired with their actual names
SELECT
o.order_id,
p.product_name,
p.category,
o.quantity_sold,
o.unit_price,
(o.quantity_sold * o.unit_price) AS total_order_revenue
FROM fact_orders o
JOIN dim_products p ON o.product_id = p.product_id;


-- The competitor benchmarking and pricing position

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.current_list_price AS our_price,
    COALESCE(MIN(c.competitor_price), p.current_list_price) AS market_min_price,
    COALESCE(MAX(c.competitor_price), p.current_list_price) AS market_max_price,
    ROUND(AVG(c.competitor_price), 2) AS market_avg_price,
    CASE 
        WHEN p.current_list_price < MIN(c.competitor_price) THEN 'Underpriced (Opportunity)'
        WHEN p.current_list_price > MAX(c.competitor_price) THEN 'Overpriced (Risk)'
        ELSE 'Competitive'
    END AS pricing_positioning_status
FROM dim_products p
LEFT JOIN competitor_prices c ON p.product_id = c.product_id
GROUP BY p.product_id, p.product_name, p.category, p.current_list_price
ORDER BY category, our_price DESC;


-- PRODUCT PERFORMANCE AND GROSS PROFIT MARGIN ANALYSIS

SELECT
p.product_id,
p.product_name,
p.category,
SUM(o.quantity_sold) AS total_units_sold,
SUM(o.quantity_sold * o.unit_price) AS gross_revenue,
SUM(o.quantity_sold * p.base_cost) AS total_cogs,
(SUM(o.quantity_sold * o.unit_price) - SUM(o.quantity_sold * p.base_cost)) AS total_gross_profit,
ROUND(
((SUM(o.quantity_sold * o.unit_price) - SUM(o.quantity_sold * p.base_cost)) / SUM(o.quantity_sold *  o.unit_price)) *100,
2
) AS profit_margin_percentage
FROM dim_products p
JOIN fact_orders o ON p.product_id = o.product_id
GROUP BY p.product_id,p.product_name,p.category
ORDER BY gross_revenue DESC;


-- CATEGORY-LEVEL REVENUE AND INVENTORY EXPOSURE SUMMARY

SELECT
p.category,
COUNT(DISTINCT p.product_id) AS distinct_products_count,
SUM(p.stock_level) AS total_inventory_units_remaining,
SUM(p.stock_level * p.base_cost) AS total_inventory_capital_tied_up,
COALESCE(SUM(o.quantity_sold * o.unit_price), 0.00 ) AS category_total_revenue
FROM dim_products p
LEFT JOIN fact_orders o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY category_total_revenue DESC;


-- INDETIFYING DEAD-STOCK VS HIGH VELOCITY PRODUCTS

SELECT
p.product_id,
p.product_name,
p.category,
p.stock_level,
COALESCE(SUM(o.quantity_sold),0) AS total_units_sold,
CASE
WHEN COALESCE(SUM(o.quantity_sold),0) = 0 THEN 'Dead Stock (Action Required)'
WHEN COALESCE(SUM(o.quantity_sold),0) < 5 THEN 'Slow Moving'
ELSE 'High Velocity (Bestseller)'
END AS inventory_health_status
FROM dim_products p
LEFT JOIN fact_orders o ON p.product_id = o.product_id
GROUP BY p.product_id,p.product_name,p.category,p.stock_level
ORDER BY total_units_sold ASC;

-- ADVANCED CTE(COMMON TABLE EXPRESSION) FOR DYNAMIC PRICING TARGETS
WITH product_market_comparison AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        p.stock_level,
        p.current_list_price,
        COALESCE(AVG(c.competitor_price), p.current_list_price) AS market_avg_price
    FROM dim_products p
    LEFT JOIN competitor_prices c ON p.product_id = c.product_id
    GROUP BY p.product_id, p.product_name, p.category, p.stock_level, p.current_list_price
)
SELECT 
    product_id,
    product_name,
    category,
    stock_level,
    current_list_price,
    ROUND(market_avg_price, 2) AS market_avg_price,
    ROUND(current_list_price - market_avg_price, 2) AS price_difference_vs_market,
    CASE 
        WHEN current_list_price > market_avg_price AND stock_level > 100 THEN 'Prime Dynamic Markdown Candidate'
        WHEN current_list_price < market_avg_price THEN 'Price Increase Opportunity'
        ELSE 'Balanced'
    END AS pricing_strategy_recommendation
FROM product_market_comparison
ORDER BY stock_level DESC;  

































