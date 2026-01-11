-- Purpose:
-- Calculates net contribution margin metrics per cocktail
-- based on net beverage costs and net selling prices.

-- Business context:
-- Sales data is transactional and may contain multiple rows
-- per cocktail. To avoid row duplication, sales prices are
-- first aggregated to product level before joining with costs.
-- The result enables profitability and pricing analysis.

-- Input tables:
-- - clean.cocktail_beverage_costs
-- - clean.sales

-- Output:
-- - View: clean.cocktail_profitability
--   - selling_price_net
--   - beverage_cost_net
--   - net_margin_pln
--   - beverage_cost_pct
--   - net_margin_pct

-- Key logic:
-- - Gross selling prices are converted to net using VAT rate
-- - Sales data is aggregated to cocktail level
-- - Net margin = net selling price - net beverage cost
-- - Percentage metrics normalize costs across price levels

-- Notes / assumptions:
-- - All costs and prices are calculated in net terms (VAT excluded)
-- - Average selling price is used as a reference price per cocktail
-- - Operational costs (staff, rent) are not included


-- Aggregate transactional sales data to cocktail level
WITH sales_per_cocktail AS (
  SELECT
    product_name,  -- Cocktail name as used in sales transactions

    -- Convert gross selling price to net and average per cocktail
    ROUND(
      AVG(product_price_gross / (1 + tax_rate)),
      2
    ) AS selling_price_net

  FROM clean.sales

  -- Ensure valid price and VAT data
  WHERE product_price_gross IS NOT NULL
    AND tax_rate IS NOT NULL

  -- One row per cocktail
  GROUP BY product_name
)

-- Calculate profitability metrics per cocktail
SELECT
  b.cocktail_name,               -- Cocktail identifier

  s.selling_price_net,           -- Net selling price per cocktail
  b.beverage_cost AS beverage_cost_net,  -- Net beverage cost

  -- Net contribution margin in PLN
  ROUND(
    s.selling_price_net - b.beverage_cost,
    2
  ) AS net_margin_pln,

  -- Beverage cost share of net selling price
  ROUND(
    b.beverage_cost / s.selling_price_net,
    3
  ) AS beverage_cost_pct,

  -- Net margin percentage
  ROUND(
    1 - (b.beverage_cost / s.selling_price_net),
    3
  ) AS net_margin_pct

FROM clean.cocktail_beverage_costs b

-- Join aggregated sales prices to beverage costs
LEFT JOIN sales_per_cocktail s
  ON b.cocktail_name = s.product_name

-- Exclude cocktails without valid selling price
WHERE s.selling_price_net IS NOT NULL

-- Highlight cocktails with the worst cost structure first
ORDER BY beverage_cost_pct DESC;
