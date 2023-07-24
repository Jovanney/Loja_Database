--Criando tabela Endereco

Create table Endereco (
    cep VARCHAR2 (50),
    bairro VARCHAR2(50),
    rua VARCHAR2(50),
    
    CONSTRAINT endereco_pk PRIMARY KEY (cep));

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
    email_usuario VARCHAR(50) NOT NULL,
   
    CONSTRAINT telefone_pk PRIMARY KEY (numero, email_usuario),
    CONSTRAINT email_usuario_fk FOREIGN KEY (email_usuario) REFERENCES Usuario (email));

--Criando Cargo_func

CREATE TABLE Cargo_func(
    cargo  VARCHAR(50),
    salario VARCHAR(50),

    CONSTRAINT cargo_func__pk PRIMARY KEY (cargo));

--Criando tabela Cliente

CREATE TABLE Cliente(
    email_usuario VARCHAR(50),
    data_criacao_Conta DATE NOT NULL,

    CONSTRAINT cliente_pk PRIMARY KEY (email_usuario),
    CONSTRAINT email_usuario_C_fk FOREIGN KEY (email_usuario) REFERENCES usuario (email));

--Criando tabela Cargos

CREATE TABLE Cargos(
    cargo VARCHAR2(50) NOT NULL,
    salario VARCHAR2(50) NOT NULL,

    CONSTRAINT cargos_pk PRIMARY KEY (cargo));


--Criando tabela Funcionario

CREATE TABLE Funcionario(
    email_funcionario VARCHAR(50) NOT NULL,
    cargo_func VARCHAR(50),
    data_contratacao  timestamp NOT NULL,
    cad_supv VARCHAR(50),

    CONSTRAINT funcionario_pk PRIMARY KEY (email_funcionario),
    CONSTRAINT email_funcionario_fk FOREIGN KEY (email_funcionario) REFERENCES Usuario (email),
    CONSTRAINT email_supv_fk FOREIGN KEY (cad_supv) REFERENCES Funcionario(email_funcionario),
    CONSTRAINT cargo_fk FOREIGN KEY (cargo_func) REFERENCES Cargos(cargo));




--Criando tabela Ordem_de_servico

CREATE TABLE Ordem_de_servico(
    protocolo VARCHAR2(50) NOT NULL,
    email_func VARCHAR2(50),
    descricao VARCHAR2(100),
    produto VARCHAR2(50) NOT NULL,
    data_de_emissao timestamp NOT NULL,

    CONSTRAINT ordem_de_servico_pk PRIMARY KEY (protocolo),
    CONSTRAINT email_func_fk FOREIGN KEY (email_func) REFERENCES Funcionario(email_funcionario));



-- Criando Tabela Transportadora
CREATE TABLE Transportadora(
    cnpj VARCHAR2(14),
	CONSTRAINT transportadora_pkey PRIMARY KEY (cnpj));


-- Criando Tabela Pedido
CREATE TABLE Pedido(
    id_pedido number(10),
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


-- Criando Tabela Pagamento
CREATE TABLE Pagamento(
	id_pagamento number(10),
	data_do_pagamento TIMESTAMP NOT NULL,
	status VARCHAR2(20),
	metodo_do_pagamento VARCHAR2(50),
  	id_pedido number(10),
  
  	CONSTRAINT pagamento_pk PRIMARY KEY (id_pagamento),
  	CONSTRAINT id_pedido_fk FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
  
);

-- Criando Tabela Produto
CREATE TABLE Produto(
    id_produto number(10),
	quantidade number(3),
	nome varchar2(100),
	preco number(7,2),
	data_estoque timestamp,
	caracteristicas varchar2(200),
	marca varchar2(20),
	categoria varchar2(20),
	pedido number (10) NOT NULL,
	
    CONSTRAINT produto_pkey PRIMARY KEY (id_produto),
	CONSTRAINT produto_fkey FOREIGN KEY (pedido) REFERENCES Pedido(id_pedido));

--Criando tabela Assistencia

CREATE TABLE Assistencia(
    cnpj VARCHAR2(14),
    data_inicio DATE NOT NULL,
    descricao VARCHAR2(50) NOT NULL,
    status VARCHAR2(50) NOT NULL,
    equipamento VARCHAR2(50) NOT NULL,

    CONSTRAINT assistencia_pkey PRIMARY KEY (cnpj));

--Criando tabela Aciona

CREATE TABLE Aciona(
	cliente_email VARCHAR2(50),
  	funcionario_email VARCHAR2(50),
  	assistencia_cnpj VARCHAR2(14),
  	CONSTRAINT cliente_aciona FOREIGN KEY (cliente_email) REFERENCES Usuario(email),
  	CONSTRAINT funcionario_aciona FOREIGN KEY (funcionario_email) REFERENCES Usuario(email),
  	CONSTRAINT assitencia_aciona FOREIGN KEY (assistencia_cnpj) REFERENCES Assistencia(cnpj)
);

--Criando tabela Tipo da Assistencia

CREATE TABLE TipoAssistencia(
    tipo_assistencia VARCHAR2(50),
    cnpj_assistencia VARCHAR2(14),
    
    CONSTRAINT tipoassistencia_pkey PRIMARY KEY (tipo_assistencia, cnpj_assistencia),
    CONSTRAINT tipoassistencia_fkey FOREIGN KEY (cnpj_Assistencia) REFERENCES Assistencia(cnpj));

CREATE TABLE Relatorio_aux(
    codigo_relatorio_aux VARCHAR2(50),

    CONSTRAINT relatorio_aux_pk PRIMARY KEY (codigo_relatorio_aux));

CREATE TABLE Servico_aux(
    codigo_servico_aux VARCHAR2(50),

    CONSTRAINT servico_aux_pk PRIMARY KEY (codigo_servico_aux));


--Criando tabela Serviço a ser realizado

CREATE TABLE Servico_a_ser_realizado(
	funcionario_email VARCHAR2(50),
  	ordServico_protocolo VARCHAR2(50),
  	relatorio_codigo VARCHAR2(50),
  	servico_codigo VARCHAR2(50), 

  	CONSTRAINT funcionario_Aprova_pk PRIMARY KEY (funcionario_email, ordServico_protocolo),
    CONSTRAINT funcionario_Aprova FOREIGN KEY (funcionario_email) REFERENCES Usuario(email),
  	CONSTRAINT ordServico_Aprova  FOREIGN KEY (ordServico_protocolo) REFERENCES Ordem_de_servico(protocolo),
  	CONSTRAINT relatorio_Aprova   FOREIGN KEY (relatorio_codigo) REFERENCES Relatorio_aux(codigo_relatorio_aux),
  	CONSTRAINT servico_Aprova     FOREIGN KEY (servico_codigo) REFERENCES Servico_aux(codigo_servico_aux));

--Alterando Relatorio por causa da dependência ciclica

CREATE TABLE Relatorio(
    codigo_relatorio VARCHAR2(50),
    descricao VARCHAR(50),
    email_funcionario VARCHAR2(50),
    protocolo VARCHAR2(50),

    CONSTRAINT relatorio_pk PRIMARY KEY (codigo_relatorio),
    CONSTRAINT servico_realizado_relatorio_fk FOREIGN KEY (email_funcionario, protocolo) REFERENCES Servico_a_ser_Realizado(funcionario_email, ordServico_protocolo));

--Alterando Servico por causa da dependência ciclica

CREATE TABLE Servico(
    codigo_servico VARCHAR2(50),
    status VARCHAR(20),
    data_inicio date,
    data_conclusao date,
    email_funcionario VARCHAR2(50),
    protocolo VARCHAR2(50),

    CONSTRAINT servico_pk PRIMARY KEY (codigo_servico),
    CONSTRAINT servico_realizado_servico_fk FOREIGN KEY (email_funcionario, protocolo) REFERENCES Servico_a_ser_Realizado(funcionario_email, ordServico_protocolo));

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
    
    CONSTRAINT protocolo_pk PRIMARY KEY (codigo_protocolo, cnpj),
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
