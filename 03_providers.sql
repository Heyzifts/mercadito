CREATE TABLE guest.providers
(
    id           INT IDENTITY (1,1)                 NOT NULL
        CONSTRAINT providers_pk
            PRIMARY KEY,
    name         VARCHAR(100)                       NOT NULL,
    phone_number VARCHAR(30),
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at   DATETIME
);
GO;

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Coca-cola', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Pepsi', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Don Julio', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Maseca', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'La rosa', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Gold Star', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Nissin', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Regia', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'Fans', null, DEFAULT, null);

INSERT INTO mercadito.guest.providers (name, phone_number, created_at, updated_at)
VALUES (N'La Costeña', null, DEFAULT, null);

