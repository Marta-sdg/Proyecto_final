-- Let's import everything we need

with part as (

    select * from {{ ref('stg_TPCH_SF1__part') }}

),

supplier as (

    select * from {{ ref('stg_TPCH_SF1__supplier') }}

),

partsupp as (

    select * from {{ ref('stg_TPCH_SF1__partsupp') }}

),

part_availability as (

    select 
        partsupp.part_key,
        partsupp.supplier_key,

        -- Part Details
        part.part_name,
        part.manufacturer,
        part.brand,
        part.part_type,

        -- Supplier Details
        supplier.supplier_name,
        supplier.supplier_phone,
        supplier.supplier_account_balance,

        -- Availability & Financials
        partsupp.available_quantity,
        partsupp.supply_cost,
        
        -- Calculated Field: Total Inventory Value
        (partsupp.available_quantity * partsupp.supply_cost) as total_inventory_value

    from partsupp
    left join part 
        on partsupp.part_key = part.part_key
    left join supplier 
        on partsupp.supplier_key = supplier.supplier_key

)

select * from part_availability


