with source as (

    select * from {{ source('TPCH_SF1', 'supplier') }}

),

renamed as (

    select
        s_suppkey as supplier_suppkey,
        s_name as supplier_name,
        s_address as supplier,
        s_nationkey as supplier_nationkey,
        s_phone as supplier_phone,
        s_acctbal,
        s_comment

    from source

)

select * from renamed