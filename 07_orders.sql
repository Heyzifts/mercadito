CREATE TABLE guest.orders
(
    id             INT IDENTITY (1,1)                    NOT NULL
        CONSTRAINT orders_pk
            PRIMARY KEY,
    client_id      INT
        CONSTRAINT orders_client_id_fk
            REFERENCES guest.clients,
    provider_id    INT
        CONSTRAINT orders_provider_id_fk
            REFERENCES guest.providers,
    payment_method VARCHAR(30) DEFAULT 'EFECTIVO'        NOT NULL,
    created_at     DATETIME    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at     DATETIME
);
GO;

CREATE TABLE guest.order_items
(
    id          INT IDENTITY (1,1) NOT NULL
        CONSTRAINT order_items_pk PRIMARY KEY,
    order_id    INT                NOT NULL
        CONSTRAINT order_items_order_id_fk REFERENCES guest.orders,
    product_id  INT                NOT NULL
        CONSTRAINT order_items_product_id_fk REFERENCES guest.products,
    quantity    SMALLINT           NOT NULL DEFAULT 1,
    unit_price  FLOAT              NOT NULL,
    total_price FLOAT              NOT NULL,
    created_at  DATETIME                    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at  DATETIME
);
GO;

CREATE OR ALTER PROCEDURE guest.sp_create_client_order @client_name varchar(100), @provider_name varchar(100),
                                                       @payment_method varchar(30),
                                                       @order_id INT OUTPUT AS
BEGIN
    INSERT guest.orders (client_id, provider_id, payment_method)
    VALUES ((SELECT id FROM guest.clients WHERE name = @client_name),
            (SELECT id FROM guest.providers WHERE name = @provider_name), @payment_method);

    SET @order_id = (SELECT SCOPE_IDENTITY());

    RETURN;
END;
GO;

CREATE OR ALTER PROCEDURE guest.sp_create_client_order_item @order_id INT, @quantity INT, @product_name varchar(30) AS
BEGIN
    DECLARE @product_id INT;
    DECLARE @product_price FLOAT;

    SELECT @order_id = id FROM orders WHERE id = @order_id;
    SELECT @product_id = id FROM products WHERE name = @product_name;
    SELECT @product_price = sale_price FROM product_prices WHERE product_id = @product_id AND ends_at IS NULL;

    INSERT INTO guest.order_items (order_id, product_id, quantity, unit_price, total_price)
    VALUES (@order_id, @product_id, @quantity, @product_id, @product_price * @quantity)

    RETURN;
END;
GO;
