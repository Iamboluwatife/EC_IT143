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

-- (Continue similarly for Q3 through Q8, ensuring all 4 categories are represented)