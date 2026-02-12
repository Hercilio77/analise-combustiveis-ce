# Análise de Preços de Gasolina - Ceará (2º Semestre 2025)

## 📊 Sobre o Projeto
Análise exploratória de **11.172 registros** de preços de gasolina comum no Ceará entre julho e dezembro de 2025, utilizando dados públicos da ANP. O objetivo foi identificar padrões de precificação, concentração de mercado e possíveis anomalias competitivas.

![Dashboard](dashboard_combustiveis_ce.png)

## 🛠️ Stack Técnica
- **Coleta e ETL:** Python + Pandas
- **Armazenamento:** MySQL 8.0
- **Análise:** SQL (DBeaver)
- **Visualização:** Power BI Desktop

## 🎯 Principais Descobertas

### 1. Concentração Geográfica Extrema
- **Fortaleza concentra 106 postos únicos** (43% dos postos analisados)
- Top 10 municípios representam 85% do mercado
- **Quixadá** (8 postos) pratica o **menor preço médio** (R$ 5,89) vs capital (R$ 6,36)

### 2. Oligopólio de Bandeiras
- **Top 5 bandeiras controlam 96,5% do mercado**
- VIBRA, BRANCA e RAIZEN dominam com 76,5% juntos
- Líderes praticam preços **abaixo da média** (estratégia de volume)
- IPIRANGA (menor share) compensa com **margens maiores** (+0,74%)

### 3. ⚠️ Padrão Suspeito em Juazeiro do Norte
**Achado crítico:** 4 postos de bandeiras diferentes (BRANCA, RAIZEN, VIBRA) mantiveram preços **praticamente idênticos** (R$ 6,89-6,90) por **3 meses consecutivos**, **8,5% acima da média local**.

**Análise detalhada:**
- MARCIANO (BRANCA): 18 ocorrências
- M.T.D.F. (BRANCA): 12 ocorrências  
- SJ PETRÓLEO (RAIZEN): 8 ocorrências
- MG DERIVADOS (VIBRA): 2 ocorrências

**Conclusão:** Padrão sugere possível coordenação de preços em região específica. Recomenda-se investigação por órgãos reguladores (CADE/PROCON).

### 4. Tendência de Queda no Semestre
- Preço médio caiu **4,9%** entre julho (R$ 6,52) e dezembro (R$ 6,20)
- Variação sugere influência de fatores macroeconômicos (petróleo internacional, impostos)

### 5. Competitividade ≠ Volume
Análise refutou hipótese inicial: **NÃO há correlação direta entre quantidade de postos e preço baixo**
- Fatores locais (logística, renda per capita, características da concorrência) pesam mais que concentração absoluta

## 📁 Estrutura do Repositório

├── analise_combustiveis_ce.sql # Queries SQL comentadas
├── gasolina_ce.csv # Dataset original (ANP)
├── dashboard_combustiveis_ce.png # Dashboard Power BI
└── README.md # Documentação


## 🚀 Como Reproduzir

### Pré-requisitos
- Python 3.8+
- MySQL 8.0
- Power BI Desktop

### Execução
1. Importe o CSV para o MySQL
2. Execute as queries do arquivo `.sql` no DBeaver
3. Conecte o Power BI ao banco MySQL
4. Visualize os insights no dashboard

## 📈 Métricas do Projeto
- **11.172 registros** analisados
- **244 postos únicos** mapeados
- **184 municípios** do Ceará cobertos
- **7 bandeiras principais** identificadas
- **Período:** Julho a Dezembro 2025

## 🎓 Aprendizados Técnicos
- Modelagem de dados com SQL (GROUP BY, HAVING, agregações)
- Criação de medidas DAX no Power BI
- Identificação de outliers e padrões anômicos
- Design de dashboards com identidade visual profissional

## 📧 Contato
**Hercílio** - Analista de Dados  
📍 Iguatu, Ceará  
🎓 Engenharia de Software - UniFatecie  

[LinkedIn](https://www.linkedin.com/in/herciliofalcao/) | [GitHub](https://github.com/Hercilio77)

---
*Projeto desenvolvido para portfólio profissional - Fevereiro 2026*

