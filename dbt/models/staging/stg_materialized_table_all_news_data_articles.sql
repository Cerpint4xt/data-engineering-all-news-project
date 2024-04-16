{{
    config(
        materialized='view'
    )
}}

with all_news_data_article as (

    select *,
    row_number() over(partition by publication, date) as rn 
    from {{ source('staging', 'all_news_partitioned_table_articles') }}
    where publication is not null
),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['publication', 'date']) }} as news_id,
        date,
        day,
        publication,
        len_title,
        len_article

    from all_news_data_article
    where rn = 1

)

select * from renamed

-- dbt build --select <model.sql> --vars '{'is_test_run':'false'}'
{% if var('is_test_run', default=true) %}

    limit 100

{% endif %}
