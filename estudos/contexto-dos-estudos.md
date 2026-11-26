# IgrejaApp — Contexto e continuidade dos estudos

**Versão:** 1.0 | **Atualização:** 25/11/2026  
**Marco:** Semana 03, Dia 02 concluído | **Próximo desafio:** 98  
**Repositório:** https://github.com/marianeteixeira/igreja-app  
**Último commit confirmado:** `0817e38` — `feat: conclui geracao de massa de dados do laboratorio`

## 1. Finalidade e uso deste documento

Este documento preserva o contexto técnico e pedagógico da formação Backend .NET + SQL Server, utilizando o IgrejaApp como projeto prático e futuro case de portfólio. Deve ser consultado ao iniciar uma nova conversa no projeto do ChatGPT. Não substitui o plano original, os relatórios diários, as regras de negócio nem o código versionado.

Em caso de divergência, consultar os arquivos atuais do repositório e o plano original antes de decidir. Não presumir acesso ao GitHub ou a conversas antigas. Solicitar somente os arquivos ou informações que estiverem faltando. Não inventar resultados de exercícios, commits ou decisões.

## 2. Perfil e objetivos de aprendizagem

A estudante atua profissionalmente como analista de sistemas. Possui conhecimentos prévios de SQL básico, que devem ser tratados como revisão, e deseja aprofundar SQL Server, desempenho, C# e desenvolvimento backend .NET por meio de implementação prática. O objetivo não é apenas produzir um sistema funcional, mas compreender as decisões, conseguir implementar soluções autonomamente e explicar os fundamentos técnicos.

## 3. Metodologia de ensino

- Atuar como professora, conduzindo a formação progressivamente, em português brasileiro.
- Explicar conceitos e propor desafios numerados; aguardar a tentativa da estudante antes de fornecer a solução completa.
- Corrigir objetivamente, explicando o motivo de cada ajuste. Diferenciar erros de sintaxe, lógica, desempenho e estilo.
- Quando houver dificuldade, dividir o problema em etapas menores e oferecer pistas graduais, exemplos reduzidos e perguntas orientadoras.
- Evitar exercícios excessivamente básicos ou repetitivos. Aumentar a complexidade conforme o domínio demonstrado.
- Não confundir uma solução fornecida pela professora com uma solução desenvolvida autonomamente pela estudante.
- Validar resultados reais apresentados pela estudante antes de declarar uma execução bem-sucedida.
- Manter a numeração dos desafios entre conversas. Último desafio abordado: 97.
- Não modificar regras de negócio nem o plano de 24 semanas sem necessidade justificada e discussão com a estudante.
- Ao final, produzir relatório técnico em Markdown, com explicações didáticas, revisão de conceitos relevantes, dificuldades, correções, resultados confirmados, pendências e planejamento da próxima sessão.

### Gestão do tempo

Plano de referência: 24 semanas, aproximadamente 3 horas semanais, normalmente três sessões de uma hora. Ajustar a duração conforme o limite informado pela estudante no início da aula. Reservar os últimos 15 minutos para documentação e versionamento; não iniciar novos desafios próximo ao encerramento. Na Semana 03, Dia 02, o limite solicitado de 1h30 foi ultrapassado. Evitar repetir esse problema. O horário deve ser confirmado quando necessário, sem presumir capacidade de monitoramento em segundo plano.

## 4. Planejamento da formação

O PDF original do plano de estudos Backend .NET + SQL Server (v2) é a referência oficial. O resumo abaixo é um registro de continuidade, não uma transcrição integral do PDF. Consultar o documento original para detalhar semanas futuras.

| Semana | Tema registrado | Situação |
|---|---|---|
| 01 | Modelo inicial, tabelas e fundamentos | Concluída |
| 02 | Presença, integridade e consultas | Concluída |
| 03 | Massa de dados e planos de execução | Dias 01 e 02 concluídos; Dia 03 pendente |
| 04 | Índices e métricas; índice composto, INCLUDE, STATISTICS IO/TIME | Prevista |
| 05 | JOINs e cardinalidade | Prevista |
| 06 | Funções de janela, CTE, CROSS APPLY e paginação | Prevista |
| 07 | Transações, concorrência e tratamento de exceções | Prevista |
| 08 | Query Store, DMVs e RLS | Prevista |
| 09 | C# moderno | Prevista |
| 10 | Camadas e injeção de dependência | Prevista |
| 11 | EF Core e operações assíncronas | Prevista |
| 12 | ASP.NET API | Prevista |
| 13 | Autenticação | Prevista |
| 14 | Autorização | Prevista |
| 15 | Interface | Prevista |
| 16 | Testes | Prevista |
| 17–24 | Consultar o PDF original para os temas exatos | Previstas |

A geração de massa foi dividida entre os dias 01 e 02 da Semana 03, sem alteração do planejamento geral.

## 5. Contexto do produto

O IgrejaApp é um sistema web para gerenciamento de pessoas, atividades e presença em igrejas, com suporte a múltiplas organizações e isolamento de dados. O MVP contempla cadastro e pesquisa de pessoas, cadastro de atividades e controle de presença. Objetivos posteriores incluem aniversariantes, relatórios e controle de acesso por permissões.

### Regras consolidadas e decisões de modelagem

- Organização pode ser desativada sem excluir seu histórico. Data de fundação e telefone podem ser desconhecidos.
- Pessoa pode ser visitante antes de ingressar oficialmente. `IsIngressada` e `DataIngresso` são independentes: a data pode ser desconhecida mesmo para membro ingressado.
- `IsAtiva` representa participação atual, não o ingresso oficial. Uma pessoa ingressada deve possuir organização; visitantes podem possuir ou não esse vínculo.
- Óbito deve ser distinguido de inatividade; modelagem de falecimento ainda pendente.
- Vínculo de frequência e exercício da função de Mestre são relacionamentos distintos. O Mestre pode visitar outras igrejas; não deve ser confundido com membro vinculado simultaneamente a outra igreja por frequência.
- Uma atividade pode ter várias organizações responsáveis. Organizações organizadoras, organizações participantes e permissões de acesso são conceitos distintos.
- Uma pessoa pode participar de atividades de outras organizações. Registrar observação de visitante foi uma sugestão, não uma obrigação definida.
- Presença registra participação positiva; ausência não é um registro de presença negativo. Relatórios de ausência dependem de critérios de elegibilidade, eventualmente históricos.
- Uma pessoa não pode ter duas presenças na mesma atividade; uma organização não pode aparecer duas vezes como organizadora da mesma atividade.

### Decisões conceituais ainda não implementadas

- Endereço em tabela própria, compartilhável. Pessoas mantêm endereço atual; ao mudar, devem referenciar outro registro sem alterar o endereço compartilhado. Organização pode ter histórico de endereços quando conhecido.
- Classificação oficial de organização concedida pela sede, com data de concessão e possibilidade de histórico em tabela de relacionamento. Uma classificação pode ser utilizada por várias organizações.
- Departamento como referência comum; atividades podem ter departamento responsável e múltiplos departamentos participantes. Modelagem detalhada pendente.
- Papéis previstos: Admin Master (acesso geral e atribuição de igrejas), Mestre (gestão das igrejas autorizadas e permissões de missassaguistas), Missassaguista (funções liberadas).
- Proposta de acesso a relatórios de outras igrejas: solicitação visível ao Admin Master e ao Mestre da igreja detentora; primeira decisão de aprovação ou rejeição prevalece; registrar histórico. Implementação e detalhes pendentes.

Consultar `docs/regras-de-negocio.md` para a versão oficial das regras. Não tratar propostas como funcionalidades implementadas.

## 6. Ambiente e estrutura atual

Windows, SQL Server 2019 (versão 15.0 RTM observada no SSMS), SSMS, VS Code e Git. Branch `main`. Banco `IgrejaApp` para desenvolvimento; `IgrejaApp_Laboratorio` para experimentos de desempenho. Versão exata do SSMS ainda não confirmada.

### Esquema implementado

| Tabela | Colunas e tipos |
|---|---|
| Organizacao | OrganizacaoId INT IDENTITY(1,1) PK; Nome NVARCHAR(150) NOT NULL; Telefone VARCHAR(20) NULL; IsAtiva BIT NOT NULL DEFAULT 1; DataFundacao DATE NULL |
| Pessoa | PessoaId INT IDENTITY(1,1) PK; Nome NVARCHAR(150) NOT NULL; DataNascimento DATE NULL; DataIngresso DATE NULL; IsIngressada BIT NOT NULL DEFAULT 0; IsAtiva BIT NOT NULL DEFAULT 1; Telefone NVARCHAR(20) NULL; OrganizacaoId INT NULL FK |
| Atividade | AtividadeId INT IDENTITY(1,1) PK; Nome NVARCHAR(150) NOT NULL; DataHoraRealizacao DATETIME2 NULL; Local NVARCHAR(150) NULL |
| AtividadeOrganizadora | AtividadeId INT NOT NULL FK; OrganizacaoId INT NOT NULL FK; PK composta (AtividadeId, OrganizacaoId) |
| Presenca | PessoaId INT NOT NULL FK; AtividadeId INT NOT NULL FK; Observacao NVARCHAR(500) NULL; PK composta (PessoaId, AtividadeId) |

`CK_Pessoa_Organizacao`: `CHECK (IsIngressada = 0 OR OrganizacaoId IS NOT NULL)`.

Convenções: nomes de tabelas e colunas em português, identificadores com sufixo Id, booleanos com prefixo Is, constraints nomeadas explicitamente (PK_, FK_, DF_, CK_). Conferir nomes exatos no script oficial; não presumir que todos seguem o mesmo padrão após renomeações.

## 7. Organização do repositório

```text
igreja-app/
  README.md
  database/scripts/
    001-criacao-tabelas.sql
    002-insercao-dados-teste.sql
    003-consultas-relatorios.sql
    004-geracao-massa-dados.sql
  docs/regras-de-negocio.md
  estudos/
    contexto-dos-estudos.md
    semana-01/
    semana-02/
    semana-03/
      dia-01.md
      dia-02.md
```

Manter o esquema SQL consolidado em 001 e os dados fictícios e testes em 002, utilizando o histórico do Git em vez de múltiplos scripts de pequenas alterações nesta fase. Reavaliar quando forem estudadas migrations do EF Core. O plano em PDF deve permanecer como referência; confirmar seu nome e localização reais antes de citar um caminho.

Fluxo de encerramento: `git status`, `git add` dos arquivos relevantes, `git commit -m "mensagem"`, `git push`, `git status`. O último status confirmou árvore limpa e sincronização com origin/main. Aviso LF/CRLF observado no Windows não impediu o commit.

## 8. Histórico de aprendizagem

### Semana 01 — Modelagem e ambiente

Dia 01: modelagem conceitual de Organização, Pessoa e Atividade; cardinalidade, atributos, obrigatoriedade, classificação, endereço e vínculo. Aula 01 concluída com 4/4 acertos; início da Aula 02.

Dia 02: instalação do Git, clonagem do repositório, criação do banco IgrejaApp no SSMS, criação de Organização e Pessoa, tipos de dados, IDENTITY, PK, FK, DEFAULT, NULL e NOT NULL. Renomeação de Ativa para IsAtiva. Preferência por constraints explicitamente nomeadas.

O fechamento detalhado da Semana 01 e a divisão exata dos desafios não estão integralmente recuperados neste documento. Consultar os relatórios diários antes de reconstruir esse histórico.

### Semana 02 — Presença, integridade e consultas

Consolidação das cinco tabelas, relacionamentos N:N, chaves compostas, CHECK de vínculo de pessoa ingressada, dados fictícios e testes negativos de integridade. Foram testadas violações de FK, PK composta e CHECK (erros 547 e 2627). Dados de teste incluem três organizações, três pessoas, duas atividades e uma presença.

Dia 03 (17/11/2026), desafios 71–78: relatórios de participantes, JOINs, contagem de presenças e organizações, multiplicação de linhas, COUNT DISTINCT, NOT IN e NOT EXISTS, subconsultas correlacionadas, pessoas ativas e ingressadas sem presença em um período. Intervalo de datas semiaberto: `DataHoraRealizacao >= @DataInicial AND DataHoraRealizacao < DATEADD(DAY, 1, @DataFinal)`. Evitar funções na coluna filtrada quando possível (sargabilidade). Script 003 e relatório versionados no commit `e5d7986`.

Consultar relatórios dos dias 01 e 02 para a sequência exata dos desafios anteriores a 71.

### Semana 03 — Dia 01 (23/11/2026), desafios 79–91

Criação do laboratório separado; geração set-based de 10 organizações e 100 mil pessoas. Conceitos: VALUES, CROSS JOIN, ROW_NUMBER, CTE, CONCAT, INSERT INTO SELECT, módulo, distribuição circular, UNION ALL. Combinação de cinco conjuntos de dez valores para produzir 100 mil linhas. Ordenação de ROW_NUMBER com critérios que distinguem as combinações; retorno BIGINT; CTE não garante materialização. Distribuição de pessoas: `((Sequencia - 1) % 10) + 1`. Confirmadas 10 mil pessoas por organização. Script 004 iniciado. Sessão de aproximadamente duas horas.

### Semana 03 — Dia 02 (25/11/2026), desafios 92–97

| Desafio | Conteúdo e resultado |
|---|---|
| 92 | Planejamento: 100 mil pessoas × 10 presenças = 1 milhão; CROSS JOIN direto com mil atividades produziria 100 milhões. |
| 93 | Geração de mil atividades com três conjuntos de dez valores, ROW_NUMBER, DATEADD e DATETIME2. |
| 94 | Inserção e validação de atividades; proteção de banco e tabelas vazias. |
| 95 | Geração de 1.200 relacionamentos atividade-organização, utilizando UNION ALL e módulo. |
| 96 | Geração de um milhão de presenças com CROSS JOIN e distribuição circular. |
| 97 | Validações gerais e agrupamentos em dois níveis; consultas finais de presença fornecidas pela professora para poupar tempo e executadas pela estudante. |

A estudante desenvolveu as fórmulas com orientação progressiva. Dificuldades principais: distinguir JOIN de UNION ALL; diferenciar multiplicação de linhas de agrupamento; distribuir presenças entre mil atividades sem limitar o resultado a dez; reconhecer quando ROW_NUMBER é desnecessário. Corrigiu a data inicial subtraindo 1 da sequência e utilizou CAST para DATETIME2. Aprendeu EXISTS para verificar existência e os parâmetros de THROW. Relatório e script 004 versionados no commit 0817e38; push confirmado.

## 9. Laboratório: geração e resultados confirmados

| Tabela | Registros |
|---|---:|
| Organizacao | 10 |
| Pessoa | 100.000 |
| Atividade | 1.000 |
| AtividadeOrganizadora | 1.200 |
| Presenca | 1.000.000 |
| Total | 1.102.210 |

- Organizações com IDs de 1 a 10; 10 mil pessoas por organização; todas as pessoas ingressadas e ativas.
- Atividades com IDs de 1 a 1.000, uma por dia, de 01/01/2024 a 26/09/2026, às 19h; dez locais com cem atividades cada.
- 800 atividades com uma organização e 200 com duas; todas as atividades possuem organizadora.
- Todas as 100 mil pessoas e mil atividades aparecem em Presenca; dez presenças por pessoa e mil por atividade. Todas as validações foram confirmadas por resultados do SSMS.

### Fórmulas de referência

```sql
-- Datas das atividades
DATEADD(DAY, Sequencia - 1, CAST('2024-01-01T19:00:00' AS DATETIME2))
-- Organização principal
((AtividadeId - 1) % 10) + 1
-- Organização adicional (WHERE AtividadeId % 5 = 0)
(AtividadeId % 10) + 1
-- Presenças: CROSS JOIN de Pessoa com VALUES de 0 a 9
((PessoaId + A.Numero - 1) % 1000) + 1
```

### Segurança e limitações

O script 004 utiliza DB_NAME e THROW 50001 para proteger o banco; EXISTS e códigos 50002–50006 para verificar tabelas vazias. A proteção depende da execução do lote completo, não de inserções isoladas. Tabelas vazias não garantem IDENTITY reiniciado. O script pressupõe identificadores nos intervalos previstos e ainda não possui tratamento transacional integral. Não executar novamente as inserções no laboratório preenchido; selecionar apenas as consultas de validação.

A massa é determinística e predominantemente uniforme, adequada a experimentos iniciais controlados, mas não representa a diversidade de produção. Todas as pessoas são ativas e ingressadas; horários e frequências são fixos; organizações adicionais concentram-se nos IDs 1 e 6. Essas características podem afetar seletividade, estatísticas e estimativas do otimizador. Não houve comparação de desempenho medida até este marco.

## 10. Conceitos a preservar e revisar

| Conceito | Ponto de atenção |
|---|---|
| PK, FK, CHECK, DEFAULT | Integridade, regras de negócio e valores padrão |
| IDENTITY | Geração automática não implica unicidade nem ausência de lacunas |
| INNER/LEFT JOIN | Cardinalidade e preservação de linhas sem correspondência |
| COUNT(*) / COUNT(coluna) / COUNT(DISTINCT coluna) | Linhas, valores não nulos e valores únicos não nulos |
| NOT EXISTS / NOT IN | Ausência de correspondência; cuidado com NULL em NOT IN |
| CROSS JOIN | Produto cartesiano; calcular cardinalidade antes de executar |
| UNION / UNION ALL | Combinação vertical; eliminação de duplicidades somente no UNION |
| GROUP BY | Agrupar, não multiplicar registros; agrupamentos sucessivos para validar distribuição |
| ROW_NUMBER | Sequência; ordenação determinística exige critérios que distingam linhas |
| CTE | Escopo de uma instrução; não é tabela permanente |
| Módulo (%) | Distribuição circular e ajuste de intervalo iniciado em 1 |
| DATEADD e DATETIME2 | Tipo de retorno depende da entrada; datas semiabertas em filtros |
| EXISTS | Testar existência sem exigir contagem total |
| THROW | Número, mensagem, estado; nova exceção tem severidade 16 |

Priorizar revisão prática das dificuldades com CROSS JOIN, GROUP BY, UNION ALL e módulo, sem repetir toda a matéria. A estudante demonstrou capacidade de corrigir soluções e validar resultados. Não presumir domínio autônomo das consultas de presença fornecidas prontas.

## 11. Pendências técnicas e próxima aula

### IntelliSense

Ctrl+Shift+R resolveu o reconhecimento de tabelas, mas permaneceram sublinhados em THROW e END. O teste isolado retornou intencionalmente `Msg 50001, Level 16, State 1` com a mensagem definida. A estudante informou que funciona apesar das marcações. Provável falso positivo do IntelliSense; causa específica e versão do SSMS ainda não confirmadas. Verificar brevemente na próxima aula, sem substituir THROW nem executar novamente a geração completa. Não confundir marcação do editor com erro efetivo do servidor.

### Semana 03 — Dia 03

Começar pelo desafio 98, após confirmar o tempo disponível. Objetivo: introdução aos planos de execução usando o laboratório já preenchido.

- Explicar otimizador, plano estimado e plano real.
- Analisar uma consulta sobre Pessoa, identificar operadores, Scan/Seek e estimativas de cardinalidade.
- Comparar linhas estimadas e reais; interpretar custos como estimativas, não tempos medidos.
- Registrar evidências dos planos e conclusões no relatório `estudos/semana-03/dia-03.md`.
- Reservar os últimos 15 minutos para documentação e Git.
- Manter índices compostos, INCLUDE e comparação detalhada com STATISTICS IO/TIME para a Semana 04.

Não iniciar novamente a geração de massa. Não declarar resultados de planos antes de receber evidências. A sequência de exercícios ainda será definida durante a aula.

## 12. Rotina de manutenção do contexto

Ao final de cada aula, salvar o relatório diário e versionar as alterações. Ao final de cada semana, atualizar este documento com o progresso, último desafio, dificuldades, decisões, pendências e ponto de retomada. Atualizar regras de negócio quando forem efetivamente definidas. Manter uma cópia atualizada deste arquivo e do plano original nas fontes do projeto ChatGPT; substituir versões antigas para evitar divergências.

Sugestão de organização: uma conversa por semana dentro do mesmo projeto. A conversa atual contém as Semanas 01–03. Ao abrir a conversa seguinte, solicitar leitura deste documento e do plano, confirmar o último marco e continuar a numeração. A memória do ChatGPT é complementar, não garantia de recuperação integral do histórico.

## 13. Instrução curta para retomada

> Continue minha formação Backend .NET + SQL Server no projeto IgrejaApp. Consulte contexto-dos-estudos.md, o plano original e os relatórios relevantes. Atue como professora, com desafios progressivos e sem entregar soluções completas antes da minha tentativa. Preserve regras de negócio, numeração e cronograma. Confirme o tempo disponível e reserve 15 minutos para encerramento. O último marco registrado é Semana 03, Dia 02 concluído; a próxima aula é Semana 03, Dia 03, desafio 98, sobre planos de execução. Se algum documento estiver indisponível, informe a lacuna antes de presumir seu conteúdo.
