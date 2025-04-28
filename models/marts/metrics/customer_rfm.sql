{{ config(materialized='table') }}

-- 1) берём заказы с датой в формате DATE и суммой
with orders as (
    select
        customer_id,
        -- если order_date в строковом формате, кастим его в DATE
        order_date::date as order_date,
        amount
    from {{ ref('customer_orders') }}
),

-- 2) считаем RFM: Recency (дни с последнего заказа), Frequency (число заказов), Monetary (суммарная выручка)
rfm as (
    select
        customer_id,

        -- дни с момента последнего заказа
        (current_date - max(order_date)) as recency_days,

        -- сколько всего заказов
        count(*)            as frequency,

        -- суммарная выручка клиента
        sum(amount)         as monetary

    from orders
    group by customer_id
)

select * from rfm
