-- =====================================================
-- 01_cleaning.sql
-- Cleaning queries for the warehouse inventory database
-- =====================================================
-- ---------------------------------------------------
-- 1. ORDERS: Find duplicate rows (before deleting)
-- ---------------------------------------------------
SELECT order_id,
    product_id,
    quantity_ordered,
    order_date,
    COUNT(*) AS how_many
FROM orders
GROUP BY order_id,
    product_id,
    quantity_ordered,
    order_date
HAVING COUNT(*) > 1;
-- Remove duplicates, keeping the first occurrence (lowest rowid) of each
DELETE FROM orders
WHERE rowid NOT IN (
        SELECT MIN(rowid)
        FROM orders
        GROUP BY order_id,
            product_id,
            quantity_ordered,
            order_date
    );
-- Catch: one duplicate pair didn't match exactly because one copy also had
-- a blank order_date. Found via order_id alone, then removed the less
-- informative (blank-date) copy manually:
-- SELECT rowid, * FROM orders WHERE order_id = 26;
DELETE FROM orders
WHERE rowid = 204;
-- Confirm final count
SELECT COUNT(*)
FROM orders;
-- ---------------------------------------------------
-- 2. PRODUCTS: Fix inconsistent category text
-- ---------------------------------------------------
-- Check what's actually in the category column first
SELECT DISTINCT category,
    COUNT(*) AS how_many
FROM products
GROUP BY category;
-- Casing/spacing issue — catches PACKAGING, packaging, etc.
UPDATE products
SET category = 'Packaging'
WHERE UPPER(category) = 'PACKAGING';
-- Genuine typos — not