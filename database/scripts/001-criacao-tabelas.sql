CREATE TABLE Organizacao(
    OrganizacaoId   INT IDENTITY(1,1) CONSTRAINT PK_Organizacao PRIMARY KEY,
    Nome	        NVARCHAR(150)	NOT NULL,
    Telefone	    VARCHAR(20)	NULL,
    IsAtiva	        BIT	NOT NULL CONSTRAINT DF_Organizacao_IsAtiva DEFAULT (1),
    DataFundacao	DATE	NULL
);

CREATE TABLE Pessoa(
    PessoaId        INT IDENTITY(1,1) CONSTRAINT PK_Pessoa PRIMARY KEY,
    Nome            NVARCHAR(150) NOT NULL,
    DataNascimento  DATE NULL,
    DataIngresso    DATE NULL,
    IsIngressada    BIT NOT NULL  CONSTRAINT DF_Pessoa_IsIngressada DEFAULT (0),
    IsAtiva         BIT NOT NULL CONSTRAINT DF_Pessoa_IsAtiva DEFAULT (1),
    Telefone        NVARCHAR(20) NULL,
    OrganizacaoId   INT NULL,
    CONSTRAINT FK_Pessoa_Organizacao  FOREIGN  KEY (OrganizacaoId) REFERENCES Organizacao(OrganizacaoId)
);

CREATE TABLE Atividade(
    AtividadeId         INT IDENTITY(1,1) CONSTRAINT PK_Atividade PRIMARY KEY,
    Nome                NVARCHAR(150) NOT NULL,
    DataHoraRealizacao  DATETIME2 NULL,
    Local               NVARCHAR(150) NULL
);

CREATE TABLE AtividadeOrganizadora(
    AtividadeId         INT,
    OrganizacaoId       INT,
    CONSTRAINT PK_AtividadeOrganizadora              PRIMARY  KEY (AtividadeId, OrganizacaoId),
    CONSTRAINT FK_AtividadeOrganizadora_Atividade    FOREIGN  KEY (AtividadeId) REFERENCES Atividade(AtividadeId),
    CONSTRAINT FK_AtividadeOrganizadora_Organizacao  FOREIGN  KEY (OrganizacaoId) REFERENCES Organizacao(OrganizacaoId)
);