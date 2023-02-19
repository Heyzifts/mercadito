CREATE TABLE guest.products
(
    id          INT IDENTITY (1,1) NOT NULL
        CONSTRAINT products_pk PRIMARY KEY,
    provider_id INT                NOT NULL
        CONSTRAINT products_provider_id_fk REFERENCES guest.providers,
    quantity    SMALLINT           NOT NULL DEFAULT 0,
    name        VARCHAR(256)       NOT NULL,
    description VARCHAR(MAX),
    created_at  DATETIME                    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at  DATETIME
);
GO;

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (1, 10, N'Coca-cola 3 litros', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (2, 15, N'Pepsi 3 litros', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (3, 20, N'Chile en bote', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (4, 30, N'Libra de maseca', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (5, 20, N'Libra de harina', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (6, 30, N'Libra de harina preparada', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (7, 20, N'Sopa de vaso', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (8, 10, N'Salsina pequena', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (9, 12, N'Caja de corn flakes', null, DEFAULT, null);

INSERT INTO mercadito.guest.products (provider_id, quantity, name, description, created_at, updated_at)
VALUES (10, 13, N'Chile jalapeno en bote', null, DEFAULT, null);


CREATE TABLE guest.product_prices
(
    id                 INT IDENTITY (1,1)                 NOT NULL
        CONSTRAINT product_prices_pk PRIMARY KEY,
    product_id         INT                                NOT NULL
        CONSTRAINT product_prices_product_id_fk REFERENCES guest.products,
    begins_at          DATETIME                           NOT NULL,
    ends_at            DATETIME,
    provider_price     FLOAT                              NOT NULL,
    sale_price         FLOAT                              NOT NULL,
    earning_percentage TINYINT,
    created_at         DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at         DATETIME
);
GO;

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (1, N'2023-01-15 22:04:19.000', null, 50, 65, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (2, N'2023-01-15 22:04:19.000', null, 50, 65, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (3, N'2023-01-15 22:04:19.000', null, 10, 15, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (4, N'2023-01-15 22:04:19.000', null, 12, 16, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (5, N'2023-01-15 22:04:19.000', null, 11, 13, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (6, N'2023-01-15 22:04:19.000', null, 13, 16, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (7, N'2023-01-15 22:04:19.000', null, 10, 12, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (8, N'2023-01-15 22:04:19.000', null, 10, 13, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (9, N'2023-01-15 22:04:19.000', null, 30, 40, 30, DEFAULT, null);

INSERT INTO mercadito.guest.product_prices (product_id, begins_at, ends_at, provider_price, sale_price,
                                            earning_percentage, created_at, updated_at)
VALUES (10, N'2023-01-15 22:04:19.000', null, 15, 20, 30, DEFAULT, null);
