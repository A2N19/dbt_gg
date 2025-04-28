{{ config(materialized='table') }}

with customers as (
    select * from {{ ref('stg_customer_profiles') }}
),

orders as (
    select * from {{ ref('stg_order_records') }}
),

payments as (
    select * from {{ ref('stg_payment_logs') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.full_name,
    orders.order_id,
    orders.order_date,
    payments.payment_id,
    payments.payment_method,
    payments.amount
from customers
left join orders on customers.customer_id = orders.customer_id
left join payments on orders.order_id = payments.order_id
