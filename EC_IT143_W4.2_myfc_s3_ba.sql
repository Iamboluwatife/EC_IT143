-- Q: What is the total monthly player salary across recorded dates?

-- A: Let's query MyFC.dbo.tblPlayerFact and sum mtd_salary by as_of_date...

SELECT f.as_of_date
     , SUM(f.mtd_salary) AS total_mtd_salary
  FROM MyFC.dbo.tblPlayerFact AS f
 GROUP BY f.as_of_date
 ORDER BY f.as_of_date;