/* Write a query to retrieve all shoe names and their corresponding prices for men's shoes: */
SELECT Shoe Name, Price
FROM ShoeInformation
WHERE Category = 'Men';

/* Write a query to retrieve the number of different colors available for each category: */
SELECT Category, COUNT(DISTINCT "Color 1", "Color 2", "Color 3", "Color 4", "Color 5") AS "Number of Colors"
FROM SizeColorInformation
GROUP BY Category;

/* Write a query to find the most expensive men's shoe: */
SELECT "Shoe Name", Price
FROM ShoeInformation
WHERE Category = 'Men'
ORDER BY Price DESC
LIMIT 1;

/* Write a query to find the cheapest women's shoe in a specific color (e.g., 'Black'): */
SELECT "Shoe Name", Price
FROM ShoeInformation
WHERE Category = 'Women' AND ("Color 1" = 'Black' OR "Color 2" = 'Black' OR "Color 3" = 'Black' OR "Color 4" = 'Black' OR "Color 5" = 'Black')
ORDER BY Price
LIMIT 1;

/* query to retrieve all shoe names and their corresponding prices for men's shoes: */
SELECT "Shoe Name", Price
FROM ShoeInformation
WHERE Category = 'Men';

/*TABLE-2
Write a query that retrieves the count of sizes for all styles: */
SELECT "Style Code", COUNT(DISTINCT "Size") AS "Count of Sizes"
FROM SizeColorInformation
GROUP BY "Style Code";

/* Write a query to list all styles with their associated colors: */
SELECT DISTINCT "Style Code", "Color 1", "Color 2", "Color 3", "Color 4", "Color 5"
FROM SizeColorInformation;

/* Write a query to find styles that have more than one color: */
SELECT "Style Code"
FROM SizeColorInformation
GROUP BY "Style Code"
HAVING COUNT(DISTINCT "Color 1", "Color 2", "Color 3", "Color 4", "Color 5") > 1;

/* query to find the count of sizes available for each color for a specific style code: */
SELECT "Style Code", "Color", COUNT(DISTINCT "Size") AS "Count of Sizes"
FROM SizeColorInformation
WHERE "Style Code" = 'your_specific_style_code'
GROUP BY "Style Code", "Color";

/* query to find styles that have a specific color: */
SELECT DISTINCT "Style Code"
FROM SizeColorInformation
WHERE "Color 1" = 'your_specific_color'
   OR "Color 2" = 'your_specific_color'
   OR "Color 3" = 'your_specific_color'
   OR "Color 4" = 'your_specific_color'
   OR "Color 5" = 'your_specific_color';

/* query that calculates the average comfort rating for a specific product based on its reviews: */
SELECT "Product Code", AVG("Comfort") AS "Average Comfort Rating"
FROM Reviews
WHERE "Product Code" = 'your_specific_product_code'
GROUP BY "Product Code";

/* query to retrieve products with high star ratings (e.g., 4 stars or above): */
SELECT "Product Code", "Product Name", "Star Rating"
FROM Reviews
WHERE "Star Rating" >= 4;

/* query that counts the number of reviews for each product: */
SELECT "Product Code", COUNT(*) AS "Number of Reviews"
FROM Reviews
GROUP BY "Product Code";

/* query to retrieve products that have a quantified durability/quality/performance rating above a certain threshold (e.g., above 7): */
SELECT "Product Code", "Product Name", "Durability/Quality/Performance"
FROM Reviews
WHERE "Durability/Quality/Performance" > 7;

/* query that calculates the average comfort rating for each size: */
SELECT "Size", AVG("Comfort") AS "Average Comfort Rating"
FROM Reviews
GROUP BY "Size";

/* SQL Join Queries using all 3 tables */
/* query that finds the top-rated men's shoes along with their sizes from "Table1" and "Table3": */
SELECT ShoeInformation."Shoe Name", t3."Size", t3."Star Rating"
FROM Table1 ShoeInformation
JOIN Table3 t3 ON ShoeInformation."Product Code" = t3."Product Code"
WHERE ShoeInformation."Category" = 'Men'
ORDER BY t3."Star Rating" DESC
LIMIT 1;

/* query that calculates the average comfort rating for each category from "Table1" and "Table3": */
SELECT ShoeInformation."Category", AVG(t3."Comfort") AS "Average Comfort Rating"
FROM Table1 ShoeInformation
JOIN Table3 t3 ON ShoeInformation."Product Code" = t3."Product Code"
GROUP BY ShoeInformation."Category";

/* query that identifies products with a durability/quality/performance rating higher than the average from "Table1" and "Table3": */
SELECT ShoeInformation."Shoe Name", t3."Durability/Quality/Performance"
FROM Table1 ShoeInformation
JOIN Table3 t3 ON ShoeInformation."Product Code" = t3."Product Code"
WHERE t3."Durability/Quality/Performance" > (
    SELECT AVG("Durability/Quality/Performance")
    FROM Table3
);

/*subquery that finds products with comfort ratings above the average comfort rating using "Table1" and "Table3": */
SELECT "Product Code", "Comfort"
FROM Table3
WHERE "Comfort" > (
    SELECT AVG("Comfort")
    FROM Table3
);

/* query that joins Table 1 and Table 2 using the "Style code/Product code" column, allowing you to retrieve shoe information along with product details: */
SELECT ShoeInformation.*, t2.*
FROM Table1 ShoeInformation
JOIN Table2 t2 ON t1."Style code/Product code" = t2."Style code/Product code";

/* query that identifies products with a star rating above the average star rating for their respective size: */
SELECT t3."Product Code", t3."Star Rating", t3."Size"
FROM Table3 t3
WHERE t3."Star Rating" > (
    SELECT AVG("Star Rating")
    FROM Table3
    WHERE t3."Size" = "Size"
);

/* query that finds products with the highest comfort rating in each category: */
WITH RankedComfort AS (
    SELECT
        "Product Code",
        "Category",
        "Comfort",
        ROW_NUMBER() OVER (PARTITION BY "Category" ORDER BY "Comfort" DESC) AS ComfortRank
    FROM Table3
)
SELECT "Product Code", "Category", "Comfort"
FROM RankedComfort
WHERE ComfortRank = 1;






















