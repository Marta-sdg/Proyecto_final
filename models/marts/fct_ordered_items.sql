{{ config(
    materialized='table'
) }}

with order_items as (

    select * from {{ ref('int_order_items') }}

),

final as (

    select
        order_key,
        line_number,
        customer_key,
        part_key,
        supplier_key,

        order_date,
        item_ship_date,
        item_commit_date,
        item_receipt_date,

        order_status,
        item_return_flag,
        item_status,
        item_ship_mode,
        item_ship_instruct,

        case
            when item_receipt_date > item_commit_date then true
            else false
        end as is_receipt_delayed,

        -- Quantities & Financials
        item_quantity,
        item_extended_price,
        item_discount,
        item_tax,
        discount_amount,
        net_item_sales_amount,
        gross_item_sales_amount_with_tax,

        -- Cost & Profitability
        supply_cost,
        total_item_supply_cost,
        item_gross_profit_amount

    from order_items

)

select * from final