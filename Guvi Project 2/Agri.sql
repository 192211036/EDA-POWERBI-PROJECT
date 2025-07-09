--Displaying the data
select*from agri_data
--Year-wise Trend of Rice Production Across States (Top 3)
SELECT "Year", "State Name", SUM("RICE PRODUCTION (1000 tons)") AS total_rice_production
FROM "Agri_data"
GROUP BY "Year", "State Name"
HAVING "State Name" IN (
    SELECT "State Name"
    FROM "Agri_data"
    GROUP BY "State Name"
    ORDER BY SUM("RICE PRODUCTION (1000 tons)") DESC
    LIMIT 3
)
ORDER BY "Year", "State Name";

--Top 5 Districts by Wheat Yield Increase Over the Last 5 Years
SELECT 
    "Dist Name", 
    MAX("WHEAT YIELD (Kg per ha)") - MIN("WHEAT YIELD (Kg per ha)") AS yield_increase
FROM "Agri_data"
WHERE "Year" >= (SELECT MAX("Year") FROM "Agri_data") - 5
GROUP BY "Dist Name"
ORDER BY yield_increase DESC
LIMIT 5;
--Yearly Production Growth of Cotton in Top 5 Cotton Producing States
WITH top_states AS (
    SELECT "State Name"
    FROM "Agri_data"
    GROUP BY "State Name"
    ORDER BY SUM("COTTON PRODUCTION (1000 tons)") DESC
    LIMIT 5
)
SELECT "Year", "State Name", SUM("COTTON PRODUCTION (1000 tons)") AS cotton_prod
FROM "Agri_data"
WHERE "State Name" IN (SELECT "State Name" FROM top_states)
GROUP BY "Year", "State Name"
ORDER BY "Year", "State Name";
--Districts with the Highest Groundnut Production in 2020
select "Dist Name","Year",max("GROUNDNUT PRODUCTION (1000 tons)") as highest_production where "Year"=2020
GROUP BY "Dist Name", "State Name"
ORDER BY groundnut_prod DESC
LIMIT 5;
--Annual Average Maize Yield Across All States
SELECT "Year", AVG("MAIZE YIELD (Kg per ha)") AS avg_maize_yield
FROM "Agri_data"
GROUP BY "Year"
ORDER BY "Year";
--Total Area Cultivated for Oilseeds in Each State
SELECT "State Name", SUM("OILSEEDS AREA (1000 ha)") AS total_oil_area
FROM "Agri_data"
GROUP BY "State Name"
ORDER BY total_oil_area DESC;
--Districts with the Highest Rice Yield
SELECT "Dist Name", "State Name", max("RICE YIELD (Kg per ha)") AS highest_rice_yield
FROM "Agri_data"
GROUP BY "Dist Name", "State Name"
ORDER BY highest_rice_yield DESC
LIMIT 10;
--Compare Production of Wheat and Rice for Top 5 States Over 10 Years
WITH top_states AS (
    SELECT "State Name"
    FROM "Agri_data"
    GROUP BY "State Name"
    ORDER BY SUM("RICE PRODUCTION (1000 tons)" + "WHEAT PRODUCTION (1000 tons)") DESC
    LIMIT 5
)
SELECT "Year", "State Name",
       SUM("RICE PRODUCTION (1000 tons)") AS rice_prod,
       SUM("WHEAT PRODUCTION (1000 tons)") AS wheat_prod
FROM "Agri_data"
WHERE "State Name" IN (SELECT "State Name" FROM top_states)
  AND "Year" >= (SELECT MAX("Year") - 10 FROM "Agri_data")
GROUP BY "Year", "State Name"
ORDER BY "Year", "State Name";





