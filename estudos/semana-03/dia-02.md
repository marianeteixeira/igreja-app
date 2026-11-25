# Semana 03 — Dia 02 | Geração e validação de massa de dados

## 1. Identificação da aula

- **Projeto:** IgrejaApp
- **Data:** 25/11/2026
- **Semana:** 03
- **Dia:** 02
- **Módulo:** Banco de dados e fundamentos de SQL
- **Tema:** Geração de massa de dados e preparação para estudos de desempenho
- **Banco de dados:** IgrejaApp_Laboratorio
- **Ferramentas:** SQL Server, SQL Server Management Studio (SSMS), Git e Visual Studio Code
- **Desafios:** 92 a 97
- **Horário de início:** 18h18
- **Duração planejada:** 1h30
- **Duração efetiva:** superior a 2h14
- **Status técnico:** Concluído

---

## 2. Objetivos da aula

Dar continuidade à construção da massa de dados iniciada no Dia 01, finalizando o preenchimento das tabelas do banco de dados de laboratório e preparando o ambiente para os estudos de planos de execução e desempenho de consultas SQL.

### Objetivos específicos

- Gerar 1.000 atividades fictícias.
- Gerar os relacionamentos entre atividades e organizações.
- Simular atividades organizadas individualmente e em conjunto.
- Gerar 1.000.000 de registros de presença.
- Garantir a integridade referencial dos registros.
- Aplicar técnicas de geração de dados baseadas em conjuntos.
- Consolidar o script de geração de massa de dados.
- Implementar mecanismos de proteção contra execuções indevidas.
- Validar as quantidades e a distribuição dos registros.
- Preparar o ambiente para análise de planos de execução.

---

## 3. Revisão dos conteúdos anteriores

### 3.1. Modelagem relacional

Nas primeiras semanas do projeto, foram definidas e implementadas cinco tabelas que representam a estrutura inicial do sistema IgrejaApp:

| Tabela | Responsabilidade |
|---|---|
| Organizacao | Armazenar as organizações cadastradas no sistema. |
| Pessoa | Armazenar membros e visitantes. |
| Atividade | Armazenar cerimônias, reuniões e eventos. |
| AtividadeOrganizadora | Relacionar atividades às organizações responsáveis. |
| Presenca | Registrar a participação das pessoas nas atividades. |

A estrutura permite representar relacionamentos de um para muitos (1:N) e muitos para muitos (N:N).

As tabelas AtividadeOrganizadora e Presenca funcionam como tabelas associativas, permitindo representar relacionamentos N:N sem comprometer a normalização do banco de dados.

### 3.2. Integridade dos dados

Foram revisados os mecanismos de integridade implementados nas aulas anteriores.

| Constraint | Finalidade |
|---|---|
| PRIMARY KEY | Identificar unicamente cada registro. |
| FOREIGN KEY | Garantir a existência dos registros referenciados. |
| CHECK | Garantir o cumprimento de determinadas regras de negócio. |
| DEFAULT | Definir valores padrão durante a inserção. |
| NOT NULL | Impedir a ausência de valores em campos obrigatórios. |

Também foi revisado o conceito de chave primária composta.

Na tabela Presenca, a combinação de PessoaId e AtividadeId identifica unicamente uma participação.

Isso significa que:

- Uma pessoa pode participar de diversas atividades.
- Uma atividade pode receber diversas pessoas.
- Uma pessoa não pode possuir dois registros de presença para a mesma atividade.

A mesma lógica é aplicada à tabela AtividadeOrganizadora, cuja chave primária é composta por AtividadeId e OrganizacaoId.

### 3.3. IDENTITY

A propriedade IDENTITY permite que o SQL Server gere automaticamente valores numéricos durante a inserção de registros.

Exemplo:

`PessoaId INT IDENTITY(1,1)`

O primeiro parâmetro representa o valor inicial e o segundo representa o incremento.

Entretanto, IDENTITY não garante, isoladamente:

- Unicidade dos valores.
- Ausência de lacunas na sequência.
- Continuidade dos identificadores após exclusões.
- Reinício da numeração após a execução de DELETE.

A unicidade é garantida pela constraint PRIMARY KEY ou UNIQUE.

Essa distinção é importante porque as fórmulas utilizadas na geração da massa de dados dependem de intervalos conhecidos de identificadores.

No laboratório, foi adotado um cenário controlado, com tabelas inicialmente vazias e identificadores iniciados em 1.

### 3.4. Consultas e relatórios

Nas aulas anteriores, foram desenvolvidas consultas utilizando:

- INNER JOIN.
- LEFT JOIN.
- GROUP BY.
- COUNT.
- COUNT DISTINCT.
- Subconsultas.
- NOT IN.
- NOT EXISTS.
- Filtros por intervalos de datas.

Esses conhecimentos foram reutilizados durante a validação da massa de dados, principalmente para contabilizar registros, verificar relacionamentos e analisar distribuições.

Também foi revisado o problema da multiplicação de registros ao relacionar tabelas com múltiplas ocorrências.

Nesses casos, COUNT DISTINCT pode ser necessário para contabilizar entidades únicas, evitando resultados inflados pela cardinalidade dos relacionamentos.

---

## 4. Revisão da geração de massa de dados — Dia 01

Na aula anterior, foi criado o banco IgrejaApp_Laboratorio, separado do banco de desenvolvimento IgrejaApp.

Essa separação permite realizar experimentos com grandes volumes de dados sem comprometer o ambiente principal do projeto.

Foram gerados:

| Tabela | Quantidade |
|---|---:|
| Organizacao | 10 |
| Pessoa | 100.000 |

As pessoas foram distribuídas uniformemente entre as dez organizações, utilizando operações matemáticas e consultas baseadas em conjuntos.

Os principais conceitos utilizados foram:

- VALUES como construtor de tabelas.
- CROSS JOIN.
- ROW_NUMBER.
- Common Table Expression (CTE).
- INSERT INTO SELECT.
- Operador módulo (%).
- Distribuição circular.
- UNION ALL.

A aula atual reutilizou esses conceitos para preencher as demais tabelas do laboratório.

---

## 5. Operações baseadas em conjuntos — Set-based

A geração de massa de dados foi realizada utilizando operações baseadas em conjuntos, também conhecidas como operações set-based.

Em vez de inserir cada registro individualmente por meio de estruturas de repetição, como WHILE, foi utilizada uma consulta capaz de produzir diversos registros em uma única operação de inserção.

Exemplo conceitual:

    INSERT INTO Tabela (Coluna)
    SELECT Coluna
    FROM Origem;

Nesse modelo, o SQL Server processa o conjunto de registros produzido pela consulta.

### Vantagens

- Redução da necessidade de estruturas de repetição.
- Código mais compacto e declarativo.
- Melhor aproveitamento dos mecanismos internos do banco de dados.
- Facilidade para gerar grandes volumes de registros.
- Maior facilidade de reprodução dos testes.

Embora operações set-based frequentemente sejam mais eficientes que o processamento linha a linha, o desempenho efetivo depende da consulta, dos índices, da estrutura das tabelas e dos recursos disponíveis.

Nesta aula, não foram realizadas medições comparativas de desempenho.

---

## 6. Desafio 92 — Planejamento da geração de presenças

Antes de iniciar as inserções, foi analisada a quantidade de registros necessária para atingir a meta de um milhão de presenças.

### Cenário definido

| Entidade | Quantidade |
|---|---:|
| Pessoas | 100.000 |
| Atividades | 1.000 |
| Presenças por pessoa | 10 |
| Total de presenças | 1.000.000 |

O cálculo utilizado foi:

100.000 pessoas × 10 presenças = 1.000.000 de registros.

Foi identificado que realizar um CROSS JOIN diretamente entre todas as pessoas e todas as atividades produziria:

100.000 × 1.000 = 100.000.000 de registros.

Esse volume seria cem vezes maior que a quantidade planejada.

Portanto, tornou-se necessário desenvolver uma estratégia que produzisse somente dez registros de presença para cada pessoa, distribuindo-os entre as mil atividades existentes.

### Regras consideradas

- Cada pessoa deve possuir dez presenças distintas.
- Uma pessoa pode participar de atividades organizadas por outras organizações.
- A chave primária composta deve ser respeitada.
- Todos os identificadores utilizados devem existir nas tabelas referenciadas.

Também foi discutida a possibilidade de identificar participantes visitantes de outras organizações por meio de observações.

Essa possibilidade foi levantada como sugestão de evolução, não sendo estabelecida como uma nova regra obrigatória do sistema nesta aula.

---

## 7. Desafio 93 — Geração das atividades

Para gerar as atividades, foi reutilizada a técnica de combinação de conjuntos numéricos.

Foram combinados três conjuntos contendo dez registros cada.

10 × 10 × 10 = 1.000 combinações.

A função ROW_NUMBER foi utilizada para atribuir uma sequência numérica às combinações geradas.

### Estrutura utilizada

    ;WITH Numeros AS (
        SELECT ROW_NUMBER() OVER (
            ORDER BY A.Numero, B.Numero, C.Numero
        ) AS Sequencia
        FROM (VALUES
            (1),(2),(3),(4),(5),
            (6),(7),(8),(9),(10)
        ) AS A(Numero)
        CROSS JOIN (VALUES
            (11),(12),(13),(14),(15),
            (16),(17),(18),(19),(20)
        ) AS B(Numero)
        CROSS JOIN (VALUES
            (21),(22),(23),(24),(25),
            (26),(27),(28),(29),(30)
        ) AS C(Numero)
    )
    SELECT
        CONCAT('Atividade ', Sequencia) AS Nome,
        DATEADD(
            DAY,
            Sequencia - 1,
            CAST('2024-01-01T19:00:00' AS DATETIME2)
        ) AS DataHoraRealizacao,
        CONCAT(
            'Local ',
            ((Sequencia - 1) % 10) + 1
        ) AS Local
    FROM Numeros;

A consulta produz mil atividades com nomes sequenciais, datas consecutivas e distribuição circular entre dez locais.

### 7.1. Revisão do CROSS JOIN

O CROSS JOIN realiza o produto cartesiano entre dois conjuntos.

Exemplo:

| Conjunto A |
|---:|
| 1 |
| 2 |

| Conjunto B |
|---|
| A |
| B |
| C |

Resultado:

| Numero | Letra |
|---:|---|
| 1 | A |
| 1 | B |
| 1 | C |
| 2 | A |
| 2 | B |
| 2 | C |

Cada registro do primeiro conjunto é combinado com todos os registros do segundo.

Diferentemente do INNER JOIN, o CROSS JOIN não necessita de uma condição ON para estabelecer correspondências.

Essa característica permite utilizá-lo para gerar grandes quantidades de combinações a partir de pequenos conjuntos.

### 7.2. Revisão do ROW_NUMBER

A função ROW_NUMBER atribui uma numeração sequencial aos registros de um conjunto.

Sintaxe:

    ROW_NUMBER() OVER (ORDER BY Coluna)

A cláusula ORDER BY dentro de OVER determina a ordem utilizada para atribuição da numeração.

Quando existem empates nas colunas utilizadas para ordenação, a associação entre os registros empatados e seus respectivos números pode não ser determinística.

Por esse motivo, foram utilizadas todas as colunas necessárias para distinguir as combinações.

Também foi revisado que ROW_NUMBER retorna um valor do tipo BIGINT e não garante, por si só, a ordenação final da apresentação dos resultados.

### 7.3. Revisão de CTE

Uma Common Table Expression é um conjunto de resultados nomeado, definido para utilização na instrução SQL imediatamente seguinte.

Sintaxe:

    ;WITH NomeCTE AS (
        SELECT ...
    )
    SELECT *
    FROM NomeCTE;

A CTE permite dividir uma consulta complexa em etapas lógicas, facilitando sua leitura e manutenção.

Uma CTE:

- Não cria uma tabela permanente.
- Não permanece disponível para consultas posteriores.
- Não garante a materialização física dos resultados.
- Pode ser utilizada em instruções como SELECT, INSERT, UPDATE e DELETE.

O ponto e vírgula antes de WITH garante o encerramento de uma eventual instrução anterior.

---

## 8. Manipulação de datas com DATEADD

Para distribuir as atividades ao longo do tempo, foi utilizada a função DATEADD.

Sintaxe:

    DATEADD(parte_da_data, quantidade, data)

Exemplo:

    SELECT DATEADD(DAY, 1, '2024-01-01');

A função adiciona a quantidade informada à parte da data especificada.

### 8.1. Correção da data inicial

Inicialmente, foi utilizada a sequência diretamente como quantidade de dias:

    DATEADD(DAY, Sequencia, '2024-01-01 19:00')

Como ROW_NUMBER inicia a numeração em 1, a primeira atividade seria gerada em 02/01/2024, e não em 01/01/2024.

Foi necessário ajustar a expressão:

    DATEADD(DAY, Sequencia - 1, ...)

Dessa forma:

| Sequencia | Dias adicionados | Data resultante |
|---:|---:|---|
| 1 | 0 | 01/01/2024 |
| 2 | 1 | 02/01/2024 |
| 3 | 2 | 03/01/2024 |
| 4 | 3 | 04/01/2024 |

Também foi avaliada uma solução utilizando duas chamadas de DATEADD, posteriormente simplificada para uma única operação.

### 8.2. DATETIME e DATETIME2

Foi revisado que o tipo de retorno de DATEADD depende do tipo do argumento utilizado como data.

Quando uma data é informada diretamente como literal textual, DATEADD retorna DATETIME.

Para garantir que a expressão trabalhasse explicitamente com DATETIME2, foi utilizada uma conversão:

    CAST('2024-01-01T19:00:00' AS DATETIME2)

A expressão final foi:

    DATEADD(
        DAY,
        Sequencia - 1,
        CAST('2024-01-01T19:00:00' AS DATETIME2)
    )

DATETIME2 oferece maior precisão e um intervalo de datas mais amplo em comparação com DATETIME.

Também foi utilizado o formato ISO 8601 para representar a data e o horário, reduzindo ambiguidades relacionadas às configurações regionais.

---

## 9. Desafio 94 — Inserção e validação das atividades

Após validar a consulta responsável pela geração das atividades, foi realizada a inserção na tabela Atividade.

A inserção utilizou a estrutura INSERT INTO SELECT, aproveitando os registros produzidos pela CTE.

### Resultados obtidos

| Indicador | Resultado |
|---|---|
| Total de atividades | 1.000 |
| Menor AtividadeId | 1 |
| Maior AtividadeId | 1.000 |
| Primeira atividade | 01/01/2024 às 19h |
| Última atividade | 26/09/2026 às 19h |
| Quantidade de locais | 10 |
| Atividades por local | 100 |

Todos os resultados foram posteriormente confirmados por meio de consultas executadas no SQL Server.

---

## 10. Distribuição circular e operador módulo

O operador módulo (%) retorna o resto de uma divisão inteira.

Exemplos:

| Expressão | Resultado |
|---|---:|
| 5 % 3 | 2 |
| 10 % 3 | 1 |
| 9 % 3 | 0 |
| 11 % 10 | 1 |

Esse operador foi utilizado para distribuir registros entre intervalos conhecidos de identificadores.

### Fórmula de distribuição circular

    ((Sequencia - 1) % Quantidade) + 1

O módulo produz valores entre zero e Quantidade - 1, considerando os valores não negativos utilizados neste laboratório.

A soma de 1 ajusta o intervalo para iniciar em 1.

Exemplo com dez organizações:

| Sequencia | OrganizacaoId |
|---:|---:|
| 1 | 1 |
| 2 | 2 |
| 9 | 9 |
| 10 | 10 |
| 11 | 1 |
| 12 | 2 |
| 20 | 10 |
| 21 | 1 |

A distribuição é reiniciada sempre que o limite do intervalo é atingido.

Essa técnica foi aplicada:

- Na distribuição das pessoas entre organizações.
- Na distribuição das atividades entre locais.
- Na definição das organizações responsáveis pelas atividades.
- Na distribuição das presenças entre atividades.

### Distribuição determinística e aleatória

Uma distribuição determinística produz resultados previsíveis a partir dos mesmos valores de entrada.

Uma distribuição aleatória pode produzir resultados diferentes a cada execução.

Para o laboratório, foi escolhida uma distribuição determinística, facilitando a validação dos resultados e a reprodução dos experimentos.

---

## 11. Desafio 95 — Geração das atividades organizadoras

A tabela AtividadeOrganizadora representa o relacionamento entre atividades e organizações responsáveis.

Para simular diferentes cenários, foi definido que:

- Todas as atividades devem possuir pelo menos uma organização responsável.
- A cada cinco atividades, uma deve possuir uma segunda organização responsável.
- Nenhuma combinação de atividade e organização pode ser duplicada.

### 11.1. Organização principal

A organização principal foi definida utilizando:

    ((AtividadeId - 1) % 10) + 1

Essa expressão distribui as mil atividades entre as dez organizações.

Cada organização recebe inicialmente cem atividades.

### 11.2. Identificação das atividades conjuntas

Para identificar as atividades que receberiam uma segunda organização, foi utilizado:

    WHERE AtividadeId % 5 = 0

A condição seleciona os identificadores divisíveis por cinco.

Exemplos:

| AtividadeId | Recebe segunda organização? |
|---:|---|
| 1 | Não |
| 4 | Não |
| 5 | Sim |
| 6 | Não |
| 10 | Sim |
| 15 | Sim |

Como existem mil atividades, foram selecionadas duzentas atividades conjuntas.

### 11.3. Segunda organização

A segunda organização foi definida utilizando:

    (AtividadeId % 10) + 1

A fórmula seleciona a organização seguinte dentro do intervalo de 1 a 10, considerando a distribuição da organização principal.

Exemplo:

| AtividadeId | Organização principal | Segunda organização |
|---:|---:|---:|
| 5 | 5 | 6 |
| 10 | 10 | 1 |
| 15 | 5 | 6 |
| 20 | 10 | 1 |

Dessa forma, a segunda organização é diferente da organização principal.

### 11.4. Consolidação dos relacionamentos

Para combinar os registros da organização principal com os registros da segunda organização, foi utilizado UNION ALL.

    INSERT INTO AtividadeOrganizadora (
        AtividadeId,
        OrganizacaoId
    )
    SELECT
        AtividadeId,
        ((AtividadeId - 1) % 10) + 1
    FROM Atividade

    UNION ALL

    SELECT
        AtividadeId,
        (AtividadeId % 10) + 1
    FROM Atividade
    WHERE AtividadeId % 5 = 0;

Resultado:

| Tipo de relacionamento | Quantidade |
|---|---:|
| Organização principal | 1.000 |
| Organização adicional | 200 |
| Total | 1.200 |

---

## 12. Revisão de JOIN, UNION e UNION ALL

Durante o desenvolvimento do Desafio 95, foi identificada uma dificuldade inicial na escolha entre JOIN e UNION ALL.

Apesar de ambos permitirem combinar informações de diferentes conjuntos, suas finalidades são distintas.

### JOIN

Relaciona registros entre conjuntos, geralmente utilizando condições de correspondência, permitindo combinar suas colunas.

Exemplo:

    SELECT
        PES.Nome,
        ORG.Nome
    FROM Pessoa PES
    INNER JOIN Organizacao ORG
        ON PES.OrganizacaoId = ORG.OrganizacaoId;

Nesse cenário, o objetivo é obter informações relacionadas entre pessoas e organizações.

### UNION

Combina verticalmente os resultados de duas ou mais consultas e elimina linhas duplicadas.

### UNION ALL

Combina verticalmente os resultados de duas ou mais consultas, preservando todas as linhas produzidas.

Exemplo:

    SELECT 1 AS Numero
    UNION ALL
    SELECT 1;

Resultado:

| Numero |
|---:|
| 1 |
| 1 |

Com UNION, o resultado conteria apenas uma linha.

### Comparação

| Operação | Finalidade |
|---|---|
| JOIN | Relacionar registros e combinar colunas. |
| UNION | Combinar resultados e eliminar duplicidades. |
| UNION ALL | Combinar resultados sem eliminar duplicidades. |

Para utilizar UNION ou UNION ALL, as consultas devem possuir a mesma quantidade de colunas, com tipos de dados compatíveis nas posições correspondentes.

Os nomes das colunas do resultado são definidos pela primeira consulta.

### Aplicação no desafio

O objetivo era acrescentar novos relacionamentos ao conjunto de organizações principais.

Portanto, UNION ALL foi a operação adequada.

Foi esclarecido que dois registros com o mesmo AtividadeId não são necessariamente duplicados.

Exemplo:

| AtividadeId | OrganizacaoId |
|---:|---:|
| 5 | 5 |
| 5 | 6 |

Apesar de possuírem o mesmo identificador de atividade, os registros representam relacionamentos distintos.

A duplicidade deve ser analisada considerando a combinação completa das colunas relevantes.

Como as fórmulas utilizadas garantem organizações diferentes para uma mesma atividade, não foi necessário utilizar UNION para eliminar duplicidades.

UNION ALL também evita a necessidade de uma etapa específica de eliminação de duplicidades, que poderia envolver operadores como Sort ou Hash Match, dependendo do plano de execução escolhido pelo SQL Server.

---

## 13. Desafio 96 — Geração de um milhão de presenças

Este desafio representou a principal etapa da aula e exigiu a combinação dos conceitos estudados anteriormente.

### Requisitos

- Utilizar as 100.000 pessoas cadastradas.
- Gerar dez presenças distintas para cada pessoa.
- Distribuir as presenças entre as mil atividades.
- Respeitar as chaves estrangeiras.
- Respeitar a chave primária composta.
- Evitar estruturas de repetição.
- Produzir exatamente um milhão de registros.

### 13.1. Estratégia de multiplicação

Foi utilizado CROSS JOIN entre a tabela Pessoa e um conjunto contendo dez valores, de zero a nove.

    SELECT
        PessoaId,
        A.Numero
    FROM Pessoa
    CROSS JOIN (VALUES
        (0),(1),(2),(3),(4),
        (5),(6),(7),(8),(9)
    ) AS A(Numero);

Cada pessoa é combinada com os dez valores do conjunto.

Consequentemente:

100.000 × 10 = 1.000.000 de registros.

O CROSS JOIN foi responsável por gerar a quantidade necessária de linhas.

Entretanto, ainda era necessário determinar qual atividade seria associada a cada linha.

### 13.2. Dificuldades encontradas

Durante a resolução do desafio, foram consideradas alternativas utilizando ROW_NUMBER, GROUP BY e operações com o módulo.

Uma das dificuldades foi distinguir três necessidades diferentes:

| Necessidade | Recurso utilizado |
|---|---|
| Multiplicar os registros | CROSS JOIN |
| Determinar a atividade correspondente | Operador módulo |
| Contabilizar os registros gerados | GROUP BY e COUNT |

Foi identificado que utilizar apenas uma distribuição baseada em dez valores não seria suficiente para contemplar as mil atividades.

Também foi esclarecido que GROUP BY não deveria ser utilizado para gerar os registros de presença, pois sua finalidade é organizar registros em grupos, normalmente para realizar agregações.

Nesse desafio, o objetivo era expandir o conjunto de dados, e não reduzi-lo.

ROW_NUMBER também não era necessário, pois a tabela Pessoa já possuía identificadores que poderiam ser utilizados como referência para a distribuição.

### 13.3. Fórmula final

Após analisar as alternativas, foi desenvolvida a seguinte expressão:

    ((PessoaId + A.Numero - 1) % 1000) + 1

A fórmula utiliza:

- PessoaId como ponto de partida.
- A.Numero como deslocamento.
- Módulo 1000 para limitar o intervalo.
- Soma de 1 para ajustar os identificadores ao intervalo de 1 a 1.000.

### 13.4. Exemplo de distribuição

| PessoaId | A.Numero | AtividadeId |
|---:|---:|---:|
| 1 | 0 | 1 |
| 1 | 1 | 2 |
| 1 | 2 | 3 |
| 1 | 9 | 10 |
| 2 | 0 | 2 |
| 2 | 1 | 3 |
| 2 | 9 | 11 |
| 999 | 0 | 999 |
| 999 | 1 | 1.000 |
| 999 | 2 | 1 |
| 999 | 3 | 2 |
| 999 | 9 | 8 |

Ao atingir a atividade de identificador 1.000, a distribuição retorna ao início do intervalo.

Esse comportamento permite distribuir as presenças circularmente sem gerar identificadores inexistentes.

### 13.5. Inserção final

    INSERT INTO Presenca (
        PessoaId,
        AtividadeId
    )
    SELECT
        PessoaId,
        ((PessoaId + A.Numero - 1) % 1000) + 1
    FROM Pessoa
    CROSS JOIN (VALUES
        (0),(1),(2),(3),(4),
        (5),(6),(7),(8),(9)
    ) AS A(Numero);

A consulta foi executada com sucesso e produziu exatamente um milhão de registros.

### 13.6. Garantia de presenças distintas

Para uma mesma pessoa, os dez deslocamentos utilizados produzem dez identificadores distintos de atividade.

Como o intervalo de atividades possui mil valores e os deslocamentos abrangem apenas dez posições consecutivas, não ocorre repetição de atividade para uma mesma pessoa.

Além disso, a chave primária composta da tabela Presenca permanece responsável por impedir eventuais duplicidades.

---

## 14. Proteções do script de geração

Durante a consolidação do arquivo 004-geracao-massa-dados.sql, foram implementadas verificações para reduzir o risco de execuções indevidas.

### 14.1. Validação do banco de dados

Foi utilizada a função DB_NAME para identificar o banco de dados atual.

    IF DB_NAME() <> 'IgrejaApp_Laboratorio'
    BEGIN
        THROW 50001,
            'Execute este script apenas no banco IgrejaApp_Laboratorio.',
            1;
    END;

Essa condição impede a continuidade normal da execução do lote caso o banco selecionado seja diferente do ambiente de laboratório.

A proteção é importante porque o projeto possui um banco de desenvolvimento separado.

Entretanto, ela depende da execução do lote que contém a verificação. A execução isolada de uma instrução de inserção pode ignorar essa proteção.

### 14.2. Verificação de tabelas vazias

Inicialmente, foi considerada a seguinte abordagem:

    IF (SELECT COUNT(*) FROM Atividade) > 0

Posteriormente, foi utilizada a estrutura EXISTS:

    IF EXISTS (SELECT 1 FROM Atividade)
    BEGIN
        THROW 50004,
            'A tabela Atividade não está vazia.',
            4;
    END;

Quando o objetivo é verificar somente a existência de registros, não é necessário contabilizar todas as linhas.

EXISTS expressa diretamente essa intenção e permite que o SQL Server interrompa a busca assim que identificar um registro que satisfaça a condição, quando o plano de execução possibilitar esse comportamento.

### COUNT e EXISTS

| Recurso | Finalidade |
|---|---|
| COUNT | Contabilizar registros. |
| EXISTS | Verificar a existência de registros. |
| NOT EXISTS | Verificar a inexistência de registros. |

Foi adotada a organização das verificações de tabelas vazias no início do script, antes das inserções.

Essa abordagem reduz o risco de iniciar a geração da massa de dados e interrompê-la posteriormente devido à existência de registros em outra tabela.

### 14.3. THROW

O comando THROW permite gerar uma exceção no SQL Server.

Sintaxe:

    THROW NumeroErro, Mensagem, Estado;

Exemplo:

    THROW 50001, 'Mensagem de erro.', 1;

Os parâmetros representam:

| Parâmetro | Finalidade |
|---|---|
| NumeroErro | Identificador do erro personalizado. |
| Mensagem | Descrição do erro. |
| Estado | Identificação adicional do contexto do erro. |

O número de um erro personalizado iniciado por THROW deve ser igual ou superior a 50000.

O terceiro parâmetro representa o estado do erro, e não sua severidade.

Ao iniciar uma nova exceção utilizando THROW, a severidade atribuída pelo SQL Server é 16.

Foram definidos os seguintes códigos:

| Código | Motivo |
|---:|---|
| 50001 | Banco de dados incorreto. |
| 50002 | Tabela Organizacao não vazia. |
| 50003 | Tabela Pessoa não vazia. |
| 50004 | Tabela Atividade não vazia. |
| 50005 | Tabela AtividadeOrganizadora não vazia. |
| 50006 | Tabela Presenca não vazia. |

### 14.4. Limitações das proteções atuais

As verificações implementadas não garantem que toda a geração seja executada de forma atômica.

Caso ocorra uma falha durante uma inserção, registros inseridos anteriormente poderão permanecer no banco de dados.

Além disso, verificar que uma tabela está vazia não garante que seu IDENTITY esteja configurado para iniciar novamente em 1.

Por esse motivo, o script possui como pré-requisito a utilização de um ambiente de laboratório preparado com os intervalos esperados de identificadores.

O tratamento transacional completo será abordado posteriormente, durante os estudos de transações, concorrência e tratamento de exceções.

---

## 15. Investigação de inconsistências no IntelliSense

Durante a edição do script no SQL Server Management Studio, foram identificados sublinhados vermelhos em nomes de tabelas e nos comandos THROW e END.

Inicialmente, foi realizada a atualização do cache local do IntelliSense por meio do atalho:

`Ctrl + Shift + R`

Após a atualização, os nomes das tabelas passaram a ser reconhecidos corretamente.

Entretanto, os comandos THROW e END continuaram apresentando indicações de erro no editor.

Para verificar se o problema estava relacionado à sintaxe ou ao mecanismo de análise do IntelliSense, foi executado um teste isolado:

    IF 1 = 1
    BEGIN
        THROW 50001,
            'Teste de funcionamento do THROW.',
            1;
    END;

Resultado obtido:

    Msg 50001, Level 16, State 1, Line 3
    Teste de funcionamento do THROW.

O resultado confirmou que o SQL Server reconhece e executa corretamente o comando THROW.

Também foi realizada a verificação de sintaxe do script por meio do atalho Ctrl + F5, sem identificação de erro impeditivo.

### Diagnóstico

As indicações visuais remanescentes são provavelmente falsos positivos do IntelliSense.

A causa específica ainda não foi confirmada.

Como o funcionamento do comando foi validado, optou-se por manter a implementação e adiar a investigação da versão e das configurações do SSMS para a próxima aula.

---

## 16. Desafio 97 — Validação da massa de dados

Após a conclusão das inserções, foram desenvolvidas e consolidadas consultas para verificar a quantidade, a abrangência e a distribuição dos registros.

### 16.1. Validação geral

Foi utilizado UNION ALL para consolidar as contagens das cinco tabelas em um único resultado.

    SELECT 'Organizacao' AS Tabela,
           COUNT(*) AS TotalRegistros
    FROM Organizacao

    UNION ALL

    SELECT 'Pessoa', COUNT(*)
    FROM Pessoa

    UNION ALL

    SELECT 'Atividade', COUNT(*)
    FROM Atividade

    UNION ALL

    SELECT 'AtividadeOrganizadora', COUNT(*)
    FROM AtividadeOrganizadora

    UNION ALL

    SELECT 'Presenca', COUNT(*)
    FROM Presenca;

Resultados obtidos:

| Tabela | TotalRegistros |
|---|---:|
| Organizacao | 10 |
| Pessoa | 100.000 |
| Atividade | 1.000 |
| AtividadeOrganizadora | 1.200 |
| Presenca | 1.000.000 |
| **Total geral** | **1.102.210** |

Todas as quantidades corresponderam ao planejamento.

### 16.2. Validação das organizações

Foram utilizadas as funções COUNT, MIN e MAX para verificar a quantidade e o intervalo dos identificadores.

| TotalOrganizacoes | MenorOrganizacaoId | MaiorOrganizacaoId |
|---:|---:|---:|
| 10 | 1 | 10 |

Resultado aprovado.

### 16.3. Validação das pessoas

Foi confirmada a existência de 100.000 pessoas.

A distribuição por organização foi validada utilizando GROUP BY.

    SELECT
        OrganizacaoId,
        COUNT(*) AS TotalPessoas
    FROM Pessoa
    GROUP BY OrganizacaoId
    ORDER BY OrganizacaoId;

Resultado obtido:

| OrganizacaoId | TotalPessoas |
|---:|---:|
| 1 | 10.000 |
| 2 | 10.000 |
| 3 | 10.000 |
| 4 | 10.000 |
| 5 | 10.000 |
| 6 | 10.000 |
| 7 | 10.000 |
| 8 | 10.000 |
| 9 | 10.000 |
| 10 | 10.000 |

Também foi validada a situação de ingresso e atividade das pessoas.

| IsIngressada | IsAtiva | TotalPessoas |
|---:|---:|---:|
| 1 | 1 | 100.000 |

Os resultados confirmaram a distribuição uniforme e o preenchimento das situações conforme o cenário planejado.

### 16.4. Validação das atividades

| Indicador | Resultado |
|---|---|
| TotalAtividades | 1.000 |
| MenorAtividadeId | 1 |
| MaiorAtividadeId | 1.000 |
| PrimeiraData | 2024-01-01 19:00:00.0000000 |
| UltimaData | 2026-09-26 19:00:00.0000000 |

Também foi validada a distribuição por local.

| Local | TotalAtividades |
|---|---:|
| Local 1 | 100 |
| Local 10 | 100 |
| Local 2 | 100 |
| Local 3 | 100 |
| Local 4 | 100 |
| Local 5 | 100 |
| Local 6 | 100 |
| Local 7 | 100 |
| Local 8 | 100 |
| Local 9 | 100 |

Foi observado que Local 10 aparece antes de Local 2.

Esse comportamento ocorre porque a coluna Local é textual e sua ordenação segue as regras de comparação de textos definidas pela collation do banco de dados, e não uma ordenação numérica do sufixo.

Não se trata de um erro na geração dos registros.

### 16.5. Validação das atividades organizadoras

A primeira consulta contabilizou os relacionamentos e as atividades distintas.

    SELECT
        COUNT(*) AS TotalRelacionamentos,
        COUNT(DISTINCT AtividadeId) AS TotalAtividades
    FROM AtividadeOrganizadora;

Resultado:

| TotalRelacionamentos | TotalAtividades |
|---:|---:|
| 1.200 | 1.000 |

A segunda consulta foi desenvolvida utilizando uma CTE e agrupamentos em dois níveis.

    ;WITH PrimAgrup AS (
        SELECT
            COUNT(OrganizacaoId) AS QuantidadeOrganizacoes,
            AtividadeId
        FROM AtividadeOrganizadora
        GROUP BY AtividadeId
    )
    SELECT
        QuantidadeOrganizacoes,
        COUNT(AtividadeId) AS TotalAtividades
    FROM PrimAgrup
    GROUP BY QuantidadeOrganizacoes;

Resultado:

| QuantidadeOrganizacoes | TotalAtividades |
|---:|---:|
| 1 | 800 |
| 2 | 200 |

Os resultados confirmaram que todas as atividades possuem pelo menos uma organização responsável e que 20% das atividades possuem duas organizações responsáveis.

### 16.6. Validação das presenças

A primeira consulta verificou a quantidade total de presenças e a abrangência dos relacionamentos.

    SELECT
        COUNT(*) AS TotalPresencas,
        COUNT(DISTINCT PessoaId) AS TotalPessoas,
        COUNT(DISTINCT AtividadeId) AS TotalAtividades,
        MIN(AtividadeId) AS MenorAtividadeId,
        MAX(AtividadeId) AS MaiorAtividadeId
    FROM Presenca;

Resultado:

| Indicador | Resultado |
|---|---:|
| TotalPresencas | 1.000.000 |
| TotalPessoas | 100.000 |
| TotalAtividades | 1.000 |
| MenorAtividadeId | 1 |
| MaiorAtividadeId | 1.000 |

A distribuição de presenças por pessoa foi validada utilizando:

    ;WITH PresencasPorPessoa AS (
        SELECT
            PessoaId,
            COUNT(*) AS QuantidadePresencas
        FROM Presenca
        GROUP BY PessoaId
    )
    SELECT
        QuantidadePresencas,
        COUNT(*) AS TotalPessoas
    FROM PresencasPorPessoa
    GROUP BY QuantidadePresencas;

Resultado:

| QuantidadePresencas | TotalPessoas |
|---:|---:|
| 10 | 100.000 |

A distribuição de presenças por atividade foi validada utilizando:

    ;WITH PresencasPorAtividade AS (
        SELECT
            AtividadeId,
            COUNT(*) AS QuantidadePresencas
        FROM Presenca
        GROUP BY AtividadeId
    )
    SELECT
        QuantidadePresencas,
        COUNT(*) AS TotalAtividades
    FROM PresencasPorAtividade
    GROUP BY QuantidadePresencas;

Resultado:

| QuantidadePresencas | TotalAtividades |
|---:|---:|
| 1.000 | 1.000 |

As consultas finais de validação das presenças foram disponibilizadas de forma orientada para otimizar o encerramento da aula, reutilizando a lógica de agrupamento em dois níveis desenvolvida durante a validação das atividades organizadoras.

Todos os resultados foram confirmados por meio da execução das consultas no SQL Server.

---

## 17. Revisão de agrupamentos em dois níveis

Uma das principais técnicas aplicadas durante as validações foi a realização de agrupamentos sucessivos.

Essa abordagem permite responder perguntas sobre a distribuição de quantidades, e não apenas sobre a quantidade individual de registros.

### Primeiro nível

Determinar quantas presenças cada pessoa possui.

    SELECT
        PessoaId,
        COUNT(*) AS QuantidadePresencas
    FROM Presenca
    GROUP BY PessoaId;

Essa consulta retorna uma linha para cada pessoa que possui presença registrada.

Exemplo:

| PessoaId | QuantidadePresencas |
|---:|---:|
| 1 | 10 |
| 2 | 10 |
| 3 | 10 |
| 4 | 10 |

### Segundo nível

Determinar quantas pessoas possuem a mesma quantidade de presenças.

O resultado da primeira consulta é utilizado como origem de um novo agrupamento.

    ;WITH PrimeiroAgrupamento AS (
        SELECT
            PessoaId,
            COUNT(*) AS QuantidadePresencas
        FROM Presenca
        GROUP BY PessoaId
    )
    SELECT
        QuantidadePresencas,
        COUNT(*) AS TotalPessoas
    FROM PrimeiroAgrupamento
    GROUP BY QuantidadePresencas;

Resultado:

| QuantidadePresencas | TotalPessoas |
|---:|---:|
| 10 | 100.000 |

Essa técnica permite identificar facilmente distribuições inesperadas.

Caso existissem pessoas com nove, dez ou onze presenças, por exemplo, o segundo agrupamento apresentaria linhas distintas para cada quantidade encontrada.

### Limitação da consulta

O agrupamento realizado diretamente sobre a tabela Presenca não apresenta pessoas que não possuem nenhum registro de presença.

Para identificar essas pessoas isoladamente, seria necessário utilizar a tabela Pessoa como origem e aplicar recursos como LEFT JOIN ou NOT EXISTS.

No laboratório, a abrangência foi confirmada adicionalmente por meio da comparação entre a quantidade total de pessoas cadastradas e a quantidade de pessoas distintas presentes na tabela Presenca, considerando também a integridade referencial existente.

---

## 18. Revisão das funções de agregação

Durante as validações, foram utilizadas diferentes formas de agregação.

| Expressão | Comportamento |
|---|---|
| COUNT(*) | Contabiliza todas as linhas. |
| COUNT(Coluna) | Contabiliza valores não nulos da coluna. |
| COUNT(DISTINCT Coluna) | Contabiliza valores distintos e não nulos. |
| MIN(Coluna) | Retorna o menor valor não nulo. |
| MAX(Coluna) | Retorna o maior valor não nulo. |

### Exemplo aplicado

Considerando os seguintes relacionamentos:

| AtividadeId | OrganizacaoId |
|---:|---:|
| 1 | 1 |
| 2 | 2 |
| 5 | 5 |
| 5 | 6 |

A expressão COUNT(*) retorna 4, pois existem quatro relacionamentos.

A expressão COUNT(DISTINCT AtividadeId) retorna 3, pois existem três atividades distintas.

A escolha da função de agregação deve considerar a entidade que se deseja contabilizar.

---

## 19. Consolidação do script SQL

Foi consolidado o arquivo:

`database/scripts/004-geracao-massa-dados.sql`

O script contempla:

- Identificação e documentação do objetivo.
- Pré-requisitos de execução.
- Validação do banco de dados.
- Verificação de tabelas vazias.
- Geração das organizações.
- Geração das pessoas.
- Geração das atividades.
- Geração dos relacionamentos atividade-organização.
- Geração das presenças.
- Validação geral das quantidades.
- Validações específicas por tabela.
- Validação da distribuição dos registros.

As seções foram organizadas utilizando títulos padronizados e comentários contendo os requisitos técnicos de cada operação.

Essa organização facilita a manutenção, a reprodução do laboratório e a compreensão das técnicas utilizadas.

O script não deve ser executado integralmente sobre o laboratório já preenchido.

As consultas de validação podem ser executadas separadamente, sem necessidade de realizar novamente as inserções.

---

## 20. Características e limitações da massa de dados

A massa de dados construída possui características adequadas para os primeiros experimentos de desempenho.

### Características

- Grande volume de registros.
- Distribuição determinística.
- Distribuição uniforme de pessoas entre organizações.
- Distribuição uniforme de atividades entre locais.
- Distribuição uniforme de presenças entre pessoas e atividades.
- Integridade referencial preservada.
- Resultados previsíveis e reproduzíveis.

### Limitações

A massa de dados não representa integralmente o comportamento de um ambiente de produção.

Todas as pessoas estão ingressadas e ativas, não existindo diversidade de situações cadastrais.

Todas as pessoas possuem exatamente dez presenças.

Todas as atividades possuem exatamente mil presenças.

As atividades possuem horários fixos e datas consecutivas.

As organizações adicionais das atividades conjuntas concentram-se nas organizações de identificadores 1 e 6, em decorrência da fórmula utilizada.

Os campos que não foram preenchidos explicitamente durante a geração permanecem com seus valores padrão ou nulos, conforme a definição das tabelas.

Essas características podem influenciar a seletividade das consultas, a distribuição estatística dos dados e as decisões do otimizador.

Para estudos futuros, poderá ser desenvolvida uma massa de dados mais heterogênea, contendo diferentes situações cadastrais, concentrações de registros, frequências de participação e distribuições não uniformes.

Entretanto, a massa atual será mantida como cenário inicial controlado para comparação de desempenho.

---

## 21. Dificuldades encontradas e aprendizados

Durante a aula, foram identificados pontos que exigiram maior aprofundamento.

| Dificuldade | Aprendizado |
|---|---|
| Definir a quantidade de registros gerados | Calcular previamente a cardinalidade de um CROSS JOIN. |
| Distribuir registros entre identificadores | Utilizar o operador módulo e ajustar os intervalos. |
| Definir corretamente a primeira data | Considerar o valor inicial de ROW_NUMBER. |
| Escolher entre JOIN e UNION ALL | Diferenciar relacionamento de registros e combinação vertical de resultados. |
| Identificar registros duplicados | Considerar todas as colunas que compõem a identidade do relacionamento. |
| Utilizar GROUP BY na geração | Diferenciar expansão de registros e agregação de resultados. |
| Utilizar ROW_NUMBER na geração de presenças | Reconhecer quando uma sequência adicional é desnecessária. |
| Validar a distribuição dos registros | Aplicar agrupamentos em dois níveis. |
| Verificar tabelas vazias | Utilizar EXISTS quando não é necessário contabilizar registros. |
| Interpretar os parâmetros de THROW | Diferenciar número, mensagem, estado e severidade do erro. |
| Interpretar erros no editor SQL | Diferenciar indicações do IntelliSense de erros efetivos do SQL Server. |

O principal aprendizado da aula foi compreender que a geração de dados envolve etapas com responsabilidades distintas.

Primeiramente, é necessário determinar a quantidade de registros.

Em seguida, definir como os registros serão relacionados.

Por fim, validar se os resultados correspondem às regras e às distribuições planejadas.

---

## 22. Resumo dos conceitos estudados

| Conceito | Aplicação |
|---|---|
| Set-based | Geração de grandes volumes de dados. |
| VALUES | Construção de pequenos conjuntos auxiliares. |
| CROSS JOIN | Multiplicação de registros. |
| ROW_NUMBER | Geração de sequências numéricas. |
| CTE | Organização lógica das consultas. |
| CONCAT | Construção de valores textuais. |
| DATEADD | Geração de datas consecutivas. |
| CAST | Conversão explícita de tipos. |
| DATETIME2 | Armazenamento de datas e horários. |
| Operador módulo (%) | Distribuição circular dos registros. |
| INSERT INTO SELECT | Inserção baseada em consultas. |
| UNION ALL | Consolidação de conjuntos de resultados. |
| GROUP BY | Agrupamento de registros. |
| COUNT | Contabilização de registros. |
| COUNT DISTINCT | Contabilização de valores distintos. |
| MIN e MAX | Verificação de intervalos. |
| EXISTS | Verificação da existência de registros. |
| DB_NAME | Identificação do banco de dados atual. |
| IF | Execução condicional de instruções. |
| THROW | Geração de exceções personalizadas. |
| Chave primária composta | Garantia de unicidade dos relacionamentos. |
| Chave estrangeira | Garantia de integridade referencial. |

---

## 23. Resultados finais

A geração da massa de dados foi concluída com sucesso.

| Tabela | Meta | Resultado | Status |
|---|---:|---:|---|
| Organizacao | 10 | 10 | Aprovado |
| Pessoa | 100.000 | 100.000 | Aprovado |
| Atividade | 1.000 | 1.000 | Aprovado |
| AtividadeOrganizadora | 1.200 | 1.200 | Aprovado |
| Presenca | 1.000.000 | 1.000.000 | Aprovado |
| **Total** | **1.102.210** | **1.102.210** | **Aprovado** |

### Indicadores complementares

| Indicador | Resultado |
|---|---:|
| Pessoas por organização | 10.000 |
| Pessoas ingressadas e ativas | 100.000 |
| Atividades por local | 100 |
| Atividades individuais | 800 |
| Atividades conjuntas | 200 |
| Pessoas com presença registrada | 100.000 |
| Atividades com presença registrada | 1.000 |
| Presenças por pessoa | 10 |
| Presenças por atividade | 1.000 |

Todas as consultas de validação foram executadas e apresentaram os resultados esperados.

O banco IgrejaApp_Laboratorio encontra-se preparado para o início dos estudos de planos de execução.

---

## 24. Avaliação da aula

Os objetivos técnicos estabelecidos para a aula foram integralmente atingidos.

A geração de um milhão de presenças representou um avanço na utilização de consultas SQL para manipulação de grandes conjuntos de dados.

O desenvolvimento dos desafios permitiu consolidar conhecimentos anteriores e aprofundar a compreensão sobre cardinalidade, distribuição de registros, agregações e integridade relacional.

A resolução foi realizada de forma progressiva, com elaboração de consultas, identificação de dificuldades, análise de alternativas e correção das implementações.

### Gestão do tempo

A aula ultrapassou o limite planejado de uma hora e trinta minutos.

O tempo adicional foi utilizado principalmente para:

- Compreensão da distribuição circular das presenças.
- Correção das estratégias de geração.
- Consolidação e revisão do script SQL.
- Investigação das indicações de erro do IntelliSense.
- Execução das consultas de validação.

Para as próximas aulas, será necessário reservar parte do tempo para documentação e encerramento, evitando iniciar novos desafios próximo ao limite estabelecido.

A extensão desta aula não implica alteração no planejamento geral de 24 semanas.

---

## 25. Planejamento da próxima aula — Semana 03, Dia 03

### Tema

Introdução aos planos de execução no SQL Server.

### Objetivos

- Compreender o conceito de plano de execução.
- Conhecer a função do otimizador de consultas.
- Diferenciar plano de execução estimado e plano de execução real.
- Identificar os principais operadores presentes em um plano.
- Compreender a diferença entre Scan e Seek.
- Analisar estimativas de quantidade de registros.
- Comparar estimativas com as quantidades efetivamente processadas.
- Identificar operadores com maior custo estimado.
- Analisar uma consulta sobre a tabela Pessoa utilizando a massa de dados construída.

### Pendência técnica

Investigar as indicações incorretas de sintaxe do IntelliSense relacionadas ao comando THROW, verificando a versão e as configurações do SQL Server Management Studio.

Essa investigação não deve comprometer o objetivo principal da próxima aula.

A criação de índices compostos, a utilização de INCLUDE e as comparações detalhadas com STATISTICS IO e STATISTICS TIME permanecem previstas para a Semana 04.

---

## 26. Arquivos desenvolvidos e atualizados

| Arquivo | Descrição |
|---|---|
| database/scripts/004-geracao-massa-dados.sql | Script consolidado de geração e validação da massa de dados. |
| estudos/semana-03/dia-02.md | Relatório técnico e didático da aula. |

---

## 27. Conclusão

A segunda aula da Semana 03 concluiu a construção do ambiente de laboratório destinado aos estudos de desempenho do projeto IgrejaApp.

Foram gerados e validados 1.102.210 registros distribuídos entre cinco tabelas relacionais, incluindo 100.000 pessoas e 1.000.000 de presenças.

A implementação utilizou operações baseadas em conjuntos, técnicas de distribuição circular, funções de agregação e mecanismos de proteção contra execuções indevidas.

Além da geração dos registros, foram desenvolvidas consultas capazes de verificar a consistência quantitativa e a distribuição da massa de dados.

O ambiente encontra-se preparado para a próxima etapa do plano de estudos, na qual serão analisados os planos de execução e o comportamento do SQL Server durante o processamento de consultas sobre grandes volumes de dados.

**Status final: objetivos técnicos concluídos e massa de dados validada.**