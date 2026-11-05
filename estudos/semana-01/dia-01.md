# Semana 01 — Dia 01
## Fundamentos de SQL Server e modelagem de dados

**Projeto:** IgrejaApp  
**Etapa:** Modelagem inicial  
**Status:** Aula concluída — implementação pendente

### 1. Objetivo

Compreender os fundamentos de bancos de dados relacionais e iniciar a modelagem das entidades `Organizacao`, `Pessoa` e `Atividade`.

### 2. Conceitos estudados

- **Tabela:** estrutura que organiza registros em linhas e colunas.
- **Primary Key (PK):** identifica cada registro de maneira única.
- **Foreign Key (FK):** estabelece referências entre tabelas.
- **Cardinalidade:** relacionamentos 1:1, 1:N e N:N.
- **Tipos de dados:** `INT`, `VARCHAR`, `NVARCHAR`, `DATE`, `DATETIME2` e `BIT`.
- **NULL / NOT NULL:** definem se uma coluna aceita ausência de valor.
- **IDENTITY:** permite gerar identificadores automaticamente.
- **DEFAULT:** define um valor padrão quando aplicável.
- **CHECK:** permite validar condições no banco.
- **Normalização:** ajuda a organizar os dados e evitar redundâncias problemáticas.

### 3. Modelagem inicial

#### Organizacao

| Atributo | Tipo | Regra |
|---|---|---|
| OrganizacaoId | INT | PK, IDENTITY |
| Nome | NVARCHAR(150) | NOT NULL |
| Telefone | VARCHAR(20) | NULL |
| Ativa | BIT | NOT NULL, DEFAULT 1 |
| DataFundacao | DATE | NULL |

**Decisões adicionais:**
- Endereços serão estudados como estrutura separada.
- Classificações oficiais poderão ter tabela própria.
- Histórico de classificações e endereços poderá ser registrado quando conhecido.

#### Pessoa

Atributos inicialmente identificados:

- PessoaId
- Nome
- DataNascimento
- DataIngresso
- IsIngressada
- IsAtiva
- Departamento
- Telefone
- Endereco

**Regras discutidas:**
- Uma pessoa pode frequentar atividades sem ter ingressado oficialmente.
- A data de ingresso pode ser desconhecida mesmo quando a pessoa é ingressada.
- Inatividade não significa perda da condição de ingressada.
- Falecimento deve ser representado separadamente da inatividade.
- O histórico de transferências entre igrejas é relevante.
- Departamento poderá ser uma entidade própria.

#### Atividade

Atributos inicialmente identificados:

- AtividadeId (identificado durante a correção)
- Nome
- DepartamentoResponsavel
- DepartamentoParticipante
- DataHoraRealizacao
- Local

**Regras discutidas:**
- Uma atividade pode envolver várias igrejas.
- A organização responsável não é necessariamente a mesma coisa que as organizações participantes.
- Uma atividade pode envolver diferentes departamentos.

### 4. Decisões de escopo

Manter o plano original de 24 semanas como referência.

Priorizar a implementação das três entidades iniciais, sem antecipar todos os recursos históricos, de permissões e de auditoria.

### 5. Pendências

- Definir os relacionamentos mínimos para a primeira implementação.
- Revisar os tipos e a obrigatoriedade dos atributos de Pessoa e Atividade.
- Decidir quais estruturas adicionais precisam entrar no primeiro script.
- Detalhar futuramente endereços, departamentos, classificações e históricos.

### 6. Próxima sessão — Dia 02

- Revisar o modelo inicial.
- Preparar o ambiente e o repositório.
- Criar o primeiro script SQL.
- Implementar as tabelas essenciais com orientação.
- Verificar a criação das estruturas.

**Resumo pessoal:** Nesta aula, pratiquei como transformar regras de negócio em entidades, atributos e relacionamentos, distinguindo necessidades atuais de possíveis evoluções do sistema.
