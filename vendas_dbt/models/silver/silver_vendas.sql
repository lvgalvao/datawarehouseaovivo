{{ config(materialized='view') }}

WITH cleaned_data AS (
    SELECT 
        UPPER(email) as email, 
        DATE(data) AS data,
        valor, 
        quantidade, 
        LOWER(produto) as produto
    FROM 
        {{ ref('bronze_vendas') }}
    WHERE 
        valor > 0 
        AND valor < 8000
        AND data <= CURRENT_DATE
)

SELECT * FROM cleaned_data