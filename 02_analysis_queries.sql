-- =====================================================
-- 02_analysis_queries.sql
-- Analysis queries for the warehouse inventory database
-- =====================================================
-- ---------------------------------------------------
-- 1. Total quantity ordered per product
-- Shows which products are actually moving, best-sellers first
-- ---------------------------------------------------
SELECT p.product_id,
    p.name,
    SUM(o.quantity_ordered) AS total_ordered
FROM orders o
    JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id,
    p.name
ORDER BY total_ordered DESC;
-- ---------------------------------------------------
-- 2. Low-stock check
-- Flags products with fewer than 20 units on hand, worst first
-- ---------------------------------------------------
SELECT p.product_id,
    p.name,
    i.quantity_on_hand
FROM inventory i
    JOIN products p ON i.product_id = p.product_id
WHERE i.quantity_on_hand < 20
ORDER BY i.quantity_on_hand ASC;