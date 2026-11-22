-- Q: What is the total monthly player salary across recorded dates?

-- A: Let's query MyFC.dbo.tblPlayerFact and sum mtd_salary by as_of_date...

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