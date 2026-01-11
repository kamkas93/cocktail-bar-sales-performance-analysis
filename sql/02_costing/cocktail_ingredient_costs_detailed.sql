-- Purpose:
-- Calculates detailed ingredient-level cost per cocktail recipe.

-- Business context:
-- Allows analysis of cost structure within each cocktail
-- and identification of the most expensive components.

-- Input tables:
-- - clean.recipes
-- - clean.ingredient_cost_ref

-- Output:
-- - View: clean.cocktail_ingredient_costs_detailed

-- Key logic:
-- - Ingredient cost = recipe volume * reference unit cost
-- - Only linear units (ml, g) are included

-- Notes / assumptions:
-- - Garnishes and non-measurable components are excluded

SELECT
  r.cocktail_name,
  r.ingredient,
  r.volume AS ingredient_quantity,
  r.unit,
  i.avg_unit_cost_net AS unit_cost,
  r.volume * i.avg_unit_cost_net AS ingredient_cost

FROM clean.recipes r

LEFT JOIN clean.ingredient_cost_ref i
  ON r.ingredient = i.product_name

WHERE r.unit IN ('ml', 'g')
  AND i.avg_unit_cost_net IS NOT NULL;
