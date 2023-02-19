-- entities:

-- transactions -> usada para registrar todos los movimientos del mercadito
    -- id
    -- transaction_parent_id -> relacion recursiva, usada para el pago de las compras a creditos
    -- client_id
    -- provider_id
    -- concept_id
    -- order_id
    -- transaction_state -> PENDING (para ordenes que se hacen a proveedores u algun caso de un cliente que no pudo pagar inmediatamente), COMPLETED, CANCELED
    -- note
    -- debit
    -- credit
    -- current_balance -> solo se toma en cuenta para transacciones de tipo COMPLETED
    -- created_at
    -- updated_at

-- products
    -- product_prices (related_table)
        -- id
        -- product_id
        -- begins_at
        -- ends_at
        -- provider_price
        -- sale_price
        -- earning_percentage
        -- created_at
        -- updated_at
    -- id
    -- provider_id
    -- quantity
    -- name
    -- description
    -- created_at
    -- updated_at

-- concepts -> usada para identificar los diferentes tipos de concepts de una transaccion
    -- id
    -- name
    -- description
    -- created_at
    -- updated_at

    -- examples:

    -- PRODUCT_SALE -> para registrar las ventas de los productos
    -- ABONOS -> para registrar los abonos hechos a una compra que se saco a credito

    -- BILL_TO_PAY -> para registrar las cuentas por pagar
    -- RECEIVABLE -> para registrar las cuentas por cobrar
    -- PROVIDER_ORDER -> para registrar los pedidos a los proveedores
    -- TELEPHONE_BILL -> para registrar los pagos del telefono
    -- WATER_BILL -> para registrar los pagos de agua
    -- ELECTRICITY_BILL para registrar los pagos de luz
    -- HOUSE_FOOD_BILL -> usado para registrar los gastos de la comida para la casa
    -- MUNIXIPALITY_TAXES -> para pagar los impuestos a la alcaldia
    -- se pueden agregar mas si es necesario

-- cierre_de_caja
    -- id
    -- employee_id
    -- starting_amount
    -- closing_amount
    -- note
    -- begins_at
    -- ends_at
    -- created_at
    -- updated_at

-- orders -> tabla para las ordenes de los clientes y las que se haran a los provedores para la compra de productos existentes o nuevos
    -- id
    -- client_id
    -- provider_id
    -- payment_method
    -- created_at
    -- updated_at
    -- order_items (related_table)
        -- id
        -- order_id
        -- product_id
        -- client_id
        -- total_price
        -- quantity
        -- unit_price
        -- created_at
        -- updated_at

-- providers
    -- id
    -- name
    -- phone_number
    -- created_at
    -- updated_at

-- clients
    -- id
    -- name
    -- phone_number
    -- amount_credit_limit
    -- created_at
    -- updated_at

-- employees -> usada para registrar a los empleados del mercadito y llevar un registro del cierre de caja en cada turno
    -- id
    -- name
    -- phone_number
    -- created_at
    -- updated_at

