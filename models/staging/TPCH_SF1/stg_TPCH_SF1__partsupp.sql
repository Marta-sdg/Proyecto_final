with 

source as (

    select * from {{ source('TPCH_SF1', 'partsupp') }}

),

renamed as (

    select
        ps_partkey as partsupp_partkey,
        ps_suppkey as partsupp_suppkey,
        ps_availqty as partsupp_availqty,
        ps_supplycost,
        ps_comment

    from source

)

select * from renamed