SELECT product_name, unit_cost FROM aperitivo_bar.ingredient_unit_costs
UNION ALL
SELECT product_name, unit_cost FROM aperitivo_bar.alcohol_unit_costs;
