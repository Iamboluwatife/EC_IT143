USE InterviewDemo55;
GO

WITH RankedDepartmentSalaries AS
(
    SELECT employee_id
         , employee_name
         , department
         , salary
         , DENSE_RANK() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS salary_rank
      FROM dbo.employee_salary
)
SELECT employee_id
     , employee_name
     , department
     , salary
     , salary_rank
  FROM RankedDepartmentSalaries
 WHERE salary_rank <= 3
 ORDER BY department
        , salary_rank
        , employee_name;