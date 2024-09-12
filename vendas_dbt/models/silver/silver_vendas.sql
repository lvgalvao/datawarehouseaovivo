{{ config(materialized='view') }}

WITH cleaned_data AS (
    SELECT 
        UPPER(email) as email, 
        DATE(data) AS data,
        ROUND(CAST(valor AS DECIMAL(10,2)), 2) as valor, 
        quantidade, 
        LOWER(produto) as produto
    FROM 
        {{ ref('bronze_vendas') }}
    WHERE 
        valor > 1000 
        AND valor < 6000
        AND data <= CURRENT_DATE
)

SELECT * FROM cleaned_data