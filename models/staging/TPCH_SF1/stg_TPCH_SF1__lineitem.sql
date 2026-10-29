{{ config(
    materialized='incremental',
    unique_key=['order_key', 'line_number']
) }}

with source as (

    select * from {{ source('TPCH_SF1', 'lineitem') }}

),

renamed as (

    select
        l_orderkey as order_key,
        l_partkey as part_key,
        l_suppkey as supplier_key,
        l_linenumber as line_number,
        l_quantity as item_quantity,
        l_extendedprice as item_extended_price,
        l_discount as item_discount,
        l_tax as item_tax,
        l_returnflag as item_return_flag,
        l_linestatus as item_status,
        l_shipdate as item_ship_date,
        l_commitdate as item_commit_date,
        l_receiptdate as item_receipt_date,
        l_shipinstruct as item_ship_instruct,
        l_shipmode as item_ship_mode,
        l_comment as item_comment

    from source

)

select * from renamed

{% if is_incremental() %}
  where item_ship_date >= (select coalesce(max(existing.item_ship_date), '1970-01-01'::date) from {{ this }} as existing)
{% endif %}