# 📊 Retail Sales Data Analysis & ETL

## 📌 Project Overview

This project demonstrates an end-to-end retail sales data analytics workflow, starting from dataset collection and data preparation in Python and Pandas, followed by loading the processed data into MySQL for structured analysis.

The project focuses on analyzing retail sales performance across different time periods, products, categories, cities, and regions to answer business-oriented questions using SQL.

## 🎯 Business Objective
The objective of this project is to analyze retail order data and identify patterns in sales and profitability that can support business reporting and decision-making.

The analysis focuses on questions such as:

- How do sales change across months and years?
- Which product categories generate the highest revenue?
- Which products contribute the most to sales?
- Which cities generate the highest revenue?
- Which products perform best across different regions?
- How does sales performance change year-over-year?
- Which months generate the highest sales for each category?
- Which sub-categories show the highest profit growth?


## 🔄 Project Workflow
The project follows an end-to-end data analytics workflow:

```text
Kaggle Dataset
      ↓
Dataset Download using Kaggle API
      ↓
Python & Pandas
      ↓
Data Inspection & Preparation
      ↓
Cleaned / Transformed Dataset
      ↓
    MySQL
      ↓
Data Loading & Schema Validation
      ↓
SQL Analysis
      ↓
Business Questions & Insights
```


## 🐍 Python & Pandas — Data Preparation
Python and Pandas were used as the data preparation layer of the project.

The main steps included:

- Downloading the retail orders dataset using the Kaggle API.
- Loading the dataset into Pandas for analysis and preparation.
- Inspecting the dataset structure, columns, and data types.
- Preparing the dataset for database loading.
- Converting relevant columns into appropriate data types before loading the data into MySQL.

This preparation ensured that the dataset was structured appropriately for subsequent SQL-based analysis.


## 🗄️ MySQL — Data Loading & Validation
The prepared retail orders dataset was loaded into MySQL for structured analysis.

The database preparation included:

- Creating and selecting the `retail` database.
- Inspecting the available table structure using `SHOW TABLES` and `DESCRIBE`.
- Reviewing and correcting column data types to ensure they were appropriate for analysis.
- Defining suitable data types for identifiers, dates, text fields, quantities, prices, discounts, and profit.
- Validating the resulting table structure before performing the SQL analysis.

The final MySQL table was structured to support sales, product, category, regional, and profitability analysis.

## 📊 SQL Business Analysis
After loading the prepared dataset into MySQL, SQL was used to perform business-oriented analysis of retail sales performance.

The analysis used:

- Aggregations such as `SUM()` and `COUNT()`
- `GROUP BY` for category, product, city, region, and time-based analysis
- Date functions for monthly and yearly analysis
- CTEs (`WITH`) to structure multi-step queries
- Window functions such as `DENSE_RANK()` for ranking products within regions and identifying top-performing periods
- Conditional logic using `CASE`
- `COALESCE()` to handle missing values during profit-growth calculations

The analysis was designed to answer practical business questions related to sales trends, product performance, geographical performance, year-over-year growth, and profitability.


## 🔍 Business Questions Answered
The SQL analysis answers the following business questions:

1. What are the monthly sales trends across different years?

2. How many unique SKUs are sold within each product category, and what percentage of the total SKUs does each category contribute?

3. Which are the top 10 products by revenue?

4. Which product categories generate the highest revenue?

5. Which cities generate the highest revenue?

6. What are the top 5 highest-selling products within each region?

7. How does monthly sales performance change year-over-year?

8. Which month generates the highest sales for each product category?

9. Which sub-category has achieved the highest profit growth in 2023 compared with 2022?

## 💡 Key Findings
The SQL analysis generated the following key findings:

- **Technology** was the highest-revenue product category, generating approximately **$3.93 million** in revenue, followed by Furniture and Office Supplies.

- **New York City** generated the highest revenue among the analyzed cities, with approximately **$1.22 million** in sales.

- **Office Supplies** contained the largest number of unique SKUs, accounting for approximately **58.16%** of all unique SKUs in the dataset.

- The regional analysis identified the **top 5 highest-selling products within each region**, helping compare product performance across geographical markets.

- Year-over-year analysis was performed to compare monthly sales performance between **2022 and 2023**.

- The highest-sales month differed by category:
  - **Furniture:** August 2023
  - **Office Supplies:** February 2023
  - **Technology:** October 2023

- **Supplies** recorded the highest profit growth among the analyzed sub-categories, with approximately **79.06% growth in 2023 compared with 2022**.


## 🛠️ Technology Stack
| Technology | Purpose |
|---|---|
| **Python** | Dataset acquisition and data preparation |
| **Pandas** | Data inspection and transformation |
| **Kaggle API** | Dataset download |
| **MySQL** | Data storage and SQL-based analysis |
| **SQL** | Business analysis and insight generation |
| **Jupyter Notebook** | Python-based ETL workflow and analysis |
| **Git & GitHub** | Project version control and portfolio management |

## 📁 Project Structure
```text
retail-sales-data-analysis/
│
├── orders.csv
│
├── retail_orders_data_ETL.ipynb
│
├── analysis_of_retail_orders.sql
│
├── README.md
│
└── .gitignore
```

## 🚀 How to Run
### 1. Clone the Repository

```bash
git clone <https://github.com/Siddharth-dataground/retail-sales-data-analysis_python-MySql.git>
cd retail-sales-data-analysis
```
### 2. Install Required Python Libraries
pip install pandas kaggle

### 3. Download the Dataset
Configure the Kaggle API on your system and download the required retail orders dataset.
Alternatively you can download directly from this repo.

### 4. Run the Python ETL Notebook
Note book: retail_orders_data_ETL.ipynb

- Note: If you don't want to use KAGGLE API, then you can skip that part and directly load using pandas

### 5. Load the Prepared Dataset into MySQL
Open the sql script : analysis_of_retail_orders.sql
- Connect to MySQL and execute the required database setup and analysis queries.


## 👨‍💻 About the Project
This project was developed as a practical portfolio project to demonstrate an end-to-end data analytics workflow.

It brings together Python, Pandas, MySQL, and SQL to transform a raw retail dataset into structured business analysis and actionable insights.

The project demonstrates practical skills in:

- Data acquisition
- Data preparation
- ETL workflow
- Database loading
- SQL analysis