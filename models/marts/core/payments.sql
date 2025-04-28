{{ config(materialized='view') }}

with payments as (
    select * from {{ ref('stg_payment_logs') }}
)

select * from payments
