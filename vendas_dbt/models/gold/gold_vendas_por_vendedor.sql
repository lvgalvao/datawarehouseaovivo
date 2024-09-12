{{ config(materialized='view') }}

WITH vendas_7_dias_vendedor AS (
    SELECT 
        email AS vendedor, 
        DATE(data) AS data, 
        SUM(valor) AS total_valor, 
        SUM(quantidade) AS total_quantidade, 
        COUNT(*) AS total_vendas
    FROM 
        {{ ref('silver_vendas') }}
    WHERE 
        data >= CURRENT_DATE - INTERVAL '30 days'
    GROUP BY 
        email, DATE(data)
)

SELECT 
    vendedor, 
    data, 
    total_valor, 
    total_quantidade, 
    total_vendas
FROM 
    vendas_7_dias_vendedor
ORDER BY 
    data ASC, vendedor ASC