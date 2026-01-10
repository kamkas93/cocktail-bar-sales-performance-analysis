-- Purpose:
-- Aggregates unit costs by product name using average values.

-- Business context:
-- Prevents row duplication in downstream joins caused by
-- multiple purchase prices for the same ingredient.

-- Input tables:
-- - ingredient_unit_costs
-- - alcohol_unit_costs

-- Output:
-- - ingredient_unit_costs_avg (view)

-- Key logic:
-- - AVG(unit_cost) grouped by product_name

-- Notes / assumptions:
-- - Averaging is used as a simplification instead of time-based pricing

SELECT
  product_name,
  AVG(unit_cost) AS avg_unit_cost
FROM aperitivo_bar.all_ingredient_unit_costs
GROUP BY product_name;
