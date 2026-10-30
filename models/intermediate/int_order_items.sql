-- Creating a view for every item sold

with orders as (

    select * from {{ ref('stg_TPCH_SF1__orders') }}

),

lineitem as (

    select * from {{ ref('stg_TPCH_SF1__lineitem') }}

),

order_items as (
    select
        lineitem.order_key,
        lineitem.line_number,
        lineitem.part_key,
        lineitem.supplier_key,
        orders.customer_key,

        orders.order_date,
        orders.order_status,

        lineitem.item_quantity,
        lineitem.item_extended_price,
        lineitem.item_discount,
        lineitem.item_tax,
        lineitem.item_ship_date,
        lineitem.item_commit_date,
        lineitem.item_receipt_date,
        lineitem.item_return_flag,
        lineitem.item_status,
        lineitem.item_ship_mode,       
        lineitem.item_ship_instruct,   

        (lineitem.item_extended_price * lineitem.item_discount) as discount_amount,
        (lineitem.item_extended_price * (1 - lineitem.item_discount)) as net_item_sales_amount,
        ((lineitem.item_extended_price * (1 - lineitem.item_discount)) * (1 + lineitem.item_tax)) as gross_item_sales_amount_with_tax

    from lineitem
    left join orders 
        on lineitem.order_key = orders.order_key
)

select * from order_items
