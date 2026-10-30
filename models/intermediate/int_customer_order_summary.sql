

with orders as (
    select * from {{ ref('stg_TPCH_SF1__orders') }}
),

summary_orders as (
    select
        customer_key,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(distinct order_key) as total_orders,
        sum(total_price) as lifetime_total_spend

    from orders
    group by customer_key
)

select * from summary_orders