{{
    config(
        materialized='table'
    )
}}

with fhv as (
    select * from {{ ref('stg_fhv_data')}}
),

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)

select 
    -- identifiers

    fhv.dispatching_base_num as dispatching_base_num,
    fhv.pickup_datetime as pickup_datetime,
    extract(year from fhv.pickup_datetime) as year,
    extract(MONTH from fhv.pickup_datetime) as month,
    fhv.dropoff_datetime as dropoff_datetime,
    fhv.pulocationid as pulocationid,
    fhv.dolocationid as dolocationid,
    fhv.sr_flag as sr_flag,
    fhv.affiliated_base_number as affiliated_base_number,
    pickup_location.borough as pickup_borough,
    pickup_location.zone as pickup_zone,
    --pickup_location.service_zone as service_zone
    dropoff_location.borough as dropoff_borough,
    dropoff_location.zone as dropoff_zone
from fhv
inner join dim_zones as pickup_location
on fhv.pulocationid = pickup_location.locationid
inner join dim_zones as dropoff_location
on fhv.dolocationid = dropoff_location.locationid