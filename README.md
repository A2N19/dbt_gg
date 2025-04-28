# dbt_gg

## Overview

This project implements a production-grade ELT pipeline using **dbt** and **PostgreSQL** for the Jaffle Shop sample dataset, extended with custom transformations, metrics, snapshots, and Power BI integration.

## Repository Structure

```
/jaffle-shop-classic
├─ models/
│  ├─ staging/
│  │  ├─ stg_customer_profiles.sql
│  │  ├─ stg_order_records.sql
│  │  ├─ stg_payment_logs.sql
│  │  └─ schema.yml
│  ├─ marts/
│  │  ├─ core/
│  │  │  ├─ customers.sql
│  │  │  ├─ orders.sql
│  │  │  ├─ payments.sql
│  │  │  └─ customer_orders.sql
│  │  ├─ metrics/
│  │  │  ├─ customer_metrics.sql
│  │  │  └─ customer_rfm.sql
│  │  └─ powerbi/
│  │     └─ customer_metrics_for_powerbi.sql
├─ snapshots/
│  └─ customer_profiles_snapshot.sql
├─ seeds/
│  ├─ raw_customers.csv
│  ├─ raw_orders.csv
│  └─ raw_payments.csv
├─ dbt_project.yml
├─ docker-compose.yml
└─ README.md
```

## Setup & Installation

1. **Clone the repo**:
   ```bash
   git clone https://github.com/A2N19/dbt_gg.git
   cd dbt_gg
   ```
2. **Start PostgreSQL** (via Docker Compose):
   ```bash
   docker-compose up -d
   ```
3. **Create Python venv & install dbt**:
   ```bash
   python -m venv .venv
   .venv\Scripts\activate   # Windows
   pip install dbt-postgres
   ```
4. **Run the pipeline**:
   ```bash
   dbt deps
   dbt seed
   dbt run
   dbt snapshot
   dbt test
   ```
5. **Generate & serve docs**:
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## Key Features

- **Staging models** with custom fields (`full_name`)
- **Core models**: `customers`, `orders`, `payments`, `customer_orders`
- **Metrics**:
  - `customer_metrics`: LTV, average order value, days between orders
  - `customer_rfm`: RFM segmentation
- **Power BI-ready view**: `customer_metrics_for_powerbi` for visual reporting
- **Snapshots**: track historical changes via `customer_profiles_snapshot`
- **Comprehensive tests** and documentation

## Publishing Documentation (optional)

To publish docs via GitHub Pages:
```bash
cp -r target docs
git add docs
git commit -m "Publish dbt docs"
git push origin main
```
Then enable GitHub Pages in repository Settings, using the `/docs` folder.

---

© 2025 Amir Nurseit. All rights reserved.

