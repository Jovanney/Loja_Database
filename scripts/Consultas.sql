--Selecionando todos os pedidos que possuem um pagamento associado e o status do pagamento foi confirmado

SELECT *
FROM Pedido p INNER JOIN  Pagamento pg
ON (p.id_pedido = pg.id_pedido)
WHERE pg.status LIKE 'Confirmado';

--Selecionando a quantidade de funcionário que não são supervisionado por nenhum outro funcionário

SELECT COUNT(*) AS Sem_supervisor
FROM Funcionario f
WHERE f.cad_supv IS NULL;

--Selecionando o Endereco e o Telefone dos usuários

SELECT u.email, u.nome, e.bairro, e.rua, t.numero
FROM Usuario u
LEFT OUTER JOIN Endereco e
ON u.cep = e.cep
LEFT OUTER JOIN Telefone t
ON u.email = t.email_usuario
ORDER BY u.nome;

--Selecionando todos os usuários que a idade é maior que a média da idade de todos os usuários

SELECT u.email, u.nome, u.idade
FROM Usuario u
WHERE u.idade > (SELECT AVG(u2.idade) FROM Usuario u2);



------------------------------------


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
