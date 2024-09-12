{{ config(materialized='view') }}

WITH vendas_7_dias AS (
    SELECT 
        data, 
        produto, 
        SUM(valor) AS total_valor, 
        SUM(quantidade) AS total_quantidade, 
        COUNT(*) AS total_vendas
    FROM 
        {{ ref('silver_vendas') }}
    WHERE 
        data >= CURRENT_DATE - INTERVAL '30 days'
    GROUP BY 
        data, produto
)

SELECT 
    data, 
    produto, 
    total_valor, 
    total_quantidade, 
    total_vendas
FROM 
    vendas_7_dias
ORDER BY 
    data ASC