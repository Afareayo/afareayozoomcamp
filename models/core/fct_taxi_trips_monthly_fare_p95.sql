{{ config(materialized='view')}}

with trip_data as (
    select * from {{ ref('fact_trips') }}
    where fare_amount > 0 and trip_distance > 0 and payment_type_description in ('Cash', 'Crdit_card')
)

select service_type, year, month,
approx_quantiles(fare_amount, 100)[offset(97)] as percentile_97,
approx_quantiles(fare_amount, 100)[offset(95)] as percentile_95,
approx_quantiles(fare_amount, 100)[offset(90)] as percentile_90,
from trip_data
where year = 2020 and month = 4
group by service_type, year, month

--where trip_data.fare_amount > 0 and trip_data.trip_distance > 0 and payment_type_description in ('Cash', 'Crdit_card')

/*
select service_type, year, month, approx_quantiles(fare_amount, 100) over (
    partition by year, month, service_type ) as fare_amount_percentiles
from trip_data
*/