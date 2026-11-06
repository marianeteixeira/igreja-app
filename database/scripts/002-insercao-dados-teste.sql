
-- INSERÇÃO DE DADOS FICTÍCIOS VÁLIDOS PARA TESTES

INSERT INTO Organizacao (Nome, Telefone, DataFundacao)
VALUES ('PL Aurora',    '21988880001', '2010-03-15'),
       ('PL Horizonte', '21988880002', '2015-08-20'),
       ('PL Esperança', NULL,          NULL);

INSERT INTO Pessoa (Nome, IsIngressada, OrganizacaoId)
VALUES ('Ana Silva',   1, 1),
       ('Bruno Costa', 0, 2),
       ('Carla Souza', 0, NULL);

INSERT INTO Atividade (Nome, DataHoraRealizacao, Local)
VALUES ('Encontro Regional',  '2026-12-10 19:00:00', 'Auditório Central'),
       ('Campanha Solidária', '2026-12-15 09:00:00', 'Praça Principal');

INSERT INTO AtividadeOrganizadora (AtividadeId, OrganizacaoId)
VALUES (1, 1), -- Encontro Regional / PL Aurora
       (1, 2); -- Encontro Regional / PL Horizonte


-- TESTES NEGATIVOS: COMANDOS COMENTADOS INTENCIONALMENTE

-- Teste 1: violação de chave estrangeira (erro 547)
-- Organização 999 não existe.
-- INSERT INTO Pessoa (Nome, IsIngressada, OrganizacaoId)
-- VALUES ('Pedro Almeida', 1, 999);

-- Teste 2: violação de chave primária composta (erro 2627)
-- A combinação (1, 1) já existe.
-- INSERT INTO AtividadeOrganizadora (AtividadeId, OrganizacaoId)
-- VALUES (1, 1);
