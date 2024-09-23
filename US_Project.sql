create database if not exists US_project;
use US_project;

SELECT * FROM us_household_income;

# ---------------------- Data cleaning and standardization  ----------------------

# identifying duplicates values
SELECT 
    id, COUNT(id)
FROM
    us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

# remove the duplicates 
DELETE FROM us_household_income
	WHERE row_id IN (SELECT row_id FROM 
(SELECT row_id,
	id,
	ROW_NUMBER() OVER(PARTITION BY id) AS row_num
 FROM us_household_income) AS row_table
	WHERE row_num > 1);

# count the occurrences of each state to identify any state names that are not capitalized correctly or are misspelled
SELECT 
    state_name, COUNT(state_name)
FROM
    us_household_income
GROUP BY state_name;

# correct the misspelled state name 
UPDATE us_household_income
SET 
    state_name = 'Georgia'
WHERE
    state_name = 'georia';








