
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

INSERT INTO Presenca (PessoaId, AtividadeId) 
VALUES (1, 1);


-- TESTES NEGATIVOS: COMANDOS COMENTADOS INTENCIONALMENTE

-- Teste 1: FK_Pessoa_Organizacao - violação de chave estrangeira (erro 547)
-- Organização 999 não existe.
-- INSERT INTO Pessoa (Nome, IsIngressada, OrganizacaoId)
-- VALUES ('Pedro Almeida', 1, 999);

-- Teste 2: PK_AtividadeOrganizadora - violação de chave primária composta (erro 2627)
-- A combinação (1, 1) já existe.
-- INSERT INTO AtividadeOrganizadora (AtividadeId, OrganizacaoId)
-- VALUES (1, 1);

-- Teste 3: CK_Pessoa_Organizacao - violação de CHECK (erro 547)
-- CK_Pessoa_Organizacao: pessoa ingressada exige organização.
--INSERT INTO Pessoa (Nome, IsIngressada,	OrganizacaoId) 
--VALUES ('Daniela Teste', 1, NULL);

-- Teste 4: FK_Presenca_Pessoa -  violação de chave estrangeira (erro 547)
--INSERT INTO Presenca (PessoaId, AtividadeId) 
--VALUES (999, 1);

-- Teste 5: FK_Presenca_Atividade - violaçãode de chave estrangeira (erro 547)
--INSERT INTO Presenca (PessoaId, AtividadeId) 
--VALUES (1, 999);

-- Teste 6: PK_Presenca - violação de chave primária composta (erro 2627)
--INSERT INTO Presenca (PessoaId, AtividadeId) 
--VALUES (1, 1);