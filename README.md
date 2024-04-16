# All the News 2.0 — 2.7 million news articles and essays from 27 American publications

## This project is for the cohort 2024 DataTalksClub by me Raul Catacora

## Problem Description

Imagine you work at a singular News Paper whos is wiling to use Technology to take advantage on the competition.

Your News Boss want you to use tech and your recently gained skills in data engineering to accomplish this goal. He/She wants you to first get some inside information on other News Paper Companies, Editorials and all you can find. The whole idea after this is to create an AI model to develop some solution to write news, opinions and even gossip articles.

* First, you will need to dig into the whole news domain aka your competition.
* Second, you need a lot of data from multiple year to have a good general idea on what is relevant for this subject.
* Third, your News Boss wants you to have a dashboard with all this information with at least 5 years information.

The image next explaint the technology used and the project diagram

![Diagram Example](/images/project_diagram.png)


### Granularization of the dataset

In order to have the dataset available in a more granular manner. After downloading the dataset from Hugging Face and creating granular files. Then I was able to continue with the process.
[Dataset From Component One](https://components.one/datasets/all-the-news-2-news-articles-dataset)

For reference you can check the Granularization of the dataset inside the `Notebook` folder

### Dataset by year and month (Source Files)

The dataset was uploaded first in the [following repo](https://github.com/Cerpint4xt/All_the_News_2_0_Component_One)

This dataset will be used as an API endpoint to use `Mage` and start the ingestion processing into the Google Cloud Platform ecosystem.  

### Data ingestion

Data ingestion was made with `Mage`, creating two pipelines as explained in this [repository](https://github.com/Cerpint4xt/All-news-2-0-mage-component). And that is actually linked here as a submodule.

![mage pipeline for authors](/images/mage_pipeline.png)

The resulting bucket in cloud should look something like the next picture

![bucket example](/images/Google_cloud_storage_example.png)

As in the picture, there are two tables `all_news_data_authors` and `all_news_data_articles`. This comes from two separate pipelines in the `Mage` instance that handle different processes that create two different tables to be sent into GCS

### Data Warehouse

From Google Cloud Storage to Google BigQuery, just a couple of queries were run in the BQ interface to create all the necessary tables to take advantage of `dbt`. ***Use `queries.sql` file to create all the tables***.

Creating the tables with `partitions` and `clustering` to enhance the flow of the pipeline.

After creating the tables BigQuery should look similar to the next picture
![bigquery example](/images/bigquery_example.png)

### Transformations

The transformation step was made with `dbt` where tables from BigQuery were used and joined with `dbt` to create a fact table.

![dbt models](/images/dbt_diagram.png)

The `dbt` models include two sources because of the quantity of data in the initial dataset. It was impossible to process all the articles and articles titles to be stored in a single run and hold everything in BigQuery, that is way I split the data in different tables one with author information and the other with aggregated information of the articles.

### Dashboard

Finally, to show all your work for your News Boss, you set up a looker with the information needed. Some of it include:

* Table of the author who writes the most.
* How much word does publication written over the years.
* The amount of percentage that each publication covers in the date ranges.
* The time-series of the quantity of articles written by each publication.

![Looker Dashboard](/images/looker_dashboard.png)

## Conclusions
By the end of the project you present the Dashboard to your News Boss, he/she seems very pleased to have the dashboard available. He/She thinks that you could develop a ML model after analyzing the data. (Now you think you could learn MLOps from #DataTalksClub or even the Machine Learning Course)

* You used the same stack as in the course with another dataset
* You were able to learn IaC with a practical example and probably many more questions and interest arise
* You were able to see the data of over 2 million data rows, and figure that there is a lot of space for cleaning and enhancing the whole data pipeline
* You can use the data pipeline for other pipelines and interest around the dataset
* You have a more granular presentation of the dataset shared in [All component dataset](https://components.one/datasets/all-the-news-2-news-articles-dataset)

## Running the project

1. Clone the repository
2. Create the project in GCP : ex. all_news_project
3. Install docker, python, terraform (if want to deploy the terraform template for mage)
4. Create your service accounts for the docker or terraform deployment (as in youtube videos)
5. Setup the dbt cloud with the repository and run the commands (as in youtube videos)
6. Setup looker to start playing with the data.
