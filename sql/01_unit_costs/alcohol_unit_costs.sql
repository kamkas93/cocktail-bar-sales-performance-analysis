-- Purpose:
-- Calculates unit cost (PLN per ml) for bottled products
-- based on gross prices and VAT rates.

-- Business context:
-- Product prices are stored as gross values.
-- VAT is removed to obtain comparable net unit costs
-- for margin and recipe analysis.

-- Input table:
-- - clean.products

-- Output:
-- - View: clean.product_unit_cost
--   - unit_cost_net: net cost per milliliter (PLN)

-- Key logic:
-- - Gross price converted to net price using VAT rate
-- - Net price divided by product capacity
-- - Only liquid products measured in milliliters

-- Notes / assumptions:
-- - VAT rate stored as decimal (e.g. 0.23)
-- - Capacity unit assumed to be ml


-- Select basic product identifiers
SELECT
  name AS product_name,          -- Business-level product name
  product_category,              -- Category used for grouping and analysis

  -- Calculate unit cost (net PLN per ml)
  SAFE_DIVIDE(
    -- Convert gross purchase price to net price by removing VAT
    SAFE_CAST(gross_price AS FLOAT64) / (1 + tax_rate),

    -- Divide net price by product capacity in milliliters
    SAFE_CAST(capacity_value AS FLOAT64)
  ) AS unit_cost_net

-- Source table containing cleaned product-level purchase data
FROM clean.products

-- Data quality filters
WHERE capacity_value IS NOT NULL      -- Capacity must be present
  AND gross_price IS NOT NULL         -- Gross price required to calculate cost
  AND tax_rate IS NOT NULL            -- VAT rate required to remove tax
  AND capacity_unit = 'ml';           -- Only liquid products measured in milliliters
