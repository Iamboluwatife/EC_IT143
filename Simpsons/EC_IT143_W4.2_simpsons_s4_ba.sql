DROP VIEW IF EXISTS dbo.v_simpsons_load;
GO

CREATE VIEW dbo.v_simpsons_load
AS

/*****************************************************************************************************************
NAME:    dbo.v_simpsons_load
PURPOSE: Create the Simpsons - Total debit spending by status load view

MODIFICATION LOG:
Ver      Date        Author      Description
-----    ----------  ----------- -------------------------------------------------------------------------------
1.0      11/22/2026  BA          1. Built this script for EC IT143

RUNTIME:
1s

NOTES:
This script exists to help me learn step 4 of 8 in the Answer Focused Approach for T-SQL Data Manipulation

******************************************************************************************************************/

SELECT f.Status
     , SUM(f.Debit) AS total_debit
  FROM Simpsons.dbo.FBS_Viza_Costmo AS f
 GROUP BY f.Status;
GO