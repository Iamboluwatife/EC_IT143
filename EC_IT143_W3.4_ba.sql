--------------------------------------------------------------------------------------------------
-- Name: Boluwatife Ajayi
-- Date: November 2026
-- Course: EC_IT143 Data Analytics
-- Assignment: W3.4 Adventure Works - Create Answers
-- Purpose: Translate 8 user and metadata questions into functional SQL statements using AdventureWorks2022.
-- Runtime Estimate: ~2 seconds
--------------------------------------------------------------------------------------------------

USE AdventureWorks2022;
GO

--------------------------------------------------------------------------------------------------
-- Q1: Business User question — Marginal complexity
-- Author: Boluwatife Ajayi (Self)
-- Question: Which five employees in the company have the highest number of accrued vacation hours?
--------------------------------------------------------------------------------------------------
SELECT TOP 5 BusinessEntityID, JobTitle, VacationHours
FROM HumanResources.Employee
ORDER BY VacationHours DESC;
GO

--------------------------------------------------------------------------------------------------
-- Q2: Business User question — Marginal complexity
-- Author: Francesco Foresta
-- Question: Which sales territory has brought in the most sales so far this year?
--------------------------------------------------------------------------------------------------
SELECT TOP 1 TerritoryID, Name, SalesYTD
FROM Sales.SalesTerritory
ORDER BY SalesYTD DESC;
GO

--------------------------------------------------------------------------------------------------
-- Q3: Business User question — Moderate complexity
-- Author: Boluwatife Ajayi (Self)
-- Question: I want to review our top-performing sales territories. Which three territories generated the highest total sales year-to-date, and what country region code does each belong to?
--------------------------------------------------------------------------------------------------
SELECT TOP 3 t.TerritoryID, t.Name AS TerritoryName, t.SalesYTD, t.CountryRegionCode
FROM Sales.SalesTerritory AS t
ORDER BY t.SalesYTD DESC;
GO

--------------------------------------------------------------------------------------------------
-- Q4: Business User question — Moderate complexity
-- Author: Francesco Foresta
-- Question: HR is planning a team lunch and needs a headcount. Which department currently has the most employees, and how many work there?
--------------------------------------------------------------------------------------------------
SELECT TOP 1 d.Name AS DepartmentName, COUNT(edh.BusinessEntityID) AS EmployeeCount
FROM HumanResources.Department AS d
JOIN HumanResources.EmployeeDepartmentHistory AS edh 
    ON d.DepartmentID = edh.DepartmentID
WHERE edh.EndDate IS NULL -- Active employees only
GROUP BY d.Name
ORDER BY EmployeeCount DESC;
GO

--------------------------------------------------------------------------------------------------
-- Q5: Business User question — Increased complexity
-- Author: Boluwatife Ajayi (Self)
-- Question: I am preparing a quarterly review for our touring bicycle line in 2013. Specifically, I need to evaluate customer demand across different regions. Can you provide a breakdown by territory name showing total units sold, total order count, and total line revenue for touring bikes?
--------------------------------------------------------------------------------------------------
SELECT 
    st.Name AS TerritoryName,
    SUM(sod.OrderQty) AS TotalUnitsSold,
    COUNT(DISTINCT soh.SalesOrderID) AS TotalOrderCount,
    SUM(sod.LineTotal) AS TotalLineRevenue
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
JOIN Production.Product AS p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Touring Bikes'
  AND YEAR(soh.OrderDate) = 2013
GROUP BY st.Name
ORDER BY TotalLineRevenue DESC;
GO

--------------------------------------------------------------------------------------------------
-- Q6: Business User question — Increased complexity
-- Author: Francesco Foresta
-- Question: Marketing is planning next year's holiday campaign and wants to learn from December 2013. Which product subcategory brought in the most revenue that month? I need the subcategory name, units sold, and total revenue.
--------------------------------------------------------------------------------------------------
SELECT TOP 1
    psc.Name AS SubcategoryName,
    SUM(sod.OrderQty) AS UnitsSold,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product AS p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
WHERE soh.OrderDate >= '2013-12-01' AND soh.OrderDate < '2014-01-01'
GROUP BY psc.Name
ORDER BY TotalRevenue DESC;
GO

--------------------------------------------------------------------------------------------------
-- Q7: Metadata question
-- Author: Boluwatife Ajayi (Self)
-- Question: Which tables in the AdventureWorks database contain a column named ModifiedDate, and what is the exact data type assigned to each?
--------------------------------------------------------------------------------------------------
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ModifiedDate'
ORDER BY TABLE_SCHEMA, TABLE_NAME;
GO

--------------------------------------------------------------------------------------------------
-- Q8: Metadata question
-- Author: Francesco Foresta
-- Question: Our new analysts say they feel lost in this database, so I'd like a quick map. Which schema holds the most base tables, and how many?
--------------------------------------------------------------------------------------------------
SELECT TABLE_SCHEMA, COUNT(*) AS BaseTableCount
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
GROUP BY TABLE_SCHEMA
ORDER BY BaseTableCount DESC;
GO
