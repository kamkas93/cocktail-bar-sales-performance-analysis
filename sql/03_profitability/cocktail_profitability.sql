SELECT
  c.cocktail_name,
  p.cocktail_price_net AS selling_price,
  c.beverage_cost,
  ROUND(p.cocktail_price_net - c.beverage_cost, 2) AS gross_margin_pln,
  ROUND(c.beverage_cost / p.cocktail_price_net, 3) AS beverage_cost_pct,
  ROUND(1 - (c.beverage_cost / p.cocktail_price_net), 3) AS gross_margin_pct
FROM aperitivo_bar.cocktail_ingredient_costs c
LEFT JOIN aperitivo_bar.price p
  ON c.cocktail_name = p.cocktail_name
WHERE p.cocktail_price IS NOT NULL
ORDER BY beverage_cost_pct DESC;
