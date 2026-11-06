# Semana 01 — Dia 02
## Implementação inicial do banco de dados

**Projeto:** IgrejaApp  
**Tecnologia:** SQL Server  
**Duração prevista:** 1 hora  
**Status:** Concluído

### 1. Objetivo

Iniciar a implementação do modelo relacional do IgrejaApp, aplicando os conceitos de tabelas, tipos de dados, chaves primárias, chaves estrangeiras e restrições.

### 2. Pré-requisitos

- [x] Acessar o ambiente de desenvolvimento.
- [x] Clonar ou atualizar o repositório IgrejaApp.
- [x] Verificar a disponibilidade do SQL Server e da ferramenta de execução de consultas.
- [x] Revisar as decisões documentadas no Dia 01.

### 3. Atividades previstas

**Etapa 1 — Revisão do modelo (10 min)**

- Revisar as entidades `Organizacao`, `Pessoa` e `Atividade`.
- Definir os relacionamentos mínimos para a implementação.
- Identificar atributos obrigatórios e opcionais.

**Etapa 2 — Preparação (15 min)**

- Organizar os arquivos SQL no repositório.
- Preparar o ambiente para execução dos scripts.
- Definir a ordem de criação das tabelas.

**Etapa 3 — Implementação (30 min)**

- Criar o script inicial das tabelas.
- Aplicar os tipos de dados definidos.
- Configurar chaves primárias e geração automática de identificadores.
- Implementar os relacionamentos essenciais.
- Aplicar restrições de integridade.

**Etapa 4 — Verificação (5 min)**

- Executar o script.
- Identificar possíveis erros de sintaxe ou relacionamento.
- Registrar resultados e pendências.

### 4. Escopo

**Incluído:**
- Estrutura inicial de `Organizacao`, `Pessoa` e `Atividade`.
- Chaves e relacionamentos essenciais.
- Restrições básicas de integridade.

**Fora do escopo inicial:**
- Histórico completo de transferências.
- Histórico de classificações e endereços.
- Autenticação e permissões.
- Auditoria.
- Funcionalidades de relatórios.

### 5. Entregáveis previstos

- [x] Primeiro script SQL versionado.
- [x] Estruturas iniciais criadas no SQL Server.
- [x] Registro das decisões e ajustes realizados.

### 6. Resultados da execução

**Banco de dados:** `IgrejaApp`
**Script:** `database/scripts/001-criacao-tabelas.sql`

O banco de dados foi criado no SQL Server e as seguintes tabelas foram implementadas:

| Tabela | Descrição |
|---|---|
| `Organizacao` | Cadastro das organizações. |
| `Pessoa` | Cadastro de pessoas e vínculo opcional com uma organização. |
| `Atividade` | Cadastro de atividades, com data e local opcionais. |
| `AtividadeOrganizadora` | Relacionamento N:N entre atividades e organizações responsáveis. |

**Restrições implementadas:**
- Chaves primárias com nomes explícitos.
- Geração automática de identificadores com `IDENTITY`.
- Chaves estrangeiras para garantir integridade referencial.
- Chave primária composta em `AtividadeOrganizadora`.
- Valores padrão para `IsAtiva` e `IsIngressada`.

**Decisões de modelagem:**
- `Pessoa.OrganizacaoId` permite `NULL` para pessoas sem vínculo definido.
- `Pessoa.IsIngressada` possui valor padrão `0`.
- `Atividade.DataHoraRealizacao` utiliza `DATETIME2 NULL`.
- Uma atividade pode ter múltiplas organizações responsáveis, representadas pela tabela associativa `AtividadeOrganizadora`.

**Validação:**

As quatro tabelas foram criadas e suas estruturas verificadas no SSMS utilizando `sp_help`. As chaves primárias, estrangeiras e restrições implementadas foram validadas.

### 7. Dificuldades e pendências

**Dificuldades resolvidas:**
- Nomeação e renomeação de constraints.
- Diferença entre alterações no script SQL e na estrutura existente do banco.
- Sintaxe de declaração de chaves estrangeiras.
- Implementação de chave primária composta em relacionamento N:N.
- Identificação da diferença entre `IDENTITY` e chaves estrangeiras.

**Pendências:**
- Implementar a associação de organizações participantes nas atividades.
- Avaliar a restrição `CHECK` entre `Pessoa.IsIngressada` e `Pessoa.OrganizacaoId`.
- Inserir dados fictícios e testar os relacionamentos.
- Versionar o script SQL e a documentação no Git.

### 8. Próxima sessão

**Dia 03 — Testes, dados fictícios, documentação e versionamento.**

As atividades pendentes do Dia 02 serão reavaliadas antes de iniciar novas tarefas.
