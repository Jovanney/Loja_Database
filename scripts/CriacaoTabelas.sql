--Criando tabela Assistencia

CREATE TABLE Assistencia
   (Cnpj VARCHAR2(14) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Descricao VARCHAR2(50) NOT NULL,
    Status VARCHAR2(50) NOT NULL,
    Equipamento VARCHAR2(50) NOT NULL,

    CONSTRAINT Assistencia_pkey PRIMARY KEY (Cnpj));

--Criando tabela Tipo da Assistencia

CREATE TABLE TipoAssistencia
   (Tipo_Assistencia VARCHAR2(50) NOT NULL,
    Cnpj_Assistencia VARCHAR2(14) NOT NULL,
    
    CONSTRAINT TipoAssistencia_pkey PRIMARY KEY (Tipo_Assistencia, Cnpj_Assistencia),
    CONSTRAINT TipoAssistencia_fkey FOREIGN KEY (Cnpj_Assistencia) REFERENCES Assistencia(Cnpj));

--Criando Tabela Protocolo de Atendimento e descrição com pk com autoincremento

CREATE SEQUENCE descricao_seq;

CREATE TABLE Descricao
   (Descricao_n NUMBER NOT NULL,
    Acoes_Tomadas VARCHAR2(50) NOT NULL,
    
    CONSTRAINT Descricao_pkey PRIMARY KEY (Descricao_n));

CREATE TABLE Protocolo_de_Atendimento (
    Codigo_Protocolo VARCHAR2(50),
    Cnpj VARCHAR2(14),
    Desc_Pro NUMBER,
    Acoes_Tomadas VARCHAR2(50),
    Data_Inicio DATE,
    Data_Conclusao DATE,
    
    CONSTRAINT Protocolo_pk PRIMARY KEY (Codigo_Protocolo),
    CONSTRAINT Desc_Pro_fk FOREIGN KEY (Desc_Pro) REFERENCES Descricao(Descricao_n),
    CONSTRAINT Cnpj_fk FOREIGN KEY (Cnpj) REFERENCES Assistencia(Cnpj));

CREATE OR REPLACE TRIGGER descricao_bir 

BEFORE INSERT ON Descricao 
FOR EACH ROW

BEGIN
  SELECT descricao_seq.NEXTVAL
  INTO   :new.descricao_n
  FROM   dual;
END;


