DROP TABLE IF EXISTS dbo.t_simpsons;
GO

CREATE TABLE dbo.t_simpsons
(
    Status     VARCHAR(50)    NOT NULL,
    total_debit DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT PK_t_simpsons PRIMARY KEY CLUSTERED (Status ASC)
);
GO