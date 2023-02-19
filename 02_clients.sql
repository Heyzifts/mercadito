CREATE TABLE guest.clients
(
    id                  INT IDENTITY (1,1)                 NOT NULL
        CONSTRAINT clients_pk
            PRIMARY KEY,
    name                VARCHAR(100)                       NOT NULL,
    phone_number        VARCHAR(30),
    amount_credit_limit FLOAT    DEFAULT 200               NOT NULL,
    created_at          DATETIME default CURRENT_TIMESTAMP NOT NULL,
    updated_at          DATETIME
);
GO;

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Hernan', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Melvin', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Heyzi', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Fernando', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Julisa', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Erick', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Jared', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Genji', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Pepito', null, DEFAULT, DEFAULT, null);

INSERT INTO mercadito.guest.clients (name, phone_number, amount_credit_limit, created_at, updated_at)
VALUES (N'Pedro', null, DEFAULT, DEFAULT, null);
