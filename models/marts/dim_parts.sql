
with part as (

    select * from {{ ref('stg_TPCH_SF1__part') }}

),

final as (
    select
        part_key,
        part_name,
        manufacturer,
        brand,
        part_type,
        part_size,
        container_type,
        retail_price
    from part

)

select * from final