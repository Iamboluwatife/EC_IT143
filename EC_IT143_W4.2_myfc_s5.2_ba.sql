DROP TABLE IF EXISTS dbo.t_myfc;
GO

CREATE TABLE dbo.t_myfc
(
    as_of_date       DATE           NOT NULL,
    total_mtd_salary DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT PK_t_myfc PRIMARY KEY CLUSTERED (as_of_date ASC)
);
GO