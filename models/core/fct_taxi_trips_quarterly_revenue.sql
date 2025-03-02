{{ config(materialized='table') }}

with trip_data as (
    select * from {{ ref('fact_trips') }}
)
/*
select trip_data.year,
    trip_data.quarter,
    sum(trip_data.total_amount) as total_amount


FROM trip_data
where year = 2020 or year = 2019
group by 1,2
order by year
*/

select quarter, service_type,
    _2019 as total_2019,
    _2020 as total_2020,
    ((_2020 - _2019)/_2019 * 100) as YoY_diff
    --total_amount
FROM (select year, quarter, service_type ,total_amount from trip_data)
pivot( sum(total_amount) for year in (2019, 2020)) AS year_quarter_sales
order by service_type