-- ========================================================
-- Project Title : Analysis using World DB
-- Dataset		   : World Sample Database
-- Author		     : Paskah Sitohang
-- Tool		       : MySQL Workbench
-- Date		       : Thursday, 17 July 2025
-- Description   : Analyze
-- ========================================================

-- ========================================================
-- STEP 1: Load and Review the Database
-- ========================================================
use world;
-- Check NULL in country table
SELECT * FROM country
WHERE Name IS NULL OR Code IS NULL OR Population IS NULL;

-- Check NULL in city table
SELECT * FROM city
WHERE Name IS NULL OR CountryCode IS NULL OR Population IS NULL;

-- Check NULL in countrylanguage table
SELECT * FROM countrylanguage
WHERE CountryCode IS NULL OR Language IS NULL OR Percentage IS NULL;

-- ========================================================
-- STEP 2: Identify the Top 10 Most Populated Countries
-- ========================================================
SELECT
    Name AS Country,
    Continent,
    Population
FROM
    country
ORDER BY
    Population DESC
LIMIT 10;

-- ========================================================
-- STEP 3: Find the Most Spoken Official Languages
-- ========================================================
SELECT
    cl.Language,
    SUM(c.Population) AS Total_Speakers
FROM
    countrylanguage cl
JOIN
    country c ON cl.CountryCode = c.Code
WHERE
    cl.IsOfficial = 'T'
GROUP BY
    cl.Language
ORDER BY
    Total_Speakers DESC
LIMIT 10;

-- ========================================================
-- STEP 4: Compute Total Population by Continent
-- ========================================================
SELECT
    Continent,
    SUM(Population) AS Total_Population
FROM
    country
GROUP BY
    Continent
ORDER BY
    Total_Population DESC;
    
-- ========================================================
-- STEP 5: Find the Largest and Smallest Cities by Population
-- ========================================================
-- Largest city per continent
SELECT
    c.Continent,
    ct.Name AS Largest_City,
    ct.Population AS Largest_Population
FROM
    city ct
JOIN
    country c ON ct.CountryCode = c.Code
WHERE
    (c.Continent, ct.Population) IN (
        SELECT
            c2.Continent,
            MAX(ct2.Population)
        FROM
            city ct2
        JOIN
            country c2 ON ct2.CountryCode = c2.Code
        GROUP BY
            c2.Continent
    )
ORDER BY
    c.Continent;

-- Smallest city per continent
SELECT
    c.Continent,
    ct.Name AS Smallest_City,
    ct.Population AS Smallest_Population
FROM
    city ct
JOIN
    country c ON ct.CountryCode = c.Code
WHERE
    (c.Continent, ct.Population) IN (
        SELECT
            c2.Continent,
            MIN(ct2.Population)
        FROM
            city ct2
        JOIN
            country c2 ON ct2.CountryCode = c2.Code
        GROUP BY
            c2.Continent
    )
ORDER BY
    c.Continent;

-- ========================================================
-- STEP 6: Identify Countries with the Highest and Lowest GDP per Capita
-- ========================================================
-- Filter: only take data with valid GNP and Population
SELECT
    Name AS Country,
    Continent,
    GNP,
    Population,
    ROUND(GNP / Population, 2) AS GDP_Per_Capita
FROM
    country
WHERE
    GNP IS NOT NULL AND Population > 0
ORDER BY
    GDP_Per_Capita DESC
LIMIT 10; -- Highest GDP per capita


-- Lowest GDP per capita
SELECT
    Name AS Country,
    Continent,
    GNP,
    Population,
    ROUND(GNP / Population, 2) AS GDP_Per_Capita
FROM
    country
WHERE
    GNP IS NOT NULL AND Population > 0
ORDER BY
    GDP_Per_Capita ASC
LIMIT 10;

-- ========================================================
-- STEP 7: Analyze Language Diversity by Continent
-- ========================================================
SELECT
    c.Continent,
    COUNT(DISTINCT cl.Language) AS Distinct_Languages
FROM
    country c
JOIN
    countrylanguage cl ON c.Code = cl.CountryCode
GROUP BY
    c.Continent
ORDER BY
    Distinct_Languages DESC;
    
-- ========================================================
-- STEP 8: Investigate the Correlation Between Population Size and Life Expectancy
-- ========================================================
SELECT
    Name AS Country,
    Continent,
    Population,
    LifeExpectancy
FROM
    country
WHERE
    Population IS NOT NULL AND LifeExpectancy IS NOT NULL
ORDER BY
    Population DESC;
    
-- ========================================================
-- END OF PROJECT
-- ========================================================
