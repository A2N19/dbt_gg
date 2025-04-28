{% snapshot customer_profiles_snapshot %}
{{
  config(
    target_schema='snapshots',
    strategy='check',
    unique_key='customer_id',
    check_cols=['first_name','last_name','full_name']
  )
}}
select * from {{ ref('stg_customer_profiles') }}
{% endsnapshot %}
