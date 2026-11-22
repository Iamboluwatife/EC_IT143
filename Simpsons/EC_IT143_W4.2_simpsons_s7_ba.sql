DROP PROCEDURE IF EXISTS dbo.usp_simpsons_load;
GO

CREATE PROCEDURE dbo.usp_simpsons_load
AS

/*****************************************************************************************************************
NAME:    dbo.usp_simpsons_load
PURPOSE: Simpsons - Load user stored procedure

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

    TRUNCATE TABLE dbo.t_simpsons;

    INSERT INTO dbo.t_simpsons
    SELECT v.Status
         , v.total_debit
      FROM dbo.v_simpsons_load AS v;

    -- 2) Review results

    SELECT t.*
      FROM dbo.t_simpsons AS t
     ORDER BY t.Status;

END;
GO