# Semana 03 — Dia 03 — Parte 01

## Análise de desempenho e planos de execução no SQL Server

## 1. Identificação da aula

- **Projeto:** IgrejaApp
- **Data:** 27/11/2026
- **Semana:** 03
- **Aula:** Dia 03 — Parte 01
- **Horário de início:** 18h45
- **Duração planejada:** 1h30
- **Horário previsto de encerramento:** 20h15
- **Banco de dados utilizado:** IgrejaApp_Laboratorio
- **Desafios realizados:** 98 a 103
- **Próximo desafio:** 104

A aula foi dividida em duas sessões para permitir maior aprofundamento dos conceitos de análise de desempenho, respeitando o tempo disponível e priorizando a consolidação do aprendizado.

## 2. Objetivos da aula

- Compreender os fundamentos de desempenho de consultas SQL.
- Conhecer o funcionamento do Query Optimizer.
- Diferenciar planos de execução estimados e reais.
- Interpretar a representação gráfica dos planos de execução.
- Compreender operações lógicas e físicas.
- Identificar operadores Scan e Seek.
- Interpretar estimativas de cardinalidade.
- Compreender os custos estimados de execução.
- Introduzir o conceito de seletividade.
- Desenvolver autonomia na análise de desempenho.

Nesta primeira parte, o foco foi a interpretação dos planos de execução estimados. A análise prática dos planos reais será realizada na próxima sessão.

## 3. Revisão dos conhecimentos anteriores

### 3.1. Modelagem e integridade dos dados

Nas primeiras semanas, foram estudados os fundamentos de modelagem relacional e implementadas as seguintes tabelas:

- Organizacao
- Pessoa
- Atividade
- AtividadeOrganizadora
- Presenca

Foram aplicados conceitos como:

- PRIMARY KEY;
- FOREIGN KEY;
- CHECK;
- DEFAULT;
- IDENTITY;
- obrigatoriedade de campos;
- relacionamentos 1:N e N:N;
- chaves primárias compostas;
- integridade referencial.

Esses conhecimentos são importantes para a análise de desempenho porque a estrutura das tabelas, as constraints e os índices disponíveis influenciam as estratégias consideradas pelo otimizador.

### 3.2. Consultas SQL

Nas aulas anteriores, foram desenvolvidas consultas utilizando:

- INNER JOIN;
- LEFT JOIN;
- GROUP BY;
- COUNT;
- COUNT DISTINCT;
- subconsultas;
- NOT EXISTS;
- NOT IN;
- filtros por intervalos de datas.

Também foi introduzido o conceito de sargabilidade, relacionado à possibilidade de utilizar condições de pesquisa que favoreçam o acesso eficiente aos dados por meio de índices.

Até então, o foco principal das consultas era garantir a corretude dos resultados.

A partir desta aula, passou-se a considerar também o trabalho necessário para produzir esses resultados.

### 3.3. Massa de dados do laboratório

Nas duas primeiras aulas da Semana 03, foi criada e validada uma massa de dados específica para estudos de desempenho.

| Tabela | Quantidade de registros |
|---|---:|
| Organizacao | 10 |
| Pessoa | 100.000 |
| Atividade | 1.000 |
| AtividadeOrganizadora | 1.200 |
| Presenca | 1.000.000 |
| **Total** | **1.102.210** |

Características relevantes da massa de dados:

- Cada organização possui 10.000 pessoas.
- Todas as pessoas estão ativas.
- Todas as pessoas estão ingressadas.
- Cada pessoa possui 10 registros de presença.
- Cada atividade possui 1.000 registros de presença.
- A distribuição dos dados é determinística e uniforme.

A distribuição uniforme facilita a compreensão inicial dos planos de execução, mas não representa necessariamente a distribuição encontrada em ambientes reais de produção.

## 4. Verificação do ambiente de desenvolvimento

Foi retomada a investigação das marcações incorretas apresentadas pelo IntelliSense do SQL Server Management Studio.

### 4.1. Versões identificadas

| Componente | Versão |
|---|---|
| SQL Server Management Studio | 15.0.18369.0 |
| SQL Server Management Objects | 16.100.46041.41 |
| SQL Server Database Engine | SQL Server 2019 |
| Sistema operacional | Windows 10 — Build 19045 |

### 4.2. Problema identificado

O IntelliSense apresenta marcações de erro nas instruções THROW e END, mesmo quando o código é reconhecido e executado corretamente pelo SQL Server.

Na aula anterior, foi realizado um teste isolado da instrução THROW, confirmando seu funcionamento no mecanismo do banco de dados.

### 4.3. IntelliSense versus Database Engine

O IntelliSense é um recurso do editor responsável por funcionalidades como:

- autocompletar;
- sugestões de código;
- identificação de objetos;
- análise de sintaxe durante a edição.

O Database Engine é o componente responsável pela interpretação, compilação e execução efetiva das instruções SQL.

Portanto, uma marcação de erro no IntelliSense não comprova necessariamente a existência de um erro na instrução SQL.

### 4.4. Decisão técnica

Não alterar instruções SQL válidas apenas para eliminar marcações do IntelliSense.

A versão antiga do SSMS pode estar relacionada ao comportamento observado, mas a causa exata ainda não foi confirmada.

A atualização do SSMS foi registrada como melhoria futura do ambiente de desenvolvimento, sem bloquear a continuidade dos estudos.

## 5. Fundamentos de análise de desempenho

Uma consulta SQL deve ser avaliada tanto pela corretude dos resultados quanto pelos recursos necessários para sua execução.

Entre os principais recursos analisados estão:

| Recurso | Descrição |
|---|---|
| CPU | Processamento necessário para executar as operações. |
| I/O | Operações de entrada e saída, incluindo acesso às páginas de dados. |
| Memória | Recursos utilizados durante o processamento. |
| Tempo de execução | Tempo decorrido até a conclusão da consulta. |

Uma consulta que retorna poucos registros não é necessariamente mais eficiente do que uma consulta que retorna muitos registros.

É necessário distinguir:

- quantidade de registros lidos;
- quantidade de registros processados;
- quantidade de registros retornados;
- recursos consumidos durante a execução.

Uma consulta pode ler milhares de registros, realizar diversos relacionamentos e retornar apenas uma linha.

## 6. Desafio 98 — Raciocínio inicial sobre desempenho

Foram analisadas conceitualmente três consultas sobre a tabela Pessoa.

### Consulta A — Pesquisa por identificador

```sql
SELECT *
FROM Pessoa
WHERE PessoaId = 50000;
```

### Consulta B — Pesquisa por organização

```sql
SELECT *
FROM Pessoa
WHERE OrganizacaoId = 5;
```

### Consulta C — Pesquisa por situação cadastral

```sql
SELECT *
FROM Pessoa
WHERE IsAtiva = 1;
```

### Resultados esperados

| Consulta | Registros esperados |
|---|---:|
| A | 1 |
| B | 10.000 |
| C | 100.000 |

Foi identificado corretamente que a consulta A tende a exigir menos trabalho para localizar os registros, devido à possibilidade de utilização do índice associado à chave primária.

Também foi compreendido que percorrer todos os registros pode ser uma estratégia adequada quando a consulta precisa retornar toda a tabela.

A quantidade de registros retornados, isoladamente, não determina o desempenho de uma consulta.

**Resultado:** 4 de 4 respostas corretas.

**Situação:** validado.

## 7. SQL como linguagem declarativa

SQL é uma linguagem predominantemente declarativa.

Ao escrever uma consulta, informa-se qual resultado deve ser obtido, sem determinar diretamente todos os algoritmos e operações necessários para produzi-lo.

Exemplo:

```sql
SELECT Nome
FROM Pessoa
WHERE PessoaId = 50000;
```

A consulta declara:

- a informação desejada;
- a tabela de origem;
- a condição de pesquisa.

O mecanismo do banco de dados determina a estratégia utilizada para localizar e retornar a informação.

Essa característica diferencia a consulta declarativa de uma implementação imperativa, na qual seriam descritas explicitamente as etapas de processamento.

## 8. Processamento de consultas no SQL Server

De maneira simplificada, a compilação e execução de uma consulta envolvem os seguintes componentes.

### 8.1. Parser

Responsável pela análise sintática da instrução SQL.

### 8.2. Binder / Algebrizer

Responsável pela resolução de referências a objetos, colunas e tipos de dados, além de outras transformações necessárias à representação lógica da consulta.

### 8.3. Query Optimizer

Responsável por avaliar estratégias de execução e selecionar um plano considerado adequado com base nas informações disponíveis.

### 8.4. Execution Engine

Responsável pela execução das operações definidas no plano.

### 8.5. Fluxo simplificado

```text
Instrução SQL
      |
      v
Parser
      |
      v
Binder / Algebrizer
      |
      v
Query Optimizer
      |
      v
Execution Engine
      |
      v
Resultado
```

Esse fluxo representa de maneira simplificada uma compilação seguida de execução.

O SQL Server também pode reutilizar planos previamente compilados, evitando a necessidade de realizar todo o processo de otimização novamente.

## 9. Query Optimizer

O Query Optimizer é o componente responsável pela seleção das estratégias de execução das consultas.

O SQL Server utiliza um otimizador baseado em custos, denominado Cost-Based Optimizer.

Entre as informações consideradas estão:

- estrutura das tabelas;
- índices disponíveis;
- estatísticas;
- distribuição dos dados;
- estimativas de cardinalidade;
- condições de pesquisa;
- relacionamentos entre tabelas;
- custos estimados de CPU e I/O.

O otimizador não executa todas as alternativas possíveis para descobrir qual delas é mais rápida.

Ele avalia alternativas utilizando estimativas e possui limites de tempo e esforço durante o processo de otimização.

Consequentemente, o plano escolhido não é necessariamente o melhor plano possível em todas as situações.

### 9.1. Importância das estatísticas

As estatísticas fornecem informações sobre a distribuição dos valores dos dados.

Essas informações auxiliam o otimizador na estimativa da quantidade de registros que poderá ser retornada por determinada condição.

Estatísticas desatualizadas ou estimativas inadequadas podem contribuir para a escolha de estratégias menos eficientes.

Por exemplo, uma estratégia escolhida considerando poucas linhas pode apresentar desempenho inadequado quando precisa processar uma quantidade muito maior.

## 10. Desafio 99 — Entendendo o otimizador

Foi analisada a possibilidade de uma mesma consulta apresentar planos diferentes em ambientes distintos.

Mesmo quando dois ambientes possuem a mesma estrutura de tabelas e índices, diferenças no volume e na distribuição dos dados podem influenciar as decisões do otimizador.

Também foi compreendido que o otimizador trabalha com estimativas, em vez de executar previamente todas as estratégias possíveis.

As respostas sobre linguagem declarativa e utilização de estatísticas receberam complementações técnicas.

**Resultado:** quatro respostas conceitualmente corretas, com complementações.

**Situação:** validado.

## 11. Planos de execução

Um plano de execução representa as operações selecionadas pelo SQL Server para processar uma instrução SQL.

Sua análise permite identificar:

- estratégias de acesso aos dados;
- índices utilizados;
- aplicação de filtros;
- operações de relacionamento;
- estimativas de cardinalidade;
- custos estimados;
- informações coletadas durante a execução, quando disponíveis.

O plano de execução é uma das principais ferramentas utilizadas no diagnóstico de desempenho de consultas.

## 12. Plano de execução estimado e real

### 12.1. Estimated Execution Plan

O plano estimado apresenta a estratégia escolhida pelo otimizador sem executar efetivamente a consulta.

No SSMS, pode ser solicitado por meio do atalho:

```text
Ctrl + L
```

Permite analisar operadores, estimativas de cardinalidade e custos antes da execução.

### 12.2. Actual Execution Plan

O plano real apresenta o plano utilizado durante a execução da consulta, acompanhado de informações coletadas durante o processamento.

No SSMS, pode ser habilitado por meio do atalho:

```text
Ctrl + M
```

Após habilitar a opção, é necessário executar a consulta.

### 12.3. Comparação

| Característica | Plano estimado | Plano real |
|---|---|---|
| Executa a consulta | Não | Sim |
| Apresenta operadores | Sim | Sim |
| Apresenta estimativas de cardinalidade | Sim | Sim |
| Apresenta cardinalidade real | Não | Sim |
| Apresenta custos estimados | Sim | Sim |
| Apresenta informações de execução | Não | Sim |

Mesmo no plano real, os percentuais de custo dos operadores continuam sendo estimativas.

Nesta sessão, foram utilizados apenas planos estimados. A geração e interpretação prática dos planos reais permanecem pendentes.

## 13. Desafio 100 — Primeiro plano de execução

Foi gerado o plano estimado da seguinte consulta:

```sql
SELECT *
FROM Pessoa
WHERE PessoaId = 50000;
```

### 13.1. Resultado observado

O plano apresentou:

- SELECT;
- Clustered Index Seek;
- índice PK_Pessoa;
- seta de fluxo com pequena espessura.

### 13.2. Fluxo dos dados

```text
SELECT <----- Clustered Index Seek
                    |
                    v
                PK_Pessoa
```

Na representação gráfica do SSMS, o fluxo dos dados ocorre da direita para a esquerda.

A espessura da seta está relacionada à quantidade de linhas estimadas ou efetivamente processadas, dependendo do plano apresentado.

Neste caso, a pequena espessura é compatível com a estimativa de apenas uma linha.

### 13.3. Mensagem apresentada

Foi observada a mensagem:

```text
(1 row affected)
```

Como foi solicitado apenas o plano estimado, essa mensagem não comprova a execução da consulta original nem a recuperação efetiva de uma pessoa.

Não foram apresentados registros na aba de resultados.

### 13.4. Avaliação

Inicialmente, a direção do fluxo foi identificada incorretamente, sendo posteriormente corrigida pela estudante após observar novamente o plano.

**Situação:** validado após correção.

## 14. Propriedades dos operadores

As propriedades dos operadores podem ser visualizadas posicionando o cursor sobre o operador ou utilizando a janela de propriedades do SSMS.

Entre as principais propriedades estudadas estão:

| Propriedade | Significado |
|---|---|
| Physical Operation | Operação física utilizada. |
| Logical Operation | Operação lógica representada. |
| Estimated Number of Executions | Quantidade estimada de execuções. |
| Estimated Number of Rows Per Execution | Quantidade estimada de linhas retornadas por execução. |
| Estimated Number of Rows to be Read | Quantidade estimada de linhas a serem lidas. |
| Estimated I/O Cost | Custo estimado de I/O. |
| Estimated CPU Cost | Custo estimado de CPU. |
| Estimated Operator Cost | Custo estimado do operador. |
| Estimated Subtree Cost | Custo estimado da subárvore do operador. |
| Estimated Row Size | Tamanho estimado da linha de saída. |
| Object | Objeto ou índice acessado. |
| Seek Predicates | Condições utilizadas na busca direcionada. |
| Predicate | Condição de filtragem aplicada pelo operador. |

A nomenclatura de algumas propriedades pode variar conforme a versão do SSMS.

## 15. Desafio 101 — Investigação das propriedades

Foram identificadas as propriedades do operador Clustered Index Seek apresentado na consulta A.

### Resultados observados

| Propriedade | Valor |
|---|---|
| Physical Operation | Clustered Index Seek |
| Logical Operation | Clustered Index Seek |
| Estimated Execution Mode | Row |
| Storage | RowStore |
| Estimated Number of Executions | 1 |
| Estimated Number of Rows Per Execution | 1 |
| Estimated Number of Rows to be Read | 1 |
| Estimated I/O Cost | 0,003125 |
| Estimated CPU Cost | 0,0001581 |
| Estimated Operator Cost | 0,0032831 |
| Estimated Subtree Cost | 0,0032831 |
| Estimated Row Size | 198 B |
| Ordered | True |
| Participação no custo da consulta | 100% |

### Objeto acessado

```text
[IgrejaApp_Laboratorio].[dbo].[Pessoa].[PK_Pessoa]
```

### Seek Predicates

```text
Seek Keys[1]: Prefix:
[IgrejaApp_Laboratorio].[dbo].[Pessoa].PessoaId
= Scalar Operator([@1])
```

A estudante identificou corretamente todas as propriedades solicitadas e observou a diferença de nomenclatura da propriedade relacionada à quantidade estimada de linhas.

**Resultado:** 9 de 9 propriedades identificadas corretamente.

**Situação:** validado.

## 16. Operações lógicas e físicas

### 16.1. Logical Operation

Representa o trabalho lógico que precisa ser realizado.

### 16.2. Physical Operation

Representa o algoritmo ou mecanismo utilizado para realizar esse trabalho.

Uma mesma operação lógica pode ser implementada por diferentes operações físicas.

Por exemplo, uma operação lógica Inner Join pode ser executada utilizando:

- Nested Loops;
- Hash Match;
- Merge Join.

A escolha depende das características da consulta, das estimativas e das estruturas disponíveis.

Esses operadores serão aprofundados durante os estudos de JOINs e cardinalidade na Semana 05.

## 17. Cardinalidade

No contexto dos planos de execução, cardinalidade representa a quantidade de linhas associada ao resultado de uma operação.

O otimizador utiliza estimativas de cardinalidade para auxiliar na avaliação das estratégias de execução.

### 17.1. Linhas lidas versus linhas retornadas

Um operador pode precisar ler uma quantidade de registros superior à quantidade retornada.

Exemplo hipotético:

| Cenário | Linhas lidas | Linhas retornadas |
|---|---:|---:|
| A | 100.000 | 10 |
| B | 10 | 10 |

Embora os dois cenários retornem a mesma quantidade de registros, o trabalho realizado pode ser significativamente diferente.

Também é necessário distinguir linhas lidas de páginas de dados lidas.

Uma busca que retorna apenas uma linha pode precisar acessar diversas páginas para navegar pela estrutura de um índice.

A análise das páginas lidas será aprofundada na Semana 04.

## 18. Custos estimados

O SQL Server utiliza um modelo interno de custos para avaliar estratégias de execução.

### 18.1. Estimated I/O Cost

Representa o componente estimado de custo associado às operações de entrada e saída.

### 18.2. Estimated CPU Cost

Representa o componente estimado de custo associado ao processamento.

### 18.3. Estimated Operator Cost

Representa o custo estimado atribuído ao operador.

No operador analisado na consulta A, foi observada a seguinte composição:

```text
Estimated I/O Cost:       0,003125
Estimated CPU Cost:       0,0001581
Estimated Operator Cost:  0,0032831
```

### 18.4. Interpretação dos custos

Os custos estimados não devem ser interpretados diretamente como:

- segundos;
- milissegundos;
- quantidade de páginas lidas;
- percentual real de utilização da CPU;
- tempo efetivamente gasto pelo operador.

São valores utilizados pelo modelo de custos do otimizador.

### 18.5. Custo absoluto versus percentual

O custo absoluto representa o valor estimado atribuído à operação.

O percentual representa sua participação relativa no custo estimado da consulta.

Um operador com custo de 100% não é necessariamente ineficiente.

Ele pode simplesmente concentrar todo ou praticamente todo o custo estimado de uma consulta de baixo custo.

Outros operadores podem apresentar 0% devido ao arredondamento.

## 19. Object e Seek Predicates

### 19.1. Object

A propriedade Object permite identificar a estrutura utilizada pelo operador.

No plano analisado:

```text
[IgrejaApp_Laboratorio].[dbo].[Pessoa].[PK_Pessoa]
```

Os componentes representam:

- IgrejaApp_Laboratorio: banco de dados;
- dbo: schema;
- Pessoa: tabela;
- PK_Pessoa: índice.

Essa propriedade será utilizada posteriormente para verificar se novos índices foram escolhidos pelo otimizador.

### 19.2. Seek Predicates

A propriedade Seek Predicates apresenta as condições utilizadas para localizar chaves ou intervalos de chaves dentro do índice.

Na consulta A, a condição foi representada internamente por:

```text
PessoaId = @1
```

Embora a consulta original tenha utilizado o valor literal 50000, o plano apresentou um parâmetro interno.

Esse comportamento está associado à parametrização automática da consulta pelo SQL Server.

A parametrização não foi aprofundada nesta sessão.

## 20. Desafio 102 — Interpretação de custos e cardinalidade

Foram comparados dois operadores, sendo o primeiro baseado no plano estimado da consulta A e o segundo um exemplo hipotético.

| Propriedade | Operador A | Operador B |
|---|---:|---:|
| Linhas estimadas para leitura | 1 | 100.000 |
| Linhas estimadas de saída | 1 | 1 |
| Estimated I/O Cost | 0,003125 | 0,350000 |
| Estimated CPU Cost | 0,0001581 | 0,110000 |
| Estimated Operator Cost | 0,0032831 | 0,460000 |
| Participação no custo da consulta | 100% | 100% |

Foi identificado corretamente que o operador A apresenta menor quantidade estimada de trabalho.

Também foi compreendido que:

- custos percentuais iguais não implicam custos absolutos iguais;
- custos estimados não representam diretamente medidas de tempo;
- retornar a mesma quantidade de registros não significa realizar o mesmo trabalho;
- planos estimados não comprovam as quantidades efetivamente processadas.

**Resultado:** 5 de 5 respostas corretas, com ajuste de terminologia sobre o custo percentual.

**Situação:** validado.

## 21. Scan e Seek

### 21.1. Seek

Estratégia que utiliza a estrutura de um índice para localizar diretamente uma chave ou um intervalo de chaves.

Pode reduzir a quantidade de registros examinados quando existe um índice adequado à condição de pesquisa.

### 21.2. Scan

Estratégia que percorre páginas de uma tabela ou índice para obter os registros necessários.

Pode aplicar condições de filtragem durante o processamento.

Um Scan não precisa necessariamente percorrer toda a estrutura em todos os cenários, embora isso tenha ocorrido nas estimativas das consultas B e C estudadas.

### 21.3. Principais operadores de acesso

| Operador | Descrição |
|---|---|
| Table Scan | Percurso de uma tabela sem índice clustered, denominada heap. |
| Clustered Index Scan | Percurso do índice clustered. |
| Index Scan | Percurso de um índice nonclustered. |
| Clustered Index Seek | Busca direcionada em um índice clustered. |
| Index Seek | Busca direcionada em um índice nonclustered. |

### 21.4. Interpretação

Um Seek não é necessariamente melhor do que um Scan.

A adequação da estratégia depende de fatores como:

- quantidade de dados solicitada;
- distribuição dos registros;
- índices disponíveis;
- colunas necessárias;
- custos estimados;
- características da consulta.

Quando uma consulta precisa retornar grande parte dos registros, uma varredura pode ser a estratégia mais eficiente.

## 22. Constraints e índices

Durante os desafios, foi identificada uma dúvida sobre a relação entre chaves estrangeiras e índices.

### 22.1. Criação de índices

| Constraint | Cria índice automaticamente? |
|---|---|
| PRIMARY KEY | Sim, normalmente por meio de um índice único. |
| UNIQUE | Sim, normalmente por meio de um índice único. |
| FOREIGN KEY | Não. |
| CHECK | Não. |
| DEFAULT | Não. |

### 22.2. Chaves estrangeiras

Uma FOREIGN KEY estabelece uma regra de integridade referencial entre tabelas.

Sua criação não implica a criação automática de um índice na coluna que referencia outra tabela.

No IgrejaApp:

- Pessoa.PessoaId possui o índice PK_Pessoa.
- Organizacao.OrganizacaoId possui seu próprio índice de chave primária.
- Pessoa.OrganizacaoId não possui um índice próprio criado automaticamente pela FOREIGN KEY.

O índice existente na tabela Organizacao não permite localizar diretamente os registros correspondentes na tabela Pessoa.

Cada índice pertence à estrutura da tabela em que foi definido.

### 22.3. Índice versus estratégia de acesso

Outro conceito reforçado foi a diferença entre a estrutura do índice e a operação utilizada para acessá-la.

O mesmo índice pode ser utilizado por um Scan ou por um Seek.

A existência de um Clustered Index Scan não significa ausência de índice.

## 23. Seletividade

A seletividade de um filtro está relacionada à proporção de registros que atendem à sua condição.

Considerando uma tabela com 100.000 pessoas:

| Pessoas ativas | Proporção | Interpretação do filtro IsAtiva = 1 |
|---|---:|---|
| 100.000 | 100% | Pouco seletivo |
| 90.000 | 90% | Pouco seletivo |
| 1.000 | 1% | Mais seletivo |

Quanto menor a proporção de registros que atende ao filtro, mais seletivo ele é.

Um índice adequado pode apresentar maior vantagem quando permite localizar uma pequena parcela dos registros, evitando o acesso a dados desnecessários.

Entretanto, a seletividade não é o único fator considerado na decisão de utilizar um índice.

No laboratório atual, todas as pessoas estão ativas. Portanto, o filtro IsAtiva = 1 retorna a totalidade da tabela.

A criação de índices será estudada na Semana 04.

## 24. Desafio 103 — Comparação de planos de execução

Foram gerados os planos estimados das três consultas estudadas inicialmente no Desafio 98.

### Consulta A

```sql
SELECT *
FROM Pessoa
WHERE PessoaId = 50000;
```

### Consulta B

```sql
SELECT *
FROM Pessoa
WHERE OrganizacaoId = 5;
```

### Consulta C

```sql
SELECT *
FROM Pessoa
WHERE IsAtiva = 1;
```

### 24.1. Resultados observados no laboratório

| Propriedade | Consulta A | Consulta B | Consulta C |
|---|---:|---:|---:|
| Operador físico | Clustered Index Seek | Clustered Index Scan | Clustered Index Scan |
| Operador lógico | Clustered Index Seek | Clustered Index Scan | Clustered Index Scan |
| Linhas estimadas para leitura | 1 | 100.000 | 100.000 |
| Linhas estimadas de saída | 1 | 10.000 | 100.000 |
| Estimated I/O Cost | 0,003125 | 0,478681 | 0,478681 |
| Estimated CPU Cost | 0,0001581 | 0,110157 | 0,110157 |
| Estimated Operator Cost | 0,0032831 | 0,588838 | 0,588838 |
| Estimated Subtree Cost | 0,0032831 | 0,588838 | 0,588838 |
| Estimated Number of Executions | 1 | 1 | 1 |
| Estimated Row Size | 198 B | 198 B | 198 B |
| Índice utilizado | PK_Pessoa | PK_Pessoa | PK_Pessoa |
| Ordered | True | False | False |
| Participação no custo da consulta | 100% | 100% | 100% |

Os valores foram conferidos por meio das capturas de tela dos planos apresentados pelo SSMS.

### 24.2. Análise da consulta A

A consulta utilizou o índice PK_Pessoa por meio de um Clustered Index Seek.

O operador estimou a leitura de uma linha para retornar uma linha.

Esse resultado é compatível com uma busca direcionada pela chave primária.

### 24.3. Análise da consulta B

A consulta utilizou um Clustered Index Scan.

O operador estimou:

- leitura de 100.000 registros;
- retorno de 10.000 registros;
- diferença de 90.000 registros entre leitura e saída.

A condição de pesquisa não utiliza a chave do índice PK_Pessoa.

A FOREIGN KEY existente na coluna OrganizacaoId não criou automaticamente um índice próprio nessa coluna.

### 24.4. Análise da consulta C

A consulta também utilizou um Clustered Index Scan.

O operador estimou a leitura e o retorno de 100.000 registros.

Como todas as pessoas do laboratório estão ativas, a utilização de uma varredura não caracteriza, isoladamente, um problema de desempenho.

### 24.5. Comparação dos custos

Os operadores Scan apresentaram custo absoluto estimado aproximadamente 179,35 vezes superior ao custo do operador Seek.

Esse valor representa uma comparação entre custos estimados.

Não permite afirmar que as consultas B e C serão executadas em um tempo 179,35 vezes maior.

### 24.6. Comparação entre as consultas B e C

As consultas B e C apresentaram o mesmo custo estimado de acesso, embora possuam cardinalidades de saída diferentes.

Esse comportamento reforça que a quantidade de registros retornados não determina, isoladamente, o custo do processamento.

### 24.7. Mesmo índice, estratégias diferentes

As três consultas utilizaram o índice PK_Pessoa.

A consulta A realizou uma busca direcionada, enquanto as consultas B e C realizaram uma varredura.

Portanto, a diferença observada não está na existência de índices distintos, mas na estratégia utilizada para acessar a mesma estrutura.

## 25. Predicate e conversão implícita

Durante a análise da consulta B, foi observada a seguinte condição:

```text
OrganizacaoId = CONVERT_IMPLICIT(int, [@1], 0)
```

A função CONVERT_IMPLICIT representa uma conversão implícita de tipo de dados realizada pelo SQL Server.

Nesse plano, a conversão foi aplicada ao parâmetro, e não à coluna OrganizacaoId.

Sua presença, isoladamente, não comprova um problema de desempenho.

Na consulta C, foi observado o seguinte predicado:

```text
IsAtiva = [@1]
```

A propriedade Predicate representa uma condição de filtragem aplicada pelo operador.

A diferença entre Predicate e Seek Predicates será aprofundada na próxima sessão.

As conversões implícitas e seus possíveis impactos sobre o desempenho serão estudados com maior profundidade na Semana 05.

## 26. Avaliação dos desafios

| Desafio | Conteúdo | Situação |
|---|---|---|
| 98 | Fundamentos de desempenho | Validado |
| 99 | Query Optimizer | Validado |
| 100 | Primeiro plano estimado | Validado após correção |
| 101 | Propriedades dos operadores | Validado |
| 102 | Interpretação de custos e cardinalidade | Validado |
| 103 | Comparação entre Scan e Seek | Resultados validados; conceitos a reforçar |

## 27. Dificuldades identificadas

Durante a aula, foram identificados os seguintes pontos que necessitam de reforço:

- distinção entre chaves estrangeiras e índices;
- identificação das constraints que criam índices;
- diferença entre estrutura de índice e estratégia de acesso;
- influência da seletividade na utilização de índices;
- distinção entre linhas lidas e linhas retornadas.

A interpretação dos valores apresentados nos planos estimados demonstrou boa evolução.

A estudante conseguiu relacionar custos, cardinalidade e estratégias de acesso para justificar suas conclusões.

As dificuldades identificadas estão concentradas principalmente nos fundamentos estruturais dos índices e em algumas precisões de terminologia.

## 28. Principais conhecimentos consolidados

- SQL é uma linguagem predominantemente declarativa.
- O Query Optimizer utiliza estimativas para selecionar estratégias de execução.
- Consultas idênticas podem apresentar planos diferentes em ambientes distintos.
- O plano estimado não executa a consulta original.
- O fluxo dos dados no plano gráfico ocorre da direita para a esquerda.
- Custos estimados não representam diretamente tempo de execução.
- Um operador com custo de 100% não é necessariamente ineficiente.
- Linhas lidas e linhas retornadas representam informações diferentes.
- Scan e Seek são estratégias de acesso aos dados.
- Um mesmo índice pode ser utilizado por um Scan ou por um Seek.
- Uma FOREIGN KEY não cria automaticamente um índice.
- A seletividade influencia a adequação das estratégias de acesso.
- Um Scan não caracteriza necessariamente um problema de desempenho.

## 29. Decisões técnicas e pedagógicas

### 29.1. Decisões técnicas

- Preservar a estrutura atual do banco de dados.
- Não criar novos índices durante a Semana 03.
- Utilizar exclusivamente o banco IgrejaApp_Laboratorio nos exercícios de desempenho.
- Registrar as consultas utilizadas em um script SQL específico.
- Manter os resultados dos planos estimados como referência inicial.
- Não alterar instruções SQL válidas em função das marcações do IntelliSense.

Nenhuma tabela, constraint, regra de negócio ou registro da massa de dados foi alterado nesta sessão.

### 29.2. Decisões pedagógicas

A aula foi dividida em duas sessões para permitir a consolidação dos conceitos e respeitar o limite de tempo estabelecido.

A decisão foi tomada considerando:

- o tempo disponível;
- as dificuldades identificadas;
- a necessidade de realizar exercícios adicionais;
- a importância da análise prática de planos reais;
- a necessidade de reservar tempo para documentação e versionamento.

O planejamento oficial de 24 semanas permanece inalterado.

## 30. Formação profissional e práticas ágeis

Foi mantida a abordagem de desenvolvimento incremental, com avaliação dos resultados e adaptação da sessão conforme as dificuldades identificadas.

A divisão da aula representa uma aplicação prática dos princípios de inspeção e adaptação.

A formação profissional será organizada considerando quatro pilares complementares:

1. Desenvolvimento Backend.
2. Gestão Ágil.
3. Engenharia de Software.
4. Cultura e práticas DevOps.

A formalização dessas diretrizes no documento mestre será realizada no encerramento da Semana 03.

A retrospectiva semanal também permanece pendente, pois a semana ainda não foi efetivamente concluída.

## 31. Planejamento da próxima sessão

### Semana 03 — Dia 03 — Parte 02

**Próximo desafio:** 104.

Conteúdo previsto:

- revisão de Scan e Seek;
- revisão da relação entre constraints e índices;
- reforço do conceito de seletividade;
- aprofundamento de Seek Predicates e Predicate;
- geração de planos de execução reais;
- comparação entre cardinalidade estimada e real;
- análise das quantidades efetivamente processadas;
- interpretação de informações de execução;
- desafio de diagnóstico com maior autonomia;
- revisão dos objetivos da Semana 03.

Não serão antecipados os estudos de criação de índices compostos, INCLUDE e comparação de métricas com STATISTICS IO e STATISTICS TIME, previstos para a Semana 04.

### Encerramento semanal previsto

- Realizar a primeira retrospectiva semanal formal.
- Elaborar o relatório da Parte 02.
- Complementar o script de análise de desempenho.
- Atualizar contexto-dos-estudos.md para a versão 1.1.
- Completar o resumo do planejamento das 24 semanas no documento mestre.
- Registrar as diretrizes de Agile e DevOps.
- Revisar regras-de-negocio.md e atualizar os status das regras já implementadas.
- Versionar as alterações.
- Substituir os arquivos atualizados nas fontes do projeto ChatGPT.
- Preparar a transição para a Semana 04.
- Iniciar uma nova conversa dentro do projeto após a conclusão da semana.

## 32. Arquivos relacionados

| Arquivo | Ação |
|---|---|
| database/scripts/005-analise-desempenho.sql | Criação prevista nesta sessão. |
| estudos/semana-03/dia-03-parte-01.md | Relatório elaborado nesta sessão. |
| database/scripts/001-criacao-tabelas.sql | Sem alterações. |
| database/scripts/004-geracao-massa-dados.sql | Sem alterações. |
| docs/regras-de-negocio.md | Revisão pendente para o encerramento semanal. |
| estudos/contexto-dos-estudos.md | Atualização pendente para o encerramento semanal. |

## 33. Checklist de encerramento

- [x] Realização dos desafios 98 a 103.
- [x] Geração dos planos estimados das consultas A, B e C.
- [x] Conferência dos resultados apresentados pelo SSMS.
- [x] Registro das dificuldades identificadas.
- [x] Definição do ponto de continuidade.
- [x] Elaboração do relatório técnico e didático.
- [ ] Salvamento do relatório no repositório local.
- [ ] Salvamento do script SQL no repositório local.
- [ ] Git add.
- [ ] Git commit.
- [ ] Git push.
- [ ] Validação do estado final do repositório.

## 34. Conclusão

Nesta sessão, foram iniciados os estudos de análise de desempenho de consultas no SQL Server, utilizando a massa de dados previamente criada e validada no laboratório do IgrejaApp.

Foi possível compreender o funcionamento geral do otimizador, interpretar planos estimados e identificar diferenças entre estratégias de acesso aos dados.

Os exercícios demonstraram que a quantidade de registros retornados não é suficiente para avaliar o desempenho de uma consulta e que a análise deve considerar diferentes propriedades dos operadores.

A sessão também permitiu identificar conceitos que necessitam de reforço, especialmente aqueles relacionados à estrutura dos índices, constraints e seletividade.

A próxima sessão dará continuidade aos estudos por meio da análise de planos reais, comparação de cardinalidades e exercícios de diagnóstico.

A Semana 03 permanece em andamento.