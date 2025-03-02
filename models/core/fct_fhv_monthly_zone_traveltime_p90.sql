{{
    config(
        materialized='table'
    )
}}

with trip_data as (
    select *, timestamp_diff(dropoff_datetime, pickup_datetime, SECOND ) as trip_duration from {{ ref('dim_fhv_trips') }}
    where pickup_zone ='Yorkville East' and year = 2019 and month = 11
)

select dropoff_zone, trip_duration, percentile_cont(trip_duration, 0.90) OVER (partition by dropoff_zone) as trip_duration_ranked from trip_data
order by trip_duration_ranked desc
