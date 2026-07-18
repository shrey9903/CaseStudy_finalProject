USE RegionalSales;

CREATE TABLE Sales(
OrderID INT PRIMARY KEY,
Date DATE,
CustomerID VARCHAR(20),
Region VARCHAR(20),
ProductName VARCHAR(100),
Category VARCHAR(50),
Quantity INT,
UnitPrice DECIMAL(10,2),
TotalAmount DECIMAL(10,2),
OrderStatus VARCHAR(20),
SalesAgent VARCHAR(100)
);

SELECT * FROM Sales LIMIT 10;


SELECT MONTH(Date) AS Month, SUM(TotalAmount) AS TotalSales FROM Sales GROUP BY MONTH(Date) ORDER BY Month;

SELECT Region, ROUND(SUM(CASE WHEN OrderStatus IN ('Cancelled','Returned') THEN 1 ELSE 0 END) *100/COUNT(*),2) AS Percentage
FROM Sales
GROUP BY Region;

SELECT Region, SUM(TotalAmount) AS RevenueLoss
FROM Sales
WHERE OrderStatus IN ('Cancelled','Returned')
GROUP BY Region
ORDER BY RevenueLoss DESC LIMIT 3;

SELECT ProductName, SUM(TotalAmount) AS RevenueLoss FROM Sales
WHERE OrderStatus IN ('Cancelled','Returned')
GROUP BY ProductName
ORDER BY RevenueLoss DESC
LIMIT 3;

SELECT Category, AVG(TotalAmount) FROM Sales GROUP BY Category;

SELECT SalesAgent, SUM(TotalAmount) FROM Sales
WHERE OrderStatus='Completed'
GROUP BY SalesAgent
ORDER BY SUM(TotalAmount) DESC
LIMIT 5;

SELECT Category, SUM(TotalAmount), ROUND(SUM(TotalAmount)*100/(SELECT SUM(TotalAmount) FROM Sales),2)
FROM Sales GROUP BY Category;

SELECT CustomerID, COUNT(*) AS Returns
FROM Sales WHERE OrderStatus='Returned'
GROUP BY CustomerID HAVING COUNT(*)>=3;