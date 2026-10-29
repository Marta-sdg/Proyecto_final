with 

source as (

    select * from {{ source('TPCH_SF1', 'nation') }}

),

renamed as (

    select
        n_nationkey as nation_nationkey,
        n_name as nation_name,
        n_regionkey as nation_regionkey,
        n_comment as nation_comment

    from source

)

select * from renamed