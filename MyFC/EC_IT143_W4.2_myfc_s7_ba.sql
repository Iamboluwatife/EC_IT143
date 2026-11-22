DROP PROCEDURE IF EXISTS dbo.usp_myfc_load;
GO

CREATE PROCEDURE dbo.usp_myfc_load
AS

/*****************************************************************************************************************
NAME:    dbo.usp_myfc_load
PURPOSE: MyFC - Load user stored procedure

MODIFICATION LOG:
Ver      Date        Author      Description
-----    ----------  ----------- -------------------------------------------------------------------------------
1.0      11/22/2026  BA          1. Built this script for EC IT143

RUNTIME:
1s

NOTES:
This script exists to help me learn step 7 of 8 in the Answer Focused Approach for T-SQL Data Manipulation

******************************************************************************************************************/

BEGIN

    -- 1) Reload data

    TRUNCATE TABLE dbo.t_myfc;

    INSERT INTO dbo.t_myfc
    SELECT v.as_of_date
         , v.total_mtd_salary
      FROM dbo.v_myfc_load AS v;

    -- 2) Review results

    SELECT t.*
      FROM dbo.t_myfc AS t
     ORDER BY t.as_of_date;

END;
GO