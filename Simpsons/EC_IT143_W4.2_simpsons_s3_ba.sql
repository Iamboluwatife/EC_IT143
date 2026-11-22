-- Q: What is the total debit spending by transaction status?

-- A: Let's query Simpsons.dbo.FBS_Viza_Costmo and sum Debit by Status...

SELECT f.Status
     , SUM(f.Debit) AS total_debit
  FROM Simpsons.dbo.FBS_Viza_Costmo AS f
 GROUP BY f.Status
 ORDER BY f.Status;