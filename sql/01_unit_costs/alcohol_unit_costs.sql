-- Purpose:
-- Calculates unit cost (PLN per ml) for alcoholic products.

-- Business context:
-- Alcohol costs are handled separately due to different sourcing
-- and pricing structure compared to non-alcohol ingredients.

-- Input tables:
-- - aperitivo_bar.product_list

-- Output:
-- - alcohol_unit_costs (view)

-- Key logic:
-- - Net price divided by bottle capacity
-- - Filters only liquid products measured in milliliters

-- Notes / assumptions:
-- - Prices are net
-- - Capacity unit assumed to be ml

SELECT
  name AS product_name,
  product_category,
  SAFE_DIVIDE(net_price, capacity_value) AS unit_cost
FROM aperitivo_bar.product_list
WHERE capacity_value IS NOT NULL
  AND net_price IS NOT NULL
  AND capacity_unit = 'ml';
