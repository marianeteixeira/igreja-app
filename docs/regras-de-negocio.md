# IgrejaApp — Regras de Negócio

**Versão:** 0.1  
**Última revisão:** 10/11/2026  
**Status:** Documento em evolução

## 1. Objetivo e convenções

Este documento reúne as regras de negócio definidas durante o desenvolvimento do IgrejaApp, sistema para gerenciamento de organizações religiosas, pessoas, atividades, presenças e acesso por usuários.

As regras poderão evoluir à medida que novas necessidades forem analisadas. A definição de uma regra **não significa que ela já foi implementada**.

**Situações utilizadas:**

- **Definida:** decisão funcional aprovada, mesmo que ainda não implementada.
- **Implementada:** comportamento ou estrutura já existente no banco ou sistema.
- **Pendente:** assunto que ainda exige decisão ou detalhamento.
- **Evolução futura:** funcionalidade fora do escopo imediato do MVP.

## 2. Organizações

### RN-ORG-01 — Identificação
Cada organização possui identificador único.

**Situação:** implementada na tabela `Organizacao`.

### RN-ORG-02 — Situação cadastral
Uma organização pode estar ativa ou inativa. A desativação não deve eliminar seu histórico.

**Situação:** campo `IsAtiva` implementado; políticas de histórico ainda não implementadas.

### RN-ORG-03 — Data de fundação
A data de fundação pode ser desconhecida e, nesse caso, permanecer sem valor.

**Situação:** implementada por `DataFundacao DATE NULL`.

### RN-ORG-04 — Classificação oficial
Organizações podem receber classificações oficiais concedidas pela sede. A classificação deve ser representada por uma estrutura de referência, com registro da data de concessão quando conhecida. O histórico de classificações poderá ser mantido quando houver informação disponível.

**Situação:** definida conceitualmente; modelagem e implementação pendentes.

### RN-ORG-05 — Endereço da organização
Cada organização terá um endereço atual. O histórico de mudanças de endereço é opcional e poderá ser registrado quando conhecido.

**Situação:** definida conceitualmente; implementação pendente.

### RN-ORG-06 — Responsabilidade do Mestre
A responsabilidade de um Mestre por uma organização deverá ser representada por um relacionamento de autorização ou responsabilidade, e não apenas por um campo fixo na organização.

**Situação:** proposta conceitual; detalhamento pendente.

## 3. Pessoas

### RN-PES-01 — Visitantes e ingressados
Uma pessoa pode ser cadastrada antes de ingressar na instituição. A condição de ingressada é representada separadamente de sua participação em atividades.

**Situação:** contemplada pela estrutura inicial da tabela `Pessoa`.

### RN-PES-02 — Organização obrigatória para ingressados
Quando `IsIngressada = 1`, `OrganizacaoId` deve estar preenchido. A regra não exige organização para pessoas não ingressadas.

Condição lógica prevista:

```sql
IsIngressada = 0 OR OrganizacaoId IS NOT NULL
```

**Situação:** definida; restrição `CHECK` ainda não implementada.

### RN-PES-03 — Organização opcional para não ingressados
Uma pessoa com `IsIngressada = 0` pode possuir uma organização vinculada ou manter `OrganizacaoId = NULL`.

**Situação:** contemplada pela estrutura atual.

### RN-PES-04 — Data de ingresso
Uma pessoa pode ser ingressada sem que a data de ingresso seja conhecida. Portanto, `DataIngresso` é opcional.

**Situação:** implementada na estrutura atual.

### RN-PES-05 — Atividade cadastral independente do ingresso
A condição de ativa ou inativa é diferente da condição de ingressada ou não ingressada.

**Situação:** contemplada pelos campos `IsAtiva` e `IsIngressada`.

### RN-PES-06 — Falecimento
O falecimento deve ser distinguido da simples inatividade. Uma possível data de falecimento será avaliada na modelagem definitiva.

**Situação:** definida conceitualmente; implementação pendente.

### RN-PES-07 — Endereço das pessoas
Pessoas podem compartilhar o mesmo registro de endereço. A mudança de endereço de uma pessoa não deverá alterar o endereço compartilhado por outras. Não está previsto histórico individual de endereços no MVP.

**Situação:** definida conceitualmente; implementação pendente.

### RN-PES-08 — Departamentos
O departamento de uma pessoa será representado por uma estrutura de referência comum às organizações. Regras de mudança de departamento e preservação histórica ainda precisam ser detalhadas.

**Situação:** proposta conceitual; implementação pendente.

## 4. Atividades

### RN-ATI-01 — Cadastro de atividades
O sistema deverá permitir cadastrar cerimônias, reuniões, eventos e outras atividades.

**Situação:** estrutura inicial da tabela `Atividade` implementada.

### RN-ATI-02 — Múltiplas organizações organizadoras
Uma atividade poderá ser organizada por mais de uma organização.

**Situação:** relacionamento N:N implementado por `AtividadeOrganizadora`.

### RN-ATI-03 — Participação entre organizações
Uma atividade poderá receber pessoas de organizações diferentes das que a organizam. O vínculo de uma pessoa a uma organização não impede sua participação em atividades de outras organizações.

**Situação:** definida; a futura tabela `Presenca` deverá respeitar a regra.

### RN-ATI-04 — Departamentos envolvidos
Uma atividade poderá envolver diferentes departamentos, incluindo departamentos responsáveis e departamentos participantes. A modelagem detalhada desses papéis permanece pendente.

**Situação:** definida conceitualmente; implementação pendente.

### RN-ATI-05 — Responsáveis e participantes são papéis distintos
A organização ou departamento responsável por organizar uma atividade não deve ser automaticamente considerado seu público-alvo.

**Situação:** definida; detalhamento da modelagem pendente.

### RN-ATI-06 — Público-alvo independente da organização
As organizações e os departamentos responsáveis pela atividade não precisam coincidir com as organizações e os departamentos definidos como público-alvo.

O público-alvo deverá ser definido por critérios próprios. Relatórios de ausência não deverão utilizar automaticamente os membros das organizações organizadoras como público esperado.

**Exemplo:** uma pessoa da Juventude da PL Niterói pode auxiliar na organização de uma atividade destinada às Senhoras da PL São Gonçalo.

**Situação:** definida; modelagem e implementação pendentes.

### RN-ATI-07 — Público esperado e participação
O público-alvo identifica a quem a atividade se destina. Para a apuração de ausências, o sistema utilizará o público esperado conforme as regras de confirmação descritas na seção de presenças.

**Situação:** definida conceitualmente; implementação futura.

## 5. Presenças e ausências

### RN-PRE-01 — Registro de comparecimento
No MVP, a tabela `Presenca` armazenará somente comparecimentos efetivos. A ausência de registro, isoladamente, não comprova falta.

**Situação:** definida; tabela ainda não implementada.

### RN-PRE-02 — Unicidade da presença
Uma pessoa não poderá ter mais de um registro de presença para a mesma atividade. A combinação `(PessoaId, AtividadeId)` será a chave primária composta da tabela `Presenca`.

**Situação:** definida; implementação pendente.

### RN-PRE-03 — Integridade referencial
Cada presença deverá referenciar uma pessoa e uma atividade existentes, por meio de chaves estrangeiras.

**Situação:** definida; implementação pendente.

### RN-PRE-04 — Presença de outras organizações
Pessoas de outras organizações poderão ter presença registrada, independentemente da organização responsável ou do público-alvo da atividade.

**Situação:** definida; implementação pendente.

### RN-PRE-05 — Observação opcional
Cada registro de presença poderá conter `Observacao NVARCHAR(500) NULL`, para registrar informações complementares sobre a participação, inclusive quando ocorrer sem confirmação prévia.

**Situação:** definida; implementação pendente.

### RN-PRE-06 — Data de lançamento
No MVP, a tabela `Presenca` não terá campo específico para data e hora do lançamento. Auditoria e rastreamento de alterações poderão ser avaliados futuramente.

**Situação:** definida para o MVP; auditoria pendente.

### RN-PRE-07 — Apuração de ausências
O sistema poderá calcular ausências comparando os registros de presença com o público esperado da atividade.

- **Sem lista de confirmação:** o público esperado será determinado pelos critérios definidos para a atividade, como organização, departamento, ingresso e situação ativa.
- **Com lista de confirmação:** o público esperado será composto pelas pessoas que confirmaram participação.

O cálculo deverá considerar os critérios válidos na data da atividade, evitando que mudanças cadastrais posteriores distorçam relatórios históricos.

**Situação:** regra conceitual definida; estrutura de público-alvo, confirmação e histórico ainda pendente.

### RN-PRE-08 — Comparecimento sem confirmação
Uma pessoa poderá comparecer e ter sua presença registrada mesmo sem constar na lista de confirmação. Ela será contabilizada normalmente entre os presentes, sem ser incluída retroativamente na lista original de confirmados.

O campo `Observacao` poderá explicar a participação, mas continuará opcional.

**Situação:** definida; implementação futura.

### RN-PRE-09 — Confirmação não equivale a presença
Confirmação e comparecimento são informações independentes. Os relatórios poderão distinguir confirmados, presentes, confirmados ausentes e presentes sem confirmação.

**Situação:** definida conceitualmente; implementação futura.

### RN-PRE-10 — Público esperado não equivale a todos os presentes
Pessoas fora do público esperado podem comparecer e ser contabilizadas como presentes. Isso não altera automaticamente os critérios usados para apurar as ausências.

**Situação:** definida conceitualmente; implementação futura.

## 6. Usuários, responsabilidades e permissões

### RN-ACE-01 — Admin Master
Papel proposto com administração geral do sistema e atribuição das organizações sob responsabilidade dos Mestres.

**Situação:** conceitual; implementação pendente.

### RN-ACE-02 — Mestre
Papel proposto para gerenciar as organizações às quais recebeu acesso e administrar permissões de usuários subordinados dentro do escopo autorizado.

**Situação:** conceitual; implementação pendente.

### RN-ACE-03 — Missassaguista
Papel proposto com acesso às funcionalidades autorizadas pelo Mestre.

**Situação:** conceitual; implementação pendente.

### RN-ACE-04 — Solicitações de acesso a relatórios
Um Mestre poderá solicitar acesso a relatórios de outras organizações. A solicitação deverá ser visível ao Admin Master e ao Mestre responsável pela organização detentora dos dados. Qualquer um deles poderá aprovar ou rejeitar; a primeira decisão registrada prevalecerá. O histórico da decisão deverá ser preservado.

**Situação:** regra proposta; modelagem e implementação pendentes.

### RN-ACE-05 — Vínculo institucional e permissão são distintos
O vínculo da pessoa com uma organização ou departamento não determina automaticamente suas permissões como usuário do sistema.

**Situação:** definida; implementação pendente.

### RN-ACE-06 — Permissões de gerenciamento de atividades
Um usuário poderá receber autorização para cadastrar, editar ou gerenciar atividades destinadas a outras organizações ou departamentos, respeitando os limites de autoridade de quem concede o acesso.

**Exemplo:** um Mestre responsável pela PL Niterói e pela PL São Gonçalo poderá autorizar um usuário da Juventude de Niterói a auxiliar no gerenciamento de uma atividade destinada às Senhoras de São Gonçalo.

A autorização administrativa não altera automaticamente o vínculo institucional da pessoa nem a torna integrante do público esperado.

**Situação:** definida; escopo e duração das permissões ainda precisam ser detalhados.

### RN-ACE-07 — Separação entre frequência e função
A organização frequentada por uma pessoa e as organizações que ela pode administrar são relacionamentos diferentes. Participar de uma atividade como convidado também não implica mudança de vínculo institucional.

**Situação:** definida conceitualmente; implementação pendente.

### RN-ACE-08 — Nomenclatura dos perfis
As discussões de negócio adotaram inicialmente `Admin Master`, `Mestre` e `Missassaguista`. O planejamento de estudos também menciona `Admin`, `Secretaria` e `Líder`. A correspondência ou substituição entre esses modelos **não está decidida** e deverá ser analisada antes da implementação de autenticação e autorização.

**Situação:** pendente.

## 7. Isolamento de dados e auditoria

### RN-SEG-01 — Acesso limitado por autorização
Usuários deverão acessar somente dados das organizações e funcionalidades para as quais tenham autorização, observadas as exceções administrativas formalmente concedidas.

**Situação:** diretriz definida; implementação pendente.

### RN-SEG-02 — Validação no backend
O controle de acesso deverá ser aplicado no backend, inclusive em consultas, relatórios e exportações, não apenas na interface.

**Situação:** diretriz técnica proposta; implementação pendente.

### RN-SEG-03 — Contexto de autorização confiável
O backend deverá verificar as organizações e ações autorizadas com base na identidade autenticada e nas permissões registradas, sem confiar exclusivamente em identificadores enviados pelo cliente.

**Situação:** diretriz técnica proposta; implementação pendente.

### RN-SEG-04 — Histórico de ações
O sistema deverá considerar o registro de ações administrativas relevantes, especialmente concessões de acesso e decisões sobre solicitações de relatórios. O mecanismo geral de auditoria será definido futuramente.

**Situação:** parcialmente definida; implementação pendente.

## 8. Pendências e decisões futuras

- Modelagem da tabela `Presenca` e implementação do `CHECK` de vínculo de pessoas.
- Estrutura de endereço compartilhado e histórico de endereço das organizações.
- Classificações oficiais, concessões e histórico.
- Departamentos e alterações de departamento ao longo do tempo.
- Representação de falecimento.
- Organizações e departamentos participantes de atividades.
- Estrutura do público-alvo e regras de participação esperada.
- Lista de confirmação: armazenamento, estados e distinção entre convite e confirmação.
- Preservação histórica dos critérios utilizados na apuração de ausências.
- Modelo definitivo de perfis e permissões, inclusive autorizações por atividade ou organização.
- Solicitações e aprovações de acesso a relatórios.
- Auditoria geral e histórico de operações.

## 9. Histórico de revisões

| Data | Versão | Alteração |
|---|---|---|
| 10/11/2026 | 0.1 | Consolidação das regras das Semanas 1 e 2; decisões sobre presença, ausências calculadas, confirmação, público-alvo independente dos organizadores e permissões administrativas. |

---

**Nota:** este documento descreve decisões funcionais e propostas técnicas. A situação real da implementação deve ser verificada nos scripts SQL e no código do projeto.
