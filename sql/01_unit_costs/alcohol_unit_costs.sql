SELECT
  name AS product_name,
  product_category,
  SAFE_DIVIDE(net_price, capacity_value) AS unit_cost
FROM aperitivo_bar.product_list
WHERE capacity_value IS NOT NULL
  AND net_price IS NOT NULL
  AND capacity_unit = 'ml';
