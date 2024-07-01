# US Household Income Data Cleaning

# Start for both tables
SELECT * 
FROM us_project.us_household_income
;

SELECT * 
FROM us_project.us_householdincome_statistics
;

# Altered First Column from `ï»¿id` to `id` in us_householdincome_statistics
ALTER TABLE us_project.us_householdincome_statistics RENAME COLUMN `ï»¿id` TO `id`;


# Verifying if all data was imported
SELECT COUNT(id) 
FROM us_project.us_household_income
;

SELECT COUNT(id) 
FROM us_project.us_householdincome_statistics
;

# Finding duplicate data in us_household_income
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income) duplicates
WHERE row_num > 1
;


# Deleting duplicate data in us_household_income
DELETE FROM us_project.us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
        ) duplicates
	WHERE row_num > 1)
;

# Checking for duplicate data in us_householdincome_statistics
SELECT id, COUNT(id)
FROM us_project.us_householdincome_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

# Checking for spelling or capitalization errors in us_household_income
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1
;


# Updated mispelling and capitalization set to the correct output
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

# Searching for missing or incorrect values from Autauga County in us_project.us_household_income
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

# Updated empty value in Column: Place in  us_project.us_household_income
UPDATE us_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


# Checking for any dirty values in the Type Column in us_project.us_household_income
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type
;


# Updated one of the values to match with the correct value in us_project.us_household_income
UPDATE us_project.us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;


# Checking for missing values in the ALand and AWater Columns in us_project.us_household_income
SELECT ALand, AWater
FROM us_project.us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;