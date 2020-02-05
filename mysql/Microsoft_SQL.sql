-- # TickerSymbol
SELECT MAX(LEN(TickerSymbol)) FROM StockData;
-- 6

SELECT LEN(TickerSymbol) AS 'Length', COUNT(*) AS 'Count' FROM StockData GROUP BY LEN(TickerSymbol);
-- Length   Count
-- 3        9709
-- 6        2551
-- 4        15093

-- # MySQL
-- My assertion that a varchar(6) would be more accurate
-- char(6)
-- Length   Count   bytes
-- 3        9709    6
-- 6        2551    6
-- 4        15093   6
-- Total            164,118 bytes

-- varchar(6)
-- Length   Count   bytes
-- 3        9709    4
-- 6        2551    7
-- 4        15093   5
-- Total            132,158 bytes

-- # Microsoft SQL
-- My assertion that a varchar(6) would be more accurate
-- char(6)
-- Length   Count   bytes
-- 3        9709    6
-- 6        2551    6
-- 4        15093   6
-- Total            164,118 bytes

-- varchar(6)
-- Length   Count   bytes
-- 3        9709    5
-- 6        2551    8
-- 4        15093   6
-- Total            159,511 bytes

-- # Industry
SELECT MAX(LEN(Industry)) FROM StockData;
-- 17
-- According to this data set varchar(20)
-- A good question to ask is what is possible
-- Perhaps varchar(20) - varchar(30)

SELECT LEN(Industry) AS 'Length', COUNT(*) AS 'Count' FROM StockData GROUP BY LEN(Industry);
-- Length   Count
-- 9        2551
-- 6        4678
-- 7        5031
-- 4        10062
-- 17       5031

-- # Mysql
-- char(30)
-- Length   Count   bytes
-- 9        2551    30
-- 6        4678    30
-- 7        5031    30
-- 4        10062   30
-- 17       5031    30
-- Total            820,590 bytes

-- varchar(30)
-- Length   Count   bytes
-- 9        2551    10
-- 6        4678    7
-- 7        5031    8
-- 4        10062   5
-- 17       5031    18
-- Total            239,372 bytes

-- # Microsoft SQL
-- char(30)
-- Length   Count   bytes
-- 9        2551    30
-- 6        4678    30
-- 7        5031    30
-- 4        10062   30
-- 17       5031    30
-- Total            820,590 bytes

-- varchar(30)
-- Length   Count   bytes
-- 9        2551    11
-- 6        4678    8
-- 7        5031    9
-- 4        10062   6
-- 17       5031    19
-- Total            266,725 bytes

-- #ST_Open 
SELECT ST_Open FROM StockData WHERE RIGHT(ST_Open, 3) != 000;
-- (181 rows)
SELECT COUNT(*) FROM StockData WHERE ST_Open IS NOT NULL;
-- (27353 rows)

-- #ST_High 
SELECT ST_High FROM StockData WHERE RIGHT(ST_High, 3) != 000;
-- (224 rows)
SELECT COUNT(*) FROM StockData WHERE ST_High IS NOT NULL;
-- (27353 rows)

-- #ST_Low 
SELECT ST_Low FROM StockData WHERE RIGHT(ST_Low, 3) != 000;
-- (247 rows)
SELECT COUNT(*) FROM StockData WHERE ST_Low IS NOT NULL;
-- (27353 rows)

-- #ST_Close 
SELECT ST_Close FROM StockData WHERE RIGHT(ST_Close, 3) != 000;
-- (257 rows)
SELECT COUNT(*) FROM StockData WHERE ST_Close IS NOT NULL;
-- (27353 rows)

-- #Volume 
SELECT Volume FROM StockData WHERE RIGHT(Volume, 2) != 00;
-- (0 rows)
SELECT Volume FROM StockData WHERE RIGHT(Volume, 2) = 00;
-- (27353 rows)
SELECT COUNT(*) FROM StockData WHERE Volume IS NOT NULL;
-- (27353 rows)
SELECT MAX(Volume) FROM StockData;
-- (1855410200.00 max)
SELECT MAX(LEN(Volume)) FROM StockData;
-- (13 Length)
-- INT




SELECT MAX(LEN(CompanyName)) 
    FROM CompanyInformation;

SELECT LEN(CompanyName) AS 'Length', COUNT(*) AS 'Count' 
    FROM CompanyInformation 
GROUP BY LEN(CompanyName) ORDER BY LEN(CompanyName);




-- @ Asignment 2
-- TODO: all pics
-- 1. List all columns and all rows from the StockData table.
SELECT * 
    FROM StockData;


-- 2 List 1000 rows of the table to see what the data look like. (On a production server, you would not select the entire table, but a limited number of rows. Otherwise you risk slowing down the server, particularly if the table is very large.)
SELECT TOP 1000 *
    FROM StockData;


-- 3. List the TickerSymbol, Industry, TradeDate and the Volume columns from the StockData table.  List all rows.
SELECT TickerSymbol, Industry, TradeDate, Volume
    FROM StockData;


-- 4. List all company information attributes for companies incorporated in Texas. 
SELECT *
    FROM CompanyInformation
    WHERE [State] = 'TX';


-- 5. List the TickerSymbol, Industry, TradeDate and the Volume columns from the StockData table.  List only the rows that have a volume of more than thirty million shares traded.  Arrange the answer in TickerSymbol order and then in TradeDate order.  This means that for a given stock, trading days should appear in chronological order.
SELECT TickerSymbol, Industry, TradeDate, Volume
    FROM StockData
    WHERE Volume > 30000000
ORDER BY TickerSymbol, TradeDate;


-- 6. List the price ID, opening price, and closing price of all stocks who have an opening price smaller than 120 dollars and a closing price greater than 120 dollars.  List the opening and closing prices in ascending order.
SELECT PriceID, ST_Open, ST_Close
    FROM StockData
    WHERE ST_Open < 120 AND ST_Close > 120
ORDER BY ST_Open, ST_Close;


-- TODO: check with others
-- 7. List the price ID, stock high and stock low of all stocks that have a stock high above 130. Also list the same information for all stocks that have a stock low below 5.  List the high and low stocks by ascending order.
SELECT PriceID, ST_High, ST_Low
    FROM StockData
    WHERE ST_High > 130 OR ST_Low < 5
ORDER BY ST_High, ST_Low;


-- 8. List all rows where any of the stock prices are zero.
SELECT *
    FROM StockData
    WHERE ST_Close = 0 OR ST_Open = 0 OR ST_High = 0 OR ST_Low = 0;


-- 9. Look for missing data by listing any rows in StockData that contain nulls.
SELECT *
    FROM StockData
    WHERE TickerSymbol IS NULL 
        OR Industry IS NULL 
        OR TradeDate IS NULL 
        OR ST_Open IS NULL 
        OR ST_High IS NULL 
        OR ST_Low IS NULL 
        OR ST_Close IS NULL 
        OR Volume IS NULL;


-- 10. List all rows where the high stock price for the day is not at least as high as the low for that day. There should not be any rows where this is the case.
SELECT *
    FROM StockData
    WHERE ST_High < ST_Low;


-- 11. List the TickerSymbol, Industry, TradeDate, the opening stock price and the closing stock price.  List only those trading days that occurred in the year 2018.  Arrange the answer in order of the trade dates which means that for a given stock, trading days should appear in chronological order.
SELECT TickerSymbol, Industry, TradeDate, ST_Open, ST_Close
    FROM StockData
    WHERE YEAR(TradeDate) = 2018
ORDER BY TradeDate;


-- 12. List the TickerSymbol, Industry, TradeDate, the opening stock price and the closing stock price.  List only stocks that include the word "oil" in the industry description.  Arrange the answer in order of the industry, the ticker symbol, and then by the trade dates.
SELECT TickerSymbol, Industry, TradeDate, ST_Open, ST_Close
    FROM StockData
    WHERE Industry LIKE '%oil%'
ORDER BY Industry, TickerSymbol, TradeDate;


-- 13. List all of the ticker symbols containing the letter S.
SELECT TickerSymbol
    FROM StockData
    WHERE TickerSymbol LIKE '%S%';


-- 14. List the TickerSymbol, TradeDate and the closing stock price.  List only Microsoft tuples that occurred between January 1, 2005 and June 1, 2018.  Arrange the answer in order of the ticker symbol, trade dates and then the closing price.
SELECT TickerSymbol, TradeDate, ST_Close
    FROM StockData
    WHERE TickerSymbol = 'MSFT' AND TradeDate BETWEEN 'January 1, 2005' AND 'June 1, 2018' 
ORDER BY TickerSymbol, TradeDate, ST_Close;

    -- other answer
    SELECT TickerSymbol, TradeDate, ST_Close
        FROM StockData
        WHERE TickerSymbol = 'MSFT' AND TradeDate >= 'January 1, 2005' AND TradeDate <= 'June 1, 2018' 
    ORDER BY TickerSymbol, TradeDate, ST_Close;

    -- Examples to make sure it's working
    SELECT TickerSymbol, TradeDate, ST_Close
        FROM StockData
        WHERE TickerSymbol = 'AAPL' AND TradeDate BETWEEN 'January 1, 2005' AND 'June 1, 2018' 
    ORDER BY TickerSymbol, TradeDate, ST_Close;
    -- (3377 rows affected)

    SELECT TickerSymbol, TradeDate, ST_Close
        FROM StockData
        WHERE TickerSymbol = 'AAPL' AND TradeDate >= 'January 1, 2005' AND TradeDate <= 'June 1, 2018' 
    ORDER BY TickerSymbol, TradeDate, ST_Close;
    -- (3377 rows affected)


-- 15. List the trade dates, stock highs and stock lows of all stocks that either had a stock high over 130 dollars and were traded before December 31st, 2014, or stocks that were traded after December 31st, 2018 and had a stock low below 5 dollars.  List the stock highs and lows in descending order.
SELECT TradeDate, ST_High, ST_Low
    FROM StockData
    WHERE (ST_High > 130 AND TradeDate < 'December 31, 2014')
        OR (TradeDate > 'December 31, 2018' AND ST_Low < 5)
ORDER BY ST_High DESC, ST_Low DESC;


-- 16. Return all attributes for stocks that have the MSFT ticker symbol and have a high stock price below 20 dollars or a low stock price above 50 dollars.  List the high and low stock prices in ascending order.
SELECT *
    FROM StockData
    WHERE TickerSymbol = 'MSFT' AND (ST_High < 20 OR ST_Low > 50) 
ORDER BY ST_High, ST_Low;


-- 17. List the Price ID and TradeDate and stock high of all stocks that were traded before October 3rd, 2018 and had a stock high over 125 dollars. List the stock highs in descending order.
SELECT PriceID, TradeDate, ST_High
    FROM StockData
    WHERE TradeDate < 'October 3, 2018' AND ST_High > 125
ORDER BY ST_High DESC;


-- 18. List the trading start date (first date) in StockData table.
SELECT MIN(TradeDate) AS 'Start Date'
    FROM StockData;


-- 19. List the trading start date and end date for each ticker in StockData.
SELECT TickerSymbol, MIN(TradeDate) AS 'Start Date', MAX(TradeDate) AS 'End Date'
    FROM StockData
GROUP BY TickerSymbol;


-- 20. List the sum of all the low stock prices that are above 60 dollars.  Call it TotalLowStockPriceOfStocksUnder60.
SELECT SUM(ST_Low) AS TotalLowStockPriceOfStocksUnder60
    FROM StockData
    WHERE ST_Low > 60;


-- 21. List the earliest trade date of the stock that ended up having a high over 100 dollars.  Call it EarliestTradeDateWithHighOver100.
SELECT MIN(TradeDate) AS EarliestTradeDateWithHighOver100
    FROM StockData
    WHERE ST_High > 100;


-- 22. List each ticker symbol and the average daily trade volume for that stock. Order the list from highest to least daily trade volume.
SELECT TickerSymbol, AVG(CONVERT(bigint, Volume)) AS 'Average Daily'
    FROM StockData
GROUP BY TickerSymbol
ORDER BY 'Average Daily' DESC;


-- 23. List the highest high price of all the stocks that have been traded in 2018 and have a low price less than 100 dollars.
SELECT MAX(ST_High)
    FROM StockData
    WHERE YEAR(TradeDate) = 2018 AND ST_Low < 100;


-- 24. List the number of trade dates of stocks that were traded in the month of August in 2018.
SELECT COUNT(TradeDate) AS 'August 2018 TradeDate Count'
    FROM StockData
    WHERE TradeDate BETWEEN 'August 1, 2018' AND 'August 31, 2018';


-- 25. List the number of stocks that have an opening price of 70 dollars and were traded in 2018.  Call it NumberOfOpeningPricesOf70In2018.
SELECT COUNT(ST_Open) AS NumberOfOpeningPricesOf70In2018
    FROM StockData
    WHERE ST_Open = 70 AND YEAR(TradeDate) = 2018;


-- TODO: check with others
-- ? https://www.w3resource.com/sql/aggregate-functions/count-with-distinct.php
-- 26. List the industry and the number of different companies in each industry.
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS 'Number of Companies'
    FROM StockData
GROUP BY Industry;

    -- Cali's team
    SELECT Industry, COUNT(TickerSymbol) AS 'Number of Companies'
        FROM CompanyInformation
    GROUP BY Industry;

    -- Examples to make sure it's working, testing
    SELECT TickerSymbol
        FROM StockData
        WHERE Industry = 'Food'
    GROUP BY TickerSymbol;
    -- (3 rows affected) 
    SELECT TickerSymbol
        FROM StockData
        WHERE Industry = 'Tech'
    GROUP BY TickerSymbol;
    -- (22 rows affected) 
    SELECT TickerSymbol
        FROM StockData
        WHERE Industry = 'Healthcare'
    GROUP BY TickerSymbol;
    -- (17 rows affected) 


-- 27. List the industry and the number of different companies in each industry. Put the answer in order of most stocks to least stocks.
-- teachers Answer
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS 'Number of stocks'
    FROM StockData
GROUP BY Industry
ORDER BY 'Number of stocks' DESC;

    -- my answer
    SELECT Industry, COUNT(DISTINCT TickerSymbol) AS 'Number of Companies', SUM(CONVERT(bigint, Volume)) AS 'Number of Stocks'
        FROM StockData
    GROUP BY Industry
    ORDER BY 'Number of stocks' DESC;

    -- ? https://stackoverflow.com/questions/2421388/using-group-by-on-multiple-columns


-- 28. List the ten most common closing prices along with the number of times each occurs.
SELECT TOP 10 ST_Close, COUNT(ST_Close) AS 'Number of Occurrences'
    FROM StockData
GROUP BY ST_Close
ORDER BY 'Number of Occurrences' DESC;


-- 29. List the largest single-day stock price increase for Ford (between the market opening and closing).
SELECT MAX(ST_Open - ST_Close) AS 'Greatest Increase Amount'
    FROM StockData
    WHERE TickerSymbol = 'F';
    
    -- Examples to make sure it's working, testing
    SELECT TOP 10 ST_Open, ST_Close, (ST_Open - ST_Close) AS 'Difference'
    FROM StockData;

    SELECT MAX(ST_Open - ST_Close) AS 'Greatest Increase Amount'
    FROM (
        SELECT TOP 10 ST_Open, ST_Close, (ST_Open - ST_Close) AS 'Difference'
            FROM StockData
    ) AS StockData;

    -- ST_Open               ST_Close                 Difference
    -- --------------------- ------------------------ ---------------------------------------
    -- 3.7455360000000       3.9977680000000          -0.2522320000000
    -- 3.8660710000000       3.6607140000000          0.2053570000000
    -- 3.7053570000000       3.7142860000000          -0.0089290000000
    -- 3.7901790000000       3.3928570000000          0.3973220000000
    -- 3.4464290000000       3.5535710000000          -0.1071420000000
    -- 3.6428570000000       3.4910710000000          0.1517860000000
    -- 3.4263390000000       3.3125000000000          0.1138390000000
    -- 3.3928570000000       3.1138390000000          0.2790180000000
    -- 3.3744390000000       3.4553570000000          -0.0809180000000
    -- 3.5714290000000       3.5870540000000          -0.0156250000000

    -- (10 rows affected)

    -- Greatest Increase Amount
    -- ---------------------------------------
    -- 0.3973220000000

    -- (1 row affected)


-- 30. List the lowest opening price for Ford stock in 2015.
SELECT MIN(ST_Open) AS 'Lowest Opening Price For Ford in 2015'
    FROM StockData
    WHERE TickerSymbol = 'F' AND YEAR(TradeDate) = 2015;


-- 31. List the highest closing price for Ford in 2018.
SELECT MAX(ST_Close) AS 'Highest Closing Price For Ford in 2018'
    FROM StockData
    WHERE TickerSymbol = 'F' AND YEAR(TradeDate) = 2018;


-- ? https://www.w3resource.com/sql/aggregate-functions/count-with-distinct.php
-- 32. List the number of days in the table when a trade occurred (when the trade volume for any stock wasn’t zero).
SELECT COUNT(DISTINCT TradeDate) AS "Days Trade Occurred" 
    FROM StockData
    WHERE Volume <> 0;

    -- other queries in the process of getting to the one above
    SELECT COUNT(DISTINCT TradeDate) AS 'Days Trade Occurred'
        FROM StockData
        WHERE Volume > 0
    GROUP BY TradeDate;

    SELECT COUNT(TradeDate) AS 'Days Trade Occurred'
        FROM StockData
        WHERE Volume > 0
    GROUP BY TradeDate;

    SELECT SUM(CountData) AS 'Days Trade Occurred'
    FROM (
        SELECT CONVERT(int, COUNT(DISTINCT TradeDate)) AS CountData
            FROM StockData
            WHERE Volume > 0
        GROUP BY TradeDate
    ) AS StockData;

    SELECT COUNT(DISTINCT TradeDate ) AS "Days Trade Occurred" 
        FROM StockData
        WHERE Volume > 0;


-- 33. List the number of days in the table when a trade occurred (when the trade volume for any stock wasn’t zero) for each ticker symbol.
SELECT TickerSymbol, COUNT(DISTINCT TradeDate ) AS "Days Trade Occurred" 
    FROM StockData
    WHERE Volume <> 0
GROUP BY TickerSymbol;


-- 34. List the 10 Ticker Symbol that have the longest trading history in StockData table.
SELECT TOP 10 TickerSymbol, DATEDIFF(day, MIN(TradeDate), MAX(TradeDate)) AS LongestTradingHistoryInDays
    FROM StockData
GROUP BY TickerSymbol
ORDER BY LongestTradingHistoryInDays DESC;

    -- Cali's Team, needs DESC
    SELECT TOP 10 TickerSymbol
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY MAX(TradeDate)-MIN(TradeDate);


-- TODO: check with others
-- 35. List the industries in alphabetical order and the number of companies in each industry in the table.
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS 'Number of Companies'
    FROM StockData
GROUP BY Industry
ORDER BY Industry;

    -- Cali's Team
    SELECT Industry, COUNT(TickerSymbol)
        FROM CompanyInformation
    GROUP BY Industry
    ORDER BY Industry;


-- 36. Suppose we have a theory that stocks dropped in value after September 11, 2001. List the minimum closing price of Ford stock in September 2001 before September 11.
SELECT MIN(ST_Close) AS 'Minimum Closing Price, Before September 11'
    FROM StockData
    WHERE TickerSymbol = 'F' AND TradeDate BETWEEN 'September 1, 2001' AND 'September 10, 2001';
    -- 18.7600000000000


-- 37. Now list the minimum closing price of Ford stock in September 2001 after September 11.
SELECT MIN(ST_Close) AS 'Minimum Closing Price, After September 11'
    FROM StockData
    WHERE TickerSymbol = 'F' AND TradeDate BETWEEN 'September 12, 2001' AND 'September 30, 2001';
    -- 15.3400000000000

-- 38. List the all the ticker symbols containing the letter S and their average closing price in 2018.
SELECT TickerSymbol, AVG(ST_Close) AS 'Average Closing Price In 2018' 
    FROM StockData
    WHERE TickerSymbol LIKE '%S%' AND YEAR(TradeDate) = 2018
GROUP BY TickerSymbol;

-- ! start here *********************************************************88
-- 39. List the ticker symbols and the average price multiplied by volume for each ticker symbol in 2018. Use the closing price of as the price for the entire day. List the ticker symbol with the highest average price times volume first.
SELECT TickerSymbol, (AVG(ST_Close) * SUM(CONVERT(bigint, Volume))) AS 'Average Closing Price Multiplied By Volume, In 2018' 
    FROM StockData
    WHERE YEAR(TradeDate) = 2018
GROUP BY TickerSymbol
ORDER BY 'Average Closing Price Multiplied By Volume, In 2018' DESC;

-- 40. List the number of times you could have made at least a 10% profit by purchasing stocks at its lowest price for the day and selling the stock at its highest price for the day.
SELECT COUNT(*) AS 'Times You Could Have Made At Least A 10% Profit'
    FROM StockData
    WHERE ((ST_High - ST_Low) / ST_High) >= .1;


-- 41. List the relevant ticker symbols and the number of times you could have made at least a 10% profit on that stock by purchasing the stock at its lowest price for the day and selling the stock at its highest price for the day. List the ticker symbol for which this occurs most frequently first.
SELECT TickerSymbol, COUNT(*) AS 'Times You Could Have Made At Least A 10% Profit'
    FROM StockData
    WHERE ((ST_High - ST_Low) / ST_High) >= .1
GROUP BY TickerSymbol
ORDER BY COUNT(*) DESC;

    -- Teacher
    SELECT TickerSymbol, COUNT(*) AS NumberOfTimes
        FROM StockData
        WHERE ST_High >= (ST_Low * 1.1)
    GROUP BY TickerSymbol
    ORDER BY COUNT(*) DESC;

-- 42. List the relevant ticker symbols and the number of times you could have had at least a 10% loss on that stock by purchasing the stock at its highest price for the day and selling the stock at its lowest price for the day. List the ticker symbol for which this occurs most frequently first.
SELECT TickerSymbol, COUNT(*) AS 'Times You Could Have Lost At Least 10% Profit'
    FROM StockData
    WHERE ((ST_Low - ST_High) / ST_High) >= -0.1
GROUP BY TickerSymbol
ORDER BY COUNT(*) DESC;

-- ? https://www.sqlservertutorial.net/sql-server-basics/sql-server-create-table/
-- 43. Create a Toys table (ToyID, ToyName) and a Colors Table (ColorID, ColorName) and put six tuples(rows) in each table. Use CREATE statements to make the tables.  
CREATE TABLE Toys (
    ToyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ToyName VARCHAR(50)
);

INSERT INTO Toys 
VALUES ('Buzz Lightyear'),('Sheriff Woody'),('Jessie'),('Bo Peep'),('Mr. Potato Head'),('Rex');

CREATE TABLE Colors (
    ColorID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ColorName VARCHAR(50)
); 

INSERT INTO Colors 
    VALUES ('Red'),('Yellow'),('Blue'),('Purple'),('Green'),('Gray');

-- 44. Add a new row to the Stock Data table.  This stock should have the Microsoft ticker symbol (MSFT) in the Tech Industry.  The stock was traded on May 5, 2017.  It had an opening price of 68.90, a high price of 69.03, a low price of 68.48, a closing price of 69, and a volume of 19,128,782.
INSERT INTO StockData (TickerSymbol, Industry, TradeDate, ST_Open, ST_High, ST_Low, ST_Close, Volume)
    VALUES ('MSFT', 'Tech', 'May 5, 2017', 68.90, 69.03, 68.48, 69, 19128782);

    -- Teachers Answer
    INSERT INTO StockData 
        VALUES ('MSFT', 'Tech', 'May 5, 2017', 68.90, 69.03, 68.48, 69, 19128782);


-- 45. It’s January 30, 2017 and you need to add information to the Stock Data table for Microsoft on that date.  You have to wait until the end of the day before you can put any of the prices because you don't know the closing price yet.  For now just add Microsoft's trade date, Industry, and ticker symbol to the table.
INSERT INTO StockData (TickerSymbol, Industry, TradeDate)
    VALUES ('MSFT', 'Tech', '1/30/2017');

-- 46. Remove all the rows of stocks that were traded before January 1st, 2001 for Microsoft.
DELETE 
FROM StockData
    WHERE TickerSymbol = 'MSFT' AND TradeDate < 'January 1, 2001';

    -- Teachers Answer
    DELETE 
    FROM StockData
        WHERE TradeDate < '1/1/2001' AND TickerSymbol = 'MSFT';

-- 47. Remove all the rows of stocks of Microsoft that were traded during the month of October in the year 2018.
DELETE FROM StockData
    WHERE TickerSymbol = 'MSFT' AND YEAR(TradeDate) = 2018 AND MONTH(TradeDate) = 10;

-- 48 (check)
UPDATE StockData
SET ST_Open = 55.1,
    ST_High = 56.26,
    ST_Low = 55.55,
    ST_Close = 55.95,
    Volume = 24298620
    WHERE TradeDate = '4//1/2018' AND TickerSymbol = 'MSFT';

-- 49. Set any opening stock prices that are zero to null.
UPDATE StockData
SET ST_Open = NULL
    WHERE ST_Open = 0;

-- 50. Any suggestions for this assignment?
-- Nope










-- Oil and Gas
    -- Team Names
        -- Russell Moore
        -- Matt Cheney
        -- Dylan Jensen
-- 5.
CREATE TABLE SpotPrices( TradeDate DATETIME NOT NULL PRIMARY KEY, BCSpotPrice DECIMAL(21,13),WTISpotPrice DECIMAL(21,13));
-- 7.
INSERT INTO SpotPrices (TradeDate)
SELECT observation_date
    FROM Brent;
-- 8.
UPDATE SpotPrices
SET BCSpotPrice = bc.DCOILBRENTEU
FROM Brent AS bc JOIN SpotPrices AS sp ON 
    (bc.observation_date = sp.TradeDate);
-- 9.
UPDATE SpotPrices
SET WTISpotPrice = WTI.DCOILWTICO
FROM WTI JOIN SpotPrices AS sp ON 
    (WTI.observation_date = sp.TradeDate);
-- 10.
SELECT MAX(BCSpotPrice) AS BrentCrude, MAX(WTISpotPrice) AS WTI
    FROM SpotPrices;
-- 11.