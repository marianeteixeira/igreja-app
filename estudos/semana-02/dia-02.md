# Semana 02 — Dia 02 | Implementação de restrições e integridade referencial

**Projeto:** IgrejaApp  
**Data:** 16/11/2026  
**Tecnologias:** SQL Server e SQL Server Management Studio (SSMS)  
**Status:** Atividades práticas concluídas

## 1. Objetivo

Implementar a estrutura de registro de presenças e aplicar restrições de integridade ao banco de dados, garantindo o cumprimento das regras de negócio definidas durante a modelagem.

## 2. Atividades realizadas

### 2.1. Verificação do ambiente

- Confirmada a conexão com o banco de dados `IgrejaApp`.
- Consultadas as tabelas existentes por meio de `INFORMATION_SCHEMA.TABLES`.
- Verificada a existência das tabelas `Organizacao`, `Pessoa`, `Atividade` e `AtividadeOrganizadora`.

### 2.2. Criação da tabela Presenca

Implementada a tabela `Presenca` com os seguintes campos:

| Campo | Tipo | Obrigatoriedade |
|---|---|---|
| PessoaId | INT | NOT NULL |
| AtividadeId | INT | NOT NULL |
| Observacao | NVARCHAR(500) | NULL |

Definida a chave primária composta `PK_Presenca`, utilizando as colunas `PessoaId` e `AtividadeId`.

A restrição impede registros duplicados de presença para a mesma pessoa em uma mesma atividade, permitindo que uma pessoa participe de diferentes atividades.

### 2.3. Implementação das chaves estrangeiras

Criadas as seguintes restrições:

- `FK_Presenca_Pessoa`: relaciona `Presenca.PessoaId` a `Pessoa.PessoaId`.
- `FK_Presenca_Atividade`: relaciona `Presenca.AtividadeId` a `Atividade.AtividadeId`.

As restrições garantem que registros de presença estejam associados a pessoas e atividades existentes.

### 2.4. Implementação da restrição CHECK

Adicionada à tabela `Pessoa` a restrição `CK_Pessoa_Organizacao`, responsável por garantir que pessoas ingressadas estejam vinculadas a uma organização.

Condição implementada:

```sql
IsIngressada = 0 OR OrganizacaoId IS NOT NULL
```

Antes da implementação, foi realizada uma consulta para identificar registros que violassem a regra. Nenhuma inconsistência foi encontrada.

## 3. Testes de integridade

Foram executados testes negativos para validar o comportamento das restrições.

| Cenário | Restrição | Resultado |
|---|---|---|
| Pessoa ingressada sem organização | CK_Pessoa_Organizacao | Rejeitado — Msg 547 |
| Presença com pessoa inexistente | FK_Presenca_Pessoa | Rejeitado — Msg 547 |
| Presença com atividade inexistente | FK_Presenca_Atividade | Rejeitado — Msg 547 |
| Presença duplicada | PK_Presenca | Rejeitado — Msg 2627 |

Também foi realizada uma inserção válida de presença utilizando `PessoaId = 1` e `AtividadeId = 1`.

Os testes demonstraram que as restrições implementadas impedem operações que violem a integridade dos dados.

## 4. Revisão técnica e decisões

Durante a atividade, foram revisados os seguintes conceitos:

- Criação e alteração de tabelas com `CREATE TABLE` e `ALTER TABLE`.
- Definição de chaves primárias compostas.
- Integridade referencial por meio de chaves estrangeiras.
- Validação de regras de negócio com `CHECK`.
- Interpretação dos erros SQL Server `547` e `2627`.
- Atomicidade de instruções de inserção.
- Diferença entre histórico de alterações no Git e migrações de banco de dados.

**Decisão de organização:** manter a definição consolidada das tabelas e restrições no arquivo `database/scripts/001-criacao-tabelas.sql`, utilizando o histórico do Git para acompanhar a evolução inicial do projeto.

Essa abordagem foi escolhida considerando o estágio de desenvolvimento do IgrejaApp e sua futura apresentação como projeto de portfólio.

## 5. Resultados

- Estrutura da tabela `Presenca` implementada no banco de desenvolvimento.
- Chave primária composta criada e validada.
- Duas chaves estrangeiras criadas e validadas.
- Restrição `CHECK` implementada e validada.
- Testes de integridade executados com os resultados esperados.
- Revisada a organização dos scripts SQL do projeto.

## 6. Pendências de versionamento

- Consolidar as alterações no arquivo `database/scripts/001-criacao-tabelas.sql`.
- Conferir a organização e as dependências entre as tabelas.
- Registrar o relatório do Dia 02.
- Verificar o status do repositório e realizar commit e push das alterações pendentes.

## 7. Planejamento — Semana 02, Dia 03

- Revisar a estrutura consolidada do banco de dados.
- Avançar para exercícios SQL mais completos, envolvendo múltiplas tabelas e regras de negócio.
- Praticar consultas relacionais e validação de resultados.
- Priorizar autonomia na resolução dos desafios e análise crítica das soluções.
- Atualizar a documentação técnica conforme a evolução do projeto.

## 8. Considerações finais

O Dia 02 consolidou a implementação de restrições de integridade no SQL Server, transformando regras definidas na modelagem em validações efetivas no banco de dados.

A partir das próximas aulas, os exercícios terão maior complexidade e exigirão mais autonomia, considerando que os fundamentos de SQL estão sendo revisados e que o objetivo principal é aprofundar os conhecimentos necessários ao desenvolvimento backend com .NET.