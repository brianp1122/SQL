-- RESTAURANT DATABASE SQL PROJECT--

/*Restaurant ratings in Mexico by real consumers from 2012, including additional information about each restaurant and their cuisines, 
  and each consumer and their preferences.

  Consumers 	Consumer_ID					Unique identifier for each consumer
				City	       			    City where the consumer lives
				State	 					State where the consumer lives
				Country						Country where the consumer lives
				Latitude					Latitude where the consumer lives
				Longitude					Longitude where the consumer lives
				Smoker						Whether the consumer smokes or not
				Drink_Level					Whether the consumer is an abstemious, causal, or social drinker
				Transportation_Method		Whether the consumer transports on foot, by public transport, or by car
				Marital_Status				The consumer's marital status (single or married)
				Children					Whether the consumer has dependent/independent children or kids
				Age							The consumer's age
				Occupation					The consumer's occupation (student, employed, or unemployed)
				Budget						The consumer's budget (low, medium, high)
	Consumer_Preferences Preferred_Cuisine	Types of food the consumer prefers
	Ratings		Overall_Rating				The overall rating by the consumer for the restaurant (0=Unsatisfactory, 1=Satisfactory, 2=Highly Satisfactory) 
				Food_Rating					The food's rating by the consumer for the restaurant (0=Unsatisfactory, 1=Satisfactory, 2=Highly Satisfactory) 
				Service_Rating				The service rating by the consumer for the restaurant (0=Unsatisfactory, 1=Satisfactory, 2=Highly Satisfactory) 
                
	Restaurants	Restaurant_ID				Unique identifier for each restaurant
				Name						The restaurant's name
				City						The restaurant's city
				State						The restaurant's state
				Country						The restaurant's country
				Zip_Code					The restaurat's zip code
				Latitude					The restaurant's latitude
				Longitude					The restaurant's longitude
				Alcohol_Service				Whether the restaurant seves no alcohol, wine & beer, or a full bar
				Smoking_Allowed				Whether any smoking is allowed, including in the bar or in smoking sections
				Price						The restaurant's price (low, medium, high)
				Franchise					Whether the restaurant is a franchise
				Area						Whether the restaurant is in an open or closed area
				Parking						Whether the restaurant offers any sort of parking (none, yes, public, valet)
Restaurant_Cuisines	Cuisine					Types of food the restaurant serves*/


-- Create tables for restaurants database and import 

CREATE TABLE consumers (
Consumer_ID VARCHAR (30) PRIMARY KEY,
City VARCHAR (30),
State VARCHAR (30),
Country VARCHAR (30),
Latitude VARCHAR (30),
Longitude VARCHAR (30),
Smoker VARCHAR (5),
Drink_Level VARCHAR (15),
Transportation_Method VARCHAR (20),
Marital_Status VARCHAR (20),
Children VARCHAR (15),
Age INT,
Occupation VARCHAR (20),
Budget VARCHAR (15)
);


CREATE TABLE consumer_preferences (
Record INT PRIMARY KEY,
Consumer_ID VARCHAR (10),
Preferred_Cuisine VARCHAR (20)
);


CREATE TABLE ratings (
Record INT PRIMARY KEY,
Consumer_ID VARCHAR (10),
Restaurant_ID INT,
Overall_Rating INT,
Food_Rating INT,
Service_Rating INT
);


CREATE TABLE restaurant_cuisines (
Record INT PRIMARY KEY,
Restaurant_ID INT,
Cuisine VARCHAR (25)
);


CREATE TABLE restaurants (
Record INT PRIMARY KEY,
Restaurant_ID INT,
Name VARCHAR (52),
City VARCHAR (30),
State VARCHAR (30),
Country VARCHAR (30),
Zip_Code INT,
Latitude VARCHAR (30),
Longitude VARCHAR (30),
Alcohol_Service VARCHAR (30),
Smoking_Allowed VARCHAR (25),
Price VARCHAR (25),
Franchise VARCHAR (25),
Area VARCHAR (25),
Parking VARCHAR (25)
);

-- SELECT table or DROP table

DROP TABLE consumers; 

SELECT *
FROM restaurant_cuisines;

-- Data Cleaning-- 

-- Change blank cells to NULL values:

UPDATE consumers
SET Smoker = NULLIF(Smoker, '');

UPDATE consumers
SET Occupation = NULLIF(Occupation, '');

UPDATE consumers
SET Budget = NULLIF(Budget, '');

UPDATE consumers
SET Children = NULLIF(Children, '');

UPDATE consumers
SET Marital_Status = NULLIF(Marital_Status, '');

UPDATE consumers
SET Transportation_Method = NULLIF(Transportation_Method, '');

-- Change Value "Abstemious" in Drink_Level column to "Does Not Drink" 

UPDATE consumers
SET Drink_Level = 'Does Not Drink'
WHERE Drink_Level = 'Abstemious';

-- Alter Tables. ADD FOREIGN KEY to Consumer_Preferences and Ratings tables to create a constraint on Consumer_ID:

ALTER TABLE Consumer_Preferences
ADD FOREIGN KEY (Consumer_ID) REFERENCES Consumers(Consumer_ID);

ALTER TABLE Ratings
ADD FOREIGN KEY (Consumer_ID) REFERENCES Consumers(Consumer_ID);

-- How many restaurants have 2 or more Cuisines associated with their establishment? 

SELECT *
FROM Restaurant_Cuisines;

SELECT Restaurant_ID,
COUNT(*) 
FROM Restaurant_Cuisines
GROUP BY Restaurant_ID
HAVING COUNT(*) >1;

-- There are 15 restaurants that are listed as having 2 or more cuisines 

-- Are there any duplicate entries for restaurants in the Restaurants table? 

SELECT *
FROM restaurants;

SELECT Name,
COUNT(*) 
FROM Restaurants
GROUP BY Restaurant_ID
HAVING COUNT(*) >1;

-- No,there are no duplicate entries for restaurants 

-- Rename restaurants table to establishments to avoid confusion with restaurants DB name: 

ALTER TABLE restaurants
RENAME establishments;

SELECT *
FROM ratings;

/* 4 questions to answer: 

1. What can you learn from the highest rated restaurants? Do consumer preferences have an effect on ratings?

2. What are the consumer demographics? Does this indicate a bias in the data sample?

3. Are there any demand & supply gaps that you can exploit in the market?

4. If you were to invest in a restaurant, which characteristics would you be looking for? */


-- 1. What can you learn from the highest rated restaurants? Do consumer preferences have an effect on ratings?

SELECT 
ratings.Consumer_ID,
consumer_preferences.preferred_cuisine,
restaurant_cuisines.Restaurant_ID,
restaurant_cuisines.cuisine,
ratings.overall_rating,
ratings.food_rating,
ratings.service_rating
FROM ratings
INNER JOIN restaurant_cuisines
ON ratings.Restaurant_ID = restaurant_cuisines.Restaurant_ID
INNER JOIN consumer_preferences
ON ratings.consumer_ID = consumer_preferences.Consumer_ID
WHERE preferred_cuisine = cuisine
ORDER BY cuisine;

SELECT Cuisine,
COUNT(*)
FROM restaurant_cuisines
GROUP BY cuisine
ORDER BY COUNT(*) desc;

/* QUESTION 1 ANSWER 

The above query pulls consumer id, preferred cuisine, restaurant id, cuisine of the rated restaurant, the 3 ratings. It also only shows where 
consumers preferred cuisine matched the cuisine of the restaruant they visited. Unfortunately, we dont have enough information based on consumer preferences alone 
to determine if preferred cuisine has an effect on ratings.
We would need to run a different kind of test to find significance in the independent variables. */



-- 2. What are the consumer demographics? Does this indicate a bias in the data sample? 

SELECT Consumers.Consumer_ID, Consumers.Country, consumer_preferences.Preferred_Cuisine
FROM Consumers
LEFT JOIN consumer_preferences
ON Consumers.Consumer_ID = Consumer_preferences.Consumer_ID;

SELECT consumer_preferences.Preferred_Cuisine, COUNT(consumer_preferences.Preferred_Cuisine) as 'COUNT_of_Preferred_Cuisine'
FROM consumer_preferences
GROUP BY Preferred_Cuisine
ORDER BY COUNT_of_Preferred_Cuisine desc; 

SELECT COUNT(consumer_preferences.Preferred_Cuisine)
FROM consumer_preferences;

SELECT COUNT(consumers.Consumer_ID)
FROM consumers;


/* QUESTION 2 ANSWER 

The first query above returns a list of each consumers ID, the country they are from, and preferred cuisine. The second query returns a list of the number 
of people who prefer each cuisine. The last query is just getting a total count of the number of preferred cuisine submissions. It is important to note that 
many participants submitted multiple preferred cuisine answers 
The observation is very clear in these queries. There is definitely a bias in the data sample towards Mexican food, which shouldn't be surprising since this 
survey was taken by participants in Mexico.  */


-- 3. Are there any demand & supply gaps that you can exploit in the market?

SELECT *
FROM consumers;

SELECT *
FROM establishments;

SELECT Parking,
COUNT(*)
FROM establishments
GROUP BY Parking;

SELECT Alcohol_Service,
COUNT(*) 
FROM establishments
GROUP BY Alcohol_Service;

SELECT Smoking_Allowed,
COUNT(*) 
FROM establishments
GROUP BY Smoking_Allowed;

SELECT Transportation_Method,
COUNT(*) 
FROM consumers
GROUP BY Transportation_Method;
 
SELECT Smoker,
COUNT(*) 
FROM consumers
GROUP BY Smoker;

SELECT Drink_Level,
COUNT(*) 
FROM consumers
GROUP BY Drink_Level;

/* QUESTION 3 ANSWER

For this question, I looked at some of the variables about the different consumers who were surveyed. I looked at things like parking, drink level and smoker 
and took the count of each of these variables for the list of consumers. I then looked at the count of establishments that offer things like smoking areas, 
alcohol, and parking to see if there was a supply/demand gap for these particular variables. The only gap I could find was that 87 of the 130 establishments 
did not serve alcohol while 87 of the 138 consumers noted that they drank on some level. */


-- 4. If you were to invest in a restaurant, which characteristics would you be looking for?

/* QUESTION 4 ANSWER

The biggest characteristic I would consider first would be consumer preferences. From looking at the data, it was pretty clear that Mexican restaurants 
in Mexico were very popular compared to other cuisines. 97 of the 330 preferred cuisine submissions were Mexican which suggests a Mexican restaurant is a good 
investment. The next thing to consider are consumer preferences outside of cuisine such as drinking, smoking, transportation, etc. This may hold as much influence
as a consumers cuisine preference, but still holds weight when considering how the establishment will be run.*/




	





