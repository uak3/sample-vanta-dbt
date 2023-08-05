--In this model, we create a "staging" table that we can supplement with other data to build the dimension table. 
--It's incremental so that we can limit the number of rows we have to add in on every run. 

{{ config(
    materialized='incremental', 
    schema = "stg", 
    unique_key = "id"
    ) 
}}

SELECT
  ci.id, 
  ci.created, 
  ci.customer_id, 
  cust.name AS customer_name, 
  ig.name AS integration_name,
  ig.category AS integration_category, 
  ci.integration_method --e.g. API, Vanta-built, etc
FROM prod.customer_integrations AS ci 
  --Everything from "prod" would be the untransformed data directly from the product, synced via fivetran
  --customer_integrations would be a table with one row per integration
LEFT JOIN prod.customers AS cust --one row per customer with descriptive columns
	ON ci.customer_id = cust.id
LEFT JOIN prod.integrations AS ig --one row per integration, from https://www.vanta.com/integrations
	ON ci.integration_id = ig.id 
  
--incremental model: only load in new customer integrations, i.e. ones created after table was last updated
{% if is_incremental() %}
WHERE ci.created > (SELECT MAX(created) FROM {{ this }})
{% endif %}
