# Cocktail Bar Sales Performance Analysis

Business intelligence case study analyzing sales and inventory data from multiple bars operating within a single food hall to support managerial decision-making.

## Scenario / Background

This project analyzes sales performance of a single cocktail bar operating within a food hall environment.

The bar offers a curated cocktail menu alongside selected beers, spirits, and soft drinks. 
Despite having access to detailed sales and product cost data, 
management lacks a structured analytical view of product performance and beverage cost efficiency.

The analysis covers Q1 2025 (January–March) and focuses on sales-driven insights supported by reference product cost data.

## Data structure

- `data/raw/` – original raw datasets (unchanged, for auditability)
- `data/clean/` – cleaned and standardized datasets used for SQL analysis

## Project Structure

```text
data/
├── raw/                # Original source datasets (unchanged)
└── clean/              # Cleaned and standardized datasets used for analysis

sql/
├── 01_unit_costs       # Unit cost normalization (warehouse & product level)
├── 02_costing          # Cocktail ingredient and beverage cost calculation
├── 03_profitability    # Pricing and margin analysis
└── 04_performance      # Sales × profitability performance metrics

CLEANING_LOG.md         # Detailed documentation of all cleaning steps
README.md               # Project overview and analytical narrative
```
## Data Source & Disclaimer

The datasets used in this project are based on the author’s professional experience in food & beverage operations and are designed to closely resemble real-world sales and product cost data from a bar environment.

All data has been anonymized and modified for analytical purposes. Product names, prices, quantities, and cost structures are representative and do not reflect actual commercial agreements, supplier pricing, or proprietary business information.

The datasets are intended solely for educational and portfolio demonstration purposes.

### Assumptions & Simplifications

For the purpose of this analysis, all prices and costs are treated as net values.
Value Added Tax (VAT) and other indirect taxes were intentionally excluded
to keep the analytical model focused on operational cost efficiency and
pricing logic.

Including taxes would require additional assumptions regarding tax rates,
product categories, and accounting treatment at multiple stages
(warehouse purchases, menu pricing, and sales reporting),
which is outside the scope of this business intelligence case study.

## Business Task (ASK Phase)

The goal of this analysis is to evaluate product-level sales performance and estimated beverage cost efficiency for a cocktail bar operating within a food hall.

The analysis aims to identify:
- top-performing products and categories,
- products with potentially inefficient cost-to-price ratios,
- opportunities to optimize pricing, menu composition, and overall profitability.

## Data Cleaning & Preparation (PREPARE Phase)
The raw datasets required multiple cleaning and standardization steps before analysis. The cleaning process focused on improving data consistency, ensuring correct data types, and preparing the data for aggregation and joins.

A detailed, step-by-step documentation of the entire data cleaning process — including validation checks, transformation logic, and business-driven data decisions — is provided in the CLEANING_LOG.md file to ensure transparency, reproducibility, and auditability of the analysis.

## Data Modeling & Integration (ANALYZE Phase)

After completing the data cleaning and preparation phase, all datasets were loaded into Google BigQuery and integrated using SQL to build a transparent analytical data model.

The SQL analysis was structured into multiple logical layers using views, allowing for clear separation of concerns, reproducibility, and easy downstream consumption in BI tools.

## SQL Analytical Model

The analytical logic is organized into clearly defined SQL layers, reflecting a **cost → profitability → performance** pipeline.

### Structure

```
sql/
  01_unit_costs        # Unit cost normalization (warehouse & product level)
  02_costing           # Cocktail ingredient and beverage cost calculation
  03_profitability     # Pricing and margin analysis
  04_performance       # Sales × profitability performance metrics
```

Each SQL file contains inline documentation describing:
- business purpose,
- input and output tables,
- transformation logic,
- analytical assumptions.

---

### Ingredient Unit Cost Modeling

Warehouse and product purchase data was used to calculate **standardized unit costs** (per gram or milliliter) for all measurable ingredients.

Because the same product may appear multiple times with different purchase prices, **average unit costs** were calculated and used as a **reference cost per ingredient**.

This approach prevents cost distortion and ensures stable, realistic cost attribution at the recipe level.

---

### Recipe-Level Ingredient Cost Attribution

Cocktail recipe data was joined with reference ingredient unit costs to calculate **ingredient-level costs per cocktail**.

Only linear, measurable units (ml, g) were included.  
Non-measurable or operational components (e.g. ice, garnishes, foams) were excluded in line with standard bar costing practices.

This step provides full transparency from warehouse purchase prices down to individual cocktail ingredients.

---

### Cocktail-Level Beverage Cost Calculation

Ingredient-level costs were aggregated using a bottom-up approach to calculate the **total beverage cost per cocktail**.

The resulting view represents the **net production cost** of each cocktail and serves as the cost foundation for all downstream profitability analysis.

---

### Pricing & Profitability Analysis

Cocktail beverage costs were combined with **net selling prices** to calculate **net contribution margin metrics**, including:

- beverage cost per cocktail,
- beverage cost percentage,
- net margin (PLN),
- net margin percentage.

All prices and costs are consistently treated as **net values**.  
VAT is explicitly removed from selling prices to ensure correct margin calculations and analytical consistency.

This layer evaluates **pricing efficiency** and highlights cocktails with suboptimal cost-to-price ratios.

---

### Sales Performance Integration

Finally, profitability metrics were integrated with **aggregated sales transaction data** to evaluate overall cocktail performance.

Sales data was aggregated to cocktail level prior to joining to avoid row duplication caused by transactional granularity.

This layer enables analysis of:
- units sold,
- total net revenue,
- total net profit contribution per cocktail.

The resulting performance view supports identification of:
- top-performing cocktails by profit contribution,
- high-margin but low-volume items,
- high-volume but low-margin products,
- menu and pricing optimization opportunities.

---

### Output & Visualization Readiness

The final analytical layer is designed for direct consumption in BI tools such as **Tableau**, enabling further visualization, ranking, and dashboard development.

---

## Key Insights & Outcomes

The analysis supports identification of:

- top-performing cocktails by revenue and profit contribution,
- cocktails with disproportionately high beverage cost percentages,
- pricing inconsistencies across similar recipes,
- opportunities to optimize:
  - menu pricing,
  - recipe composition,
  - product sourcing decisions.

The results reflect common operational challenges faced by cocktail bars and demonstrate how data-driven analysis can support managerial decision-making.

---

## Tools & Technologies

- **Google Sheets** – data cleaning and validation  
- **Google BigQuery** – SQL-based data modeling and analysis  
- **GitHub** – version control, documentation, and portfolio presentation
