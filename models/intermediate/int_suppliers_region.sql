-- Importarem les referencies
with supplier as (

    select * from {{ ref('stg_TPCH_SF1__supplier') }}

),

nation as(

    select * from {{ ref('stg_TPCH_SF1__nation') }}

),

region as (

    select * from {{ ref('stg_TPCH_SF1__region') }}

),

supplier_with_region as (

    select 
        supplier.supplier_key,
        supplier.supplier_name,
        nation.nation_name,
        region.region_name,
        supplier.supplier_address,
        supplier.supplier_phone
    
    from supplier
    left join nation 
        on supplier.nation_key = nation.nation_key
    left join region 
        on nation.region_key = region.region_key
        
)

select * from supplier_with_region


