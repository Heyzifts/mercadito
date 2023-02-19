-- Pepito inicia a vender con el nuevo sistema y registra su entrada
INSERT INTO guest.cashier_account_closing (employee_id, starting_balance, begins_at, note)
VALUES ((SELECT id FROM guest.employees WHERE name = 'Pepito'), 0, CURRENT_TIMESTAMP, 'Primer uso del sistema');
GO;

-- El cliente Hernan llega a la tienda y realiza una orden para comprar una pepsi y una salsina
DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Hernan', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 1, N'Pepsi 3 litros';
EXECUTE guest.sp_create_client_order_item @order_id, 3, N'Salsina pequena';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'CLIENT_ORDER', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;
GO;

-- El cliente Melvin llega luego y pide 5 cocas y 4 libras de maseca
DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Melvin', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 5, N'Coca-cola 3 litros';
EXECUTE guest.sp_create_client_order_item @order_id, 4, N'Libra de maseca';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'CLIENT_ORDER', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;
GO;

-- Luego llega Fernando por 3 sopas de vaso
DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Fernando', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 3, N'Sopa de vaso';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'CLIENT_ORDER', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;
GO;


DECLARE @current_balance FLOAT = (SELECT TOP 1 balance
                                  FROM guest.transactions
                                  WHERE transaction_state = 'COMPLETED'
                                  ORDER BY transactions.created_at DESC);

-- Termina el turno de Pepito con esos 3 clientes, entonces cierra su historial y Juan empieza su turno
UPDATE guest.cashier_account_closing
SET closing_balance = @current_balance,
    closed_at       = CURRENT_TIMESTAMP
WHERE employee_id = (SELECT id FROM guest.employees WHERE name = 'Pepito');

INSERT INTO guest.cashier_account_closing (employee_id, starting_balance, begins_at, note)
VALUES ((SELECT id FROM guest.employees WHERE name = 'Juan'), @current_balance, CURRENT_TIMESTAMP,
        'Segundo turno del dia');
GO;

-- LLega el Erick, el primer cliente de Juan y le comenta si le puede dar credito, y este acepta
DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Erick', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 1, N'Caja de corn flakes';
EXECUTE guest.sp_create_client_order_item @order_id, 2, N'Chile jalapeno en bote';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'RECEIVABLE', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;
GO;

-- Llega otro cliente para Juan
DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Jared', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 5, N'Libra de harina';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'CLIENT_ORDER', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;
GO;

-- horas despues vuelve Erick para hacer un abono de 10lps del credito que obtuvo mas temprano

DECLARE @transaction_id INT, @order_id INT;
SELECT TOP 1 @transaction_id = id, @order_id = order_id
FROM guest.transactions
WHERE concept_id = (SELECT id FROM guest.concepts WHERE name = 'RECEIVABLE')
  AND client_id = (SELECT id FROM guest.clients WHERE name = 'Erick')
  AND credit = 0
ORDER BY created_at DESC;

EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'RECEIVABLE', @notes = '',
        @debit = 0, @credit = 10, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = @transaction_id;
GO;

-- Ahora llega un proveedor de los que hacen la orden y luego envian el producto y se paga
-- Juan le hace la orden y la guarda en el sistema

DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = null, @provider_name = 'Coca-cola', @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 7, N'Coca-cola 3 litros';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'BILL_TO_PAY',
        @notes = 'Se paga cuando traigan los productos',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = 0;

-- luego de unas horas el pedido llega y se registra el pago de la orden
DECLARE @total_to_pay FLOAT;
SET @total_to_pay = (SELECT sum(total_price)
                     FROM guest.order_items
                     WHERE order_id = @order_id);

EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'BILL_TO_PAY', @notes = '',
        @debit = @total_to_pay, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id,
        @parent_id = @transaction_id;
GO;

-- El turno de Juan termina y empieza el de Ramon
DECLARE @current_balance FLOAT = (SELECT TOP 1 balance
                                  FROM guest.transactions
                                  WHERE transaction_state = 'COMPLETED'
                                  ORDER BY transactions.created_at DESC);

UPDATE guest.cashier_account_closing
SET closing_balance = @current_balance,
    closed_at       = CURRENT_TIMESTAMP
WHERE employee_id = (SELECT id FROM guest.employees WHERE name = 'Juan');

INSERT INTO guest.cashier_account_closing (employee_id, starting_balance, begins_at, note)
VALUES ((SELECT id FROM guest.employees WHERE name = 'Ramon'), @current_balance, CURRENT_TIMESTAMP,
        'Ultimo turno del dia');
GO;

-- Llega su primer cliente
DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Julisa', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;
EXECUTE guest.sp_create_client_order_item @order_id, 4, N'Pepsi 3 litros';
EXECUTE guest.sp_create_client_order_item @order_id, 3, N'Libra de harina preparada';

DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'CLIENT_ORDER', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;
GO;

-- Llega Erick a pagar otro abono del credito que saco mas temprano
DECLARE @transaction_id INT, @order_id INT;
SELECT TOP 1 @transaction_id = id, @order_id = order_id
FROM guest.transactions
WHERE concept_id = (SELECT id FROM guest.concepts WHERE name = 'RECEIVABLE')
  AND client_id = (SELECT id FROM guest.clients WHERE name = 'Erick')
  AND credit = 0
ORDER BY created_at DESC;

EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'RECEIVABLE', @notes = '',
        @debit = 0, @credit = 30, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = @transaction_id;
GO;

-- Ramon ahora debe pagar los servicios publicos y registrar los gastos de la comida para la casa
DECLARE @transaction_id INT = 0;
EXECUTE guest.sp_create_transaction_parent @order_id = null, @concept_name = 'ELECTRICITY_BILL', @notes = '',
        @debit = 50, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;

EXECUTE guest.sp_create_transaction_parent @order_id = null, @concept_name = 'WATER_BILL', @notes = '',
        @debit = 50, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;

EXECUTE guest.sp_create_transaction_parent @order_id = null, @concept_name = 'TELEPHONE_BILL', @notes = '',
        @debit = 70, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;


DECLARE @order_id INT = 0;
EXECUTE guest.sp_create_client_order @client_name = N'Pepito', @provider_name = _, @payment_method = N'Efectivo',
        @order_id = @order_id OUTPUT;


EXECUTE guest.sp_create_client_order_item @order_id, 1, N'Pepsi 3 litros';
EXECUTE guest.sp_create_client_order_item @order_id, 1, N'Salsina pequena';

EXECUTE guest.sp_create_transaction_parent @order_id = @order_id, @concept_name = 'HOUSE_FOOD_BILL', @notes = '',
        @debit = 0, @credit = 0, @state = 'COMPLETED', @transaction_id = @transaction_id, @parent_id = null;

GO;