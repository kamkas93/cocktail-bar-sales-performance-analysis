-- Purpose:
-- Combines sales volume with net profitability metrics
-- to evaluate overall cocktail performance.

-- Business context:
-- Identifies top-performing cocktails in terms of
-- total revenue and total profit contribution.

-- Input tables:
-- - clean.cocktail_profitability
-- - clean.sales

-- Output:
-- - View: clean.cocktail_performance

-- Key logic:
-- - Sales data is aggregated to cocktail level
-- - Revenue = units sold * net selling price
-- - Total profit = units sold * net margin per cocktail

-- Notes / assumptions:
-- - All prices, costs and margins are net (VAT excluded)
-- - Sales table contains transactional data
-- - Cocktails without sales are retained via LEFT JOIN


-- Aggregate transactional sales data to cocktail level
WITH sales_per_cocktail AS (
  SELECT
    product_name AS cocktail_name,

    COUNT(*) AS transactions,       -- number of sales records
    SUM(quantity) AS units_sold      -- total units sold

  FROM clean.sales
  GROUP BY product_name
)

-- Combine sales volume with profitability metrics
SELECT
  p.cocktail_name,

  s.transactions,
  s.units_sold,

  p.selling_price_net,
  p.beverage_cost_net,
  p.net_margin_pln,
  p.beverage_cost_pct,
  p.net_margin_pct,

  -- Total net revenue
  ROUND(
    s.units_sold * p.selling_price_net,
    2
  ) AS total_revenue_net,

  -- Total net profit (contribution margin)
  ROUND(
    s.units_sold * p.net_margin_pln,
    2
  ) AS total_profit_net

FROM clean.cocktail_profitability p

LEFT JOIN sales_per_cocktail s
  ON p.cocktail_name = s.cocktail_name

ORDER BY total_profit_net DESC;
