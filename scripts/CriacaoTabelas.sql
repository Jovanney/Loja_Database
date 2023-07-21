--Criando tabela Endereco

Create table Endereco (
    cep VARCHAR2 (50),
    bairro VARCHAR2(50),
    rua VARCHAR2(50),
    
    CONSTRAINT endereço_pk PRIMARY KEY (cep));

--Criando tabela Usuario

Create table Usuario (
    email VARCHAR2(50),
    senha VARCHAR2(50) NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    idade Number,
    cep VARCHAR2 (50) NOT NULL,
    numero VARCHAR2(50),
    complemento VARCHAR2(50),

    CONSTRAINT usuario_pk PRIMARY KEY (email),
    CONSTRAINT cep_fk FOREIGN KEY (cep) REFERENCES Endereco (cep));

--Criando tabela Telefone

CREATE TABLE Telefone(
    numero number,
    email_Usuario VARCHAR(50) NOT NULL,
   
    CONSTRAINT telefone_pk PRIMARY KEY (numero, email_usuario),
    CONSTRAINT email_usuario_fk FOREIGN KEY (email_usuario) REFERENCES Usuario (email));

--Criando tabela Cliente

CREATE TABLE Cliente(
    email_usuario VARCHAR(50),
    data_criacao_Conta DATE NOT NULL,

    CONSTRAINT cliente_pk PRIMARY KEY (email_Usuario),
    CONSTRAINT email_usuario_C_fk FOREIGN KEY (email_usuario) REFERENCES usuario (email));


-- Criando Tabela Transportadora
CREATE TABLE Transportadora
    (cnpj varchar2 (14),
	CONSTRAINT transportadora_pkey PRIMARY KEY (cnpj));


-- Criando Tabela Pedido
CREATE TABLE Pedido
    (id_pedido number(10),
	descricao varchar2(100),
	preco number(8,2),
	data_pedido timestamp NOT NULL,
	cliente varchar2(50) NOT NULL,
	destino varchar2(50),
	local_saida varchar2(50),
	data_saida timestamp,
	local_atual varchar2(50),
	data_entrega timestamp,
	transportadora varchar2(14),
	frete number(5,2),
	status varchar2(20),
	CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido),
	CONSTRAINT pedido_fkey1 FOREIGN KEY (cliente) REFERENCES Usuario (email),
	CONSTRAINT pedido_fkey2 FOREIGN KEY (transportadora) REFERENCES Transportadora (cnpj));


-- Criando Tabela Produto
CREATE TABLE Produto
    (id_produto number(10),
	quantidade number(3),
	nome varchar2(100),
	preco number(7,2),
	data_estoque timestamp,
	caracteristicas varchar2(200),
	marca varchar2(20),
	categoria varchar2(20),
	pedido number (10) NOT NULL,
	CONSTRAINT produto_pkey PRIMARY KEY (id_produto),
	CONSTRAINT produto_fkey FOREIGN KEY (pedido) REFERENCES Pedido (id_pedido));

--Criando tabela Assistencia

CREATE TABLE Assistencia
   (cnpj VARCHAR2(14),
    data_inicio DATE NOT NULL,
    descricao VARCHAR2(50) NOT NULL,
    status VARCHAR2(50) NOT NULL,
    equipamento VARCHAR2(50) NOT NULL,

    CONSTRAINT assistencia_pkey PRIMARY KEY (cnpj));

--Criando tabela Tipo da Assistencia

CREATE TABLE TipoAssistencia
   (tipo_assistencia VARCHAR2(50),
    cnpj_assistencia VARCHAR2(14),
    
    CONSTRAINT tipoassistencia_pkey PRIMARY KEY (tipo_assistencia, cnpj_assistencia),
    CONSTRAINT tipoassistencia_fkey FOREIGN KEY (cnpj_Assistencia) REFERENCES Assistencia(cnpj));

--Criando Tabela Protocolo de Atendimento e descrição com pk com autoincremento

CREATE SEQUENCE descricao_seq;

CREATE TABLE Descricao
   (descricao_n NUMBER,
    acoes_tomadas VARCHAR2(50) NOT NULL,
    
    CONSTRAINT descricao_pkey PRIMARY KEY (descricao_n));

CREATE TABLE Protocolo_de_Atendimento (
    codigo_Protocolo VARCHAR2(50),
    cnpj VARCHAR2(14),
    desc_Pro NUMBER,
    acoes_tomadas VARCHAR2(50) NOT NULL,
    data_inicio DATE NOT NULL,
    data_conclusao DATE NOT NULL,
    
    CONSTRAINT protocolo_pk PRIMARY KEY (codigo_protocolo),
    CONSTRAINT desc_pro_fk FOREIGN KEY (desc_pro) REFERENCES Descricao(descricao_n),
    CONSTRAINT cnpj_fk FOREIGN KEY (cnpj) REFERENCES Assistencia(cnpj));

CREATE OR REPLACE TRIGGER descricao_bir 

BEFORE INSERT ON Descricao 
FOR EACH ROW

BEGIN
  SELECT descricao_seq.NEXTVAL
  INTO   :new.descricao_n
  FROM   dual;
END;
