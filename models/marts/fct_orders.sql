
with orders as (

    select * from {{ ref('stg_TPCH_SF1__orders') }}

),

lineitem_aggregates as (

    select
        order_key,
        count(distinct line_number) as total_line_items,
        sum(item_quantity) as total_quantity_ordered,
        sum(item_extended_price) as gross_order_amount,
        sum(discount_amount) as total_order_discount,
        sum(net_item_sales_amount) as net_order_sales_amount

    from {{ ref('int_order_items') }}
    group by order_key

),

final as (

    select
        -- Primary & Foreign Keys
        orders.order_key,
        orders.customer_key,

        -- Dates & Context
        orders.order_date,
        orders.order_status,
        orders.order_priority,
        orders.order_clerk,
        orders.order_ship_priority,

        -- Order Level Financials
        orders.total_price as total_order_price,

        -- Derived Line-Item Rollups
        coalesce(lineitem_aggregates.total_line_items, 0) as total_line_items,
        coalesce(lineitem_aggregates.total_quantity_ordered, 0) as total_quantity_ordered,
        coalesce(lineitem_aggregates.gross_order_amount, 0) as gross_order_amount,
        coalesce(lineitem_aggregates.total_order_discount, 0) as total_order_discount,
        coalesce(lineitem_aggregates.net_order_sales_amount, 0) as net_order_sales_amount

    from orders
    left join lineitem_aggregates
        on orders.order_key = lineitem_aggregates.order_key

)

select * from final