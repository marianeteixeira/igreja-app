# Semana 03 — Dia 01 | Geração de massa de dados

**Data:** 23/11/2026  
**Projeto:** IgrejaApp  
**Tecnologia:** SQL Server  
**Tempo de estudo:** aproximadamente 2 horas  
**Desafios realizados:** 79 a 91

---

## 1. Objetivo da aula

Iniciar a preparação de um ambiente de laboratório destinado aos estudos de desempenho de consultas SQL, análise de planos de execução e utilização de índices.

Nesta etapa, o objetivo foi desenvolver estratégias para a geração de grandes volumes de dados fictícios, utilizando operações baseadas em conjuntos, respeitando as regras de negócio e as restrições de integridade referencial estabelecidas nas semanas anteriores.

A meta geral da Semana 03 é preparar uma massa de dados contendo:

- 10 organizações;
- 100.000 pessoas;
- Atividades fictícias;
- Relacionamentos entre atividades e organizações;
- 1.000.000 de registros de presença.

Neste primeiro dia, foram concluídas a criação do ambiente de laboratório e a inserção das organizações e pessoas.

---

## 2. Revisão dos conhecimentos adquiridos nas semanas anteriores

Antes da geração da massa de dados, foram retomados conceitos utilizados durante a construção inicial do banco de dados IgrejaApp.

### 2.1. Modelagem de banco de dados

Nas primeiras semanas, foram estudados conceitos de modelagem relacional, identificação de entidades, definição de atributos, cardinalidade e representação de regras de negócio por meio de relacionamentos e restrições.

Até o momento, o banco possui cinco tabelas:

| Tabela | Responsabilidade |
|---|---|
| Organizacao | Armazenar as organizações cadastradas no sistema. |
| Pessoa | Armazenar os dados das pessoas, visitantes e ingressados. |
| Atividade | Armazenar as atividades realizadas pelas organizações. |
| AtividadeOrganizadora | Representar o relacionamento entre atividades e organizações responsáveis. |
| Presenca | Registrar a participação das pessoas nas atividades. |

### 2.2. Integridade dos dados

Foram revisadas as responsabilidades das principais restrições e propriedades utilizadas no SQL Server.

| Recurso | Finalidade |
|---|---|
| PRIMARY KEY | Identificar unicamente cada registro. |
| FOREIGN KEY | Garantir a integridade referencial entre tabelas. |
| CHECK | Validar condições e regras de negócio. |
| DEFAULT | Definir um valor padrão para uma coluna quando aplicável. |
| NOT NULL | Impedir o armazenamento de valores nulos. |
| IDENTITY | Gerar automaticamente valores numéricos de acordo com uma configuração de identidade. |

Um ponto reforçado durante a aula foi a diferença entre PRIMARY KEY e IDENTITY.

Uma chave primária não é necessariamente autoincremental. A geração automática de identificadores nas tabelas Pessoa e Organizacao ocorre devido à propriedade `IDENTITY(1,1)`, enquanto a PRIMARY KEY é responsável pela identificação única dos registros.

Também foi revisada a restrição:

```sql
CONSTRAINT CK_Pessoa_Organizacao
CHECK (IsIngressada = 0 OR OrganizacaoId IS NOT NULL)
```

Essa restrição estabelece que uma pessoa ingressada deve possuir vínculo com uma organização.

Como todas as pessoas da massa inicial de laboratório seriam ingressadas, tornou-se obrigatório atribuir uma organização válida a cada registro.

### 2.3. Consultas e relatórios SQL

Durante a Semana 02, foram desenvolvidas consultas voltadas à geração de relatórios do sistema, utilizando:

- INNER JOIN;
- LEFT JOIN;
- GROUP BY;
- ORDER BY;
- COUNT;
- COUNT DISTINCT;
- NOT IN;
- NOT EXISTS;
- Subconsultas correlacionadas;
- Filtros por períodos;
- Variáveis SQL;
- DATEADD.

Também foram estudados problemas relacionados à multiplicação de registros em consultas com múltiplos relacionamentos, ao tratamento de valores NULL e à utilização de intervalos de datas semiabertos.

Esses conhecimentos foram reaproveitados na validação da massa de dados gerada nesta aula.

---

## 3. Operações baseadas em conjuntos — Set-based

Um dos primeiros conceitos abordados foi a geração e manipulação de dados utilizando operações baseadas em conjuntos, conhecidas como operações set-based.

O SQL Server é um sistema de gerenciamento de banco de dados relacional projetado para trabalhar com conjuntos de registros.

Em vez de executar uma operação individualmente para cada linha, é possível construir uma única instrução capaz de processar diversos registros.

### Abordagem procedural

Uma possibilidade para inserir 100.000 pessoas seria utilizar uma estrutura de repetição, como WHILE, executando uma inserção a cada iteração.

Nesse cenário, seriam realizadas 100.000 execuções individuais da instrução INSERT.

### Abordagem set-based

Na abordagem baseada em conjuntos, uma consulta é utilizada para produzir os 100.000 registros, permitindo que sejam inseridos por meio de uma única instrução.

Essa estratégia geralmente reduz a sobrecarga de operações repetitivas e permite que o SQL Server utilize seus mecanismos de otimização para processar o conjunto de dados.

Embora estruturas de repetição tenham aplicações válidas, operações set-based devem ser consideradas prioritariamente quando o problema puder ser resolvido dessa forma.

---

## 4. Table Value Constructor — VALUES

Foi estudada a utilização do VALUES como uma fonte de dados dentro de uma consulta SELECT.

Até então, o VALUES havia sido utilizado principalmente em instruções INSERT.

Entretanto, também é possível utilizá-lo na cláusula FROM para construir um conjunto de registros sem depender de uma tabela física.

Exemplo:

```sql
SELECT Numero
FROM (VALUES
    (1),
    (2),
    (3),
    (4),
    (5)
) AS Numeros(Numero);
```

Nesse exemplo:

- VALUES define os registros;
- Numeros representa o alias da fonte de dados;
- Numero representa o nome atribuído à coluna.

Resultado:

| Numero |
|---:|
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |

Esse recurso permite criar conjuntos de dados temporários no contexto de uma consulta, sendo especialmente útil para testes, simulações e geração de dados fictícios.

---

## 5. CROSS JOIN e produto cartesiano

O CROSS JOIN foi utilizado para ampliar a quantidade de registros disponíveis para a geração da massa de dados.

Diferentemente de outros tipos de JOIN, o CROSS JOIN produz todas as combinações possíveis entre os registros de duas fontes de dados.

Exemplo:

```sql
SELECT
    A.Nome,
    B.Sobrenome
FROM (VALUES
    ('Maria'),
    ('Joao')
) AS A(Nome)
CROSS JOIN (VALUES
    ('Silva'),
    ('Santos')
) AS B(Sobrenome);
```

Resultado:

| Nome | Sobrenome |
|---|---|
| Maria | Silva |
| Maria | Santos |
| Joao | Silva |
| Joao | Santos |

Como cada fonte possui dois registros, o resultado contém quatro combinações.

A quantidade de registros produzidos por um CROSS JOIN corresponde à multiplicação da quantidade de registros de cada fonte.

Durante os exercícios, foram utilizadas cinco fontes contendo dez registros cada.

| Quantidade de fontes | Registros resultantes |
|---:|---:|
| 1 | 10 |
| 2 | 100 |
| 3 | 1.000 |
| 4 | 10.000 |
| 5 | 100.000 |
| 6 | 1.000.000 |

Dessa forma, foi possível gerar 100.000 linhas utilizando apenas cinco conjuntos de dez valores, sem a necessidade de escrever individualmente todos os registros.

Também foi desenvolvido um exercício de combinação de nomes e sobrenomes, demonstrando que o CROSS JOIN pode ser utilizado tanto para geração numérica quanto para composição de dados textuais.

### Cuidados com o CROSS JOIN

Por produzir todas as combinações possíveis, o CROSS JOIN pode aumentar significativamente a quantidade de registros de uma consulta.

Sua utilização deve ser intencional, principalmente em consultas que envolvam tabelas com grandes volumes de dados.

---

## 6. Função de janela ROW_NUMBER()

Após a geração das combinações com CROSS JOIN, foi necessário atribuir uma numeração sequencial a cada linha.

Para isso, foi utilizada a função de janela ROW_NUMBER().

Exemplo:

```sql
SELECT
    ROW_NUMBER() OVER (
        ORDER BY A.Numero
    ) AS Sequencia,
    A.Numero
FROM (VALUES
    (50),
    (10),
    (90),
    (30)
) AS A(Numero);
```

Considerando a ordenação definida, a numeração atribuída será:

| Sequencia | Numero |
|---:|---:|
| 1 | 10 |
| 2 | 30 |
| 3 | 50 |
| 4 | 90 |

### 6.1. Diferença entre o valor da linha e sua numeração

Um dos principais aprendizados da aula foi compreender que o ROW_NUMBER() não depende dos valores numéricos existentes na fonte de dados para gerar sua sequência.

A função atribui uma numeração a cada linha conforme a ordenação definida na cláusula OVER.

Portanto, os valores utilizados no VALUES poderiam ser números, letras ou textos, desde que fossem adequados à expressão de ordenação.

Se uma consulta produzir 100.000 linhas, o ROW_NUMBER(), sem particionamento, atribuirá números de 1 a 100.000.

A quantidade de linhas determina a extensão da sequência, enquanto o ORDER BY determina a ordem de atribuição dos números.

### 6.2. Ordenação e determinismo

Durante os exercícios, também foi identificada a importância de utilizar critérios de ordenação que permitam distinguir as combinações geradas.

A expressão utilizada foi:

```sql
ROW_NUMBER() OVER (
    ORDER BY
        A.Numero,
        B.Numero,
        C.Numero,
        D.Numero,
        E.Numero
) AS Sequencia
```

Como cada combinação dos cinco conjuntos é distinta, a ordenação considera todos os elementos necessários para identificar cada combinação.

Caso o ORDER BY utilize apenas uma coluna com valores repetidos, a ordem de numeração entre os registros empatados não será garantida.

Outro ponto importante é que o ORDER BY dentro do OVER determina a atribuição da numeração, mas não garante a ordem de apresentação do resultado final. Para garantir a ordenação da saída, deve-se utilizar um ORDER BY na consulta final.

A função ROW_NUMBER() retorna valores do tipo BIGINT.

---

## 7. Common Table Expressions — CTEs

As Common Table Expressions foram utilizadas para organizar a consulta de geração de dados em etapas lógicas.

Uma CTE representa um conjunto de resultados nomeado, definido no contexto de uma instrução SQL.

Exemplo:

```sql
;WITH NumerosGerados AS (
    SELECT Numero
    FROM (VALUES
        (1),
        (2),
        (3)
    ) AS Numeros(Numero)
)
SELECT *
FROM NumerosGerados;
```

A utilização de CTEs facilita a organização de consultas complexas, permitindo separar responsabilidades e melhorar a legibilidade do código.

### 7.1. Múltiplas CTEs

Durante a aula, foi desenvolvida uma consulta contendo duas CTEs na mesma instrução WITH.

A primeira, denominada NumerosGerados, foi responsável pela geração das 100.000 linhas numeradas.

A segunda, denominada PessoasGeradas, foi responsável pela criação dos nomes fictícios e pela distribuição das pessoas entre as organizações.

Estrutura lógica desenvolvida:

```sql
;WITH NumerosGerados AS (
    -- Geracao da sequencia
),
PessoasGeradas AS (
    -- Transformacao dos dados
    -- Distribuicao entre organizacoes
    SELECT
        Sequencia,
        CONCAT('Pessoa ', Sequencia) AS Nome,
        ((Sequencia - 1) % 10) + 1 AS OrganizacaoId
    FROM NumerosGerados
)
SELECT
    OrganizacaoId,
    COUNT(*) AS TotalPessoas
FROM PessoasGeradas
GROUP BY OrganizacaoId
ORDER BY OrganizacaoId;
```

As CTEs são separadas por vírgulas, sendo possível que uma CTE faça referência a outra definida anteriormente.

### 7.2. Escopo e materialização

Uma CTE não cria uma tabela permanente no banco de dados.

Seu escopo está limitado à instrução que a sucede, podendo ser utilizada, por exemplo, com SELECT, INSERT, UPDATE ou DELETE.

Também foi introduzido um conceito importante para os próximos estudos de desempenho: uma CTE não implica necessariamente a materialização de seus resultados.

A separação em etapas lógicas não significa que o SQL Server executará fisicamente cada etapa de forma independente.

O otimizador poderá reorganizar as operações durante a elaboração do plano de execução.

### 7.3. Utilização do ponto e vírgula

Foi recomendada a utilização de `;WITH` nos scripts SQL.

O ponto e vírgula encerra uma eventual instrução anterior, evitando problemas de sintaxe quando uma CTE é declarada após outras instruções no mesmo lote de execução.

---

## 8. Função CONCAT

A função CONCAT foi utilizada para construir os nomes fictícios das organizações e pessoas.

Exemplo:

```sql
SELECT CONCAT('Pessoa ', Sequencia) AS Nome
FROM NumerosGerados;
```

Resultado:

| Sequencia | Nome |
|---:|---|
| 1 | Pessoa 1 |
| 2 | Pessoa 2 |
| 3 | Pessoa 3 |

Durante os exercícios, foi identificado que não era necessário utilizar CAST para converter explicitamente a sequência numérica em texto.

A função CONCAT realiza a conversão dos argumentos para tipos textuais quando necessário.

Além disso, a função trata valores NULL como strings vazias durante a concatenação.

---

## 9. Operador módulo (%) e distribuição circular

Um dos principais desafios da aula foi distribuir as 100.000 pessoas igualmente entre dez organizações.

A primeira estratégia considerada foi utilizar valores pseudoaleatórios, por meio da expressão:

```sql
ABS(CHECKSUM(NEWID()) % 10)
```

Essa expressão produz valores entre 0 e 9.

Entretanto, além de gerar um identificador zero, inexistente na massa planejada, a distribuição aleatória não garantiria exatamente a mesma quantidade de pessoas em cada organização.

Para os primeiros testes de desempenho, foi escolhida uma distribuição uniforme e previsível.

### 9.1. Funcionamento do operador módulo

O operador `%` retorna o resto de uma divisão.

Exemplos:

```sql
SELECT 7 % 3;   -- Resultado: 1
SELECT 10 % 3;  -- Resultado: 1
SELECT 10 % 10; -- Resultado: 0
SELECT 11 % 10; -- Resultado: 1
```

Inicialmente, foi desenvolvida a seguinte expressão:

```sql
Sequencia % 10
```

Embora produzisse uma distribuição uniforme, o resultado continha valores entre 0 e 9.

Como os identificadores das organizações estavam compreendidos entre 1 e 10, foi necessário ajustar a expressão.

### 9.2. Desenvolvimento da solução

A solução foi construída em três etapas:

1. Subtrair 1 da sequência para ajustar o início do ciclo.
2. Calcular o resto da divisão por 10.
3. Adicionar 1 ao resultado para deslocar o intervalo de 0 a 9 para 1 a 10.

Expressão final:

```sql
((Sequencia - 1) % 10) + 1 AS OrganizacaoId
```

| Sequencia | Sequencia - 1 | Resto da divisão | OrganizacaoId |
|---:|---:|---:|---:|
| 1 | 0 | 0 | 1 |
| 2 | 1 | 1 | 2 |
| 9 | 8 | 8 | 9 |
| 10 | 9 | 9 | 10 |
| 11 | 10 | 0 | 1 |
| 12 | 11 | 1 | 2 |
| 100000 | 99999 | 9 | 10 |

Essa estratégia é conhecida como distribuição circular, ou Round Robin.

Sua principal vantagem neste cenário é permitir uma distribuição determinística e uniforme, atribuindo exatamente 10.000 pessoas a cada organização.

### 9.3. Cuidados com identificadores

A expressão desenvolvida considera que as organizações possuem identificadores consecutivos de 1 a 10.

Essa condição foi posteriormente confirmada no banco de laboratório.

Entretanto, em ambientes reais, não se deve presumir que identificadores gerados por IDENTITY sejam necessariamente consecutivos.

Exclusões, falhas de inserção, rollbacks e outros acontecimentos podem produzir lacunas na sequência de identificadores.

Em cenários mais genéricos, uma alternativa seria numerar as organizações existentes com ROW_NUMBER() e relacionar a posição calculada ao identificador real de cada organização.

### 9.4. Distribuição uniforme e distribuição aleatória

| Característica | Uniforme | Aleatória |
|---|---|---|
| Previsibilidade | Alta | Menor |
| Reprodutibilidade | Alta | Menor |
| Quantidade por organização | Controlada | Variável |
| Validação inicial | Simplificada | Mais complexa |

A distribuição uniforme foi escolhida como ponto de partida para os testes de desempenho.

Posteriormente, poderão ser utilizadas distribuições desiguais para estudar como a concentração dos dados influencia as estatísticas, estimativas de cardinalidade e decisões do otimizador do SQL Server.

---

## 10. Validação da geração dos dados

Antes de executar qualquer instrução de inserção em massa, foram realizadas consultas para validar a quantidade de registros produzidos.

A primeira validação verificou a quantidade total de linhas e os limites da sequência gerada.

```sql
SELECT
    COUNT(*) AS TotalRegistros,
    MIN(Sequencia) AS MenorSequencia,
    MAX(Sequencia) AS MaiorSequencia
FROM NumerosGerados;
```

Os valores esperados eram:

| TotalRegistros | MenorSequencia | MaiorSequencia |
|---:|---:|---:|
| 100000 | 1 | 100000 |

Posteriormente, foi validada a distribuição das pessoas entre as organizações utilizando GROUP BY e COUNT.

```sql
SELECT
    OrganizacaoId,
    COUNT(*) AS TotalPessoas
FROM PessoasGeradas
GROUP BY OrganizacaoId
ORDER BY OrganizacaoId;
```

O resultado confirmou que a estratégia produziria exatamente 10.000 pessoas para cada uma das dez organizações.

Essa etapa reforçou a importância de validar previamente a lógica de geração dos dados, antes de executar operações que modifiquem o banco.

---

## 11. Criação do ambiente de laboratório

Foi criado um banco de dados independente, denominado IgrejaApp_Laboratorio.

O objetivo dessa separação foi preservar os registros utilizados nas semanas anteriores e evitar que a geração de grandes volumes de dados interferisse no ambiente principal de desenvolvimento.

### Ambientes definidos

| Banco de dados | Finalidade |
|---|---|
| IgrejaApp | Desenvolvimento do sistema e validação das regras de negócio. |
| IgrejaApp_Laboratorio | Testes de desempenho, geração de massa de dados e análise de índices. |

A estrutura do banco original foi reproduzida utilizando como referência o script `001-criacao-tabelas.sql`.

Foram criadas as cinco tabelas existentes no projeto:

- Organizacao;
- Pessoa;
- Atividade;
- AtividadeOrganizadora;
- Presenca.

Também foi reforçada a importância de verificar o contexto do banco de dados antes da execução de instruções de inserção.

```sql
SELECT DB_NAME();
```

Essa consulta permite identificar o banco de dados associado à sessão atual.

---

## 12. UNION e UNION ALL

Durante a validação das tabelas do laboratório, foi estudada a diferença entre UNION e UNION ALL.

Ambos permitem combinar verticalmente os resultados de diferentes consultas SELECT, desde que possuam quantidades compatíveis de colunas e tipos de dados compatíveis.

### 12.1. UNION

O UNION combina os resultados e elimina linhas duplicadas.

Exemplo:

```sql
SELECT 1 AS Numero
UNION
SELECT 1
UNION
SELECT 2;
```

Resultado:

| Numero |
|---:|
| 1 |
| 2 |

### 12.2. UNION ALL

O UNION ALL combina os resultados preservando todas as linhas, inclusive as duplicadas.

```sql
SELECT 1 AS Numero
UNION ALL
SELECT 1
UNION ALL
SELECT 2;
```

Resultado:

| Numero |
|---:|
| 1 |
| 1 |
| 2 |

A ordem de apresentação dos exemplos é ilustrativa. A ordenação somente é garantida mediante a utilização de ORDER BY.

### 12.3. Impacto no desempenho

O UNION pode exigir operações adicionais para identificar e eliminar duplicidades.

Dependendo do plano de execução, o SQL Server poderá utilizar operadores como:

- Sort;
- Hash Match;
- Stream Aggregate.

Essas operações podem consumir recursos adicionais de processamento e memória.

O UNION ALL não possui a responsabilidade de eliminar duplicidades, sendo geralmente mais eficiente quando essa eliminação não é necessária.

A escolha entre os dois operadores deve considerar primeiramente a necessidade funcional da consulta.

### 12.4. Aplicação prática

Foi desenvolvida uma consulta para verificar a quantidade de registros de todas as tabelas do laboratório.

```sql
SELECT
    'Organizacao' AS Tabela,
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
```

Antes das inserções, foi confirmado que todas as tabelas estavam vazias.

O UNION ALL foi escolhido porque cada consulta retornava um nome de tabela diferente, não havendo necessidade de eliminar linhas duplicadas.

### 12.5. Separação das informações e tipos de dados

Na primeira tentativa de elaboração da consulta, foi utilizada a função CONCAT para combinar a quantidade de registros e o nome da tabela em uma única coluna.

Exemplo:

```sql
SELECT CONCAT(COUNT(*), ' - Organizacao')
FROM Organizacao;
```

Embora funcional para apresentação textual, essa abordagem transformava a contagem numérica em texto.

A consulta foi posteriormente ajustada para retornar duas colunas independentes:

- Tabela;
- TotalRegistros.

Essa separação preserva o tipo numérico da contagem, facilita operações matemáticas, ordenações e o consumo dos dados por aplicações e APIs.

Também foi aprendido que os nomes das colunas do resultado de um UNION ou UNION ALL são definidos pelo primeiro SELECT.

---

## 13. Inserção de dados utilizando INSERT INTO ... SELECT

Foi estudada a possibilidade de utilizar uma consulta SELECT como fonte de dados para uma instrução INSERT.

Essa abordagem permite inserir registros produzidos dinamicamente por uma consulta.

Diferentemente de uma inserção convencional utilizando VALUES diretamente após o INSERT, o INSERT INTO ... SELECT permite aproveitar recursos como:

- JOINs;
- CTEs;
- Funções de janela;
- Funções de agregação;
- Expressões matemáticas;
- Transformações de dados.

A quantidade e a ordem das colunas retornadas pelo SELECT devem ser compatíveis com as colunas especificadas no INSERT.

### 13.1. Inserção das organizações

Foram inseridas dez organizações fictícias utilizando VALUES como fonte de dados e CONCAT para geração dos nomes.

```sql
INSERT INTO Organizacao (Nome)
SELECT CONCAT('ORG ', Numero) AS Nome
FROM (VALUES
    (1), (2), (3), (4), (5),
    (6), (7), (8), (9), (10)
) AS Numeros(Numero);
```

Não foi necessário informar explicitamente o identificador da organização, pois sua geração é realizada pela propriedade IDENTITY.

Também foram aproveitadas as configurações de DEFAULT e nulabilidade existentes na tabela.

Após a inserção, foram confirmados os seguintes resultados:

- Dez organizações cadastradas;
- Identificadores de 1 a 10;
- Todas as organizações ativas;
- Telefone e data de fundação com valores NULL.

### 13.2. Inserção das pessoas

A estratégia de geração de registros desenvolvida durante os exercícios foi reaproveitada para inserir as 100.000 pessoas.

Na implementação final, foi utilizada apenas uma CTE, pois a transformação dos dados pôde ser realizada diretamente no SELECT da instrução INSERT.

```sql
;WITH NumerosGerados AS (
    SELECT
        ROW_NUMBER() OVER (
            ORDER BY
                A.Numero,
                B.Numero,
                C.Numero,
                D.Numero,
                E.Numero
        ) AS Sequencia
    FROM (VALUES
        (1), (2), (3), (4), (5),
        (6), (7), (8), (9), (10)
    ) AS A(Numero)

    CROSS JOIN (VALUES
        (11), (12), (13), (14), (15),
        (16), (17), (18), (19), (20)
    ) AS B(Numero)

    CROSS JOIN (VALUES
        (21), (22), (23), (24), (25),
        (26), (27), (28), (29), (30)
    ) AS C(Numero)

    CROSS JOIN (VALUES
        (31), (32), (33), (34), (35),
        (36), (37), (38), (39), (40)
    ) AS D(Numero)

    CROSS JOIN (VALUES
        (41), (42), (43), (44), (45),
        (46), (47), (48), (49), (50)
    ) AS E(Numero)
)
INSERT INTO Pessoa (
    Nome,
    IsIngressada,
    OrganizacaoId
)
SELECT
    CONCAT('Pessoa ', Sequencia) AS Nome,
    1,
    ((Sequencia - 1) % 10) + 1 AS OrganizacaoId
FROM NumerosGerados;
```

A instrução foi construída considerando as seguintes características:

| Coluna | Estratégia de preenchimento |
|---|---|
| PessoaId | Geração automática por IDENTITY. |
| Nome | CONCAT com a sequência gerada. |
| DataNascimento | NULL. |
| DataIngresso | NULL. |
| IsIngressada | Valor explícito igual a 1. |
| IsAtiva | Valor padrão igual a 1. |
| Telefone | NULL. |
| OrganizacaoId | Distribuição circular entre os identificadores de 1 a 10. |

A inserção foi concluída respeitando as restrições de integridade existentes na tabela Pessoa.

---

## 14. Validação dos registros inseridos

Após a inserção, foram realizadas consultas para verificar a quantidade total de pessoas e sua distribuição entre as organizações.

### 14.1. Quantidade total de pessoas

```sql
SELECT COUNT(*) AS TotalPessoas
FROM Pessoa;
```

Resultado obtido:

| TotalPessoas |
|---:|
| 100000 |

### 14.2. Distribuição por organização

```sql
SELECT
    OrganizacaoId,
    COUNT(*) AS TotalPessoas
FROM Pessoa
GROUP BY OrganizacaoId
ORDER BY OrganizacaoId;
```

Resultado obtido:

| OrganizacaoId | TotalPessoas |
|---:|---:|
| 1 | 10000 |
| 2 | 10000 |
| 3 | 10000 |
| 4 | 10000 |
| 5 | 10000 |
| 6 | 10000 |
| 7 | 10000 |
| 8 | 10000 |
| 9 | 10000 |
| 10 | 10000 |

Os resultados confirmaram que a estratégia de distribuição uniforme foi implementada corretamente.

### 14.3. Validação dos indicadores de ingresso e atividade

Foi definida uma consulta complementar para verificar os indicadores IsIngressada e IsAtiva.

```sql
SELECT
    IsIngressada,
    IsAtiva,
    COUNT(*) AS TotalPessoas
FROM Pessoa
GROUP BY
    IsIngressada,
    IsAtiva;
```

Resultado esperado:

| IsIngressada | IsAtiva | TotalPessoas |
|---:|---:|---:|
| 1 | 1 | 100000 |

A confirmação do resultado dessa consulta ficou pendente no momento da elaboração deste relatório.

### 14.4. Validação eficiente de grandes volumes de dados

Também foi discutida a utilização de SELECT * para validar tabelas com grandes quantidades de registros.

Embora seja uma instrução válida, retornar 100.000 registros ao SSMS não é necessário quando o objetivo consiste apenas em verificar a quantidade de registros inseridos.

A utilização de consultas agregadas, como COUNT e GROUP BY, permite obter informações mais objetivas e reduz o volume de dados transferidos ao cliente.

Essa prática representa uma introdução ao desenvolvimento de consultas orientadas à eficiência e à finalidade de cada operação.

---

## 15. Principais aprendizados

A aula permitiu ampliar os conhecimentos de SQL para além das operações convencionais de cadastro e consulta.

Os principais conceitos estudados e consolidados foram:

- Geração de dados utilizando operações set-based;
- Utilização de VALUES como fonte de dados;
- Geração de combinações por meio do CROSS JOIN;
- Crescimento multiplicativo de conjuntos de registros;
- Numeração sequencial com ROW_NUMBER();
- Diferença entre o valor de uma linha e sua numeração;
- Ordenação determinística em funções de janela;
- Organização de consultas com CTEs;
- Utilização de múltiplas CTEs;
- Escopo e características de materialização das CTEs;
- Conversão implícita de valores na função CONCAT;
- Funcionamento do operador módulo;
- Distribuição circular e uniforme de registros;
- Diferenças entre distribuições uniformes e aleatórias;
- Diferenças entre UNION e UNION ALL;
- Impacto potencial da eliminação de duplicidades no desempenho;
- Preservação dos tipos de dados em consultas;
- Inserção de registros utilizando INSERT INTO ... SELECT;
- Aproveitamento das propriedades IDENTITY e DEFAULT;
- Validação de dados antes e após operações de inserção;
- Separação entre ambientes de desenvolvimento e laboratório.

Um dos principais avanços desta aula foi compreender como diferentes recursos do SQL Server podem ser combinados para resolver um problema de maior complexidade.

A geração de 100.000 registros não exigiu estruturas de repetição, inserções individuais ou ferramentas externas, sendo realizada por meio da combinação de recursos nativos do SQL Server.

---

## 16. Situação atual do projeto

### Banco de desenvolvimento

O banco IgrejaApp foi preservado, mantendo a estrutura e os dados utilizados nas semanas anteriores.

### Banco de laboratório

| Tabela | Quantidade de registros |
|---|---:|
| Organizacao | 10 |
| Pessoa | 100.000 |
| Atividade | 0 |
| AtividadeOrganizadora | 0 |
| Presenca | 0 |

A primeira etapa de geração da massa de dados foi concluída.

A estrutura existente foi suficiente para suportar as inserções realizadas, sem necessidade de alterações nas regras de negócio ou na modelagem do projeto.

---

## 17. Organização e versionamento dos arquivos

A geração da massa de dados deverá ser registrada no seguinte script:

`database/scripts/004-geracao-massa-dados.sql`

Esse arquivo será responsável por centralizar as instruções de geração dos dados fictícios destinados ao banco IgrejaApp_Laboratorio.

O registro técnico da aula será armazenado em:

`estudos/semana-03/dia-01.md`

O script de geração de dados será complementado nas próximas aulas, conforme a evolução da massa de laboratório.

---

## 18. Planejamento da próxima aula

**Semana 03 — Dia 02**

A próxima aula será destinada à continuidade da geração da massa de dados.

Atividades planejadas:

1. Definir a estratégia de geração das atividades fictícias.
2. Inserir os registros na tabela Atividade.
3. Gerar os relacionamentos entre atividades e organizações.
4. Definir uma estratégia para geração de 1.000.000 de registros de presença.
5. Garantir a integridade das chaves estrangeiras.
6. Respeitar a chave primária composta da tabela Presenca, evitando registros duplicados.
7. Validar quantitativamente a massa de dados.
8. Iniciar os estudos de planos de execução, caso haja tempo disponível.

Devido à duração da aula e à quantidade de conceitos abordados, foi decidido encerrar o Dia 01 após a geração das organizações e pessoas, transferindo as demais atividades para o Dia 02.

Essa decisão não altera os objetivos gerais do planejamento de 24 semanas, representando apenas uma redistribuição das atividades previstas para a Semana 03.

---

## 19. Conclusão

O primeiro dia da Semana 03 marcou a transição dos estudos de modelagem, integridade e consultas relacionais para a preparação de cenários de análise de desempenho.

Foi possível aplicar conhecimentos adquiridos nas semanas anteriores e desenvolver novas estratégias para manipulação de grandes volumes de dados utilizando recursos nativos do SQL Server.

A criação de um ambiente de laboratório independente, associada à geração controlada e validada de dados fictícios, estabeleceu a base necessária para os próximos estudos de planos de execução, índices, estatísticas e otimização de consultas.

Ao final da aula, foram confirmadas a inserção de dez organizações e 100.000 pessoas, distribuídas uniformemente entre as organizações, preservando a integridade referencial e as regras de negócio implementadas no projeto IgrejaApp.