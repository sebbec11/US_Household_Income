# US Household Income Exploratory Data Analysis


# Start
SELECT * 
FROM us_project.us_household_income
;

SELECT * 
FROM us_project.us_householdincome_statistics
;

# Queried to find the top 10 states with the most land and the top 10 states with the most water
SELECT State_Name, SUM(ALand)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

SELECT State_Name, SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;


# Joining both us_project.us_household_income and us_project.us_householdincome_statistics us to find deeper insights
SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
;

# Filtered out any values that were equal to zero for better analysis
SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
WHERE Mean != 0
;


# Quering the top 10 states with the highest and lowest Average Income
SELECT  u.State_Name,ROUND(AVG(us.Mean)) AS Mean
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;

SELECT  u.State_Name,ROUND(AVG(us.Mean)) AS Mean
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY u.State_Name
ORDER BY 2 
LIMIT 10
;


# Quering the average income by type of living
SELECT u.Type, ROUND(AVG(us.Mean)) AS Mean
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY u.Type
ORDER BY 2 
;


# Quering the top 10 highest and lowest average income by State, County, and City
SELECT u.State_Name ,County, u.City, us.Mean
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
WHERE Mean != 0
ORDER BY 4 DESC
LIMIT 10
;

SELECT u.State_Name ,County, u.City, us.Mean
FROM us_project.us_household_income u
INNER JOIN us_project.us_householdincome_statistics us
	ON u.id = us.id
WHERE Mean != 0
ORDER BY 4 
LIMIT 10
;