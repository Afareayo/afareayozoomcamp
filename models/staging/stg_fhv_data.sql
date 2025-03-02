{{
    config(
        materialized='view'
    )
}}

select * from {{ source("staging", "ny_taxi_fhv") }}
where dispatching_base_num is not null