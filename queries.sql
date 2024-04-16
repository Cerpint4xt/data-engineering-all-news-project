-- This queries should be run in BigQuery interface to create the necessary sources for dbt

-- After Google Cloud Storage ingestion, you need to create a bucket to reference the queries for author. 

-- Create External Table from Google Cloud Storage
CREATE OR REPLACE EXTERNAL TABLE `all-news-project-<project_id>.all_news_data.external_table_all_news_data_authors`
OPTIONS (
    FORMAT='PARQUET',
    URIS=['gs://all-news-bucket-project/all_news_data_authors/*']
)


-- Create Materialized Table from the external Table

CREATE OR REPLACE TABLE `all-news-project-<project-id>.all_news_data.materialized_table_all_news_data_authors`
AS (
    SELECT * FROM `all-news-project-<project-id>.all_news_data.external_table_all_news_data_authors`
)


-- Create Partitioning `date` and clustering `publication`
CREATE OR REPLACE TABLE `all-news-project-<project-id>.all_news_data.all_news_partitioned_table_authors`
PARTITION BY date
CLUSTER BY publication as (
    SELECT * FROM `all-news-project-<project-id>.all_news_data.materialized_table_all_news_data_authors` 
)




-- After Google Cloud Storage ingestion, you need to create a bucket to reference the queries for articles. 

-- Create External Table from Google Cloud Storage
CREATE OR REPLACE EXTERNAL TABLE `all-news-project-<project-id>.all_news_data.external_table_all_news_data_articles`
OPTIONS (
    FORMAT='PARQUET',
    URIS=['gs://all-news-bucket-project/all_news_data_articles/*']
)

-- Create Materialized Table form the external Table

CREATE OR REPLACE TABLE `all-news-project-<project-id>.all_news_data.materialized_table_all_news_data_articles`
AS (
    SELECT * FROM `all-news-project-<project-id>.all_news_data.external_table_all_news_data_articles`
)

-- Create Partitioning `date` and clustering `publication`
CREATE OR REPLACE TABLE `all-news-project-<project-id>.all_news_data.all_news_partitioned_table_articles`
PARTITION BY date
CLUSTER BY publication as (
    SELECT * FROM `all-news-project-<project-id>.all_news_data.materialized_table_all_news_data_articles` 
)
