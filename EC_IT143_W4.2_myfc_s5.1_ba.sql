-- Q: What is the total monthly player salary across recorded dates?

-- A: Let's query MyFC.dbo.tblPlayerFact and sum mtd_salary by as_of_date...

SELECT v.as_of_date
     , v.total_mtd_salary
  INTO dbo.t_myfc
  FROM dbo.v_myfc_load AS v;