-- Q: What is the total debit spending by transaction status?

-- A: Let's query Simpsons.dbo.FBS_Viza_Costmo and sum Debit by Status...

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