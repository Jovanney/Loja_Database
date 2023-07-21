--Criando tabela Assistencia

CREATE TABLE Assistencia
   (Cnpj VARCHAR2(14) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Descricao VARCHAR2(50) NOT NULL,
    Status VARCHAR2(50) NOT NULL,
    Equipamento VARCHAR2(50) NOT NULL,

    CONSTRAINT Assistencia_pkey PRIMARY KEY (Cnpj));

--Criando tabela TipoAssistencia

CREATE TABLE TipoAssistencia
   (Tipo_Assistencia VARCHAR2(50) NOT NULL,
    Cnpj_Assistencia VARCHAR2(14) NOT NULL,
    
    CONSTRAINT TipoAssistencia_pkey PRIMARY KEY (Tipo_Assistencia),
    CONSTRAINT TipoAssistencia_fkey FOREIGN KEY (Cnpj_Assistencia) REFERENCES Assistencia(Cnpj));
