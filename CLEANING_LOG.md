# Data Cleaning Log

This document records the data cleaning and preparation steps applied
to the raw datasets prior to analysis.

## Dataset: sales_aperitivo_RAW

### Initial data review

The raw dataset contains aggregated daily sales per product.
Each row represents total quantity sold for a given product on a given date.

### Step 1: Sale date standardization

Issue:
The `sale_date` column contained multiple date formats
(e.g. YYYY-MM-DD and DD/MM/YYYY).

Action:
Google Sheets correctly recognized all values as date objects.
The column was standardized by applying a uniform date format
(YYYY-MM-DD).

Result:
All dates are stored consistently and are ready for time-based analysis.

### Step 2: Text normalization – trimming whitespace

Issue:
Potential leading and trailing whitespace detected in text fields
(`product_name`, `category`), which could affect joins and aggregations.

Action:
Applied TRIM (and CLEAN where necessary) to remove extra whitespace
from key text columns.

Result:
Text fields are standardized and safe for grouping and joining.

### Step 3: Logical duplicate detection

Issue:
Duplicate business records could inflate aggregated sales metrics.

Action:
Created a composite logical key combining:
sale_date, product_name, category, quantity, and product_price.
Used COUNTIF to identify repeated composite keys.

Result:
Each record represents a unique daily product-level sales aggregate.
No logical duplicates detected.

### Step 4: Text normalization

- Trimmed whitespace in product_name and category fields
- Standardized category naming (lowercase, consistent labels)
- Ensured sale_date stored as DATE type

### Step 5: Numeric validation

- Validated quantity > 0
- Validated product_price_gross > 0
- Verified total_price_gross = quantity * product_price_gross

### Step 6: Data completeness & range checks

- Verified no missing critical fields
- Confirmed date range limited to Q1 2025
- Checked price ranges for business plausibility

## Sales_Aperitivo – Data Cleaning Summary

**Dataset:** sales_aperitivo_RAW  
**Output:** sales_aperitivo_CLEAN  

### Performed cleaning steps:
- Standardized date format to ISO (YYYY-MM-DD)
- Removed empty rows and blank values in `sale_date`
- Normalized product names and categories (trimmed whitespace, unified casing)
- Validated numeric fields (`quantity`, `product_price_gross`)
- Identified and removed logical duplicates using composite row keys
- Verified absence of NULL values after cleaning
- Performed basic range validation on quantity and prices

### Result:
Dataset is consistent, normalized, and ready for transformation and aggregation.
