DROP VIEW IF EXISTS dbo.v_myfc_load;
GO

CREATE VIEW dbo.v_myfc_load
AS

/*****************************************************************************************************************
NAME:    dbo.v_myfc_load
PURPOSE: Create the MyFC - Total monthly player salary load view

MODIFICATION LOG:
Ver      Date        Author      Description
-----    ----------  ----------- -------------------------------------------------------------------------------
1.0      11/22/2026  BA          1. Built this script for EC IT143

RUNTIME:
1s

NOTES:
This script exists to help me learn step 4 of 8 in the Answer Focused Approach for T-SQL Data Manipulation

******************************************************************************************************************/

SELECT f.as_of_date
     , SUM(f.mtd_salary) AS total_mtd_salary
  FROM MyFC.dbo.tblPlayerFact AS f
 GROUP BY f.as_of_date;
GO