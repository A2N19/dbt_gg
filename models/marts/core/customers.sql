{{ config(materialized='table') }}

-- Итоговая таблица клиентов с полным именем
select
    customer_id,               -- уникальный ID клиента
    first_name,                -- имя
    last_name,                 -- фамилия
    first_name || ' ' || last_name as full_name  -- полное имя
from {{ ref('stg_customer_profiles') }}
