--Criando tabela Endereco

Create table Endereco (
    Cep VARCHAR2 (50),
    Bairro VARCHAR2(50),
    Rua VARCHAR2(50),
    
    CONSTRAINT Endereço_pk PRIMARY KEY (Cep));

--Criando tabela Usuario

Create table Usuario (
    Email VARCHAR2(50),
    Senha VARCHAR2(50) NOT NULL,
    Nome VARCHAR2(50) NOT NULL,
    Idade Number,
    Cep VARCHAR2 (50) NOT NULL,
    Numero VARCHAR2(50),
    Complemento VARCHAR2(50),

    CONSTRAINT Usuario_pk PRIMARY KEY (Email),
    CONSTRAINT Cep_fk FOREIGN KEY (Cep) REFERENCES Endereco (Cep));

--Criando tabela Telefone

CREATE TABLE Telefone(
    Numero number,
    Email_Usuario VARCHAR(50) NOT NULL,
   
    CONSTRAINT Telefone_pk PRIMARY KEY (Numero, Email_usuario),
    CONSTRAINT Email_usuario_fk FOREIGN KEY (Email_usuario) REFERENCES Usuario (Email));

--Criando tabela Cliente

CREATE TABLE Cliente(
    Email_Usuario VARCHAR(50),
    Data_Criacao_Conta DATE NOT NULL,

    CONSTRAINT Cliente_pk PRIMARY KEY (Email_Usuario),
    CONSTRAINT Email_Usuario_C_fk FOREIGN KEY (Email_Usuario) REFERENCES Usuario (Email));

--Criando tabela Assistencia

CREATE TABLE Assistencia
   (Cnpj VARCHAR2(14),
    Data_Inicio DATE NOT NULL,
    Descricao VARCHAR2(50) NOT NULL,
    Status VARCHAR2(50) NOT NULL,
    Equipamento VARCHAR2(50) NOT NULL,

    CONSTRAINT Assistencia_pkey PRIMARY KEY (Cnpj));

--Criando tabela Tipo da Assistencia

CREATE TABLE TipoAssistencia
   (Tipo_Assistencia VARCHAR2(50),
    Cnpj_Assistencia VARCHAR2(14),
    
    CONSTRAINT TipoAssistencia_pkey PRIMARY KEY (Tipo_Assistencia, Cnpj_Assistencia),
    CONSTRAINT TipoAssistencia_fkey FOREIGN KEY (Cnpj_Assistencia) REFERENCES Assistencia(Cnpj));

--Criando Tabela Protocolo de Atendimento e descrição com pk com autoincremento

CREATE SEQUENCE descricao_seq;

CREATE TABLE Descricao
   (Descricao_n NUMBER,
    Acoes_Tomadas VARCHAR2(50) NOT NULL,
    
    CONSTRAINT Descricao_pkey PRIMARY KEY (Descricao_n));

CREATE TABLE Protocolo_de_Atendimento (
    Codigo_Protocolo VARCHAR2(50),
    Cnpj VARCHAR2(14),
    Desc_Pro NUMBER,
    Acoes_Tomadas VARCHAR2(50) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Conclusao DATE NOT NULL,
    
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
