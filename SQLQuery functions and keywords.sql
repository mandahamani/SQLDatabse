-- SELECT statement 
SELECT * FROM employees;
SELECT * FROM shops;
SELECT * FROM locations;
SELECT * FROM suppliers;

SELECT employee_id, first_name, last_name
FROM employees

SELECT employee_id, hire_date, salary
FROM employees

---- WHERE clause + AND & OR

-- Select only the employees who make more than 50k
SELECT * 
FROM employees
WHERE salary > 50000

-- Select only the employees who work in Common Grounds coffeeshop
SELECT * FROM employees
Where coffeeshop_id = 1

-- Select all the employees who work in Common Grounds and make more than 50k
SELECT * FROM employees
Where coffeeshop_id = 1 AND salary > 50000

--- Select all employees who work in Common Grounds or make more than 50k
SELECT * FROM employees
Where coffeeshop_id = 1 OR salary > 50000

-- Select all the employees who work in Common Grounds, make more than 50k and are male 
SELECT * 
FROM employees
Where coffeeshop_id = 1 
AND salary > 50000 
AND Gender = 'M'

---- IN, NOT IN, IS NULL, BETWEEN

-- Select all rows from the suppliers table where the supplier is Beans and Barley
SELECT * 
FROM suppliers
WHERE supplier_name = 'Beans and Barley';

-- Select all rows from the suppliers table where the supplier is NOT Beans and Barley
SELECT * 
FROM suppliers
WHERE NOT supplier_name = 'Beans and Barley';

SELECT * 
FROM suppliers
WHERE supplier_name <> 'Beans and Barley';

-- Select all Robusta and Arabica coffee types 
SELECT * 
FROM suppliers
WHERE coffee_type IN ('Robusta', 'Arabica')

SELECT * 
FROM suppliers
WHERE coffee_type = 'Robusta' 
OR coffee_type = 'Arabica';

-- Select all coffee types that are not Robusta or Arabica
SELECT * 
FROM suppliers
WHERE NOT coffee_type = 'Robusta' 
OR coffee_type = 'Arabica';

-- Select all employees with missing email addresses
SELECT *
FROM employees
WHERE email IS NULL;

-- Select all employees whose emails are not missing 
SELECT * 
FROM employees
WHERE NOT email IS NULL;

-- Select all employees who make between 35 k and 50k
SELECT * 
FROM employees
WHERE salary BETWEEN 35000  AND 50000;

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary >= 35000 AND salary <= 50000;


---- ORDER BY, LIMIT, DISTINCT, RENAMING COLUMNS 

-- ORDER BY Salary Ascending
SELECT *
FROM employees
ORDER BY salary;

--- ORDER by Salary Descending
SELECT *
FROM employees
ORDER BY salary DESC;

--- Top 10 highest paid employees (Some Databases such as PostgreSQL use the keyword LIMIT)
SELECT TOP 10 *
FROM coffee.dbo.employees
ORDER BY salary DESC

--- Return all unique coffeeshop ids
SELECT DISTINCT coffeeshop_id
FROM employees

--- Return all unique countries
SELECT DISTINCT Country
FROM locations


--- Renaming columns 
SELECT
    email, 
	email AS email_address, 
	hire_date,
	hire_date AS date_joined,
	salary,
	salary AS pay
FROM employees


----- UPPER, LOWER, LENGTH, TRIM

--- Uppercase first and last names
SELECT
     first_name,
	 UPPER(first_name) AS first_name_upper,
	 last_name,
	 UPPER(last_name) AS  last_name_upper
FROM employees

--- Lowercase first and last names

SELECT
     first_name,
	 LOWER(first_name) AS first_name_lower,
	 last_name,
	 LOWER(last_name) AS  last_name_lower
FROM employees

--- Return the email and the length of emails
SELECT
     email,
	 LEN(email) as email_length
FROM employees

--- TRIM
SELECT 
     LEN('   HELLO   ') AS hello_with_spaces,
	 LEN('HELLO') AS hello_no_spaces,
	 LEN(TRIM('   HELLO   ')) AS hello_trimmed;

----- CONCATENATION, BOOLEAN EXPRESSIONS, WILDCARDS

--- Concatenate first and last names to create full names (For PostgreSQL -> SELECT first_name || ' ' || last_name AS full name) 
SELECT first_name, last_name, first_name + ' ' + last_name AS full_name
FROM employees

---- SUBSTRING, POSITION, COALESCE

-- SUBSTRING
--- Get the email from the 5th character (Microsoft SQL server)

SELECT 
   email,
   SUBSTRING(email, 5, 30) AS substring
FROM employees;

--- Get the email from the 5th character (PostgreSQL)

SELECT 
   email,
   SUBSTRING(email FROM 5)
FROM employees;

--- POSITION
--- Find the position of @ in the email (Microsoft SQL server)

SELECT  
   email, 
   CHARINDEX('@', email) AS Position
FROM employees;

--- Find the position of @ in the email (PostgreSQL)
SELECT 
   email, 
   POSITION('@' IN email)
FROM employees;

---- SUBSTRING & POSITION/CHARINDEX FUNCTION to find email client (Postgre SQL)
SELECT 
   email, 
   SUBSTRING(email FROM POSITION('@' IN email))
FROM employees

-- (Use this syntax so that the result does not include the actual @ sign)
SELECT
   email,
   SUBSTRING(email FROM POSITION('@' IN email) + 1)
FROM employees


--- COALESCE to fill missing emails with custom value 
SELECT
   email,
   COALESCE(email, 'NO EMAIL PROVIDED')
FROM employees


--- MIN, MAX, AVG, SUM, COUNT

-- select minimun salary
SELECT MIN(salary) AS min_salary
FROM employees

-- select maximun salary
SELECT MAX(salary) AS max_salary
FROM employees

-- Select the difference between the maximun and minimum salary

SELECT MAX(salary) - MIN(salary) AS difference_between_salary
FROM employees

--- select the average salary
SELECT AVG(salary)
FROM employees

-- Round average salary to nearest integer
SELECT ROUND(AVG(salary),0)
FROM employees

-- Sum up the salaries
SELECT SUM(salary)
FROM employees;

-- Count the number of entries
SELECT COUNT(*)
FROM employees;

SELECT COUNT (salary)
FROM employees;

SELECT COUNT(email)
FROM employees;


---- GROUP BY & HAVING

--- Return the number of employees for each coffeeshop
SELECT coffeeshop_id, COUNT(employee_id) AS number_of_employees
FROM employees
GROUP BY coffeeshop_id

--- Return the total salaries for each coffeeshop
SELECT coffeeshop_id, SUM(salary) AS total_salaries
FROM employees
GROUP BY coffeeshop_id

-- Return the number of employees, the avg & min & max & total salaries for each coffeeshop 
SELECT 
   coffeeshop_id, 
   COUNT(employee_id) AS number_of_employees, 
   AVG(salary) AS average_salary, 
   MIN(salary) AS min_salary, 
   MAX(Salary) AS Max_salary, 
   SUM(salary) AS total_salary
FROM employees
GROUP BY coffeeshop_id
ORDER BY number_of_employees


SELECT 
   coffeeshop_id, 
   COUNT(*) AS number_of_employees, 
   AVG(salary) AS average_salary, 
   MIN(salary) AS min_salary, 
   MAX(Salary) AS Max_salary, 
   SUM(salary) AS total_salary
FROM employees
GROUP BY coffeeshop_id
ORDER BY number_of_employees

--- HAVING
--- After GROUP BY, return only the coffeeshops with more than 200 employees 

SELECT 
   coffeeshop_id, 
   COUNT(*) AS number_of_employees, 
   AVG(salary) AS average_salary, 
   MIN(salary) AS min_salary, 
   MAX(Salary) AS Max_salary, 
   SUM(salary) AS total_salary
FROM employees
GROUP BY coffeeshop_id
HAVING COUNT (*) > 200
ORDER BY number_of_employees


--- After GROUP BY, return only the coffeeshops with a mimumn salary of less than 10k
SELECT 
   coffeeshop_id, 
   COUNT(*) AS number_of_employees, 
   AVG(salary) AS average_salary, 
   MIN(salary) AS min_salary, 
   MAX(Salary) AS Max_salary, 
   SUM(salary) AS total_salary
FROM employees
GROUP BY coffeeshop_id
HAVING MIN(salary) <10000
ORDER BY number_of_employees


--- CASE, CASE with GROUP BY, and CASE for transposing data 

-- CASE
-- if pay is less than 50k then low pay, otherwise high pay

SELECT
   employee_id,
   first_name,
   last_name,
   salary,
   CASE 
       WHEN salary< 50000 THEN 'low pay'
	   WHEN salary > 50000 THEN 'high pay'
	   ELSE 'no pay' 
	END
FROM employees
ORDER BY salary DESC;

-- if pay is less than 20k then low pay, if between 20-50k inclusicem then medium pay, if over 50k then high pay 
SELECT
   employee_id,
   first_name,
   last_name,
   salary,
   CASE 
       WHEN salary< 20000 THEN 'low pay'
	   WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
	   WHEN salary > 50000 THEN 'high pay'
	   ELSE 'no pay' 
	END
FROM coffee.dbo.employees

--- CASE & GROUP BY
-- Return the count of employees in each pay category (PostgreSQL)
 
SELECT a.pay_category, COUNT(*)
FROM(
     SELECT 
     employee_id,
     first_name,
     last_name,
     salary,
     CASE 
         WHEN salary< 20000 THEN 'low pay'
	     WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
	     WHEN salary > 50000 THEN 'high pay'
	     ELSE 'no pay' 
	  END as pay_category
  FROM coffee.dbo.employees
  ORDER BY salary 
 ) a
GROUP BY a.pay_category;


---- Transpose above (turning rows into columns) 

SELECT 
    SUM(CASE WHEN salary < 20000 THEN 1 ELSE 0 END) AS low_pay,
	SUM(CASE WHEN salary BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS medium_pay,
	SUM(CASE WHEN salary > 50000 THEN 1 ELSE 0 END) AS high_pay
FROM coffee.dbo.employees


---- JOIN & UNIONS

--- Inserting values just for JOIN excercises
INSERT INTO coffee.dbo.locations VALUES (4, 'Paris', 'France');
INSERT INTO coffee.dbo.shops VALUES (6, 'Happy Bew', NULL);

--- Checking values we inserted
SELECT * FROM coffee.dbo.shops
SELECT * FROM coffee.dbo.locations

--- INNER JOIN (inner join and join is the same)
SELECT s.coffeeshop_name, l.city, l.country
FROM coffee.dbo.shops s
INNER JOIN coffee.dbo.locations l
ON s.city_id = l.city_id

SELECT s.coffeeshop_name, l.city, l.country
FROM coffee.dbo.shops s
JOIN coffee.dbo.locations l
ON s.city_id = l.city_id

--- LEFT JOIN

SELECT s.coffeeshop_name, l.city, l.country
FROM coffee.dbo.shops s
LEFT JOIN coffee.dbo.locations l
ON s.city_id = l.city_id

--- RIGHT JOIN

SELECT s.coffeeshop_name, l.city, l.country
FROM coffee.dbo.shops s
RIGHT JOIN coffee.dbo.locations l
ON s.city_id = l.city_id

--- FULL OUTER JOIN

SELECT s.coffeeshop_name, l.city, l.country
FROM coffee.dbo.shops s
FULL OUTER JOIN coffee.dbo.locations l
ON s.city_id = l.city_id

--- Delete the values created for the JOIN Excercises
DELETE FROM coffee.dbo.locations WHERE city_id = 4
DELETE FROM coffee.dbo.shops WHERE coffeeshop_id = 6;


--- UNION (used to stack data on top of eachother - vertically)

--- Return all cities and countries 
SELECT city FROM coffee.dbo.locations
UNION 
SELECT country FROM coffee.dbo.locations;

--- UNION removed duplicares
SELECT country FROM coffee.dbo.locations
UNION 
SELECT country FROM coffee.dbo.locations;

-- UNION ALL keeps duplicates

SELECT country FROM coffee.dbo.locations
UNION ALL
SELECT country FROM coffee.dbo.locations;

--- Return all coffeeshop names, cities and countries
SELECT city FROM coffee.dbo.locations
UNION 
SELECT coffeeshop_name FROM coffee.dbo.shops
UNION 
SELECT country FROM coffee.dbo.locations;


--- SUBQUERIES 
--- Basic subqueries with subqueries in the FROM clause

SELECT * 
FROM (SELECT * FROM coffee.dbo.employees where coffeeshop_id IN (3, 4)) a;

SELECT a.employee_id, a.first_name, a.last_name
FROM (SELECT * FROM coffee.dbo.employees where coffeeshop_id IN (3, 4)) a;

--- Basic subqueries with subquerie n the SELECT clause 
SELECT
    first_name, 
	last_name,
	salary,
	(SELECT MAX(salary) FROM coffee.dbo.employees)
FROM coffee.dbo.employees;


-- (Postgre SQL)
SELECT 
    first_name, 
	last_name,
	salary,
	(SELECT MAX(salary) FROM coffee.dbo.employees LIMIT 1)
FROM coffee.dbo.employees;

SELECT 
    first_name, 
	last_name,
	salary,
	(SELECT ROUND(AVG(salary), 0) FROM coffee.dbo.employees)
FROM coffee.dbo.employees;

-- difference between the employees salary and the avg salary
SELECT 
    first_name, 
	last_name,
	salary,
	salary - (SELECT ROUND(AVG(salary), 0) FROM coffee.dbo.employees)
FROM coffee.dbo.employees;


-- Subqueries in the WHERE clause
---Return all US coffee shops

SELECT * 
FROM coffee.dbo.shops
WHERE city_id IN
    (SELECT city_id 
	FROM coffee.dbo.locations
	WHERE country = 'United States');

--- Return all employees who work in the US coffee shops (two subqueries)

SELECT * 
FROM coffee.dbo.employees
WHERE coffeeshop_id IN
    (
	SELECT coffeeshop_id 
	FROM coffee.dbo.shops
	WHERE city_id IN
	    (SELECT city_id FROM coffee.dbo.locations
		WHERE country = 'United States')
);


--- Return all employees who make over 35k and work in US coffeeshops

SELECT * 
FROM coffee.dbo.employees
WHERE salary > 35000
   AND coffeeshop_id IN
   (
   SELECT coffeeshop_id
   FROM coffee.dbo.shops
   WHERE city_id IN 
       (SELECT city_id FROM coffee.dbo.locations
	   WHERE country = 'United States')
    );























