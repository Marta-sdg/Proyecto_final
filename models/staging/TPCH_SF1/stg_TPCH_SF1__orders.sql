{{ config(
    materialized='incremental',
    unique_key='order_key'
) }}

with source as (

    select * from {{ source('TPCH_SF1', 'orders') }}

),

renamed as (

    select
        o_orderkey as order_key,
        o_custkey as customer_key,
        o_orderstatus as order_status,
        o_totalprice as total_price,
        o_orderdate as order_date,
        o_orderpriority as order_priority,
        o_clerk as order_clerk,
        o_shippriority as order_ship_priority,
        o_comment as order_comment

    from source

)

select * from renamed

{% if is_incremental() %}
  where order_date >= (select coalesce(max(existing.order_date), '1970-01-01'::date) from {{ this }} as existing)
{% endif %}