CREATE TABLE guest.transactions
(
    id                    INT IDENTITY (1,1) NOT NULL
        CONSTRAINT transactions_pk PRIMARY KEY,
    transaction_parent_id INT,
    client_id             INT
        CONSTRAINT transactions_client_id_fk REFERENCES guest.clients,
    provider_id           INT
        CONSTRAINT transactions_provider_fk REFERENCES guest.providers,
    concept_id            INT                NOT NULL
        CONSTRAINT transactions_concept_id REFERENCES guest.concepts,
    order_id              INT
        CONSTRAINT transactions_order_id REFERENCES guest.orders,
    transaction_state     VARCHAR(50)        NOT NULL DEFAULT 'PENDING',
    notes                 VARCHAR(MAX),
    debit                 FLOAT,
    credit                FLOAT,
    balance               FLOAT              NOT NULL,
    created_at            DATETIME                    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at            DATETIME
);

CREATE OR ALTER PROCEDURE guest.sp_create_transaction_parent @order_id INT, @concept_name varchar(100),
                                                             @notes VARCHAR(MAX),
                                                             @debit FLOAT,
                                                             @credit FLOAT,
                                                             @state varchar(30),
                                                             @parent_id INT,
                                                             @transaction_id INT OUTPUT
AS
BEGIN
    DECLARE @client_id INT;
    DECLARE @provider_id INT;
    DECLARE @concept_id INT;
    DECLARE @previous_balance FLOAT = 0;

    SELECT TOP 1 @previous_balance = balance
    FROM transactions
    WHERE transaction_state = 'COMPLETED'
    ORDER BY created_at DESC;

    IF @concept_name = 'CLIENT_ORDER'
        SET @credit = (SELECT sum(total_price) FROM order_items WHERE order_id = @order_id);

    if @concept_name = 'HOUSE_FOOD_BILL'
        SET @debit = (SELECT sum(total_price) FROM order_items WHERE order_id = @order_id);

    SET @previous_balance += @credit;
    SET @previous_balance -= @debit;

    SELECT @client_id = client_id, @provider_id = provider_id FROM orders WHERE id = @order_id;
    SELECT @concept_id = id FROM concepts WHERE name = @concept_name;

    INSERT INTO guest.transactions (transaction_parent_id, client_id, provider_id, concept_id, order_id,
                                    transaction_state, notes, debit,
                                    credit, balance)
    VALUES (@parent_id, @client_id, @provider_id, @concept_id, @order_id, @state, @notes, @debit, @credit,
            @previous_balance)

    SET @transaction_id = (SELECT SCOPE_IDENTITY());

    RETURN;
END;
GO;
