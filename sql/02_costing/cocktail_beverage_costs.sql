-- Purpose:
-- Aggregates total beverage cost per cocktail.

-- Business context:
-- Provides a single cost metric used for pricing
-- and profitability analysis.

-- Input tables:
-- - cocktail_ingredient_costs_detailed

-- Output:
-- - cocktail_beverage_costs (view)

-- Key logic:
-- - SUM of ingredient_cost grouped by cocktail_name

SELECT
  cocktail_name,
  ROUND(SUM(ingredient_cost), 2) AS beverage_cost
FROM aperitivo_bar.cocktail_ingredient_costs_detailed
GROUP BY cocktail_name
ORDER BY beverage_cost DESC;
