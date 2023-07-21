--Inserindo Assistencia 

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('34567890123456', TO_DATE('2023-07-23', 'YYYY-MM-DD'), 'Instalar o Pacote Office', 'Em andamento', 'Notebook');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('45678901234567', TO_DATE('2023-07-24', 'YYYY-MM-DD'), 'Display quebrado', 'Concluído', 'Monitor');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('56789012345678', TO_DATE('2023-07-25', 'YYYY-MM-DD'), 'Configurações feitas incorretamente', 'Em andamento', 'Roteador');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('12345678901234', TO_DATE('2023-07-21', 'YYYY-MM-DD'), 'Poeira interna e pasta térmica antiga', 'Em andamento', 'Computador');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('23456789012345', TO_DATE('2023-07-22', 'YYYY-MM-DD'), 'Impressora com engasgo de papel', 'Concluído', 'Impressora');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('12344672301454', TO_DATE('2023-05-210', 'YYYY-MM-DD'), 'Porta HDMI sem funcionar', 'Em andamento', 'Placa de Vídeo');

--Inserindo Tipo Assistencia

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Instalação de software', '34567890123456');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Substituição de peças', '45678901234567');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Configuração de rede', '56789012345678');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Manutenção preventiva', '12345678901234');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Reparo de hardware', '23456789012345');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Reparo de hardware', '12344672301454');
