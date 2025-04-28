{{ config(materialized='view') }}

-- staging customer profiles
with raw_customers as (
    select * from raw_customers
),

transformed_customers as (
    select
        id as customer_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name
    from raw_customers
)

select * from transformed_customers
