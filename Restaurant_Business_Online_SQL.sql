/* Restaurant Business Rankings 2020  

This dataset is in regard to Restaurant Business Rankings from 2020. It takes a look into the business 
results from 2020 with a focus on how the COVID-19 pandemic impacted restaurant's business results for the entire year. 
For this study, we are looking to answer 4 questions in particular: 

1. What are the top 5 most popular cuisine foods found in the Top 250?
2. What are the top 10 Independent Restaurants with the highest customer count? Is there any correlation as it relates to US Region or Sales?
3. How do the Future50 Restaurants compare to the Top250? Is there any indication the Future50 are keeping pace in Sales and 
Growth with the Top 250, or that they can one day become part of the Top250?
4. Take the Average Sales (in Millions) of the Independent100 and Future50 businesses joining the tables on location
(only interested in cities that have both Independent and Future50 locations.) What conclusions can be drawn from the data?
What cities have the highest concentration of Total Average Sales, and is one group of restaurants outperforming the other?

Scroll down to line 305 for responses to questions. 

The data was obtained from https://www.kaggle.com/datasets/michau96/restaurant-business-rankings-2020. */ 

-- Step 1: Create the database-- 
CREATE TABLE Top250(
Ranking INT AUTO_INCREMENT,
Restaurant VARCHAR(50),
Content VARCHAR (425) NULL DEFAULT "NA",
Sales INT,
YOY_Sales VARCHAR (15) NOT NULL,
Units INT,
YOY_Units VARCHAR (15) NOT NULL,
Headquarters VARCHAR (20),
Segment_Category VARCHAR (40),
PRIMARY KEY (Ranking)
);

-- Alter the table to modify the Headquarters column. Set NULL DEFAULT to NA 
ALTER TABLE Top250
MODIFY COLUMN Headquarters VARCHAR (20) NULL DEFAULT "NA";


CREATE TABLE Future50(
Ranking INT AUTO_INCREMENT,
Restaurant VARCHAR(50) NOT NULL,
Location VARCHAR (80) NOT NULL,
Sales INT NOT NULL,
YOY_Sales VARCHAR(15) NOT NULL,
Units INT NOT NULL,
YOY_Units VARCHAR(15) NOT NULL,
Unit_Volume INT NOT NULL,
Franchising VARCHAR(5),
PRIMARY KEY (Ranking)
);

-- Update the franchising column to '1's and '0's instead of Yes and No. 
UPDATE Future50
SET Franchising =
	CASE
		WHEN Franchising = "Yes" THEN 1
        WHEN Franchising = "No" THEN 0
        ELSE NULL
	END;
    
CREATE TABLE Independent100(
Ranking INT AUTO_INCREMENT,
Restaurant VARCHAR(50) NOT NULL,
Sales INT NOT NULL,
Average_Check INT NOT NULL,
City VARCHAR (80) NOT NULL,
State VARCHAR (10) NOT NULL,
Meals_Served INT NOT NULL,
PRIMARY KEY (Ranking)
);

-- Fix the State Column and make them all 2 Letter Abbreviations instead of spelled or partially spelled names--
UPDATE Independent100
SET State = 
	CASE
		WHEN State LIKE '%Va.%' THEN 'VA'
        WHEN State LIKE '%Texas%' THEN 'TX'
        WHEN State LIKE '%Tenn%' THEN 'TN'
        WHEN State LIKE '%Pa%' THEN 'PA'
        WHEN State LIKE '%Ore%' THEN 'OR'
        WHEN State LIKE '%Nev%' THEN 'NV'
        WHEN State LIKE '%N.Y.%' THEN 'NY'
        WHEN State LIKE '%N.J.%' THEN 'NJ'
        WHEN State LIKE '%N.C.%' THEN 'NC'
        WHEN State LIKE '%Mich%' THEN "MI"
        WHEN State LIKE '%Mass%' THEN "MA"
        WHEN State LIKE '%Ind%' THEN "IN"
        WHEN State LIKE '%Ill%' THEN "IL"
        WHEN State LIKE '%Ga.%' THEN "GA"
        WHEN State LIKE '%Fla.%' THEN "FL"
        WHEN State LIKE '%D.C.%' THEN "DC"
        WHEN State LIKE '%Colo%' THEN "CO"
        WHEN State LIKE '%Calif%' THEN "CA"
		ELSE 'N/A'
	END;

-- Create a columns for the Average Sales per Meal Served for the Independent100 table
ALTER TABLE Independent100
ADD COLUMN Average_Sales_per_Meal_Served INT;

-- Set the Average Sales per Meal Served calculation
UPDATE Independent100
SET Average_Sales_per_Meal_Served = Sales/Meals_Served;

-- Change the Name of the Sales column to Sales_In_Millions--
ALTER TABLE Future50
CHANGE COLUMN Sales Sales_In_Millions INT; 

-- Add columns for City and State in Future50
ALTER TABLE Future50
ADD COLUMN City VARCHAR(50),
ADD COLUMN State VARCHAR (10);

-- Pull the city name from the Location column and set it as the City column-- 
UPDATE Future50
SET City = SUBSTRING_INDEX(Location, ',', 1);

-- Pull the state name from the Location column and set it as the City column-- 
UPDATE Future50
SET State = SUBSTRING_INDEX(Location, ',', -1);

-- Extract the abbreviation of each Location. Use a two letter abbreviation based on the given state-- 
UPDATE Future50
SET State = 
	CASE
		WHEN State LIKE '%Calif%' THEN 'CA'
        WHEN State LIKE '%N.J.%' THEN 'NJ'
        WHEN State LIKE '%Ariz%' THEN 'AZ'
        WHEN State LIKE '%Ark%' THEN 'AR'
        WHEN State LIKE '%Colo%' THEN 'CO'
        WHEN State LIKE '%D.C.%' THEN 'DC'
        WHEN State LIKE '%Fla%' THEN 'FL'
        WHEN State LIKE '%Ga%' THEN 'GA'
        WHEN State LIKE '%Ky%' THEN 'KY'
        WHEN State LIKE '%Mo%' THEN 'MO'
        WHEN State LIKE '%N.C.%' THEN 'NC'
        WHEN State LIKE '%N.J.%' THEN 'NJ'
        WHEN State LIKE '%N.Y.%' THEN 'NY'
        WHEN State LIKE '%Neb%' THEN 'NV'
        WHEN State LIKE '%Ohio%' THEN 'OH'
        WHEN State LIKE '%Ore%' THEN 'OR'
        WHEN State LIKE '%Pa.%' THEN 'PA'
        WHEN State LIKE '%S.C.%' THEN 'SC'
        WHEN State LIKE '%Tenn.%' THEN 'TN'
        WHEN State LIKE '%Texas%' THEN 'TX'
        WHEN State LIKE '%Va.%' THEN 'VA'
        WHEN State LIKE '%Wash.%' THEN 'WA'
        ELSE 'N/A'
	END;
    
-- Move the column locations of City and State in the table--     
ALTER TABLE Future50
MODIFY COLUMN City VARCHAR(50) AFTER Restaurant,
MODIFY COLUMN State VARCHAR(10) AFTER City; 

-- Change the name of the Units column-- 
ALTER TABLE Future50
CHANGE COLUMN Units Units_In_Millions INT;

-- Change the name of the Units_Sold_In_Millions column-- 
ALTER TABLE Future50
CHANGE COLUMN Units_Sold_In_Millions Total_Establishments INT;

-- Change the name of YOY_Units_Sold --
ALTER TABLE Future50
CHANGE COLUMN YOY_Units_Sold YOY_Establishments VARCHAR(15);


-- Change Establishments Column to an INT data type-- 
ALTER TABLE Top250
CHANGE COLUMN Establishments Establishments INT;

-- Change YOY_Units to YOY_Establishments-- 
ALTER TABLE Top250
CHANGE COLUMN YOY_Units YOY_Establishments VARCHAR(50);

-- Add City and State columns to the Top250 Table, same as before.-- 
ALTER TABLE Top250
ADD COLUMN City VARCHAR(30),
ADD COLUMN State VARCHAR(30);


-- Pull the city name from the Headquarters column and set it as the City column-- 
UPDATE Top250
SET City = SUBSTRING_INDEX(Headquarters, ',', 1);

-- Pull the state name from the Headquarters column and set it as the State column-- 
UPDATE Top250
SET State = SUBSTRING_INDEX(Headquarters, ',', -1);

-- Extract the abbreviation of each State. Use a two letter abbreviation based on the given state-- 
UPDATE Top250
SET State = 
	CASE
		WHEN State LIKE '%Calif%' THEN 'CA'
        WHEN State LIKE '%N.J.%' THEN 'NJ'
        WHEN State LIKE '%Ariz%' THEN 'AZ'
        WHEN State LIKE '%Ark%' THEN 'AR'
        WHEN State LIKE '%Colo%' THEN 'CO'
        WHEN State LIKE '%D.C.%' THEN 'DC'
        WHEN State LIKE '%Fla%' THEN 'FL'
        WHEN State LIKE '%Ga%' THEN 'GA'
        WHEN State LIKE '%Ky%' THEN 'KY'
        WHEN State LIKE '%Mo%' THEN 'MO'
        WHEN State LIKE '%N.C.%' THEN 'NC'
        WHEN State LIKE '%N.J.%' THEN 'NJ'
        WHEN State LIKE '%N.Y.%' THEN 'NY'
        WHEN State LIKE '%Neb%' THEN 'NV'
        WHEN State LIKE '%Ohio%' THEN 'OH'
        WHEN State LIKE '%Ore%' THEN 'OR'
        WHEN State LIKE '%Pa.%' THEN 'PA'
        WHEN State LIKE '%S.C.%' THEN 'SC'
        WHEN State LIKE '%Tenn.%' THEN 'TN'
        WHEN State LIKE '%Texas%' THEN 'TX'
        WHEN State LIKE '%Va.%' THEN 'VA'
        WHEN State LIKE '%Wash.%' THEN 'WA'
        ELSE 'N/A'
	END; 
    
-- Create and Calculate a column for Sales in Millions. Move the column to the slot right behind Sales --
    
    ALTER TABLE Independent100
    ADD COLUMN  Sales_In_Millions INT;
    
    UPDATE Independent100
    SET Sales_In_Millions = Sales/1000000;
    
    ALTER TABLE Independent100
    MODIFY COLUMN Sales_In_Millions INT AFTER Sales;
    
    
-- Create and Calculate a column for Meals served per 100k. Move the column to the slot right behind Meals Served --    
    ALTER TABLE Independent100
    ADD COLUMN Meals_Served_per_100k INT;
    
	UPDATE Independent100
    SET Meals_Served_per_100k = Meals_Served/100000;
    
	ALTER TABLE Independent100
    MODIFY COLUMN Meals_Served_per_100k INT AFTER Meals_Served;
    
-- Move the City column to after restaurant--     
    ALTER TABLE Independent100
    MODIFY COLUMN City VARCHAR(50) AFTER Restaurant;

-- Move the State column to after City--      
	ALTER TABLE Independent100
    MODIFY COLUMN State VARCHAR(50) AFTER City;
    
-- Create similar columns for the other two tables-- 
    ALTER TABLE Top250
    ADD COLUMN Sales_In_Millions INT;
    
    ALTER TABLE Independent100
    ADD COLUMN Meals_Served_Weekly INT;
    
    UPDATE Independent100
    SET Meals_Served_Weekly = Meals_Served/52;
    
    ALTER TABLE Independent100
    MODIFY COLUMN Meals_Served_Weekly INT AFTER Meals_Served;
    
	ALTER TABLE Top250
    CHANGE COLUMN Sales Sales_In_Millions INT; 
    
    ALTER TABLE Top250
    DROP COLUMN Sales_In_Millions;
    
    -- Create a column for the Sales_in_Millions_per_Establishment for Top250 and Future50.  
    
    ALTER TABLE Top250
    ADD COLUMN Sales_Per_Establishment_In_Millions DEC (4,2);
    
    ALTER TABLE Top250
    DROP COLUMN Sales_Per_Establishment_In_Millions;
    
    UPDATE Top250
    SET Sales_Per_Establishment_In_Millions = Sales_In_Millions/Establishments;
    
    ALTER TABLE Top250
    MODIFY COLUMN Sales_Per_Establishment_In_Millions DEC (4,2) AFTER YOY_Establishments;
    
	ALTER TABLE Future50
    ADD COLUMN Sales_Per_Establishment_In_Millions DEC (4,2);
    
    ALTER TABLE Future50
    DROP COLUMN Sales_Per_Establishment_In_Millions;
    
    UPDATE Future50
    SET Sales_Per_Establishment_In_Millions = Sales_In_Millions/Total_Establishments; 
    
    ALTER TABLE Future50
    MODIFY COLUMN Sales_Per_Establishment_In_Millions DEC (4,2) AFTER YOY_Establishments; 
    
-- SELECT * STATEMENTS TO REFERENCE --

SELECT *
FROM Independent100;

SELECT *
FROM Top250;

SELECT *
FROM Future50;

-- 1.  What are the top 5 most popular cuisine foods found in the Top 250?

SELECT Segment_Category, COUNT(*) as Num_Segment_Category
FROM Top250
GROUP BY Segment_Category
ORDER BY Num_Segment_Category DESC
LIMIT 5;

/* Varied Menu leads this list with 22 of the 250 restaurants having this menu. Mexican is 2nd at 14, 
Quick Service & Burger at 13, Family Style 10, and Italian/Pizza at 10 */

/* 2. What are the top 10 Independent Restaurants with the highest customer count? Is there any correlation as it relates to US Region or Sales? */
   
   SELECT Ranking, Restaurant, City, State, Sales, Sales_In_Millions, Meals_Served, Average_Sales_per_Meal_Served
   FROM Independent100 as i
   ORDER BY Meals_Served Desc
   LIMIT 10;
   
   /* For this question, I'm using Meals_Served as a measure of customer count. It isn't perfect because it doesn't capture a distinct customer count,
   but it does capture the number of meals served. For any given visit, a customer will order one meal, which can also be a measure of each visiting customer.
   In this summary, visitors are very likely to be repeat customers, but it still demonstrates the popularity of these businesses. 
   
   Given the data, it appears that 2 of the top 5 businesses serving the most meals are from the Midwest, with Zehnder's of Frankenmuth being the top restaurant. 
   It is only ranked #58 because it's Sales numbers are much lower than others, but it's Meals Served number could also represent customer count and demonstrates
   that it is extremely popular. I believe the Sales Numbers are lower because it's Average Sales per Meal Served is only $17, the lowest of the Top 10 list. One could 
   make the assumption that this is a more casual restaurant than fancy restaurant. It's also interesting to note that the West Coast only had 1 restaurant in the
   top 10 in California. */
   
   /* 3. How do the Future50 Restaurants compare to the Top250? Is there any indication the Future50 are keeping pace in Sales and 
   Growth with the Top 250, or that they can one day become part of the Top250? */
   
   SELECT *
   FROM Future50;
   
   SELECT *
   FROM Top250;
   
   SELECT *
   FROM Independent100;
   
SELECT AVG(YOY_Sales), AVG (YOY_Establishments), AVG(Sales_In_Millions), AVG (Sales_Per_Establishment_In_Millions)
FROM Top250
ORDER BY Ranking
LIMIT 50;
   
/* The top 20% of the Top250 demonstrated about 3% YOY growth in Sales, a 1.26% YOY growth in number of establishments, and $2.56 million in average sales per
establishment. Overall they averaged $12 billion in Sales. */

SELECT AVG(YOY_Sales), AVG (YOY_Establishments), AVG(Sales_In_Millions), AVG (Sales_Per_Establishment_In_Millions)
FROM Future50
ORDER BY Ranking
LIMIT 10;

/* The top 20% of the Future50 demonstrated about 34% YOY growth in Sales, a 27% YOY growth in number of establishments, and $1.43 million in average
sales per establishment. Overall they averaged $33 million in Sales. 

There are some indicators to believe that the Future50 will one day be as successful as the top 20% of the Top250, but that is still a long way off and
there isn't enough information to know for sure. A great indication of potential is in the Sales_Per_Establishment metric, where
the Top250 showed $2.56 million per establishement and the Future50
showed $1.43 million. If the Future50 can continue to grow at 34% YOY or better for the next several years, there is reason to believe that they will  
reach the Top250's Sales per Establishment and there will be plenty of opportunities for investment. */



 /*4. Take the Average Sales (in Millions) of the Independent100 and Future50 businesses joining the tables on location
 (only interested in cities that have both Independent and Future50 locations.) What conclusions can be drawn from the data?
 What cities have the highest concentration of Total Average Sales, and is one group of restaurants outperforming the other?*/ 
 
SELECT Independent100.City, 
AVG(Independent100.Sales_In_Millions) AS 'Avg Ind Sales (in Millions)', 
AVG(Future50.Sales_In_Millions) AS 'Avg Future50 Sales (in Millions)'
FROM Independent100
INNER JOIN Future50
ON Independent100.City = Future50.City
GROUP BY City;

/* The top 6 cities where both Independent and Future50 restaurants exist are New York, Washington, Los Angeles, Atlanta, San Francisco, and Denver.
New York. It is also apparent that Future50 establishments are considerably outperforming Independent restaurants across the board. */
 