# Semana 02 — Dia 03 | Consultas relacionais e relatórios SQL

**Projeto:** IgrejaApp  
**Data:** 17/11/2026  
**Tecnologias:** SQL Server e SQL Server Management Studio (SSMS)  
**Status:** Atividades práticas concluídas

## 1. Objetivo

Desenvolver consultas SQL para recuperação, consolidação e análise de informações relacionadas a pessoas, organizações, atividades e presenças.

Aplicar relacionamentos entre tabelas, funções de agregação e subconsultas correlacionadas, considerando as regras de negócio e a integridade dos resultados.

## 2. Atividades realizadas

### 2.1. Relatório de presença por atividade

Desenvolvida consulta relacionando as tabelas `Presenca`, `Pessoa`, `Atividade` e `Organizacao`.

**Funcionalidades implementadas:**
- Identificação das pessoas presentes em cada atividade.
- Exibição da data de realização da atividade.
- Identificação da organização vinculada à pessoa.
- Ordenação cronológica das atividades e alfabética dos participantes.

Utilizados `INNER JOIN` para relacionamentos obrigatórios e `LEFT JOIN` para preservar registros de pessoas sem organização vinculada.

### 2.2. Relatório consolidado de atividades

Implementada consulta para apresentar todas as atividades cadastradas, incluindo aquelas sem registros de presença ou organizações responsáveis.

**Indicadores calculados:**
- Total de participantes distintos por atividade.
- Total de organizações responsáveis por atividade.

Utilizados `LEFT JOIN`, `COUNT(DISTINCT ...)` e `GROUP BY`.

Durante o desenvolvimento, foi identificada a multiplicação de linhas resultante do relacionamento entre duas tabelas com múltiplos registros associados à mesma atividade.

A utilização de `COUNT(DISTINCT ...)` permitiu evitar contagens incorretas.

O agrupamento também foi ajustado para considerar `AtividadeId`, impedindo a consolidação indevida de atividades diferentes com nomes iguais.

### 2.3. Relatório de organizações sem atividades

Desenvolvidas duas versões de consulta para identificar organizações que não possuem registros na tabela `AtividadeOrganizadora`.

**Abordagens utilizadas:**
- Subconsulta com `NOT IN`.
- Subconsulta correlacionada com `NOT EXISTS`.

Foram analisadas as diferenças entre os operadores, especialmente quanto ao tratamento de valores `NULL`.

Na estrutura atual, a coluna `AtividadeOrganizadora.OrganizacaoId` não permite valores nulos, tornando válida a abordagem com `NOT IN`.

A versão com `NOT EXISTS` utiliza uma condição correlacionada para verificar a ausência de relacionamentos para cada organização.

### 2.4. Relatório de pessoas sem participação

Implementada consulta para identificar pessoas ingressadas e ativas que não possuem registros de presença.

**Critérios aplicados:**
- `IsIngressada = 1`.
- `IsAtiva = 1`.
- Ausência de registros relacionados em `Presenca`.

Utilizada subconsulta correlacionada com `NOT EXISTS`.

A coluna `TotalPresencas` foi definida com valor constante `0`, eliminando a necessidade de uma operação de contagem, uma vez que a própria condição de seleção garante a ausência de presenças.

### 2.5. Relatório de pessoas sem participação em determinado período

Desenvolvida consulta para identificar pessoas ingressadas e ativas sem participação em atividades realizadas durante um intervalo de datas.

**Recursos utilizados:**
- Variáveis `DATE` para definição do período.
- Relacionamento entre `Presenca` e `Atividade`.
- Subconsulta correlacionada com `NOT EXISTS`.
- Função `DATEADD` para cálculo do limite superior.

O filtro foi implementado utilizando um intervalo semiaberto:

```sql
ATI.DataHoraRealizacao >= @DataInicial
AND ATI.DataHoraRealizacao < DATEADD(DAY, 1, @DataFinal)
```

Essa abordagem considera todos os horários da data final, sem incluir registros do dia seguinte.

Também evita a aplicação de funções diretamente à coluna `DataHoraRealizacao`, característica relevante para futuras análises de índices e desempenho.

## 3. Conceitos técnicos revisados

- Relacionamentos com `INNER JOIN` e `LEFT JOIN`.
- Agregação com `COUNT` e `COUNT(DISTINCT ...)`.
- Agrupamento de resultados com `GROUP BY`.
- Multiplicação de linhas em relacionamentos entre tabelas.
- Subconsultas com `NOT IN` e `NOT EXISTS`.
- Subconsultas correlacionadas.
- Lógica de três valores do SQL envolvendo `NULL`.
- Declaração e utilização de variáveis.
- Filtragem de períodos com `DATEADD`.
- Intervalos semiabertos para colunas `DATETIME2`.
- Considerações iniciais sobre sargabilidade e desempenho de consultas.

## 4. Decisões técnicas

Durante a implementação, foram adotadas as seguintes decisões:

1. Utilizar `LEFT JOIN` quando a ausência de registros relacionados não deve excluir a entidade principal do relatório.
2. Aplicar `COUNT(DISTINCT ...)` para evitar contagens duplicadas em relacionamentos com múltiplas correspondências.
3. Incluir identificadores únicos no agrupamento para preservar a individualidade dos registros.
4. Utilizar `NOT EXISTS` em consultas que verificam a ausência de relacionamentos.
5. Evitar agregações desnecessárias quando as condições de seleção já determinam o resultado.
6. Utilizar intervalos semiabertos em filtros de data e hora.

## 5. Organização do repositório

Criado o arquivo:

`database/scripts/003-consultas-relatorios.sql`

O script reúne seis consultas:

1. Relatório de presença por atividade.
2. Relatório consolidado de atividades.
3. Relatório de organizações sem atividades utilizando `NOT IN`.
4. Relatório de organizações sem atividades utilizando `NOT EXISTS`.
5. Relatório de pessoas sem participação.
6. Relatório de pessoas sem participação em determinado período.

As consultas foram organizadas por finalidade, acompanhadas de comentários com seus requisitos técnicos.

## 6. Resultados

- Seis consultas SQL desenvolvidas.
- Aplicação de relacionamentos entre múltiplas tabelas.
- Tratamento de duplicidades em operações de agregação.
- Implementação de subconsultas correlacionadas.
- Aplicação de regras de negócio aos filtros dos relatórios.
- Correção do tratamento de limites de data e hora.
- Consolidação das consultas em um script SQL dedicado.

## 7. Planejamento — Próxima aula

- Avançar na modelagem e implementação das funcionalidades do IgrejaApp conforme o planejamento de estudos.
- Priorizar desafios mais completos, com maior autonomia na definição das soluções.
- Aprofundar a análise de consultas SQL quando necessário.
- Manter a documentação técnica e o versionamento do projeto atualizados.

## 8. Considerações finais

O Dia 03 consolidou conhecimentos de consultas relacionais e introduziu análises mais próximas das necessidades reais do IgrejaApp.

As atividades permitiram revisar técnicas de recuperação e agregação de dados, identificar problemas relacionados à multiplicação de registros e desenvolver consultas considerando as regras de negócio.

Os exercícios foram realizados com maior autonomia, priorizando a análise dos problemas e a construção das soluções antes da revisão técnica.

O conteúdo desenvolvido foi consolidado no arquivo `003-consultas-relatorios.sql`, contribuindo para a documentação das funcionalidades de consulta e relatório do projeto.