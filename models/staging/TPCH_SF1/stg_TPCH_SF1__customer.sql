with 

source as (

    select * from {{ source('TPCH_SF1', 'customer') }}

),

renamed as (

    select
        c_custkey AS customer_key,
        c_name AS customer_name,
        c_address AS customer_adress,
        c_nationkey AS nation_key,
        c_phone as customer_phone,
        c_acctbal as customer_account_balance,
        c_mktsegment as customer_market_segment,
        c_comment as customer_comment

    from source

)

select * from renamed