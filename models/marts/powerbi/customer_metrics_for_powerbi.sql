{{ config(materialized='view') }}

-- Собираем базовые метрики по клиенту
with base as (

    select
        cm.customer_id,
        c.full_name,
        cm.total_orders,
        cm.avg_order_value,
        cm.avg_time_between_orders_days
    from {{ ref('customer_metrics') }} as cm
    join {{ ref('customers') }} as c
      using (customer_id)

),

-- Добавляем метрики по месяцам
monthly as (

    select
        customer_id,
        date_trunc('month', order_date)::date as OrderMonth,
        count(order_id)            as MonthlyOrders,
        avg(amount)                as MonthlyAverageOrderValue
    from {{ ref('customer_orders') }}
    group by 1, 2

)

select
    b.customer_id               as CustomerID,
    b.full_name                 as CustomerName,
    b.total_orders              as TotalOrders,
    round(b.avg_order_value, 2) as AverageOrderValue,
    round(b.avg_time_between_orders_days, 1) as AvgDaysBetweenOrders,
    m.OrderMonth,
    m.MonthlyOrders,
    round(m.MonthlyAverageOrderValue, 2) as MonthlyAverageOrderValue
from base as b
left join monthly as m
  on b.customer_id = m.customer_id
