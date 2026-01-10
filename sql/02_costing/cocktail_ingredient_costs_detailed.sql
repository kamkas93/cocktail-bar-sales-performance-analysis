-- Purpose:
-- Calculates detailed ingredient-level cost per cocktail recipe.

-- Business context:
-- Allows analysis of cost structure within each cocktail
-- and identification of the most expensive components.

-- Input tables:
-- - aperitivo_bar.aperitivo_cocktails
-- - ingredient_unit_costs_avg

-- Output:
-- - cocktail_ingredient_costs_detailed (view)

-- Key logic:
-- - Ingredient cost = recipe volume * average unit cost
-- - Only linear units (ml, g) are included

-- Notes / assumptions:
-- - Garnishes and non-measurable components are excluded

SELECT
  c.cocktail_name,
  c.ingredient,
  c.volume AS ingredient_quantity,
  c.unit,
  u.avg_unit_cost AS unit_cost,
  c.volume * u.avg_unit_cost AS ingredient_cost
FROM aperitivo_bar.aperitivo_cocktails c
LEFT JOIN aperitivo_bar.ingredient_unit_costs_avg u
  ON c.ingredient = u.product_name
WHERE c.unit IN ('ml', 'g')
  AND u.avg_unit_cost IS NOT NULL;
