{{ config(
    materialized='incremental',
    unique_key='orders_orderkey'
) }}

with source as (

    select * from {{ source('TPCH_SF1', 'orders') }}

),

renamed as (

    select
        o_orderkey as orders_orderkey,
        o_custkey as orders_custkey,
        o_orderstatus as orders_orderstatus,
        o_totalprice as orders_totalprice,
        o_orderdate as orders_orderdate,
        o_orderpriority as orders_orderpriority,
        o_clerk as orders_clerk,
        o_shippriority as orders_shippriority,
        o_comment as orders_comment

    from source

)

select * from renamed

{% if is_incremental() %}
  where orders_orderdate >= (select max(orders_orderdate) from {{ this }})
{% endif %}