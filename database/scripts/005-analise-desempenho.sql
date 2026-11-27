/*
=================================================================
Projeto: IgrejaApp
Arquivo: 005-analise-desempenho.sql
Data de criação: 27/11/2026
Banco de dados: IgrejaApp_Laboratorio

Objetivo:
Registrar as consultas utilizadas nos estudos de análise
de desempenho e interpretação de planos de execução.

Semana 03 - Dia 03 - Parte 01

Conteúdos:
- Planos de execução estimados
- Query Optimizer
- Clustered Index Seek
- Clustered Index Scan
- Cardinalidade
- Custos estimados
- Seletividade

Pré-requisitos:
- Banco IgrejaApp_Laboratorio criado.
- Estrutura das tabelas criada.
- Script 004-geracao-massa-dados.sql executado.
- Massa de dados previamente validada.

Orientações:
- Executar as consultas individualmente.
- Utilizar Ctrl + L para gerar o plano estimado.
- Utilizar F4 para consultar as propriedades dos operadores.
- Não criar ou modificar índices nesta etapa.
- Os valores registrados representam os planos observados
  durante a aula de 27/11/2026.
- Os planos e custos podem variar em outros ambientes.

Observação:
Este script não altera a estrutura do banco de dados
nem os registros armazenados.
=================================================================
*/


-----------------------------------------------------------------
------------------- Seleção do banco de dados -------------------
-----------------------------------------------------------------

USE IgrejaApp_Laboratorio;
GO


-----------------------------------------------------------------
------------------- Validação do ambiente -----------------------
-----------------------------------------------------------------

-- Requisitos técnicos
-- 1. Confirmar o banco de dados utilizado.
-- 2. Evitar a execução dos estudos em outro banco.

IF DB_NAME() <> 'IgrejaApp_Laboratorio'
BEGIN
    THROW 50001,
          'Execute este script apenas no banco IgrejaApp_Laboratorio.',
          1;
END;


-----------------------------------------------------------------
------------------- Consulta A - PessoaId -----------------------
-----------------------------------------------------------------

-- Requisitos técnicos
-- 1. Consultar uma pessoa pelo identificador.
-- 2. Gerar o plano de execução estimado.
-- 3. Identificar o operador de acesso aos dados.
-- 4. Identificar o índice utilizado.
-- 5. Analisar as estimativas de cardinalidade e custo.
-- 6. Identificar a propriedade Seek Predicates.

SELECT *
FROM Pessoa
WHERE PessoaId = 50000;

/*
Resultado observado no plano estimado:

Physical Operation:
    Clustered Index Seek

Logical Operation:
    Clustered Index Seek

Estimated Execution Mode:
    Row

Storage:
    RowStore

Estimated Number of Executions:
    1

Estimated Number of Rows Per Execution:
    1

Estimated Number of Rows to be Read:
    1

Estimated I/O Cost:
    0,003125

Estimated CPU Cost:
    0,0001581

Estimated Operator Cost:
    0,0032831 (100%)

Estimated Subtree Cost:
    0,0032831

Estimated Row Size:
    198 B

Ordered:
    True

Object:
    [IgrejaApp_Laboratorio].[dbo].[Pessoa].[PK_Pessoa]

Seek Predicates:
    Seek Keys[1]: Prefix:
    [IgrejaApp_Laboratorio].[dbo].[Pessoa].PessoaId
    = Scalar Operator([@1])

Análise:

A consulta utiliza o índice associado à chave primária
por meio de um Clustered Index Seek.

O operador estima a leitura de uma linha para retornar
uma linha.

O custo percentual de 100% representa a participação
do operador no custo estimado da consulta.

Não representa percentual de utilização da CPU
nem tempo real de execução.
*/


-----------------------------------------------------------------
---------------- Consulta B - OrganizacaoId ---------------------
-----------------------------------------------------------------

-- Requisitos técnicos
-- 1. Consultar as pessoas vinculadas à organização 5.
-- 2. Gerar o plano de execução estimado.
-- 3. Identificar o operador de acesso aos dados.
-- 4. Identificar o índice utilizado.
-- 5. Comparar linhas estimadas para leitura e saída.
-- 6. Identificar a propriedade Predicate.
-- 7. Comparar o custo estimado com a consulta A.

SELECT *
FROM Pessoa
WHERE OrganizacaoId = 5;

/*
Resultado observado no plano estimado:

Physical Operation:
    Clustered Index Scan

Logical Operation:
    Clustered Index Scan

Estimated Execution Mode:
    Row

Storage:
    RowStore

Estimated Number of Executions:
    1

Estimated Number of Rows Per Execution:
    10000

Estimated Number of Rows to be Read:
    100000

Estimated I/O Cost:
    0,478681

Estimated CPU Cost:
    0,110157

Estimated Operator Cost:
    0,588838 (100%)

Estimated Subtree Cost:
    0,588838

Estimated Row Size:
    198 B

Ordered:
    False

Object:
    [IgrejaApp_Laboratorio].[dbo].[Pessoa].[PK_Pessoa]

Predicate:
    [IgrejaApp_Laboratorio].[dbo].[Pessoa].[OrganizacaoId]
    = CONVERT_IMPLICIT(int, [@1], 0)

Análise:

A consulta utiliza um Clustered Index Scan sobre
o índice PK_Pessoa.

O operador estima a leitura de 100.000 registros
para retornar 10.000 registros.

A coluna OrganizacaoId é uma chave estrangeira,
mas a criação de uma FOREIGN KEY não implica
a criação automática de um índice nessa coluna.

A condição de pesquisa não utiliza a chave
do índice PK_Pessoa.

Diferença estimada entre linhas lidas e retornadas:
    90.000 registros.

Foi observada uma conversão implícita aplicada
ao parâmetro da consulta.

A presença de CONVERT_IMPLICIT, isoladamente,
não comprova um problema de desempenho.

O conceito será aprofundado na Semana 05.
*/


-----------------------------------------------------------------
------------------- Consulta C - IsAtiva ------------------------
-----------------------------------------------------------------

-- Requisitos técnicos
-- 1. Consultar todas as pessoas ativas.
-- 2. Gerar o plano de execução estimado.
-- 3. Identificar o operador de acesso aos dados.
-- 4. Identificar o índice utilizado.
-- 5. Comparar linhas estimadas para leitura e saída.
-- 6. Avaliar a seletividade do filtro.
-- 7. Comparar o custo estimado com as consultas A e B.

SELECT *
FROM Pessoa
WHERE IsAtiva = 1;

/*
Resultado observado no plano estimado:

Physical Operation:
    Clustered Index Scan

Logical Operation:
    Clustered Index Scan

Estimated Execution Mode:
    Row

Storage:
    RowStore

Estimated Number of Executions:
    1

Estimated Number of Rows Per Execution:
    100000

Estimated Number of Rows to be Read:
    100000

Estimated I/O Cost:
    0,478681

Estimated CPU Cost:
    0,110157

Estimated Operator Cost:
    0,588838 (100%)

Estimated Subtree Cost:
    0,588838

Estimated Row Size:
    198 B

Ordered:
    False

Object:
    [IgrejaApp_Laboratorio].[dbo].[Pessoa].[PK_Pessoa]

Predicate:
    [IgrejaApp_Laboratorio].[dbo].[Pessoa].[IsAtiva] = [@1]

Análise:

A consulta utiliza um Clustered Index Scan sobre
o índice PK_Pessoa.

O operador estima a leitura de 100.000 registros
para retornar 100.000 registros.

Todas as pessoas da massa de dados atual estão ativas.

Portanto, o filtro IsAtiva = 1 apresenta baixa
seletividade, pois retorna a totalidade da tabela.

A utilização de um Scan não caracteriza,
isoladamente, um problema de desempenho.
*/


-----------------------------------------------------------------
--------------- Comparação dos planos estimados -----------------
-----------------------------------------------------------------

/*
Resultados observados em 27/11/2026:

Propriedade                A           B           C
-----------------------------------------------------------------
Operador                   Seek        Scan        Scan
Linhas estimadas leitura   1           100000      100000
Linhas estimadas saída     1           10000       100000
Estimated I/O Cost         0,003125    0,478681    0,478681
Estimated CPU Cost         0,0001581   0,110157    0,110157
Estimated Operator Cost    0,0032831   0,588838    0,588838
Índice utilizado           PK_Pessoa   PK_Pessoa   PK_Pessoa
Execuções estimadas        1           1           1
Estimated Row Size         198 B       198 B       198 B
Ordered                    True        False       False
Custo percentual           100%        100%        100%
-----------------------------------------------------------------

Conclusões:

1. As três consultas utilizaram o mesmo índice.

2. A consulta A utilizou uma busca direcionada
   por meio de um Clustered Index Seek.

3. As consultas B e C utilizaram uma varredura
   por meio de um Clustered Index Scan.

4. A consulta B apresentou a maior diferença
   entre linhas estimadas para leitura e saída.

5. As consultas B e C apresentaram o mesmo custo
   estimado de acesso, embora retornem quantidades
   diferentes de registros.

6. Os operadores Scan apresentaram custo absoluto
   estimado aproximadamente 179,35 vezes superior
   ao custo do operador Seek.

7. A diferença entre os custos estimados não
   representa diretamente uma diferença equivalente
   no tempo real de execução.

8. Um Scan não é necessariamente uma operação ruim,
   assim como um Seek não é necessariamente a melhor
   estratégia em todos os cenários.

9. A quantidade de registros retornados não determina,
   isoladamente, o desempenho de uma consulta.

10. Os resultados representam estimativas.
    Nenhuma métrica real de execução foi coletada
    nesta etapa.
*/


-----------------------------------------------------------------
-------------------- Continuidade dos estudos -------------------
-----------------------------------------------------------------

/*
Semana 03 - Dia 03 - Parte 02

Próximas atividades:

1. Revisar Scan, Seek e seletividade.
2. Aprofundar Predicate e Seek Predicates.
3. Gerar os planos de execução reais.
4. Comparar cardinalidade estimada e real.
5. Analisar as quantidades efetivamente processadas.
6. Realizar um desafio de diagnóstico de desempenho.

Próximo desafio: 104.

A criação de índices e a comparação de métricas
com STATISTICS IO e STATISTICS TIME serão realizadas
na Semana 04.
*/