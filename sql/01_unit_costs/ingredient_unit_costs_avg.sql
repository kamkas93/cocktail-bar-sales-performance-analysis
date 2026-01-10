SELECT
  product_name,
  AVG(unit_cost) AS avg_unit_cost
FROM aperitivo_bar.all_ingredient_unit_costs
GROUP BY product_name;
