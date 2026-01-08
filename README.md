# FlexiMart Data Architecture Project

**Student Name:** Pranjal Pramod Shet Narvekar

**Student ID:** bitsom_ba_25071749

**Email:** pranjal.narvekar21@gmail.com

**Date:** 08-01-2026
---
## Project Overview

The project is divided into 3 sections. Part 1 excercises the ETL(Extracation Transformation Loading) of Data. Part 2 is about the NoSQL and Part 3 excercises the Data warehousing concept.

## Repository Structure
├── part1-database-etl/
│   ├── etl_pipeline.ipynb
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   ├── customers_raw.csv
│   ├── products_raw.csv
│   ├── sales_raw.scs
│   ├── Query1-output.png
│   ├── Query2-output.png
│   ├── Query-3-output.png
│   └── fleximartData.db
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
└── README.md

## Technologies Used

- Python 3.x, pandas, numpy,Phonenumbers, sqlalchemy, mysql-connector-python
- MySQL 8.0
- MongoDB 6.0

## Setup Instructions

### Database Setup

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql


### MongoDB Setup

mongosh < part2-nosql/mongodb_operations.js

## Key Learnings

Learnt about documentation and ETL processes, using GIT and VScode in depth. How the real life ETL works and connecting across platforms and language to read and transform data. Drafting Queries to obtain solution to bussiness questions.

## Challenges Faced

1. Seletion of Dimentions for Star schema.
2. Forming logics for Data Tranformation and cleaning.