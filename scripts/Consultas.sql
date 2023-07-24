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
