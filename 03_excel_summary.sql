SELECT p.product_id,
    p.name,
    p.category,
    i.quantity_on_hand,
    p.storage_cost_per_unit,
    COALESCE(SUM(o.quantity_ordered), 0) AS total_ordered
FROM products p
    JOIN inventory i ON p.product_id = i.product_id
    LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id,
    p.name,
    p.category,
    i.quantity_on_hand,
    p.storage_cost_per_unit
ORDER BY p.product_id;