-- Purpose:
-- Creates a unified list of all ingredient unit costs.

-- Business context:
-- Enables a single join point for cocktail recipes regardless
-- of ingredient type (alcoholic / non-alcoholic).

-- Input tables:
-- - ingredient_unit_costs_avg

-- Output:
-- - all_ingredient_unit_costs (view)

-- Key logic:
-- - UNION ALL of averaged ingredient costs

SELECT product_name, unit_cost FROM aperitivo_bar.ingredient_unit_costs
UNION ALL
SELECT product_name, unit_cost FROM aperitivo_bar.alcohol_unit_costs;
