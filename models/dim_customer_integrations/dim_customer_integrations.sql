--Putting together all the upstream models
--This is the table that will get handed off to BI tools

{{ config(
    materialized='table', 
    schema = "vanta" --schema in data warehouse meant for consumption
    ) 
}}


SELECT 
  stg.id, 
  stg.created, 
  stg.customer_id, 
  stg.customer_name, 
  stg.integration_id,
  stg.integration_name,
  stg.integration_category, 
  stg.integration_method, 
  COALESCE(dc.num_documents, 0) AS num_documents 
FROM {{ ref('stg_dim_customer_integrations') }} AS stg --using dbt's reference feature to pull in staging table
LEFT JOIN {{ ref('customer_integration_document_count') }} AS cs 
  ON stg.id = cs.customer_integration_id
