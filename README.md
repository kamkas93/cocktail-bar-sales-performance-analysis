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

data/
├── raw/        # Original source datasets (unchanged)
├── clean/      # Cleaned and standardized datasets used for analysis
CLEANING_LOG.md # Detailed documentation of all cleaning steps
README.md       # Project overview and analytical narrative

## Data Source & Disclaimer

The datasets used in this project are based on the author’s professional experience in food & beverage operations and are designed to closely resemble real-world sales and product cost data from a bar environment.

All data has been anonymized and modified for analytical purposes. Product names, prices, quantities, and cost structures are representative and do not reflect actual commercial agreements, supplier pricing, or proprietary business information.

The datasets are intended solely for educational and portfolio demonstration purposes.

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

After completing the data cleaning and preparation phase, all datasets were loaded into BigQuery and integrated using SQL.
The analytical data model was built by combining:

- daily cocktail sales data,

- recipe-level cocktail compositions,

- standardized warehouse purchase costs,

- product master data,

- cocktail-level selling prices.

Data integration was performed using SQL joins and common table expressions (CTEs), ensuring transparent, reproducible logic and full traceability of calculations.

The final analytical layer enables ingredient-level cost attribution and cocktail-level profitability analysis.

### Beverage Cost Calculation

Beverage cost was calculated using a bottom-up approach:

#### Ingredient usage per cocktail
Recipe data was used to determine the exact quantity of each ingredient used in a single cocktail.

#### Ingredient unit cost estimation
Warehouse purchase data was used to calculate unit costs (per gram or milliliter) for each ingredient.

#### Cocktail-level cost aggregation
Ingredient-level costs were aggregated to determine the total beverage cost per cocktail.

Non-linear, batch-based, or operational ingredients (e.g. foams, garnishes, ice) were excluded or handled separately, in line with real-world bar costing practices.

### Pricing & Margin Analysis

Cocktail selling prices were joined with calculated beverage costs to derive:

- beverage cost per cocktail,
- beverage cost percentage,
- estimated gross margin.

This enabled direct comparison of cost efficiency across cocktails and categories, independent of sales volume.

## Key Insights & Outcomes

- The analysis supports the identification of:

- top-performing cocktails by revenue and volume,

- cocktails with disproportionately high beverage cost percentages,

- pricing inconsistencies across similar recipes,

- opportunities to optimize:

  - menu pricing,

  - recipe composition,

  - product sourcing decisions.

The results reflect common operational challenges faced by cocktail bars and demonstrate how data-driven analysis can support managerial decision-making.

## Tools & Technologies

  Google Sheets – data cleaning and validation

  BigQuery – SQL-based data modeling and analysis

  GitHub – version control, documentation, and portfolio presentation

