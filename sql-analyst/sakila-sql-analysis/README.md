# Sakila Film Rental Analysis Project

A complete SQL data analysis project based on the **Sakila** sample database using **MySQL Workbench**, aimed at uncovering customer behavior, rental trends, revenue performance, and potential losses from late returns.

---

## Project Overview

- **Database**: [Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/)
- **Tool**: MySQL Workbench
- **Language**: SQL (MySQL)
- **Author**: Paskah Sitohang
- **Objective**: Perform multi-dimensional analysis on movie rental data

---

## 📈 Analysis Steps

### ✅ 1. Analyze Film Popularity
- Total rentals/film and genre
- Rank films and genres by rental frequency

### ✅ 2. Evaluate Customer Behavior
- Total rentals and revenue/customer
- Customer segmentation into **High**, **Medium**, and **Low** spender categories using `CASE`

### ✅ 3. Analyze Rental Trends
- Rentals grouped by **month** and **year**
- Identify **peak rental periods**
- Calculate revenue/time period

### ✅ 4. Calculate Revenue
- Revenue :
  - Film
  - Genre
  - Store
  - Staff
- Ranked by highest revenue performance

### ✅ 5. Assess Late Returns
- Calculate rental duration/transaction
- Identify **late returns** (actual duration > allowed rental period)
- Estimate **potential late fee loss**

---
