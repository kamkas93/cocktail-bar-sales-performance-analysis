SELECT
  p.cocktail_name,

  COUNT(*) AS transactions,
  SUM(s.quantity) AS units_sold,

  p.selling_price,
  p.beverage_cost,
  p.gross_margin_pln,
  p.beverage_cost_pct,
  p.gross_margin_pct,

  ROUND(SUM(s.quantity) * p.selling_price, 2) AS total_revenue,
  ROUND(SUM(s.quantity) * p.gross_margin_pln, 2) AS total_gross_profit

FROM aperitivo_bar.cocktail_profitability p
LEFT JOIN aperitivo_bar.sales s
  ON p.cocktail_name = s.product_name

GROUP BY
  p.cocktail_name,
  p.selling_price,
  p.beverage_cost,
  p.gross_margin_pln,
  p.beverage_cost_pct,
  p.gross_margin_pct

ORDER BY total_gross_profit DESC;
