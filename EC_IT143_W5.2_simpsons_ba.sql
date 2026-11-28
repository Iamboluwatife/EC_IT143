/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_simpsons_ba.sql
PURPOSE: Answer four analytical questions for the Simpsons community dataset

MODIFICATION LOG:
Ver      Date        Author      Description
-----    ----------  ----------- -------------------------------------------------------------------------------
1.0      11/28/2026  BA          1. Built this script for EC IT143 Assignment 5.2

RUNTIME:
1s

NOTES:
Contains 4 questions (3 self-authored, 1 peer-authored), original authors, explanations, and T-SQL queries.
Note: Family_Data joins to FBS_Viza_Costmo and Planet_Express on member/cardholder name fields where no
shared numeric ID exists across tables.
******************************************************************************************************************/

-- Q1: Which household members have the highest total debit spending across recorded transaction dates?
-- Author: Boluwatife Ajayi
-- A1: Join Family_Data and FBS_Viza_Costmo by member name to sum Debit across Member_ID, Name, and Date.

SELECT fd.Member_ID
     , fd.Name
     , vc.Date
     , SUM(vc.Debit) AS total_debit
  FROM Simpsons.dbo.Family_Data AS fd
 INNER JOIN Simpsons.dbo.FBS_Viza_Costmo AS vc
    ON fd.Name = vc.Member_Name
 GROUP BY fd.Member_ID
        , fd.Name
        , vc.Date
 ORDER BY total_debit DESC
        , vc.Date;

-- Q2: Which spending categories and card accounts account for the largest transaction totals?
-- Author: Boluwatife Ajayi
-- A2: Group Planet_Express records by Category, Account, and Date to sum Amount from highest to lowest.

SELECT pe.Category
     , pe.Account
     , pe.Date
     , SUM(pe.Amount) AS total_amount
  FROM Simpsons.dbo.Planet_Express AS pe
 GROUP BY pe.Category
        , pe.Account
        , pe.Date
 ORDER BY total_amount DESC
        , pe.Date;

-- Q3: How do cleared credit card debits compare against credits for each family member over time?
-- Author: Boluwatife Ajayi
-- A3: Filter FBS_Viza_Costmo where Status = 'Cleared' and sum Debit and Credit by Member_Name and Date.

SELECT vc.Member_Name
     , vc.Status
     , vc.Date
     , SUM(vc.Debit) AS total_debit
     , SUM(vc.Credit) AS total_credit
  FROM Simpsons.dbo.FBS_Viza_Costmo AS vc
 WHERE vc.Status = 'Cleared'
 GROUP BY vc.Member_Name
        , vc.Status
        , vc.Date
 ORDER BY vc.Member_Name
        , vc.Date;

-- Q4: Which employee spent the most money?
-- Author: Beni-serge TIABATANTOU BOUBOTE
-- A4: Join Family_Data with FBS_Viza_Costmo and Planet_Express on member/cardholder name to total spending per employee.

SELECT fd.Member_ID
     , fd.Name
     , fd.Department
     , COALESCE(SUM(vc.Debit), 0) AS total_viza_debit
     , COALESCE(SUM(pe.Amount), 0) AS total_planet_express_amount
     , COALESCE(SUM(vc.Debit), 0) + COALESCE(SUM(pe.Amount), 0) AS total_spent
  FROM Simpsons.dbo.Family_Data AS fd
  LEFT JOIN Simpsons.dbo.FBS_Viza_Costmo AS vc
    ON fd.Name = vc.Member_Name
  LEFT JOIN Simpsons.dbo.Planet_Express AS pe
    ON fd.Name = pe.Card_Member
 GROUP BY fd.Member_ID
        , fd.Name
        , fd.Department
 ORDER BY total_spent DESC
        , fd.Name;