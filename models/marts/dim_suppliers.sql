with suppliers as (

    select * from {{ ref('int_suppliers_region') }}

),

final as (
    select 
        supplier_key,
        supplier_name,
        supplier_address,
        supplier_phone,
        nation_name,
        region_name
    from suppliers
)

select * from final
