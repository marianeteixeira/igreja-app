-- Consultas de estudo e validação dos relatórios do IgrejaApp --

-----------------------------------------------------------------
------------ Relatório de presença por atividade ----------------
-----------------------------------------------------------------
--Requisitos técnicos
--1. Utilizar as tabelas Presenca, Pessoa, Atividade e Organizacao.
--2. Relacionar corretamente as quatro tabelas.
--3. Utilizar aliases para tornar o SQL legível.
--4. Ordenar os resultados pela data de realização da atividade e pelo nome da pessoa.
--5. Considerar que uma pessoa pode não possuir organização vinculada. 
--A consulta não deve excluir sua presença por esse motivo.

SELECT	ATI.Nome AS Atividade,
		ATI.DataHoraRealizacao,
		PES.Nome AS Pessoa,
		ORG.Nome AS OrganizacaoPessoa
FROM Presenca PRE
INNER JOIN Atividade ATI
	ON PRE.AtividadeId = ATI.AtividadeId
INNER JOIN Pessoa PES
	ON PRE.PessoaId = PES.PessoaId
LEFT JOIN Organizacao ORG
	ON PES.OrganizacaoId = ORG.OrganizacaoId
ORDER BY ATI.DataHoraRealizacao, PES.Nome

-----------------------------------------------------------------
---------- Relatório consolidado de atividades ------------------
-----------------------------------------------------------------
--Requisitos técnicos
--1. Retornar todas as atividades, mesmo sem presenças.
--2. Contar o número de pessoas presentes em cada atividade.
--3. Contar o número de organizações responsáveis por cada atividade.
--4. Utilizar JOIN, COUNT e GROUP BY.
--5. Ordenar pelo nome da atividade.
--6. Evitar contagens incorretas quando uma atividade possuir várias 
--pessoas presentes e várias organizações organizadoras.

SELECT	ATI.Nome AS Atividade,
		COUNT(DISTINCT PRE.PessoaId) AS TotalPresentes,
		COUNT (DISTINCT ATIORG.OrganizacaoId) AS TotalOrganizacoes
FROM Atividade ATI
LEFT JOIN Presenca PRE
	ON ATI.AtividadeId = PRE.AtividadeId
LEFT JOIN AtividadeOrganizadora ATIORG
	ON ATI.AtividadeId = ATIORG.AtividadeId 
GROUP BY ATI.AtividadeId,  ATI.Nome
ORDER BY ATI.Nome

-----------------------------------------------------------------
------- Relatório de organizações sem atividades - NOT IN -------
-----------------------------------------------------------------
--Requisitos técnicos
--1. Retornar OrganizacaoId e Nome.
--2. Considerar todas as organizações cadastradas, inclusive as inativas.
--3. Não retornar organizações que já organizaram alguma atividade.
--4. Ordenar pelo nome da organização.
--5. Evitar utilizar valores fixos de IDs.

SELECT  ORG.OrganizacaoId,
		ORG.Nome AS Organizacao
FROM Organizacao ORG
WHERE ORG.OrganizacaoId NOT IN ( SELECT ATIORG. OrganizacaoId
								 FROM AtividadeOrganizadora ATIORG)
ORDER BY ORG.Nome

-----------------------------------------------------------------
----- Relatório de organizações sem atividades - NOT EXISTS -----
-----------------------------------------------------------------
--Requisitos técnicos
--1. Utilize obrigatoriamente NOT EXISTS.
--2. Não utilize JOIN na consulta principal.
--3. Não utilize IDs fixos.
--4. Retorne OrganizacaoId e Nome.
--5. Ordene pelo nome da organização.

SELECT  ORG.OrganizacaoId,
		ORG.Nome AS Organizacao
FROM Organizacao ORG
WHERE NOT EXISTS ( SELECT *
					FROM AtividadeOrganizadora ATIORG
					WHERE ATIORG.OrganizacaoId = ORG.OrganizacaoId)
ORDER BY ORG.Nome

-----------------------------------------------------------------
------------- Relatório de pessoas sem participação ----------
-----------------------------------------------------------------
--Requisitos técnicos
--1. Considerar apenas pessoas com IsIngressada = 1 e IsAtiva = 1.
--2. Retornar somente pessoas sem nenhuma presença.
--3. Utilizar uma subconsulta correlacionada.
--4. Não utilizar IDs fixos.
--5. Ordenar pelo nome da organização e, depois, pelo nome da pessoa.
--6. Garantir que TotalPresencas seja apresentado como 0.

SELECT PES.PessoaId,
	PES.Nome AS Pessoa,
	ORG.Nome AS Organizacao,
	0 AS TotalPresencas
FROM Pessoa PES
INNER JOIN Organizacao ORG
	ON PES.OrganizacaoId = ORG.OrganizacaoId
WHERE	PES.IsIngressada = 1 
	AND PES.IsAtiva = 1
	AND NOT EXISTS (SELECT * 
					FROM Presenca PRE 
					WHERE PES.PessoaId = PRE.PessoaId)
ORDER BY ORG.Nome, PES.Nome

-----------------------------------------------------------------
------ Relatório de pessoas sem participação em um período ------
-----------------------------------------------------------------
--Requisitos técnicos
--1. Considerar apenas pessoas ingressadas e ativas.
--2. Identificar pessoas sem presenças em atividades realizadas durante 
--dezembro de 2026.
--3. Considerar a data da tabela Atividade, não a data do cadastro da pessoa.
--4. Utilizar uma subconsulta correlacionada.
--5. Não utilizar IDs fixos.
--6. Não excluir uma pessoa apenas porque ela participou de atividades 
--fora do período.

DECLARE @DataInicial DATE = '2026-12-01'
DECLARE @DataFinal DATE = '2026-12-31'

SELECT PES.PessoaId,
	PES.Nome AS Pessoa,
	ORG.Nome AS Organizacao,
	0 AS TotalPresencas
FROM Pessoa PES
INNER JOIN Organizacao ORG
	ON PES.OrganizacaoId = ORG.OrganizacaoId
WHERE	PES.IsIngressada = 1 
	AND PES.IsAtiva = 1
	AND NOT EXISTS (SELECT * 
					FROM Presenca PRE 
					INNER JOIN Atividade ATI
						ON PRE.AtividadeId = ATI.AtividadeId
						AND ATI.DataHoraRealizacao >= @DataInicial 
						AND ATI.DataHoraRealizacao < DATEADD(DAY, 1, @DataFinal)
					WHERE PES.PessoaId = PRE.PessoaId)
ORDER BY ORG.Nome, PES.Nome