
with customers as (

    select * from {{ ref('int_customers_regions') }}

),

order_summary as (

    select * from {{ ref('int_customer_order_summary') }}

),

final as (

    select
        customers.customer_key,
        customers.customer_name,
        customers.customer_address,
        customers.customer_phone,
        customers.nation_name,
        customers.region_name,

        coalesce(order_summary.total_orders, 0) as lifetime_total_orders,
        coalesce(order_summary.lifetime_total_spend, 0) as lifetime_total_spend,
        order_summary.first_order_date,
        order_summary.most_recent_order_date,

        case
            when order_summary.total_orders > 0 then true
            else false
        end as has_placed_order

    from customers
    left join order_summary
        on customers.customer_key = order_summary.customer_key

)

select * from final