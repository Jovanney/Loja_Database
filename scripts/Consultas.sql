--ALTER TABLE
ALTER TABLE Transportadora
    ADD (cidade varchar2(50));



--CREATE INDEX
CREATE INDEX id_status ON Pedido (status);



--INSERT INTO
INSERT INTO Transportadora (cnpj, nome) VALUES (97070707070709, 'FNS, mt ruim')



--UPDATE
UPDATE Transportadora
SET cidade = 'São Paulo'
WHERE cnpj = 90101010101019



--DELETE
DELETE FROM Transportadora
WHERE cnpj = 97070707070709



--SELECT-FROM-WHERE
SELECT * FROM Pedido WHERE status = 'Cancelado'



--BETWEEN
SELECT cliente, destino, preco, frete FROM Pedido WHERE preco BETWEEN 100 AND 500



--IN
SELECT quantidade, nome, categoria, marca FROM Produto WHERE categoria IN ('Mouse', 'Teclado', 'Monitor');



--LIKE, INNER JOIN
--Selecionando todos os pedidos que possuem um pagamento associado e o status do pagamento foi confirmado

SELECT *
FROM Pedido p INNER JOIN  Pagamento pg
ON (p.id_pedido = pg.id_pedido)
WHERE pg.status LIKE 'Confirmado';



--IS NULL ou IS NOT NULL, COUNT
--Selecionando a quantidade de funcionário que não são supervisionado por nenhum outro funcionário

SELECT COUNT(*) AS Sem_supervisor
FROM Funcionario f
WHERE f.cad_supv IS NULL;




--MAX

SELECT cargo, salario FROM Cargos
WHERE salario = (SELECT MAX(salario) FROM Cargos);

--MIN

SELECT nome, preco FROM Produto
WHERE preco = (SELECT MIN(preco) FROM Produto);

--AVG, SUBCONSULTA COM OPERADOR RELACIONAL
--Selecionando todos os usuários que a idade é maior que a média da idade de todos os usuários

SELECT u.email, u.nome, u.idade
FROM Usuario u
WHERE u.idade > (SELECT AVG(u2.idade) FROM Usuario u2);


--LEFT ou RIGHT ou FULL OUTER JOIN, ORDER BY
--Selecionando o Endereco e o Telefone dos usuários

SELECT u.email, u.nome, e.bairro, e.rua, t.numero
FROM Usuario u
LEFT OUTER JOIN Endereco e
ON u.cep = e.cep
LEFT OUTER JOIN Telefone t
ON u.email = t.email_usuario
ORDER BY u.nome;


--SUBCONSULTA COM IN

SELECT id_pedido, cliente, preco, status FROM Pedido
WHERE cliente IN (SELECT cliente FROM Pedido WHERE id_pedido = '9131313139');

--SUBCONSULTA COM ANY



--SUBCONSULTA COM ALL



--ORDER BY



--GROUP BY / HAVING

SELECT id_pedido, SUM(preco) as preco_pedido FROM Pedido
GROUP BY id_pedido
HAVING SUM(preco) > 500;

--UNION ou INTERSECT ou MINUS

SELECT email_usuario FROM Cliente
UNION
SELECT email_funcionario FROM Funcionario;

--CREATE VIEW

CREATE VIEW Funcionarios AS
SELECT email_funcionario, cargo_func FROM Funcionario
WHERE cargo_func = 'Supervisor';

--GRANT / REVOKE



--USO DE RECORD



--USO DE ESTRUTURA DE DADOS DO TIPO TABLE

DECLARE
	TYPE usuario_tb IS TABLE OF Usuario%rowtype
	INDEX BY BINARY_INTEGER;

	modelo_t usuario_tb;
BEGIN 
	modelo_t(1).email := 'jjsl@cin.ufpe.br';
	modelo_t(1).senha := '123Jova';
	modelo_t(1).nome := 'Jovanney';
	modelo_t(1).idade := 19;
	modelo_t(1).cep := 50740535;
	modelo_t(1).numero := '123123123123';
	modelo_t(1).complemento := 'A perto de B';

	DBMS_OUTPUT.PUT_LINE('Email: '|| modelo_t(1).email);

END;



--BLOCO ANÔNIMO
--SELECT … INTO
-- Função para contar funcionários contratados até determinada data (BLOCO ANONIMO / SELECT INTO)

CREATE OR REPLACE FUNCTION contar_funcionarios(data_referencia IN TIMESTAMP) RETURN NUMBER IS
	total_funcionarios NUMBER := 0;
BEGIN

	BEGIN
    	SELECT COUNT(*) INTO total_funcionarios
    	FROM Funcionario
    	WHERE data_contratacao <= data_referencia;
	END;

	RETURN total_funcionarios;
END;
/
---------- Exemplo -----------

DECLARE
	total NUMBER;
BEGIN
	total := contar_funcionarios(TO_TIMESTAMP('2023-07-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
	DBMS_OUTPUT.PUT_LINE('Total de funcionários contratados até 24 de julho de 2023: ' || total);
END;
/
------------------------------



--CREATE PROCEDURE

CREATE OR REPLACE PROCEDURE pegar_qtd_pedidos(email_in usuario.email%TYPE)
IS
    pedidoqtd NUMBER;
    nome usuario.nome%TYPE;
BEGIN
	SELECT COUNT(*) INTO pedidoqtd FROM Pedido P
    INNER JOIN Usuario U ON (P.cliente = U.email)
    WHERE U.email = email_in;

	SELECT U.nome INTO nome from Usuario U
    WHERE U.email = email_in;
    
    DBMS_OUTPUT.PUT_LINE('Usuário: ' || nome || ' Pedidos: ' || pedidoqtd );
END pegar_qtd_pedidos;
/
EXECUTE pegar_qtd_pedidos('pessoaP@gmail.com');
/


--CREATE FUNCTION



--%TYPE



--%ROWTYPE



--IF ELSIF
-- Função que retorna a faixa etária e idade do usuário baseado no E-MAIL (IF/ELSIF)

CREATE OR REPLACE FUNCTION faixa_etaria_usuario(email_usuario IN VARCHAR2) RETURN VARCHAR2 IS
	idade_usuario NUMBER;
	faixa_etaria VARCHAR2(100);
BEGIN
	SELECT idade INTO idade_usuario
	FROM Usuario
	WHERE email = email_usuario;

	IF idade_usuario < 25 THEN
    	faixa_etaria := 'Jovem-adulto';
    	faixa_etaria := faixa_etaria || ' (' || idade_usuario || ').';

	ELSIF idade_usuario >= 25 AND idade_usuario <= 45 THEN
    	faixa_etaria := 'Adulto';
    	faixa_etaria := faixa_etaria || ' (' || idade_usuario || ').';

	ELSE
    	faixa_etaria := 'Terceira idade';
    	faixa_etaria := faixa_etaria || ' (' || idade_usuario || ').';

	END IF;

	RETURN faixa_etaria;
END;
/
---------- Exemplo -----------
DECLARE
	email_usuario VARCHAR2(50) := 'pessoaP@gmail.com';
	resultado VARCHAR2(100);
BEGIN
	resultado := faixa_etaria_usuario(email_usuario);
	DBMS_OUTPUT.PUT_LINE('Faixa etária do usuário: ' || resultado);
END;
/
------------------------------



--CASE WHEN



--LOOP EXIT WHEN
--FOR IN LOOP
-- Função que verifica os produtos para achar se algum tem algum fora de estoque ou não. (LOOP EXIT WHEN / FOR IN)

CREATE OR REPLACE FUNCTION verificar_estoque RETURN VARCHAR2 IS
	nome_item_fora_estoque VARCHAR2(100);
BEGIN
	nome_item_fora_estoque := NULL;

	FOR produto_rec IN (SELECT nome FROM Produto WHERE quantidade = 0) LOOP
    	nome_item_fora_estoque := produto_rec.nome;
    	EXIT;
	END LOOP;

	IF nome_item_fora_estoque IS NOT NULL THEN
    	RETURN 'Há pelo menos um item fora de estoque. Por exemplo, o item:  ' || nome_item_fora_estoque;
	ELSE
    	RETURN 'Não há itens fora de estoque.';
	END IF;
END;
/
---------- Exemplo -----------
DECLARE
	resultado VARCHAR2(100);
BEGIN
	resultado := verificar_estoque;
	DBMS_OUTPUT.PUT_LINE(resultado);
END;
/
------------------------------





--WHILE LOOP
-- Função que mostra quantos clientes novos para X ano (WHILE LOOP)

CREATE OR REPLACE FUNCTION novos_clientes_por_ano(ano IN NUMBER) RETURN NUMBER IS
	contador NUMBER := 0;
	data_criacao DATE;
BEGIN
	FOR cliente IN (SELECT data_criacao_Conta FROM Cliente) LOOP
    	data_criacao := cliente.data_criacao_Conta;
    	EXIT WHEN data_criacao IS NULL;

    	WHILE EXTRACT(YEAR FROM data_criacao) = ano LOOP
        	contador := contador + 1;
        	EXIT;
    	END LOOP;
	END LOOP;

	RETURN contador;
END;
/
---------- Exemplo -----------

DECLARE
	ano_escolhido NUMBER := 1979;
	quantidade_clientes NUMBER;
BEGIN
	quantidade_clientes := novos_clientes_por_ano(ano_escolhido);
	DBMS_OUTPUT.PUT_LINE('Número de novos clientes criados em ' || ano_escolhido || ': ' || quantidade_clientes);
END;
/

------------------------------





--CURSOR (OPEN, FETCH e CLOSE)



--EXCEPTION WHEN



--USO DE PAR METROS (IN, OUT ou IN OUT)



--CREATE OR REPLACE PACKAGE
--CREATE OR REPLACE PACKAGE BODY
-- Função que ve quantas assistências tem em andamento para X equipamento (CREATE OR REPLACE PACKAGE / CREATE OR REPLACE PACKAGE BODY)

-- criando especificação de pacote
CREATE OR REPLACE PACKAGE AssistenciaPackage IS
	FUNCTION contar_assistencias_em_andamento(equipamento_in IN VARCHAR2) RETURN NUMBER;
END AssistenciaPackage;
/

-- criando body
CREATE OR REPLACE PACKAGE BODY AssistenciaPackage IS
	FUNCTION contar_assistencias_em_andamento(equipamento_in IN VARCHAR2) RETURN NUMBER IS
    	quantidade_assistencias NUMBER := 0;
	BEGIN
    	SELECT COUNT(*) INTO quantidade_assistencias
    	FROM Assistencia
    	WHERE UPPER(equipamento) = UPPER(equipamento_in) AND status = 'Em andamento';

    	RETURN quantidade_assistencias;

	END contar_assistencias_em_andamento;
END AssistenciaPackage;
/

---------- Exemplo -----------
DECLARE
	total_assistencias NUMBER;
	equipamento_escolhido VARCHAR2(50) := 'Teclado';
BEGIN
	total_assistencias := AssistenciaPackage.contar_assistencias_em_andamento(equipamento_escolhido);
	DBMS_OUTPUT.PUT_LINE('Total de assistências em progresso para o equipamento '||equipamento_escolhido||': ' || total_assistencias);
END;
/
------------------------------




--CREATE OR REPLACE TRIGGER (COMANDO)



--CREATE OR REPLACE TRIGGER (LINHA)



