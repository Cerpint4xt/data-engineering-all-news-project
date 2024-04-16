{{
    config(
        materialized='table'
    )
}}

with all_news_data_author as (
    select * 
    from {{ ref('stg_materialized_table_all_news_data_authors') }}
),
all_news_data_article as (
    select *
    from {{ ref('stg_materialized_table_all_news_data_articles') }}
)

select all_news_data_author.date,
       all_news_data_author.author,
       all_news_data_author.url,
       all_news_data_author.section,
       all_news_data_author.publication,
       all_news_data_article.len_title,
       all_news_data_article.len_article
from all_news_data_author
left join all_news_data_article
on all_news_data_author.date = all_news_data_article.date
 and all_news_data_author.publication = all_news_data_article.publication 

-- dbt build --select <model.sql> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

    limit 100

{% endif %}
