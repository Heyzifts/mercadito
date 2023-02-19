CREATE DATABASE mercadito;
GO;

USE mercadito;
GO;

CREATE TABLE guest.employees
(
    id           INT IDENTITY (1,1) NOT NULL
        CONSTRAINT employees_pk
            PRIMARY KEY,
    name         VARCHAR(100)       NOT NULL,
    phone_number VARCHAR(30),
    created_at   DATETIME           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME
);
GO;

INSERT INTO mercadito.guest.employees (name, phone_number, created_at, updated_at)
VALUES (N'Pepito', null, DEFAULT, null);

INSERT INTO mercadito.guest.employees (name, phone_number, created_at, updated_at)
VALUES (N'Juan', null, DEFAULT, null);

INSERT INTO mercadito.guest.employees (name, phone_number, created_at, updated_at)
VALUES (N'Ramon', null, DEFAULT, null);