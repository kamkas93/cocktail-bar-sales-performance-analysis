SELECT
  product_name,
  category,
  purchase_quantity_standardized AS total_quantity,
  net_purchase_cost,
  SAFE_DIVIDE(net_purchase_cost, purchase_quantity_standardized) AS unit_cost
FROM aperitivo_bar.warehouse_products
WHERE purchase_quantity_standardized IS NOT NULL
ORDER BY product_name;
