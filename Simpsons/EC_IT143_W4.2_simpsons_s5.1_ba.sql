-- Q: What is the total debit spending by transaction status?

-- A: Let's query Simpsons.dbo.FBS_Viza_Costmo and sum Debit by Status...

DROP TABLE IF EXISTS dbo.t_simpsons;

SELECT v.Status
     , v.total_debit
  INTO dbo.t_simpsons
  FROM dbo.v_simpsons_load AS v;