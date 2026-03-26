-- Purpose:
-- Calculates unit cost (PLN per standardized unit) for non-alcohol ingredients
-- based on gross purchase costs and VAT rates.

-- Business context:
-- Ingredient purchase data comes from warehouse invoices
-- and is used to calculate recipe-level beverage costs.

-- Input table:
-- - clean.ingredients

-- Output:
-- - View: clean.ingredient_unit_cost
--   - unit_cost_net (PLN per standardized unit)

-- Key logic:
-- - Gross purchase cost converted to net using VAT rate
-- - Net cost divided by standardized purchase quantity

-- Notes / assumptions:
-- - Standardized quantity is expressed in grams or milliliters
-- - VAT rate stored as decimal (e.g. 0.23)

SELECT
  product_name,
  category,

  purchase_quantity_standardized AS total_quantity,

  -- Calculate unit cost (net PLN per standardized unit)
  SAFE_DIVIDE(
    gross_purchase_cost / (1 + tax_rate),
    purchase_quantity_standardized
  ) AS unit_cost_net

FROM clean.ingredients

WHERE purchase_quantity_standardized IS NOT NULL
  AND gross_purchase_cost IS NOT NULL
  AND tax_rate IS NOT NULL

ORDER BY product_name;
