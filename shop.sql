CREATE DATABASE shop;
use shop;
CREATE TABLE SALES1 (
    Store VARCHAR(20) NOT NULL,
    Week INTEGER NOT NULL,
    Day VARCHAR(20) NOT NULL,
    SalesPerson VARCHAR(20) NOT NULL,
    SalesAmount DECIMAL(6 , 2 ) NOT NULL,
    Month VARCHAR(20) NULL
); 
INSERT INTO  SALES1
(Store, Week, Day, SalesPerson, SalesAmount, Month) 
VALUES 
('London', '2', 'Monday','Frank', CAST(56.25 AS Decimal(6, 2)), 'May'),
('London', '5', 'Tuesday', 'Frank', CAST(74.32 AS Decimal(6, 2)), 'Sep'),
('London', '5', 'Monday', 'Bill', CAST(98.42 AS Decimal(6, 2)), 'Sep'),
('London', '5', 'Saturday', 'Bill', CAST(73.90 AS Decimal(6, 2)),'Dec'),
('London','1', 'Tuesday', 'Josie', CAST(44.27 AS Decimal(6, 2)), 'Sep'),
('Dusseldorf', '4', 'Monday', 'Manfred', CAST(77.00 AS Decimal(6, 2)), 'Jul'),
('Dusseldorf', '3', 'Tuesday', 'Inga', CAST(9.99 AS Decimal(6, 2)), 'Jun'),
('Dusseldorf', '4', 'Wednesday', 'Manfred', CAST(86.81 AS Decimal(6, 2)), 'Jul'),
('London', '6', 'Friday', 'Josie', CAST(74.02 AS Decimal(6, 2)), 'Oct'),
('Dusseldorf', '1', 'Saturday', 'Manfred', CAST(43.11 AS Decimal(6, 2)), 'Apr');


-- Find all sales records (and all columns) that took place in the London store, not in
-- December, but sales concluded by Bill or Frank for the amount higher than £50
SELECT 
    *
FROM
    SALES1
WHERE
    STORE = 'LONDON' AND MONTH <> 'dec'
        AND SalesAmount > 50.00
        AND (SalesPerson = 'BILL'
        OR SalesPerson = 'FRANK');
        
    -- Find out how many sales took place each week (in no particular order)    
SELECT 
	WEEK, COUNT(*)
FROM
    SALES1
GROUP BY WEEK;

-- Find out how many sales took place each week (and present data by week in descending
-- and then in ascending order)

SELECT 
	WEEK, COUNT(*)
FROM
	SALES1
GROUP BY WEEK
ORDER BY COUNT(*) desc;

-- Find out how many sales were recorded each week on different days of the week

SELECT 
	COUNT(*), DAY
FROM
	SALES1
GROUP BY DAY;




-- We need to change salesperson's name Inga to Annette

SET SQL_SAFE_UPDATES = 0;

UPDATE SALES1
SET
	SalesPerson = 'Anette'
WHERE
    SalesPerson = 'Inga';

SET SQL_SAFE_UPDATES = 1;

-- Find out how many sales did Annete do

SELECT
SalesPerson, COUNT(*)
FROM
SALES1
WHERE
SalesPerson = 'Anette';


-- • Find the total sales amount by each person by day

SELECT
DAY, SalesPerson, COUNT(*)
FROM
SALES1
GROUP by SalesPerson;


-- How much (sum) each person sold for the given period

SELECT SUM(SalesAmount) AS 'SalesAmount', SalesPerson
FROM
	SALES1
GROUP by SalesPerson;

-- How much (sum) each person sold for the given period, including the number of sales per
-- person, their average, lowest and highest sale amounts

SELECT SalesPerson,
	SUM(SalesAmount) AS 'SalesAmount',
	AVG(SalesAmount) AS 'Avg_Sale',
	COUNT(SalesAmount) AS 'Num_Sales',
	MAX(SalesAmount) AS 'Highest_Sale',
	MIN(Salesamount) AS 'Lowest_Sale'
FROM
	SALES1
GROUP BY SalesPerson
ORDER BY SalesAmount DESC;

--  Find the total monetary sales amount achieved by each store

SELECT
Store,
SUM(SalesAmount) AS 'SalesAmount'
FROM SALES1

GROUP BY Store;



-- Find the number of sales by each person if they did less than 3 sales for the past period

SELECT
SalesPerson, COUNT(SalesAmount) AS 'Num_Sales' 
FROM
	SALES1
GROUP BY SalesPerson
HAVING COUNT(SalesAmount) < 3;

-- Find the total amount of sales by month where combined total is less than £100



SELECT 
    month, SUM(salesamount) AS 'Total Sales £'
FROM
    SALES1
GROUP BY month
HAVING SUM(salesamount) < 100;
