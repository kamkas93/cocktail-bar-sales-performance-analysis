SELECT
  cocktail_name,
  ROUND(SUM(ingredient_cost), 2) AS beverage_cost
FROM aperitivo_bar.cocktail_ingredient_costs_detailed
GROUP BY cocktail_name
ORDER BY beverage_cost DESC;
