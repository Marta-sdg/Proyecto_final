{% macro calculate_net_amount(extended_price, discount_rate) %}
    round(({{ extended_price }} * (1 - {{ discount_rate }})), 2)
{% endmacro %}