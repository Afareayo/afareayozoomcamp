{#
    This macro returns the payment type description from the dataset
#}

{% macro get_payment_type_description(payment_type) -%}

    case cast(replace({{ payment_type }},'.0','') as integer) --cast({{payment_type}} as integer)
        when 1 then 'Credit Card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
        else 'EMPTY'
    end

{%- endmacro %}