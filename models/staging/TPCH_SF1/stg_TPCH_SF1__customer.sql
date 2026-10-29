with 

source as (

    select * from {{ source('TPCH_SF1', 'customer') }}

),

renamed as (

    select
        c_custkey AS customer_custkey,
        c_name AS customer_name,
        c_address AS customer_adress,
        c_nationkey AS customer_nationkey,
        c_phone as customer_phone,
        c_acctbal as customer_acctbal,
        c_mktsegment as customer_mktsegment,
        c_comment as customer_comment

    from source

)

select * from renamed