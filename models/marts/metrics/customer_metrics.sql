with customer_orders as (

    select
        customer_id,
        order_id,
        order_date,
        amount
    from {{ ref('customer_orders') }}

),

orders_with_diff as (

    select
        customer_id,
        amount,
        order_date,
        lead(order_date) over (partition by customer_id order by order_date) as next_order_date
    from customer_orders

),

metrics as (

    select
        customer_id,
        count(order_date) as total_orders,
        avg(amount) as avg_order_value,
        avg(
            extract(epoch from next_order_date) - extract(epoch from order_date)
        ) / 86400 as avg_time_between_orders_days
    from orders_with_diff
    group by customer_id

)

select * from metrics
