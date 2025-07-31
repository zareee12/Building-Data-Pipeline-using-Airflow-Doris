# 🚀 Coingecko Crypto Analytics – Data Pipeline Project

This project builds a full data pipeline using **top-1000 token data from Coingecko**, structured in a modern **Bronze → Silver → Gold** architecture, and orchestrated with **Apache Airflow**.

---

## 🧠 Objective

> Build an end-to-end data pipeline to process and analyze top-1000 crypto tokens from Coingecko and extract meaningful business insights.

---
## 📁 Project Structure

```bash
COINGECKO_PIPELINE/
├── data/                      # Source dataset (JSON)
├── image/                     # Image assets (for docs/presentation)
├── install/
│   ├── docker_airflow/        # Apache Airflow setup
│   │   ├── config/            # Airflow configuration files
│   │   ├── dags/              # DAG scripts
│   │   ├── data/              # Data mount volume
│   │   ├── logs/              # Logs for Airflow
│   │   ├── plugins/           # Custom Airflow plugins (if any)
│   │   └── docker-compose.yaml # Docker Compose file for Airflow
│   ├── docker_doris/          # Apache Doris setup
│   │   ├── data/              # Doris persistent volume
│   │   │   ├── be/            # Backend node storage
│   │   │   └── fe/            # Frontend node storage
│   │   ├── .env               # Environment variables
│   │   └── docker-compose.yml # Docker Compose file for Doris
├── mapping/                   # Mapping references (e.g., xlsx to SQL transformation)
├── quiz/                      # Source quiz challenge file (JSON)
├── veloDB/                    # Optional database workspace
├── ddl_mapping.sql            # Doris DDL for Bronze, Silver, and Gold layers
└── README.md                  # Project documentation.

---

## 🛠️ Tech Stack

* **Apache Doris** (Analytical DB)
* **Apache Airflow** (Orchestration)
* **Shell Scripts** (for Stream Load)
* **Docker Compose** (for local setup)
* **Python (Airflow DAGs)**
* **Sql (DML)**

---

### 🔁 Pipeline Overview


### 🧏‍♂️ Bronze Layer

* **Raw data** ingested from `coingecko_grouped_top_1000_tokens.json`
* Loaded to Doris using **STREAM LOAD** from shell scripts
* Stored as-is in normalized JSON tables:

  * `identification`
  * `market_data`
  * `price_change`
  * `metadata`
  * `supply_data`

### 🧏‍⚖ Silver Layer

* Cleaned & flattened data via SQL transformations
* Extracted fields using JSON path
* Combined into one flat table `refined.coingecko_flat`

### 🥇 Gold Layer

* Business Insight Tables:

  * `asset_summary`
  * `price_performance_summary`
  * `supply_metrics`
  * `asset_profile`
* Calculations:

  * Supply Utilization %
  * 24h price change %
  * ATH / ATL comparisons

---

## ⚙️ Airflow Automation

* DAG: `dag_json_to_doris`
* Automates the pipeline: `Bronze → Silver → Gold`
* BashOperator to run shell scripts
* SQLExecuteOperator for transformation queries

---

## 🧪 How to Run

### 1. 🐳 Start Doris & Airflow with Docker

```bash
cd coingecko_pipeline/install/docker_doris
docker-compose up -d

cd coingecko_pipeline/install/docker_airflow
docker-compose up -d
```

### 2. 📟 Set Airflow Variable

```json
{
  "dag_json_to_doris": {
    "shell_path": "/opt/airflow/dags/script"
  }
}
```
```json
{
  "dag_raw_to_refined": {
    "path_dir": "/opt/airflow/dags/sql/silver"
  }
}
```json
{
  "dag_refined_to_business": {
    "path_dir": "/opt/airflow/dags/sql/gold"
  }
}
```

### 3. ▶️ Trigger DAG

* Access Airflow UI at [http://localhost:8080](http://localhost:8080)
* Trigger `dag_json_to_doris`

---

## ✅ Deliverables

* [x] DDLs for Bronze, Silver, Gold
* [x] SQL for transformation and aggregation
* [x] Stream Load Shell Scripts
* [x] DAG to orchestrate full pipeline
* [x] JSON & Mapping file from quiz
* [x] Docker Compose setup for Airflow + Doris
* [x] README.md with instructions

---

## 📊 Sample Insights Produced

| Symbol | Current Price | Market Cap Rank | Supply Utilization (%) |
| ------ | ------------- | --------------- | ---------------------- |
| BTC    | 108,000.00    | 1               | 94.70                  |
| ETH    | 57,000.00     | 2               | 89.20                  |

---


## 👨‍💻 Author

**Reza Septia Kamajaya**

