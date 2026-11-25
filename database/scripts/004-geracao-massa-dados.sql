/*
    Projeto: IgrejaApp
    Script: 004-geracao-massa-dados.sql
    Objetivo: Gerar dados fictícios para testes de desempenho.
    Ambiente: IgrejaApp_Laboratorio
    Criação: 23/11/2026
    Última atualização: 25/11/2026

    Massa de dados prevista:
    - 10 organizações
    - 100.000 pessoas
    - 1.000 atividades
    - 1.200 relacionamentos entre atividades e organizações
    - 1.000.000 de presenças

    Total: 1.102.210 registros

    Pré-requisitos:
    - Banco de laboratório com a estrutura criada.
    - Todas as tabelas de destino vazias.
    - Colunas IDENTITY(1,1) em seu estado inicial, sem IDs consumidos.
    - Executar o script completo em um único lote, sem GO.
    - Não executar novamente sobre uma massa já gerada.
    - Executar sem outras sessões modificando as tabelas.
*/

-----------------------------------------------------------------
------------ Validação do ambiente ------------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Permitir a execução somente no banco de laboratório.
-- 2. Interromper a execução caso o banco esteja incorreto.

IF DB_NAME() <> 'IgrejaApp_Laboratorio'
BEGIN
    THROW 50001, 'Execute este script apenas no banco IgrejaApp_Laboratorio.', 1;
END;

-----------------------------------------------------------------
------------ Validação das tabelas -------------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Verificar todas as tabelas antes de iniciar as inserções.
-- 2. Utilizar EXISTS para verificar a existência de registros.
-- 3. Interromper a execução caso alguma tabela não esteja vazia.

IF EXISTS (SELECT 1 FROM Organizacao)
BEGIN
    THROW 50002, 'A tabela Organizacao não está vazia.', 2;
END;

IF EXISTS (SELECT 1 FROM Pessoa)
BEGIN
    THROW 50003, 'A tabela Pessoa não está vazia.', 3;
END;

IF EXISTS (SELECT 1 FROM Atividade)
BEGIN
    THROW 50004, 'A tabela Atividade não está vazia.', 4;
END;

IF EXISTS (SELECT 1 FROM AtividadeOrganizadora)
BEGIN
    THROW 50005, 'A tabela AtividadeOrganizadora não está vazia.', 5;
END;

IF EXISTS (SELECT 1 FROM Presenca)
BEGIN
    THROW 50006, 'A tabela Presenca não está vazia.', 6;
END;

-----------------------------------------------------------------
------------ Geração de organizações -----------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Gerar 10 organizações fictícias utilizando VALUES.
-- 2. Utilizar CONCAT para gerar os nomes.
-- 3. Utilizar IDENTITY para gerar os identificadores.
-- 4. Preservar os valores padrão definidos na tabela.

INSERT INTO Organizacao (Nome)
SELECT CONCAT('ORG ', Numero) AS Nome
FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Numeros(Numero);

-----------------------------------------------------------------
------------ Geração de pessoas ---------------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Gerar 100.000 linhas utilizando VALUES e CROSS JOIN.
-- 2. Utilizar CTE e ROW_NUMBER() para gerar uma sequência numérica.
-- 3. Utilizar CONCAT para gerar os nomes.
-- 4. Cadastrar todas as pessoas como ingressadas.
-- 5. Distribuir as pessoas circularmente entre as 10 organizações.
-- 6. Garantir 10.000 pessoas por organização.

;WITH NumerosGerados AS (
    SELECT ROW_NUMBER() OVER (ORDER BY A.Numero, B.Numero, C.Numero, D.Numero, E.Numero) AS Sequencia
    FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS A(Numero)
    CROSS JOIN (VALUES (11), (12), (13), (14), (15), (16), (17), (18), (19), (20)) AS B(Numero)
    CROSS JOIN (VALUES (21), (22), (23), (24), (25), (26), (27), (28), (29), (30)) AS C(Numero)
    CROSS JOIN (VALUES (31), (32), (33), (34), (35), (36), (37), (38), (39), (40)) AS D(Numero)
    CROSS JOIN (VALUES (41), (42), (43), (44), (45), (46), (47), (48), (49), (50)) AS E(Numero)
)
INSERT INTO Pessoa (Nome, IsIngressada, OrganizacaoId)
SELECT CONCAT('Pessoa ', Sequencia) AS Nome,
       1,
       ((Sequencia - 1) % 10) + 1 AS OrganizacaoId
FROM NumerosGerados;

-----------------------------------------------------------------
------------ Geração de atividades -------------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Gerar 1.000 atividades utilizando CTE, CROSS JOIN e ROW_NUMBER().
-- 2. Utilizar CONCAT para gerar os nomes.
-- 3. Utilizar DATEADD e CAST para gerar datas do tipo DATETIME2.
-- 4. Gerar uma atividade por dia a partir de 01/01/2024 às 19h.
-- 5. Distribuir circularmente as atividades entre 10 locais.

;WITH NumerosGerados AS (
    SELECT ROW_NUMBER() OVER (ORDER BY A.Numero, B.Numero, C.Numero) AS Sequencia
    FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS A(Numero)
    CROSS JOIN (VALUES (11), (12), (13), (14), (15), (16), (17), (18), (19), (20)) AS B(Numero)
    CROSS JOIN (VALUES (21), (22), (23), (24), (25), (26), (27), (28), (29), (30)) AS C(Numero)
)
INSERT INTO Atividade (Nome, DataHoraRealizacao, Local)
SELECT CONCAT('Atividade ', Sequencia) AS Nome,
       DATEADD(DAY, Sequencia - 1, CAST('2024-01-01T19:00:00' AS DATETIME2)) AS DataHoraRealizacao,
       CONCAT('Local ', ((Sequencia - 1) % 10) + 1) AS Local
FROM NumerosGerados;

-----------------------------------------------------------------
------------ Geração de atividades organizadoras -----------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Utilizar Atividade como fonte dos registros.
-- 2. Distribuir uma organização principal por atividade.
-- 3. Gerar uma organização adicional a cada cinco atividades.
-- 4. Garantir que a organização adicional seja diferente da principal.
-- 5. Utilizar UNION ALL para combinar os relacionamentos distintos.
-- 6. Respeitar a chave primária composta e as chaves estrangeiras.
-- 7. Gerar 1.200 relacionamentos.

INSERT INTO AtividadeOrganizadora (AtividadeId, OrganizacaoId)
SELECT AtividadeId,
       ((AtividadeId - 1) % 10) + 1 AS OrganizacaoId
FROM Atividade
UNION ALL
SELECT AtividadeId,
       (AtividadeId % 10) + 1 AS OrganizacaoId
FROM Atividade
WHERE AtividadeId % 5 = 0;

-----------------------------------------------------------------
------------ Geração de presenças --------------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Utilizar Pessoa e CROSS JOIN com dez números de 0 a 9.
-- 2. Gerar dez presenças distintas por pessoa.
-- 3. Utilizar o operador módulo para distribuir os IDs de 1 a 1.000.
-- 4. Garantir que todas as atividades recebam presenças.
-- 5. Respeitar a chave primária composta e as chaves estrangeiras.
-- 6. Gerar 1.000.000 de registros sem funções aleatórias ou loops.

INSERT INTO Presenca (PessoaId, AtividadeId)
SELECT PessoaId,
       ((PessoaId + A.Numero - 1) % 1000) + 1 AS AtividadeId
FROM Pessoa
CROSS JOIN (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9)) AS A(Numero);

-----------------------------------------------------------------
------------ Validação da massa de dados -------------------------
-----------------------------------------------------------------
-- Requisitos técnicos
-- 1. Contabilizar os registros de todas as tabelas.
-- 2. Utilizar UNION ALL para consolidar as contagens.
-- Resultado esperado: 10, 100000, 1000, 1200 e 1000000 registros.

SELECT 'Organizacao' AS Tabela, COUNT(*) AS TotalRegistros FROM Organizacao
UNION ALL
SELECT 'Pessoa', COUNT(*) FROM Pessoa
UNION ALL
SELECT 'Atividade', COUNT(*) FROM Atividade
UNION ALL
SELECT 'AtividadeOrganizadora', COUNT(*) FROM AtividadeOrganizadora
UNION ALL
SELECT 'Presenca', COUNT(*) FROM Presenca;

-----------------------------------------------------------------
------------ Validação das pessoas -------------------------------
-----------------------------------------------------------------
-- Resultado esperado: 10.000 pessoas por organização.

SELECT OrganizacaoId, COUNT(*) AS TotalPessoas
FROM Pessoa
GROUP BY OrganizacaoId
ORDER BY OrganizacaoId;

-- Resultado esperado: 100.000 pessoas ingressadas e ativas.
SELECT IsIngressada, IsAtiva, COUNT(*) AS TotalPessoas
FROM Pessoa
GROUP BY IsIngressada, IsAtiva;

-----------------------------------------------------------------
------------ Validação das atividades ----------------------------
-----------------------------------------------------------------
-- Resultado esperado: 1.000 atividades, IDs de 1 a 1.000,
-- primeira data em 01/01/2024 e última em 26/09/2026, às 19h.

SELECT COUNT(*) AS TotalAtividades,
       MIN(AtividadeId) AS MenorAtividadeId,
       MAX(AtividadeId) AS MaiorAtividadeId,
       MIN(DataHoraRealizacao) AS PrimeiraData,
       MAX(DataHoraRealizacao) AS UltimaData
FROM Atividade;

-----------------------------------------------------------------
------------ Validação das atividades organizadoras --------------
-----------------------------------------------------------------
-- Resultado esperado: 1.200 relacionamentos e 1.000 atividades.

SELECT COUNT(*) AS TotalRelacionamentos,
       COUNT(DISTINCT AtividadeId) AS TotalAtividades
FROM AtividadeOrganizadora;

-- Resultado esperado: 800 atividades com uma organização
-- e 200 atividades com duas organizações.
;WITH PrimAgrup AS (
    SELECT AtividadeId, COUNT(OrganizacaoId) AS QuantidadeOrganizacoes
    FROM AtividadeOrganizadora
    GROUP BY AtividadeId
)
SELECT QuantidadeOrganizacoes, COUNT(AtividadeId) AS TotalAtividades
FROM PrimAgrup
GROUP BY QuantidadeOrganizacoes
ORDER BY QuantidadeOrganizacoes;

-----------------------------------------------------------------
------------ Validação das presenças -----------------------------
-----------------------------------------------------------------
-- Resultado esperado: 1.000.000 de presenças, 100.000 pessoas,
-- 1.000 atividades distintas e IDs de atividades entre 1 e 1.000.

SELECT COUNT(*) AS TotalPresencas,
       COUNT(DISTINCT PessoaId) AS TotalPessoas,
       COUNT(DISTINCT AtividadeId) AS TotalAtividades,
       MIN(AtividadeId) AS MenorAtividadeId,
       MAX(AtividadeId) AS MaiorAtividadeId
FROM Presenca;

-- Resultado esperado: 100.000 pessoas com 10 presenças cada.
;WITH PresencasPorPessoa AS (
    SELECT PessoaId, COUNT(*) AS QuantidadePresencas
    FROM Presenca
    GROUP BY PessoaId
)
SELECT QuantidadePresencas, COUNT(*) AS TotalPessoas
FROM PresencasPorPessoa
GROUP BY QuantidadePresencas
ORDER BY QuantidadePresencas;

-- Resultado esperado: 1.000 atividades com 1.000 presenças cada.
;WITH PresencasPorAtividade AS (
    SELECT AtividadeId, COUNT(*) AS QuantidadePresencas
    FROM Presenca
    GROUP BY AtividadeId
)
SELECT QuantidadePresencas, COUNT(*) AS TotalAtividades
FROM PresencasPorAtividade
GROUP BY QuantidadePresencas
ORDER BY QuantidadePresencas;

