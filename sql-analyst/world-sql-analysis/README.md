
# 🌍 World SQL Analysis Project

This project explores population, language, GDP, and demographic data using the `world.sql` sample database provided by MySQL.

---

## 📊 Objective
Perform exploratory data analysis (EDA) using SQL to extract insights from global country data. The project includes:
- Population statistics
- GDP per capita insights
- Language diversity analysis
- City demographics
- Relationship between population and life expectancy

---

## 🛠️ Tools & Technology
- **Database**: MySQL (world.sql schema)
- **Client**: MySQL Workbench
- **Language**: SQL

---

## 📁 Dataset Structure

**Tables Used:**
- `country`: General data for each country
- `city`: City-level data
- `countrylanguage`: Languages spoken in each country

**Relationships:**
- `city.CountryCode` → `country.Code`
- `countrylanguage.CountryCode` → `country.Code`

---

## 📌 Steps Performed

1. ✅ Load and validate the `world` database
2. ✅ Identify the top 10 most populated countries
3. ✅ Find the most spoken official languages
4. ✅ Compute total population by continent
5. ✅ Determine the largest and smallest cities by continent
6. ✅ Calculate GDP per capita and find countries with highest/lowest
7. ✅ Analyze language diversity by continent
8. ✅ Investigate correlation between population size and life expectancy

---

## 📂 Files Included
- `world_analysis_project.sql` – contains all SQL queries used for analysis
- `world.sql` – the original database schema (not included here, available from MySQL sample DB)

---

## 📎 Author
**Paskah Sitohang**  
[GitHub Profile](https://github.com/paskahsitohang)

---

## 🚀 How to Run
1. Import `world.sql` into your MySQL server
2. Open and execute `world_analysis_project.sql` in MySQL Workbench
3. Review output results per step

---

## 📢 License
This project uses the public sample dataset provided by MySQL and is intended for educational purposes.
