--Count number of documents added to each integration. 
--Ephemeral model, since we probably don't need a table just for this column - can always join onto the final dimension table

{{ config(
    materialized='ephemeral', 
    schema = "stg"
    ) 
}}


SELECT 
  cd.customer_integration_id, 
  COUNT(cd.id) AS num_documents 
FROM prod.customer_integration_documents AS cd --dataset directly from product, with one row per document
WHERE cd.deleted IS NULL --exclude deleted documents
GROUP BY 1
