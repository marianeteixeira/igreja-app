# IgrejaApp

Sistema web para gerenciamento de pessoas, atividades e controle de presença em igrejas, com suporte a múltiplas organizações.

O projeto tem como objetivo centralizar informações, facilitar a gestão de membros e simplificar o acompanhamento de atividades e eventos da igreja.

## Objetivos do projeto

- Centralizar o cadastro de pessoas.
- Gerenciar cerimônias, reuniões, eventos e outras atividades.
- Registrar e consultar presença.
- Facilitar a identificação de aniversariantes.
- Controlar o acesso às informações conforme as permissões de cada usuário.
- Garantir o isolamento dos dados entre diferentes igrejas.

## Funcionalidades do MVP

- **Cadastro de pessoas:** cadastro, edição, pesquisa e consulta de pessoas.
- **Atividades:** gerenciamento de cerimônias, reuniões e eventos.
- **Controle de presença:** registro e histórico de presença por atividade.
- **Aniversariantes:** consulta de aniversariantes por período.
- **Autenticação e autorização:** login e controle de acesso por perfil e permissões.
- **Multi-organização:** isolamento dos dados de cada igreja, com administração global pelo Admin Master.

## Perfis de acesso

- **Admin Master:** acesso global, gerenciamento das igrejas e definição dos Mestres responsáveis por cada organização.
- **Mestre:** gerenciamento das igrejas sob sua responsabilidade e definição das permissões dos Missassaguistas.
- **Missassaguista:** acesso às funcionalidades liberadas pelo Mestre.

## Funcionalidades futuras

- Relatórios de viagens e eventos.
- Controle por setores e unidades.
- Notificações de aniversários.
- Solicitação de acesso a relatórios de outras igrejas.
- Exportação de relatórios.
- Melhorias de desempenho e escalabilidade.

## Tecnologias

- C#
- ASP.NET Core Web API
- ASP.NET Core MVC / Razor Pages
- Entity Framework Core
- SQL Server
- Git e GitHub

## Arquitetura

O projeto será desenvolvido utilizando separação de responsabilidades em camadas:

- **Domain:** entidades e regras de negócio.
- **Application:** casos de uso e serviços da aplicação.
- **Infrastructure:** acesso ao banco de dados e integrações.
- **Web:** interface e endpoints da aplicação.

## Desenvolvimento

O projeto está sendo desenvolvido como parte de um plano prático de estudos de Backend .NET e SQL Server, com evolução incremental ao longo de 24 semanas.

As funcionalidades serão implementadas e documentadas conforme o avanço do desenvolvimento.

Durante a fase de estudos, serão utilizados exclusivamente dados fictícios.

## Status

Em desenvolvimento — fase inicial de modelagem e estruturação do banco de dados.
