# Cocktail Bar Sales Performance Analysis

Business intelligence case study analyzing sales and inventory data from multiple bars operating within a single food hall to support managerial decision-making.

## Scenario / Background

This project analyzes sales performance of a single cocktail bar operating within a food hall environment.

The bar offers a curated cocktail menu alongside selected beers, spirits, and soft drinks. 
Despite having access to detailed sales and product cost data, 
management lacks a structured analytical view of product performance and beverage cost efficiency.

The analysis covers Q1 2025 (January–March) and focuses on sales-driven insights supported by reference product cost data.

## Data Structure

- `data/raw/` – original raw datasets (unchanged, for auditability)
- `data/clean/` – cleaned and standardized datasets used for SQL analysis
- `data/transformed/` – analytical outputs (aggregated, business-ready views)

## Project Structure

## Project Structure

```text
data/
├── raw/                # Original source datasets (unchanged)
├── clean/              # Cleaned and standardized datasets used for analysis
└── transformed/        # Analytical outputs (aggregated, business-ready)

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

This project follows the Google Data Analytics framework:
Ask (business problem definition), Prepare and Process (data cleaning in Google Sheets),
Analyze (SQL-based modeling in BigQuery), Share (Tableau dashboard),
and Act (data-driven recommendations).

## Business Task (ASK Phase)

The goal of this analysis is to evaluate product-level sales performance and estimated beverage cost efficiency for a cocktail bar operating within a food hall.

The analysis aims to identify:
- top-performing products and categories,
- products with potentially inefficient cost-to-price ratios,
- opportunities to optimize pricing, menu composition, and overall profitability.

## Data Cleaning & Preparation (PREPARE AND PROCESS Phase)

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

## Data Visualization & Dashboarding (SHARE Phase)

The final analytical dataset was visualized using **Tableau Public** to create an interactive, decision-oriented dashboard.

The visualization layer was designed to support **managerial decision-making**, not just descriptive reporting.

👉 **Interactive dashboard:**  
https://public.tableau.com/views/CocktailPerformaneDashboard/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

### Dashboard Objectives

The Tableau dashboard focuses on answering the following business questions:

- Which cocktails generate the highest total profit?
- How does sales volume relate to net margin across menu items?
- Are best-selling cocktails also the most profitable?
- Which cocktails may require pricing or recipe optimization?

---

### Visualization Design Decisions

Several deliberate visualization and modeling decisions were made:

- **Scatter plot (Volume vs Net Margin)** was used to highlight trade-offs between sales scale and profitability.
- **Bubble size** represents total net profit contribution.
- **Margin-based segmentation** (High / Medium margin) supports quick identification of strong and weak performers.
- **Average reference lines** provide contextual benchmarks for performance comparison.

Cocktails with zero sales are intentionally excluded from margin averages to prevent distortion.
They are retained in the data model but not emphasized in performance KPIs.

---

### KPI Design

The dashboard includes executive-level KPIs:

- Total Net Revenue
- Total Net Profit
- Average Net Margin (calculated on sold products only)
- Best-Selling Cocktail (by units sold)

KPIs are calculated exclusively on cocktails with realized sales to ensure analytical correctness and avoid bias caused by zero-sales items.

---

### Intended Use

The dashboard is designed as a **menu engineering and pricing support tool**, enabling managers to:

- identify profit drivers,
- detect underperforming or mispriced cocktails,
- balance high-margin items with high-volume sellers,
- support data-driven menu and sourcing decisions.
---

## Actionable Insights & Recommendations (ACT Phase)

Based on the SQL analysis and the Tableau performance dashboard, several actionable insights emerge:

- **Profit contribution is not driven by margin alone.**  
  Some cocktails with very high net margins generate limited total profit due to low sales volume, while others with moderate margins contribute disproportionately to total profit.

- **Best-selling cocktails are not always the most profitable.**  
  High-volume items should be continuously monitored, as even small cost or pricing inefficiencies can have a significant impact on total profit.

- **Menu performance can be segmented into clear strategic groups.**  
  The volume vs net margin analysis enables identification of:
  - high-volume, high-margin “menu stars”,
  - high-margin but low-volume items with growth potential,
  - high-volume but lower-margin products requiring cost or pricing review.

- **Cocktails without sales require separate managerial action.**  
  Products with zero sales are excluded from profitability KPIs but remain visible in the data model, supporting decisions such as menu removal, repositioning, or recipe redesign.

### Recommended Actions

- Focus pricing and sourcing optimization efforts on **high-volume cocktails**, as they have the largest impact on total profit.
- Evaluate high-margin, low-volume cocktails for **menu placement or promotion** opportunities.
- Review recipes and ingredient sourcing for **lower-margin high-volume items** to improve contribution without reducing sales.
- Consider removing or redesigning **non-selling menu items** to simplify the menu and reduce operational complexity.

These insights demonstrate how combining bottom-up cost modeling with sales performance data enables data-driven menu and pricing decisions.

---

## Tools & Technologies

- **Google Sheets** – data cleaning and validation  
- **Google BigQuery** – SQL-based data modeling and analysis  
- **GitHub** – version control, documentation, and portfolio presentation
- **Tableau Public** – data visualisation & dashboard
- **Generative AI (ChatGPT)** - support for SQL development, data transformations, metric definitions, and reproducible analytics documentation
