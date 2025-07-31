# Coingecko Crypto Analytics – Data Pipeline Project

This project builds a full data pipeline using **top-1000 token data from Coingecko**, structured in a modern **Bronze → Silver → Gold** architecture, and orchestrated with **Apache Airflow**.

## Objective

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
│   │   ├── plugins/           # Custom Airflow plugins
│   │   └── docker-compose.yaml # Docker Compose file for Airflow
│   ├── docker_doris/          # Apache Doris setup
│   │   ├── data/              # Doris persistent volume
│   │   │   ├── be/            # Backend node storage
│   │   │   └── fe/            # Frontend node storage
│   │   ├── .env               # Environment variables
│   │   └── docker-compose.yml # Docker Compose file for Doris
├── mapping/                   # Mapping references
├── quiz/                      # Source quiz challenge
├── veloDB/                    # Optional database workspace
├── ddl_mapping.sql            # Doris DDL for Bronze, Silver, and Gold layers
└── README.md                  # Project documentation.
```
---

## 🛠️ Tech Stack

* **Apache Doris** (Analytical DB)
* **Apache Airflow** (Orchestration)
* **Shell Scripts** (for Stream Load)
* **Docker Compose** (for local setup)
* **Python (Airflow DAGs)**
* **SQL (DML)**

---

## Architecture Overview

This project implements a Medallion Architecture using Airflow and Doris.

![Data Pipeline](https://github.com/zareee12/Building-Data-Pipeline-using-Airflow-Doris/blob/main/image/data%20pipeline.jpg?raw=true)

---
### Bronze Layer

* **Raw data** ingested from `coingecko_grouped_top_1000_tokens.json`
* Loaded to Doris using **STREAM LOAD** from shell scripts
* Stored as-is in normalized JSON tables:

  * `identification`
  * `market_data`
  * `price_change`
  * `metadata`
  * `supply_data`

### Silver Layer

* Cleaned & flattened data via SQL transformations
* Extracted fields using JSON path
* Combined into one flat table `refined.coingecko_flat`

### Gold Layer

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
```
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
## Pipeline 
![Bronze Pipeline](https://github.com/zareee12/Building-Data-Pipeline-using-Airflow-Doris/blob/main/image/pipeline%20bronze.jpg)
![Silver Pipeline](https://github.com/zareee12/Building-Data-Pipeline-using-Airflow-Doris/blob/main/image/pipeline%20silver.jpg)
![Gold Pipeline](https://github.com/zareee12/Building-Data-Pipeline-using-Airflow-Doris/blob/main/image/gold%20pipeline.jpg)


## ✅ Business Table Overview
![Gold Pipeline](https://github.com/zareee12/Building-Data-Pipeline-using-Airflow-Doris/blob/main/image/doris.jpeg)

---
## 👨‍💻 Author

**Reza Septia Kamajaya**

