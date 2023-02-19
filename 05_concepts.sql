CREATE TABLE guest.concepts
(
    id          INT IDENTITY (1,1)                 NOT NULL
        CONSTRAINT concepts_pk PRIMARY KEY,
    name        VARCHAR(100)                       NOT NULL,
    description VARCHAR(MAX)                       NOT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at  DATETIME
);
GO;


INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'BILL_TO_PAY', N'Para registrar las cuentas por pagar', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'RECEIVABLE', N'Para registrar las cuentas por cobrar', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'CLIENT_ORDER', N'Para registrar las ordenes pagadas de los clientes', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'PROVIDER_ORDER', N'Para registrar los pedidos a los proveedores', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'TELEPHONE_BILL', N'Para registrar los pagos del telefono', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'WATER_BILL', N'para registrar los pagos de agua', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'ELECTRICITY_BILL', N'para registrar los pagos de luz', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'HOUSE_FOOD_BILL', N'usado para registrar los gastos de la comida para la casa', DEFAULT, null);

INSERT INTO mercadito.guest.concepts (name, description, created_at, updated_at)
VALUES (N'MUNIXIPALITY_TAXES', N'para pagar los impuestos a la alcaldia', DEFAULT, null);