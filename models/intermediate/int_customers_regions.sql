-- Importarem les referencies
with customer as (

    select * from {{ ref('stg_TPCH_SF1__customer') }}

),

nation as(

    select * from {{ ref('stg_TPCH_SF1__nation') }}

),

region as (

    select * from {{ ref('stg_TPCH_SF1__region') }}

),

customers_with_region as (

    select 
        customer.customer_key,
        customer.customer_name,
        nation.nation_name,
        region.region_name,
        customer.customer_address,
        customer.customer_phone
    
    from customer
    left join nation 
        on customer.nation_key = nation.nation_key
    left join region 
        on nation.region_key = region.region_key
        
)

select * from customers_with_region