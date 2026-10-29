with 

source as (

    select * from {{ source('TPCH_SF1', 'region') }}

),

renamed as (

    select
        r_regionkey as region_regionkey,
        r_name as region_name,
        r_comment as region_comment

    from source

)

select * from renamed