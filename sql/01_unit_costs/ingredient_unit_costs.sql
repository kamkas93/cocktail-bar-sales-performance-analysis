-- Purpose:
-- Calculates unit cost (PLN per standardized unit) for non-alcohol ingredients
-- based on warehouse purchase data.

-- Business context:
-- Provides base cost metrics required for bottom-up beverage cost calculation
-- at the cocktail recipe level.

-- Input tables:
-- - aperitivo_bar.warehouse_products

-- Output:
-- - ingredient_unit_costs (view)

-- Key logic:
-- - Uses standardized purchase quantity to normalize costs
-- - SAFE_DIVIDE prevents division by zero

-- Notes / assumptions:
-- - Only products with known standardized quantities are included
-- - Costs are treated as net values (VAT excluded)


SELECT
  product_name,
  category,
  purchase_quantity_standardized AS total_quantity,
  net_purchase_cost,
  SAFE_DIVIDE(net_purchase_cost, purchase_quantity_standardized) AS unit_cost
FROM aperitivo_bar.warehouse_products
WHERE purchase_quantity_standardized IS NOT NULL
ORDER BY product_name;
