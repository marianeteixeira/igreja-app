# Semana 02 — Dia 01: Modelagem de Presença e Integridade

**Projeto:** IgrejaApp  
**Data:** 10/11/2026  
**Duração planejada:** 1 hora  
**Status:** Concluído

## 1. Objetivo

Estudar a modelagem do controle de presença em atividades, aprofundar os conceitos de integridade de dados e definir as regras de negócio necessárias para a implementação da tabela `Presenca`.

Consolidar as decisões funcionais do projeto em um documento centralizado de regras de negócio.

## 2. Conteúdos estudados

### 2.1. Relacionamento N:N

Foi revisado o relacionamento muitos para muitos entre `Pessoa` e `Atividade`.

Uma pessoa pode participar de várias atividades, e uma atividade pode receber várias pessoas.

Para representar esse relacionamento, foi proposta a tabela intermediária `Presenca`.

### 2.2. Chave primária composta

Foi definida a utilização de uma chave primária composta pelas colunas:

- `PessoaId`
- `AtividadeId`

Essa combinação impede o registro duplicado de uma mesma pessoa na mesma atividade, permitindo que uma pessoa participe de atividades diferentes.

### 2.3. Integridade referencial

Foram revisadas as restrições `PRIMARY KEY` e `FOREIGN KEY`.

As chaves estrangeiras da tabela `Presenca` deverão garantir que os registros estejam relacionados a pessoas e atividades existentes.

### 2.4. Restrição CHECK

Foi estudado o funcionamento da restrição `CHECK` para validar condições específicas no banco de dados.

Foi utilizada como exemplo a regra que exige uma organização vinculada para pessoas ingressadas.

Condição definida:

```sql
IsIngressada = 0
OR OrganizacaoId IS NOT NULL
```

A regra permite que pessoas não ingressadas possuam ou não uma organização vinculada, mas impede que pessoas ingressadas sejam cadastradas sem organização.

A implementação da restrição na tabela `Pessoa` ficou planejada para o Dia 02.

### 2.5. Operadores lógicos

Foram revisados:

- `AND`: exige que todas as condições sejam verdadeiras.
- `OR`: exige que pelo menos uma condição seja verdadeira.
- `IS NULL`: verifica a ausência de valor.
- `IS NOT NULL`: verifica a existência de valor.

Também foi reforçado que o SQL Server utiliza `=` para comparação de igualdade, e não `==`.

## 3. Modelagem da tabela Presenca

Foi definida a seguinte estrutura inicial:

| Coluna | Tipo | Restrições |
|---|---|---|
| PessoaId | INT | NOT NULL, PK composta, FK |
| AtividadeId | INT | NOT NULL, PK composta, FK |
| Observacao | NVARCHAR(500) | NULL |

A tabela armazenará os comparecimentos efetivos às atividades.

O campo `Observacao` será opcional e permitirá registrar informações complementares sobre a participação.

Não será incluído inicialmente um campo específico para a data e hora de lançamento da presença.

## 4. Regras de negócio discutidas

### 4.1. Registro de comparecimento

O MVP armazenará apenas presenças efetivas, sem cadastrar individualmente as ausências.

### 4.2. Participação entre organizações

Pessoas poderão participar de atividades organizadas por outras organizações, independentemente de seu vínculo cadastral.

### 4.3. Público-alvo e ausências

Foi identificada a possibilidade de calcular ausências comparando o público esperado com os registros de presença.

Na ausência de uma lista de confirmação, o público esperado será determinado pelos critérios da atividade, como organização, departamento e situação cadastral.

Quando houver lista de confirmação, as pessoas confirmadas serão consideradas o público esperado para a apuração das ausências.

A implementação deverá considerar a preservação das informações históricas, evitando que alterações cadastrais posteriores modifiquem indevidamente relatórios de atividades passadas.

### 4.4. Participação sem confirmação

Pessoas que não tenham confirmado previamente poderão ter sua presença registrada normalmente.

O campo `Observacao` poderá ser utilizado para complementar o registro, sem obrigatoriedade de preenchimento.

### 4.5. Separação entre organização, público-alvo e permissões

Foi definido que as organizações e os departamentos organizadores de uma atividade não precisam coincidir com aqueles definidos como público-alvo.

Também foi estabelecido que as permissões de gerenciamento não devem depender exclusivamente do vínculo da pessoa com uma organização ou departamento.

Um usuário poderá receber autorização para auxiliar na administração de atividades de outras organizações, respeitando as permissões concedidas.

A definição detalhada desse modelo de autorização permanece pendente.

## 5. Desafios realizados

| Desafio | Conteúdo | Resultado |
|---|---|---|
| 42 | Relacionamento N:N e chave composta | Concluído |
| 43 | Modelo de registro de presença | Concluído |
| 44 | Integridade referencial | Concluído |
| 45 | Regras de negócio e FOREIGN KEY | Concluído |
| 46 | Condições lógicas com OR | Concluído após correção |
| 47 | Interpretação da restrição CHECK | Concluído |
| 48 | Avaliação da data de registro | Concluído |
| 49 | Participação entre organizações | Concluído |
| 50 | Campo de observações | Concluído |
| 51 | Confirmação e participação | Concluído |

## 6. Documentação

Foi proposta a criação do arquivo:

`docs/regras-de-negocio.md`

O documento centraliza as regras funcionais do IgrejaApp, diferenciando decisões aprovadas, funcionalidades implementadas, pendências e evoluções futuras.

Também foi definida a necessidade de manter um histórico de revisões conforme as regras forem alteradas.

## 7. Dificuldades e aprendizados

Durante os exercícios, foi identificada e corrigida uma condição lógica que utilizava `IS NULL` em vez de `IS NOT NULL`.

A correção reforçou o entendimento de que uma restrição deve representar exatamente a regra de negócio pretendida.

A discussão sobre ausências também demonstrou a importância de distinguir:

- Pessoas que efetivamente compareceram.
- Pessoas esperadas na atividade.
- Pessoas que confirmaram participação.
- Organizações e departamentos responsáveis pela organização.
- Usuários autorizados a gerenciar a atividade.

Essas distinções deverão orientar as próximas etapas da modelagem.

## 8. Pendências

- Criar a tabela `Presenca` no SQL Server.
- Implementar a restrição `CHECK` na tabela `Pessoa`.
- Testar a integridade referencial e a unicidade dos registros de presença.
- Definir futuramente a estrutura de público-alvo e listas de confirmação.
- Detalhar o modelo de permissões de gerenciamento de atividades.
- Preservar a consistência histórica dos critérios utilizados nos relatórios de ausência.

## 9. Planejamento — Semana 02, Dia 02

Na próxima aula, serão realizadas as seguintes atividades:

1. Revisar a modelagem da tabela `Presenca`.
2. Criar a tabela utilizando `CREATE TABLE`.
3. Definir a chave primária composta.
4. Criar as chaves estrangeiras para `Pessoa` e `Atividade`.
5. Adicionar a restrição `CHECK` à tabela `Pessoa`.
6. Executar testes de inserção e integridade.
7. Documentar os resultados e preparar os scripts para versionamento.

## 10. Encerramento

O Dia 01 da Semana 02 foi dedicado à modelagem conceitual e à definição de regras de integridade.

A estrutura da tabela `Presenca` foi definida, e foram identificadas regras adicionais relacionadas a público-alvo, apuração de ausências, confirmação de participação e permissões de usuários.

A implementação prática ficou programada para o Dia 02.