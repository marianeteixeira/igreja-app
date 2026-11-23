/*
    Projeto: IgrejaApp
    Script: 004-geracao-massa-dados.sql
    Objetivo: Gerar dados ficticios para testes de desempenho.
    Ambiente: IgrejaApp_Laboratorio
    Criacao: 23/11/2026

    Massa de dados:
    - 10 organizacoes
    - 100.000 pessoas
    - Atividades (pendente)
    - 1.000.000 de presencas (pendente)
*/

IF DB_NAME() <> 'IgrejaApp_Laboratorio'
BEGIN
    THROW 50001, 'Execute este script apenas no banco IgrejaApp_Laboratorio.', 1;
END;

-- Pre-requisito:
-- Banco de laboratorio com a estrutura criada
-- e as tabelas de destino vazias.
-- Nao executar novamente sobre uma massa ja gerada.

---- TABELA Organizacao --
--INSERT INTO Organizacao (Nome)
--SELECT	CONCAT('ORG ', Numero) AS Nome
--FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Numeros(Numero);

---- TABELA Pessoa --
--;WITH NumerosGerados AS (
--	SELECT
--		ROW_NUMBER() OVER (ORDER BY A.Numero, B.Numero, C.Numero, D.Numero, E.Numero) AS Sequencia
--	FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS A(Numero)
--	CROSS JOIN (VALUES (11), (12), (13), (14), (15), (16), (17), (18), (19), (20)) AS B(Numero)
--	CROSS JOIN (VALUES (21), (22), (23), (24), (25), (26), (27), (28), (29), (30)) AS C(Numero)
--	CROSS JOIN (VALUES (31), (32), (33), (34), (35), (36), (37), (38), (39), (40)) AS D(Numero)
--	CROSS JOIN (VALUES (41), (42), (43), (44), (45), (46), (47), (48), (49), (50)) AS E(Numero)
--)

--INSERT INTO Pessoa (Nome, IsIngressada, OrganizacaoId)
--SELECT	CONCAT('Pessoa ', Sequencia) AS Nome,
--		1, 
--		((Sequencia-1) % 10) + 1 AS OrganizacaoId
--FROM NumerosGerados