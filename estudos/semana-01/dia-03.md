# Semana 01 — Dia 03

**Projeto:** IgrejaApp  
**Data:** 06/11/2026  
**Status:** Concluído  
**Tema:** Inserção de dados fictícios e testes de integridade referencial

## 1. Objetivo da aula

Praticar a inserção e consulta de dados no SQL Server, validar os relacionamentos implementados na aula anterior e verificar o comportamento das restrições de integridade do banco de dados.

## 2. Dados fictícios inseridos

Foram cadastrados os seguintes registros no banco `IgrejaApp`:

**Tabela `Organizacao`**

- PL Aurora — ID 1
- PL Horizonte — ID 2
- PL Esperança — ID 3

**Tabela `Pessoa`**

- Ana Silva — ingressada, vinculada à PL Aurora.
- Bruno Costa — não ingressado, vinculado à PL Horizonte.
- Carla Souza — não ingressada, sem organização vinculada.

**Tabela `Atividade`**

- Encontro Regional — 10/12/2026, às 19h, no Auditório Central.
- Campanha Solidária — 15/12/2026, às 9h, na Praça Principal.

**Tabela `AtividadeOrganizadora`**

Foram cadastrados dois vínculos para o Encontro Regional:

- Atividade 1 — Organização 1 (PL Aurora).
- Atividade 1 — Organização 2 (PL Horizonte).

Esses registros demonstram que uma atividade pode possuir mais de uma organização responsável.

## 3. Testes realizados

### 3.1. Inserção de múltiplos registros

Utilização de `INSERT INTO` com múltiplas linhas na cláusula `VALUES`.

Foram observados os comportamentos das colunas configuradas com `IDENTITY`, `DEFAULT` e permissão para `NULL`.

### 3.2. Consulta de registros

Utilização do comando `SELECT` para consultar dados das tabelas e da cláusula `WHERE` para filtrar registros específicos.

### 3.3. Teste de chave estrangeira (FK)

Foi realizada uma tentativa de cadastrar Pedro Almeida com `OrganizacaoId = 999`, identificador inexistente na tabela `Organizacao`.

**Resultado:** erro 547, referente à restrição `FK_Pessoa_Organizacao`.

O SQL Server rejeitou a inserção. Uma consulta posterior confirmou que o registro não havia sido cadastrado.

### 3.4. Teste de chave primária composta (PK)

Foi realizada uma tentativa de inserir novamente a combinação `(AtividadeId = 1, OrganizacaoId = 1)` na tabela `AtividadeOrganizadora`.

**Resultado:** erro 2627, referente à restrição `PK_AtividadeOrganizadora`.

O SQL Server impediu a duplicação da combinação de identificadores.

## 4. Resultados obtidos

Os testes demonstraram que:

- A geração automática de identificadores está funcionando.
- Os valores padrão são aplicados às colunas não informadas.
- As colunas opcionais permitem armazenar `NULL`.
- As chaves estrangeiras impedem vínculos com registros inexistentes.
- A chave primária composta impede combinações duplicadas.
- O relacionamento N:N entre atividades e organizações