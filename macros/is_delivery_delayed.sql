{% macro is_delivery_delayed(receipt_date, commit_date) %}
    case
        when {{ receipt_date }} > {{ commit_date }} then true
        else false
    end
{% endmacro %}