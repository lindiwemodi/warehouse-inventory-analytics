SELECT p.product_id,
    p.name,
    p.category,
    i.quantity_on_hand,
    s.supplier_id,
    s.lead_time_days
FROM products p
    JOIN inventory i ON p.product_id = i.product_id
    LEFT JOIN suppliers s ON p.product_id = s.product_id
WHERE i.quantity_on_hand < 20
ORDER BY i.quantity_on_hand ASC;
SELECT *
FROM orders;