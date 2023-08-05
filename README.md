# sample-vanta-dbt
dbt Pipeline: Customer Integrations

## Introduction
This repository contains a dbt pipeline that creates a dimension table for every active customer integration. Here, I'm using "integration" to mean one of the connected apps Vanta has available (i.e., the ones listed here: https://www.vanta.com/integrations), while a "customer integration" is the specific connection a customer has to one of these integrations. For example, if my company has integrated Vanta with AWS, 1Password, and Box, and another has integrated AWS and Notion, then we have five customer integrations between us. 

The output table, `vanta.dim_customer_integrations`, is meant to be analysis-ready and to enable easy insights for data professionals. 

## Model Overview
1. Models are built from raw data ingested by our analytics data warehouse.
2. A staging model removes deleted records and adds descriptive columns to the customer integrations data.
3. An ephemeral model counts how many active documents each integration has.
4. Finally, the dimension model puts all this data together.

## Tests
Each model has a primary key, which is tested to ensure every value is unique and not null. These can be seen in the model's .yml file.

## Metadata
Model descriptions, as well as descriptions for key columns, are also available in the .yml file. 

