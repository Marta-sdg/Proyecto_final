{{ config(
    materialized='incremental',
    unique_key=['lineitem_orderkey', 'lineitem_linenumber']
) }}

with source as (

    select * from {{ source('TPCH_SF1', 'lineitem') }}

),

renamed as (

    select
        l_orderkey as lineitem_orderkey,
        l_partkey as lineitem_partkey,
        l_suppkey as lineitem_suppkey,
        l_linenumber as lineitem_linenumber,
        l_quantity as lineitem_quantity,
        l_extendedprice as lineitem_extendedprice,
        l_discount as lineitem_discount,
        l_tax as lineitem_tax,
        l_returnflag as lineitem_returnflag,
        l_linestatus as lineitem_status,
        l_shipdate as lineitem_shipdate,
        l_commitdate as lineitem_commitdate,
        l_receiptdate as lineitem_reciptdate,
        l_shipinstruct as lineitem_shipinstruct,
        l_shipmode as lineitem_shipmode,
        l_comment as lineitem_comment

    from source

)

select * from renamed

{% if is_incremental() %}
  where lineitem_shipdate >= (select max(lineitem_shipdate) from {{ this }})
{% endif %}