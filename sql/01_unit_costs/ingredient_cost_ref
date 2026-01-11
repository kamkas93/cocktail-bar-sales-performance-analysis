-- Purpose:
-- Creates a single reference table of averaged unit costs (net)
-- for all ingredients used in cocktail recipes.

-- Business context:
-- Ingredient prices may vary over time and across invoices.
-- Averaging unit costs provides a stable reference value
-- for recipe costing and margin analysis.

-- Input tables:
-- - clean.ingredient_unit_cost
-- - clean.product_unit_cost

-- Output:
-- - View: clean.ingredient_cost_ref
--   - avg_unit_cost_net (PLN per standardized unit)

-- Key logic:
-- - UNION ALL of alcohol and non-alcohol unit costs
-- - AVG(unit_cost_net) grouped by product_name

-- Notes / assumptions:
-- - Product name is used as the business identifier
-- - Averaging is used instead of time-based pricing

SELECT
  product_name,
  AVG(unit_cost_net) AS avg_unit_cost_net
FROM (
  -- non-alcohol ingredients
  SELECT
    product_name,
    unit_cost_net
  FROM clean.ingredient_unit_cost

  UNION ALL

  -- alcohol products
  SELECT
    product_name,
    unit_cost_net
  FROM clean.product_unit_cost
)
GROUP BY product_name;
