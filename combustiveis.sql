
-- ========================================
-- ANÁLISE DE PREÇOS DE GASOLINA - CEARÁ
-- ========================================
-- Período: Julho a Dezembro 2025 (2º Semestre)
-- Fonte: ANP (Agência Nacional do Petróleo, Gás Natural e Biocombustíveis)
-- Total de Registros: 11.172
-- Autor: Hercílio
-- Data: Fevereiro 2026
-- ========================================

-- Consultas >: 

-- QUERY 1: CONCENTRAÇÃO GEOGRÁFICA
-- Objetivo: Identificar os 10 municípios com maior número de postos
-- Insight: Fortaleza concentra 40,7% do mercado estadual

SELECT 
    Municipio,
    COUNT(*) AS Total_Postos,
    ROUND(AVG(Valor_Venda), 2) AS Preco_Medio,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gasolina_ce)), 1) AS Percentual_Mercado
FROM gasolina_ce
GROUP BY Municipio
ORDER BY Total_Postos DESC
LIMIT 10;

-- QUERY 2: EVOLUÇÃO TEMPORAL
-- Objetivo: Analisar variação de preços ao longo do 2º semestre de 2025
-- Insight: Queda de 4,9% entre julho (R$ 6,52) e dezembro (R$ 6,20)

SELECT 
    Data_Coleta,
    COUNT(*) AS Total_Registros,
    ROUND(AVG(Valor_Venda), 2) AS Preco_Medio,
    ROUND(MIN(Valor_Venda), 2) AS Preco_Minimo,
    ROUND(MAX(Valor_Venda), 2) AS Preco_Maximo
FROM gasolina_ce
GROUP BY Data_Coleta
ORDER BY Data_Coleta;

-- QUERY 3: RANKING DE BANDEIRAS
-- Objetivo: Comparar participação de mercado e estratégia de preços
-- Insight: Top 5 bandeiras controlam 96,5% do mercado
-- Líderes (VIBRA, RAIZEN) praticam preços abaixo da média

SELECT 
    Bandeira,
    COUNT(*) AS Total_Postos,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gasolina_ce)), 1) AS Percentual_Mercado,
    ROUND(AVG(Valor_Venda), 2) AS Preco_Medio,
    ROUND(((AVG(Valor_Venda) - 6.36) / 6.36) * 100, 2) AS Diferenca_vs_Media_Estadual
FROM gasolina_ce
GROUP BY Bandeira
ORDER BY Total_Postos DESC
LIMIT 5;

-- QUERY 4: DETECÇÃO DE OUTLIERS (PREÇOS EXTREMOS)
-- Objetivo: Identificar postos com preços significativamente acima da média
-- Insight: 100% dos outliers concentrados em Juazeiro do Norte

-- ========================================

SELECT
    Municipio,
    Revenda,
    Bandeira,
    Valor_Venda,
    ROUND(((Valor_Venda - 6.36) / 6.36) * 100, 2) AS Perc_Acima_Media
FROM gasolina_ce
ORDER BY Valor_Venda DESC
LIMIT 10;

-- QUERY 4.1: INVESTIGAÇÃO DE OUTLIERS (GRANULARIDADE)
-- Objetivo: Verificar se outliers são do mesmo posto repetido ou múltiplos postos
-- Insight CRÍTICO: 4 postos diferentes mantiveram preços idênticos por 3 meses
-- possível coordenação de preços ou cartel

SELECT
    Municipio,
    Revenda,
    Bandeira,
    cnpj_revenda,
    COUNT(*) AS Num_Registros,
    ROUND(AVG(Valor_Venda), 2) AS Preco_Medio,
    MIN(Data_Coleta) AS Primeira_Coleta,
    MAX(Data_Coleta) AS Ultima_Coleta,
    DATEDIFF(MAX(Data_Coleta), MIN(Data_Coleta)) AS Dias_Duracao
FROM gasolina_ce
WHERE Valor_Venda >= 6.89
GROUP BY cnpj_revenda, Municipio, Revenda, Bandeira
ORDER BY Num_Registros DESC;

-- QUERY 5: ANÁLISE DE COMPETITIVIDADE
-- Objetivo: Testar hipótese "mais postos = preços menores"
-- Método: Comparar postos únicos (CNPJ) vs preço médio praticado
-- Insight: NÃO há correlação direta. Quixadá (8 postos): R$ 5,89
-- Itapipoca (12 postos): R$ 6,71 (+13,9%)

SELECT
    Municipio,
    COUNT(DISTINCT cnpj_revenda) AS Total_Postos_Unicos,  -- CORRIGIDO: postos únicos
    COUNT(*) AS Total_Registros,  -- Total de coletas
    ROUND(AVG(Valor_Venda), 2) AS Preco_Medio,
    ROUND(MIN(Valor_Venda), 2) AS Menor_Preco,
    ROUND(MAX(Valor_Venda), 2) AS Maior_Preco,
    ROUND(MAX(Valor_Venda) - MIN(Valor_Venda), 2) AS Amplitude_Precos
FROM gasolina_ce
GROUP BY Municipio
HAVING COUNT(DISTINCT cnpj_revenda) >= 5  -- Filtrar cidades com pelo menos 5 postos únicos
ORDER BY Total_Postos_Unicos DESC
LIMIT 15;

-- Resumo das principais métricas

SELECT 
    'Resumo Estadual - Ceará' AS Categoria,
    COUNT(DISTINCT Municipio) AS Total_Municipios,
    COUNT(DISTINCT cnpj_revenda) AS Total_Postos_Unicos,
    COUNT(DISTINCT Bandeira) AS Total_Bandeiras,
    COUNT(*) AS Total_Registros,
    ROUND(AVG(Valor_Venda), 2) AS Preco_Medio_Geral,
    ROUND(MIN(Valor_Venda), 2) AS Menor_Preco_Estado,
    ROUND(MAX(Valor_Venda), 2) AS Maior_Preco_Estado,
    MIN(Data_Coleta) AS Data_Inicial,
    MAX(Data_Coleta) AS Data_Final
FROM gasolina_ce;

SELECT * FROM gasolina_ce;
