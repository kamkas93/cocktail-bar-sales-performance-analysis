-- Purpose:
-- Aggregates total beverage cost per cocktail.

-- Business context:
-- Provides a single cost metric used for pricing
-- and profitability analysis.

-- Input tables:
-- - clean.cocktail_ingredient_costs_detailed

-- Output:
-- - View: clean.cocktail_beverage_costs
--   - beverage_cost (PLN, net)

-- Key logic:
-- - SUM of ingredient_cost grouped by cocktail_name

SELECT
  cocktail_name,
  ROUND(SUM(ingredient_cost), 2) AS beverage_cost
FROM clean.cocktail_ingredient_costs_detailed
GROUP BY cocktail_name
ORDER BY beverage_cost DESC;
