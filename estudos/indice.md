# IgrejaApp — Índice de estudos

**Formação:** Backend .NET + SQL Server  
**Versão:** 1.0  
**Última atualização:** 27/11/2026  
**Marco atual:** Semana 03 — Dia 03 — Parte 01  
**Último desafio realizado:** 103

## 1. Finalidade

Este documento funciona como um catálogo dos conhecimentos adquiridos durante a formação, facilitando a localização de conceitos, exemplos, exercícios, implementações e decisões técnicas.

A organização permite consultar os conteúdos por assunto ou pela sequência cronológica das aulas.

## 2. Sumário

- [Índice por assunto](#3-índice-por-assunto)
- [Índice por semana e aula](#4-índice-por-semana-e-aula)
- [Scripts SQL](#5-scripts-sql)
- [Documentação do projeto](#6-documentação-do-projeto)
- [Assuntos que necessitam de reforço](#7-assuntos-que-necessitam-de-reforço)
- [Manutenção deste documento](#8-manutenção-deste-documento)
- [Histórico de revisões](#9-histórico-de-revisões)

## 3. Índice por assunto

### 3.1. Modelagem de banco de dados

| Assunto | Referência |
|---|---|
| Modelagem conceitual | [Semana 01 — Dia 01](semana-01/dia-01.md) |
| Entidades e atributos | [Semana 01 — Dia 01](semana-01/dia-01.md) |
| Cardinalidade de relacionamentos | [Semana 01 — Dia 01](semana-01/dia-01.md) |
| Relacionamentos 1:N e N:N | [Semana 01](semana-01/) / [Semana 02](semana-02/) |
| Tabelas associativas | [Semana 02](semana-02/) |
| Modelagem de organizações | [Semana 01 — Dia 01](semana-01/dia-01.md) |
| Modelagem de pessoas | [Semana 01 — Dia 01](semana-01/dia-01.md) |
| Modelagem de atividades | [Semana 01](semana-01/) / [Semana 02](semana-02/) |
| Modelagem de presenças | [Semana 02](semana-02/) |
| Histórico de informações | [Semana 01 — Dia 01](semana-01/dia-01.md) |
| Regras de negócio e integridade | [Regras de negócio](../docs/regras-de-negocio.md) |

### 3.2. SQL Server — Fundamentos e estrutura

| Assunto | Referência |
|---|---|
| CREATE DATABASE | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| CREATE TABLE | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| Tipos de dados INT, BIT e DATE | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| VARCHAR e NVARCHAR | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| DATETIME2 | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| NULL e NOT NULL | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| IDENTITY | [Semana 01 — Dia 02](semana-01/dia-02.md) / [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Renomeação de colunas — sp_rename | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| Schemas — dbo | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Separação de ambientes de desenvolvimento e laboratório | [Semana 03 — Dia 01](semana-03/dia-01.md) |

### 3.3. Constraints e integridade

| Assunto | Referência |
|---|---|
| PRIMARY KEY | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| FOREIGN KEY | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| DEFAULT | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| CHECK | [Semana 02](semana-02/) |
| UNIQUE — introdução | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Chave primária composta | [Semana 02](semana-02/) |
| Nomeação de constraints | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| Integridade referencial | [Semana 02](semana-02/) |
| Testes de violação de constraints | [Semana 02](semana-02/) |
| Erro 547 — violação de integridade | [Semana 02](semana-02/) |
| Erro 2627 — violação de unicidade | [Semana 02](semana-02/) |
| Constraints que criam índices automaticamente | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Relação entre FOREIGN KEY e índices | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |

### 3.4. Consultas, relacionamentos e agregações

| Assunto | Referência |
|---|---|
| INNER JOIN | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| LEFT JOIN | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| CROSS JOIN | [Semana 03 — Dia 01](semana-03/dia-01.md) / [Dia 02](semana-03/dia-02.md) |
| Produto cartesiano | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Multiplicação de linhas em JOINs | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| GROUP BY | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| Agrupamentos em dois níveis | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| COUNT(*) | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| COUNT(coluna) | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| COUNT(DISTINCT coluna) | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| EXISTS | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| NOT EXISTS | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| NOT IN | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| Comportamento de NULL em NOT IN | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| Subconsultas correlacionadas | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| UNION e UNION ALL | [Semana 03 — Dia 01](semana-03/dia-01.md) / [Dia 02](semana-03/dia-02.md) |
| Diferença entre JOIN e UNION ALL | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| ORDER BY | [Semana 03 — Dia 01](semana-03/dia-01.md) / [Dia 02](semana-03/dia-02.md) |
| Ordenação lexicográfica | [Semana 03 — Dia 02](semana-03/dia-02.md) |

### 3.5. Datas e funções SQL

| Assunto | Referência |
|---|---|
| Filtros por intervalo de datas | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| Intervalos semiabertos de datas | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| DATEADD | [Semana 02 — Dia 03](semana-02/dia-03.md) / [Semana 03 — Dia 02](semana-03/dia-02.md) |
| DATEADD e tipos de retorno | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| CAST | [Semana 03 — Dia 01](semana-03/dia-01.md) / [Dia 02](semana-03/dia-02.md) |
| CONCAT | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Formato ISO 8601 | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Operador módulo (%) | [Semana 03 — Dia 01](semana-03/dia-01.md) / [Dia 02](semana-03/dia-02.md) |

### 3.6. Geração de massa de dados

| Assunto | Referência |
|---|---|
| Processamento set-based | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| VALUES como fonte de dados | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Geração de combinações com CROSS JOIN | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| ROW_NUMBER — introdução | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Ordenação determinística | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| CTE — Common Table Expression | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Escopo e materialização de CTEs | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| INSERT INTO SELECT | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Distribuição circular de registros | [Semana 03 — Dia 01](semana-03/dia-01.md) / [Dia 02](semana-03/dia-02.md) |
| Geração de 100 mil pessoas | [Semana 03 — Dia 01](semana-03/dia-01.md) |
| Geração de mil atividades | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Geração de relacionamentos N:N | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Geração de um milhão de presenças | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Validação da distribuição dos dados | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Limitações de massas de dados uniformes | [Semana 03 — Dia 02](semana-03/dia-02.md) |

### 3.7. Segurança e controle de execução de scripts

| Assunto | Referência |
|---|---|
| DB_NAME() | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| IF EXISTS | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| THROW | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Número, mensagem e estado de exceções | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| EXISTS versus COUNT para verificar existência | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Proteção contra execução no banco incorreto | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Proteção contra inserções repetidas | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| Limitações de scripts sem transações | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| IDENTITY após exclusão de registros | [Contexto dos estudos — Seção 9](contexto-dos-estudos.md#9-laboratório-geração-e-resultados-confirmados) |

### 3.8. Análise de desempenho

| Assunto | Referência |
|---|---|
| Sargabilidade — introdução | [Semana 02 — Dia 03](semana-02/dia-03.md) |
| Fundamentos de desempenho | [Seção 5 — Parte 01](semana-03/dia-03-parte-01.md#5-fundamentos-de-análise-de-desempenho) |
| CPU, I/O, memória e tempo de execução | [Seção 5 — Parte 01](semana-03/dia-03-parte-01.md#5-fundamentos-de-análise-de-desempenho) |
| SQL como linguagem declarativa | [Seção 7 — Parte 01](semana-03/dia-03-parte-01.md#7-sql-como-linguagem-declarativa) |
| Parser | [Seção 8 — Parte 01](semana-03/dia-03-parte-01.md#8-processamento-de-consultas-no-sql-server) |
| Binder / Algebrizer | [Seção 8 — Parte 01](semana-03/dia-03-parte-01.md#8-processamento-de-consultas-no-sql-server) |
| Execution Engine | [Seção 8 — Parte 01](semana-03/dia-03-parte-01.md#8-processamento-de-consultas-no-sql-server) |
| Query Optimizer | [Seção 9 — Parte 01](semana-03/dia-03-parte-01.md#9-query-optimizer) |
| Cost-Based Optimizer | [Seção 9 — Parte 01](semana-03/dia-03-parte-01.md#9-query-optimizer) |
| Estatísticas — introdução | [Seção 9.1 — Parte 01](semana-03/dia-03-parte-01.md#91-importância-das-estatísticas) |
| Plano de execução estimado | [Seção 12 — Parte 01](semana-03/dia-03-parte-01.md#12-plano-de-execução-estimado-e-real) |
| Plano de execução real — teoria | [Seção 12 — Parte 01](semana-03/dia-03-parte-01.md#12-plano-de-execução-estimado-e-real) |
| Fluxo dos dados no plano gráfico | [Seção 13 — Parte 01](semana-03/dia-03-parte-01.md#13-desafio-100--primeiro-plano-de-execução) |
| Propriedades dos operadores | [Seção 14 — Parte 01](semana-03/dia-03-parte-01.md#14-propriedades-dos-operadores) |
| Operações lógicas e físicas | [Seção 16 — Parte 01](semana-03/dia-03-parte-01.md#16-operações-lógicas-e-físicas) |
| Cardinalidade estimada | [Seção 17 — Parte 01](semana-03/dia-03-parte-01.md#17-cardinalidade) |
| Linhas lidas versus retornadas | [Seção 17.1 — Parte 01](semana-03/dia-03-parte-01.md#171-linhas-lidas-versus-linhas-retornadas) |
| Estimated I/O Cost | [Seção 18 — Parte 01](semana-03/dia-03-parte-01.md#18-custos-estimados) |
| Estimated CPU Cost | [Seção 18 — Parte 01](semana-03/dia-03-parte-01.md#18-custos-estimados) |
| Estimated Operator Cost | [Seção 18 — Parte 01](semana-03/dia-03-parte-01.md#18-custos-estimados) |
| Custo absoluto versus percentual | [Seção 18.5 — Parte 01](semana-03/dia-03-parte-01.md#185-custo-absoluto-versus-percentual) |
| Object | [Seção 19 — Parte 01](semana-03/dia-03-parte-01.md#19-object-e-seek-predicates) |
| Seek Predicates | [Seção 19 — Parte 01](semana-03/dia-03-parte-01.md#19-object-e-seek-predicates) |
| Parametrização automática — introdução | [Seção 19.2 — Parte 01](semana-03/dia-03-parte-01.md#192-seek-predicates) |
| Scan e Seek | [Seção 21 — Parte 01](semana-03/dia-03-parte-01.md#21-scan-e-seek) |
| Table Scan | [Seção 21 — Parte 01](semana-03/dia-03-parte-01.md#21-scan-e-seek) |
| Clustered Index Scan | [Seção 21 — Parte 01](semana-03/dia-03-parte-01.md#21-scan-e-seek) |
| Clustered Index Seek | [Seção 21 — Parte 01](semana-03/dia-03-parte-01.md#21-scan-e-seek) |
| Index Scan e Index Seek | [Seção 21 — Parte 01](semana-03/dia-03-parte-01.md#21-scan-e-seek) |
| Constraints e índices | [Seção 22 — Parte 01](semana-03/dia-03-parte-01.md#22-constraints-e-índices) |
| Seletividade | [Seção 23 — Parte 01](semana-03/dia-03-parte-01.md#23-seletividade) |
| Comparação prática de planos estimados | [Seção 24 — Parte 01](semana-03/dia-03-parte-01.md#24-desafio-103--comparação-de-planos-de-execução) |
| Predicate | [Seção 25 — Parte 01](semana-03/dia-03-parte-01.md#25-predicate-e-conversão-implícita) |
| CONVERT_IMPLICIT — introdução | [Seção 25 — Parte 01](semana-03/dia-03-parte-01.md#25-predicate-e-conversão-implícita) |

**Observação:** as referências denominadas Parte 01 nesta seção pertencem à Semana 03 — Dia 03 — Parte 01.

### 3.9. Ferramentas e ambiente de desenvolvimento

| Assunto | Referência |
|---|---|
| Instalação do Git | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| Clonagem de repositório | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| SQL Server Management Studio | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| IntelliSense | [Semana 03 — Dia 02](semana-03/dia-02.md) / [Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Atualização do cache do IntelliSense | [Semana 03 — Dia 02](semana-03/dia-02.md) |
| IntelliSense versus Database Engine | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Verificação da versão do SSMS | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Ctrl + L — plano estimado | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| Ctrl + M — habilitar plano real | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |
| F4 — propriedades dos operadores | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) |

### 3.10. Git, GitHub e versionamento

| Assunto | Referência |
|---|---|
| git clone | [Semana 01 — Dia 02](semana-01/dia-02.md) |
| git status | [Semana 01 — Dia 02](semana-01/dia-02.md) / [Contexto dos estudos](contexto-dos-estudos.md) |
| git add | [Contexto dos estudos](contexto-dos-estudos.md) |
| git commit | [Contexto dos estudos](contexto-dos-estudos.md) |
| git push | [Contexto dos estudos](contexto-dos-estudos.md) |
| Branch main | [Contexto dos estudos](contexto-dos-estudos.md) |
| Working tree clean | [Contexto dos estudos](contexto-dos-estudos.md) |
| Avisos LF e CRLF | [Contexto dos estudos](contexto-dos-estudos.md) |
| Organização de scripts versionados | [Contexto dos estudos](contexto-dos-estudos.md) |

### 3.11. Engenharia de Software, Agile e DevOps

| Assunto | Referência | Situação |
|---|---|---|
| Organização da documentação técnica | [Contexto dos estudos](contexto-dos-estudos.md) | Em aplicação |
| Documentação de regras de negócio | [Regras de negócio](../docs/regras-de-negocio.md) | Em aplicação |
| Versionamento de código e documentação | [Contexto dos estudos](contexto-dos-estudos.md) | Em aplicação |
| Desenvolvimento incremental | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Introduzido |
| Inspeção e adaptação | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Introduzido |
| Separação de ambientes | [Semana 03 — Dia 01](semana-03/dia-01.md) | Em aplicação |
| Scrum | A definir | Planejado |
| Kanban | A definir | Planejado |
| Backlog | A definir | Planejado |
| User Stories | A definir | Planejado |
| Critérios de aceitação | A definir | Planejado |
| Definition of Done | A definir | Planejado |
| Retrospectiva semanal | Encerramento da Semana 03 | Planejado |
| GitHub Issues | A definir | Planejado |
| GitHub Projects | A definir | Planejado |
| Milestones | A definir | Planejado |
| Branches e Pull Requests | A definir | Planejado |
| CI/CD | A definir | Não estudado |

### 3.12. C# e desenvolvimento Backend .NET

Conteúdo previsto no planejamento oficial e ainda não iniciado.

Esta seção será ampliada conforme o avanço da formação, incluindo:

- fundamentos de C#;
- programação orientada a objetos;
- arquitetura em camadas;
- injeção de dependência;
- Entity Framework Core;
- ASP.NET Core;
- APIs REST;
- autenticação e autorização;
- testes automatizados.

Os assuntos planejados não representam conhecimentos já estudados ou validados.

## 4. Índice por semana e aula

### Semana 01 — Modelagem inicial e fundamentos

**Situação:** concluída.

#### [Dia 01 — Modelagem conceitual](semana-01/dia-01.md)

Conteúdos:

- definição inicial do IgrejaApp;
- identificação das entidades;
- atributos e obrigatoriedade;
- cardinalidade de relacionamentos;
- organizações, pessoas e atividades;
- regras de vínculo institucional;
- classificação e endereço;
- decisões iniciais de modelagem.

#### [Dia 02 — Ambiente e estrutura SQL](semana-01/dia-02.md)

Conteúdos:

- instalação e configuração do Git;
- clonagem do repositório;
- criação do banco IgrejaApp;
- criação das tabelas Organizacao e Pessoa;
- tipos de dados;
- IDENTITY;
- PRIMARY KEY;
- FOREIGN KEY;
- DEFAULT;
- NULL e NOT NULL;
- nomeação de constraints;
- renomeação de colunas.

#### Demais registros da Semana 01

Consultar a [pasta da Semana 01](semana-01/).

A divisão exata dos conteúdos restantes deverá ser complementada após a conferência dos relatórios originais.

### Semana 02 — Presença, integridade e consultas

**Situação:** concluída.

#### [Dias 01 e 02 — Estrutura e integridade](semana-02/)

Conteúdos registrados para a semana:

- consolidação da estrutura do banco;
- tabela Atividade;
- tabela AtividadeOrganizadora;
- tabela Presenca;
- relacionamentos N:N;
- chaves primárias compostas;
- CHECK;
- integridade referencial;
- inserção de dados fictícios;
- testes positivos e negativos de integridade.

A distribuição exata desses conteúdos entre os dois relatórios deverá ser conferida nos arquivos originais.

#### [Dia 03 — Consultas e relatórios](semana-02/dia-03.md)

**Desafios:** 71 a 78.

Conteúdos:

- INNER JOIN e LEFT JOIN;
- relatórios de presença;
- agregações;
- GROUP BY;
- COUNT DISTINCT;
- multiplicação de linhas;
- NOT EXISTS e NOT IN;
- subconsultas correlacionadas;
- comportamento de NULL;
- relatórios de ausência de presença;
- filtros por intervalo de datas;
- intervalos semiabertos;
- introdução à sargabilidade.

### Semana 03 — Massa de dados e planos de execução

**Situação:** em andamento.

#### [Dia 01 — Geração de organizações e pessoas](semana-03/dia-01.md)

**Data:** 23/11/2026  
**Desafios:** 79 a 91.

Conteúdos:

- processamento set-based;
- VALUES;
- CROSS JOIN;
- produto cartesiano;
- ROW_NUMBER;
- ordenação determinística;
- CTE;
- CONCAT;
- INSERT INTO SELECT;
- operador módulo;
- distribuição circular;
- UNION e UNION ALL;
- criação do banco IgrejaApp_Laboratorio;
- geração de 10 organizações;
- geração de 100 mil pessoas;
- validação da distribuição.

#### [Dia 02 — Geração de atividades e presenças](semana-03/dia-02.md)

**Data:** 25/11/2026  
**Desafios:** 92 a 97.

Conteúdos:

- geração de mil atividades;
- DATEADD;
- DATETIME2;
- CAST;
- formato ISO 8601;
- geração de relacionamentos entre atividades e organizações;
- UNION ALL;
- distribuição circular;
- geração de um milhão de presenças;
- agrupamentos em dois níveis;
- DB_NAME;
- EXISTS;
- THROW;
- proteção de scripts;
- validação da massa de dados;
- investigação do IntelliSense.

Resultado consolidado: 1.102.210 registros validados no laboratório.

#### [Dia 03 — Parte 01 — Planos de execução estimados](semana-03/dia-03-parte-01.md)

**Data:** 27/11/2026  
**Desafios:** 98 a 103.

Conteúdos:

- fundamentos de análise de desempenho;
- CPU, I/O, memória e tempo;
- SQL como linguagem declarativa;
- Parser;
- Binder / Algebrizer;
- Query Optimizer;
- Execution Engine;
- planos estimados e reais — fundamentos;
- fluxo dos dados;
- propriedades dos operadores;
- operações lógicas e físicas;
- cardinalidade;
- custos estimados;
- linhas lidas versus retornadas;
- Scan e Seek;
- Clustered Index Scan;
- Clustered Index Seek;
- relação entre constraints e índices;
- seletividade;
- Seek Predicates;
- Predicate;
- parametrização automática;
- introdução a conversões implícitas;
- comparação prática de três planos estimados.

#### Dia 03 — Parte 02 — Planos de execução reais

**Situação:** planejado.  
**Próximo desafio:** 104.

Conteúdo previsto:

- revisão de Scan e Seek;
- revisão de constraints e índices;
- seletividade;
- Predicate versus Seek Predicates;
- geração de planos reais;
- cardinalidade estimada versus real;
- diagnóstico de desempenho;
- retrospectiva semanal.

O link para o relatório será incluído após a realização da sessão.

## 5. Scripts SQL

| Arquivo | Finalidade | Conteúdos de referência |
|---|---|---|
| [001-criacao-tabelas.sql](../database/scripts/001-criacao-tabelas.sql) | Estrutura do banco | CREATE TABLE, tipos de dados, PK, FK, CHECK, DEFAULT, IDENTITY e relacionamentos |
| [002-insercao-dados-teste.sql](../database/scripts/002-insercao-dados-teste.sql) | Dados fictícios e testes de integridade | INSERT, testes positivos e negativos, violações de constraints |
| [003-consultas-relatorios.sql](../database/scripts/003-consultas-relatorios.sql) | Consultas e relatórios | JOINs, GROUP BY, COUNT DISTINCT, NOT EXISTS, NOT IN e filtros de datas |
| [004-geracao-massa-dados.sql](../database/scripts/004-geracao-massa-dados.sql) | Geração de dados para desempenho | CTE, CROSS JOIN, ROW_NUMBER, módulo, DATEADD, UNION ALL, EXISTS, THROW e validações |
| [005-analise-desempenho.sql](../database/scripts/005-analise-desempenho.sql) | Estudos de desempenho | Planos estimados, Scan, Seek, cardinalidade, custos e seletividade |

## 6. Documentação do projeto

| Documento | Finalidade |
|---|---|
| [README.md](../README.md) | Apresentação do projeto, objetivos e escopo |
| [regras-de-negocio.md](../docs/regras-de-negocio.md) | Regras funcionais, decisões de negócio e pendências |
| [contexto-dos-estudos.md](contexto-dos-estudos.md) | Continuidade da formação, progresso, decisões e planejamento |
| indice.md | Localização dos conteúdos estudados |
| Plano de Estudos — Backend .NET + SQL Server (v2).pdf | Planejamento oficial das 24 semanas |
| Relatórios diários | Registro técnico e didático das aulas |
| Scripts SQL | Implementações, consultas e exercícios práticos |

### Quando consultar cada documento?

| Necessidade | Documento recomendado |
|---|---|
| Encontrar um conceito estudado | indice.md |
| Revisar a explicação de um conceito | Relatório diário correspondente |
| Encontrar um exemplo de código | Script SQL correspondente |
| Entender uma regra funcional | regras-de-negocio.md |
| Retomar os estudos após uma interrupção | contexto-dos-estudos.md |
| Consultar o conteúdo das próximas semanas | Plano de estudos em PDF |
| Entender o propósito do sistema | README.md |

## 7. Assuntos que necessitam de reforço

Esta seção registra conceitos que apresentaram dificuldades ou que ainda necessitam de consolidação prática.

| Assunto | Material para revisão | Situação |
|---|---|---|
| CROSS JOIN versus GROUP BY | [Semana 03 — Dia 02](semana-03/dia-02.md) | Revisar em novos exercícios |
| JOIN versus UNION ALL | [Semana 03 — Dia 02](semana-03/dia-02.md) | Revisar em novos exercícios |
| Distribuição circular com módulo | [Semana 03 — Dia 02](semana-03/dia-02.md) | Revisar em novos exercícios |
| Quando utilizar ROW_NUMBER | [Semana 03 — Dia 02](semana-03/dia-02.md) | Revisar em novos exercícios |
| Constraints que criam índices | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Reforço pendente |
| FOREIGN KEY versus índice | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Reforço pendente |
| Índice versus estratégia de acesso | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Reforço pendente |
| Seletividade | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Reforço pendente |
| Linhas lidas versus retornadas | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Reforço pendente |
| Predicate versus Seek Predicates | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Aprofundamento pendente |
| Planos de execução reais | [Semana 03 — Dia 03 — Parte 01](semana-03/dia-03-parte-01.md) | Prática pendente |

Os assuntos deverão ter seus status revisados conforme novos exercícios forem realizados e validados.

## 8. Manutenção deste documento

O índice deverá ser atualizado ao final de cada sessão de estudos, juntamente com a elaboração do relatório técnico e didático.

### 8.1. Procedimento de atualização

- Adicionar o novo relatório ao índice cronológico.
- Identificar os conceitos novos estudados.
- Adicionar as referências ao índice por assunto.
- Complementar as referências de assuntos aprofundados.
- Registrar novos scripts SQL.
- Atualizar os assuntos que necessitam de reforço.
- Atualizar a data e o marco atual.
- Verificar os caminhos dos arquivos e links.
- Registrar a alteração no histórico de revisões.
- Versionar o índice juntamente com os demais arquivos da aula.

### 8.2. Critérios de organização

- Preservar os conteúdos anteriormente registrados.
- Evitar duplicação desnecessária de assuntos.
- Utilizar links relativos ao repositório.
- Referenciar seções específicas dos relatórios quando possível.
- Diferenciar conteúdos estudados de conteúdos planejados.
- Diferenciar introdução teórica de prática validada.
- Não registrar atividades como concluídas sem confirmação.
- Não presumir o conteúdo de relatórios indisponíveis.

### 8.3. Responsabilidades

A professora deverá orientar a atualização deste índice durante o encerramento de cada aula.

A estudante deverá salvar as alterações no repositório local e realizar o versionamento.

Ao final de cada semana, a versão atualizada também deverá substituir a versão anterior nas fontes do projeto ChatGPT.

## 9. Histórico de revisões

| Versão | Data | Descrição |
|---|---|---|
| 1.0 | 27/11/2026 | Criação do índice inicial, contemplando os conteúdos registrados das Semanas 01, 02 e 03 até o Dia 03 — Parte 01. |