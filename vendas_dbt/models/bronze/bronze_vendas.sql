{{ config(materialized='view') }}

SELECT 
    * 
FROM 
    {{ source('vendas_source', 'vendas') }}