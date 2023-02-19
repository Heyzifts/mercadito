CREATE TABLE guest.cashier_account_closing
(
    id               INT IDENTITY (1,1) NOT NULL
        CONSTRAINT cashier_account_closing_pk PRIMARY KEY,
    employee_id      INT
        CONSTRAINT cashier_account_closing_employee_id_fk REFERENCES guest.employees,
    starting_balance FLOAT              NOT NULL,
    closing_balance  FLOAT,
    begins_at        DATETIME           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at        DATETIME,
    note             VARCHAR(MAX),
    created_at       DATETIME                    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at       DATETIME
);
GO;
