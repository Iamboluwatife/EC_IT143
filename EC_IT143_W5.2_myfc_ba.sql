/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_myfc_ba.sql
PURPOSE: Answer four analytical questions for the MyFC community dataset

MODIFICATION LOG:
Ver      Date        Author      Description
-----    ----------  ----------- -------------------------------------------------------------------------------
1.0      11/28/2026  BA          1. Built this script for EC IT143 Assignment 5.2

RUNTIME:
1s

NOTES:
Contains 4 questions (3 self-authored, 1 peer-authored), original authors, explanations, and T-SQL queries.
******************************************************************************************************************/

-- Q1: Which team codes and positions generate the highest total monthly player salaries across recorded dates?
-- Author: Boluwatife Ajayi
-- A1: Join tblPlayerFact, tblPlayerDim, tblTeamDim, and tblPositionDim to sum mtd_salary by t_code, p_name, and as_of_date.

SELECT t.t_code
     , p.p_name
     , f.as_of_date
     , SUM(f.mtd_salary) AS total_mtd_salary
  FROM MyFC.dbo.tblPlayerFact AS f
 INNER JOIN MyFC.dbo.tblPlayerDim AS pl
    ON f.pl_id = pl.pl_id
 INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON pl.t_id = t.t_id
 INNER JOIN MyFC.dbo.tblPositionDim AS p
    ON pl.p_id = p.p_id
 GROUP BY t.t_code
        , p.p_name
        , f.as_of_date
 ORDER BY total_mtd_salary DESC
        , f.as_of_date;

-- Q2: How do monthly player salary totals vary across different team divisions over time?
-- Author: Boluwatife Ajayi
-- A2: Join tblPlayerFact, tblPlayerDim, and tblTeamDim to aggregate mtd_salary by team code and as_of_date.

SELECT t.t_code
     , f.as_of_date
     , SUM(f.mtd_salary) AS total_mtd_salary
  FROM MyFC.dbo.tblPlayerFact AS f
 INNER JOIN MyFC.dbo.tblPlayerDim AS pl
    ON f.pl_id = pl.pl_id
 INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON pl.t_id = t.t_id
 GROUP BY t.t_code
        , f.as_of_date
 ORDER BY t.t_code
        , f.as_of_date;

-- Q3: Which individual players earn above-average monthly salaries within their assigned team division?
-- Author: Boluwatife Ajayi
-- A3: Calculate each team's average mtd_salary per date via a window function and return players above that average.

WITH TeamSalaryBenchmarks AS
(
    SELECT pl.pl_id
         , pl.pl_name
         , t.t_code
         , f.as_of_date
         , f.mtd_salary
         , AVG(f.mtd_salary) OVER (PARTITION BY t.t_id, f.as_of_date) AS avg_team_mtd_salary
      FROM MyFC.dbo.tblPlayerFact AS f
     INNER JOIN MyFC.dbo.tblPlayerDim AS pl
        ON f.pl_id = pl.pl_id
     INNER JOIN MyFC.dbo.tblTeamDim AS t
        ON pl.t_id = t.t_id
)
SELECT tsb.pl_id
     , tsb.pl_name
     , tsb.t_code
     , tsb.as_of_date
     , tsb.mtd_salary
     , tsb.avg_team_mtd_salary
  FROM TeamSalaryBenchmarks AS tsb
 WHERE tsb.mtd_salary > tsb.avg_team_mtd_salary
 ORDER BY tsb.as_of_date
        , tsb.t_code
        , tsb.mtd_salary DESC;

-- Q4: Which team has the highest average player salary?
-- Author: Nathaniel Neyor, II
-- A4: Join tblPlayerFact, tblPlayerDim, and tblTeamDim to compute average mtd_salary by t_code and sort descending.

SELECT t.t_code
     , AVG(f.mtd_salary) AS avg_mtd_salary
  FROM MyFC.dbo.tblPlayerFact AS f
 INNER JOIN MyFC.dbo.tblPlayerDim AS pl
    ON f.pl_id = pl.pl_id
 INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON pl.t_id = t.t_id
 GROUP BY t.t_code
 ORDER BY avg_mtd_salary DESC;