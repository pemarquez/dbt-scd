{% macro build_key_from_columns(table_name, exclude=[], include=[]) %}

{% set output_col_list = [] %}

{% if exclude == [] and  include == [] %}
     {{ log("Running build_key_from_columns you need to provide either a list of columns to exclude or include, currently both are empty! ") }}
{% elif exclude != [] and  include != [] %}
    {{ log("Running build_key_from_columns you need to provide either a list of columns to exclude or include: , you cant supply both! ") }}
{% elif exclude != [] and  include != [] %}

    {% set cols = dbt_utils.star(from=table_name, except = exclude) %}

{% else %}
    
    {% set cols = dbt_utils.star(from=table_name, except = include) %}

{% endif %}


{% set input_col_list = cols.split(',') %}

{%- for col in input_col_list -%}

    {%- do output_col_list.append(col)  -%}

{%- endfor -%}

{{ log("Running build_key_from_columns with output_col_list: " ~ output_col_list) }}

{{ return(dbt_utils.generate_surrogate_key(output_col_list)) }}

{% endmacro %}