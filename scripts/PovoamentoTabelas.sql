--Inserindo Assistencia 

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('34567890123456', TO_DATE('2023-07-23', 'YYYY-MM-DD'), 'Instalar o Pacote Office', 'Em andamento', 'Notebook');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('45678901234567', TO_DATE('2023-07-24', 'YYYY-MM-DD'), 'Display quebrado', 'Concluído', 'Monitor');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('56789012345678', TO_DATE('2023-07-25', 'YYYY-MM-DD'), 'Sinal fraco', 'Em andamento', 'Roteador');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('12345678901234', TO_DATE('2023-07-21', 'YYYY-MM-DD'), 'Poeira interna e pasta térmica antiga', 'Em andamento', 'Computador');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('23456789012345', TO_DATE('2023-07-22', 'YYYY-MM-DD'), 'Impressora com engasgo de papel', 'Concluído', 'Impressora');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('12344672301454', TO_DATE('2023-05-21', 'YYYY-MM-DD'), 'Porta HDMI sem funcionar', 'Em andamento', 'Placa de Vídeo');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('67890123456789', TO_DATE('2023-07-26', 'YYYY-MM-DD'), 'Problemas com o sistema operacional', 'Em andamento', 'Computador');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('78901234567890', TO_DATE('2023-07-27', 'YYYY-MM-DD'), 'Problemas com a conexão de internet', 'Concluído', 'Roteador');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('89012345678901', TO_DATE('2023-07-28', 'YYYY-MM-DD'), 'Teclas sem funcionar', 'Em andamento', 'Teclado');

INSERT INTO Assistencia (Cnpj, Data_Inicio, Descricao, Status, Equipamento)
VALUES ('90123456789012', TO_DATE('2023-07-29', 'YYYY-MM-DD'), 'Clique duplo', 'Concluído', 'Mouse');

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

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Reparo de software', '67890123456789');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Configuração de rede', '78901234567890');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Substituição de peças', '89012345678901');

INSERT INTO TipoAssistencia (Tipo_Assistencia, Cnpj_Assistencia)
VALUES ('Substituição de peças', '90123456789012');


--Inserindo Descricao

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Instalação do Pacote Office');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Substituição do display quebrado');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Melhoria do sinal do roteador');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Limpeza interna e troca de pasta térmica');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Desobstrução do mecanismo de papel');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Reparo da porta HDMI');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Correção de problemas com o sistema operacional');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Melhoria da conexão de internet');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Substituição de teclas quebradas');

INSERT INTO Descricao (Acoes_Tomadas) VALUES ('Correção do problema de clique duplo');

--Inserindo Protocolo_de_Atendimento

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P001', '34567890123456', 1, 'Instalação do Pacote Office', TO_DATE('2023-07-23', 'YYYY-MM-DD'), TO_DATE('2023-07-24', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P002', '45678901234567', 2, 'Substituição do display quebrado', TO_DATE('2023-07-24', 'YYYY-MM-DD'), TO_DATE('2023-07-25', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P003', '56789012345678', 3, 'Troca das antenas do roteador', TO_DATE('2023-07-25', 'YYYY-MM-DD'), TO_DATE('2023-07-26', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P004', '12345678901234', 4, 'Limpeza interna e troca de pasta térmica', TO_DATE('2023-07-21', 'YYYY-MM-DD'), TO_DATE('2023-07-22', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P005', '23456789012345', 5, 'Desobstrução do mecanismo de papel', TO_DATE('2023-07-22', 'YYYY-MM-DD'), TO_DATE('2023-07-23', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P006', '12344672301454', 6, 'Troca da entrada HDMI e repato na placa', TO_DATE('2023-05-21', 'YYYY-MM-DD'), TO_DATE('2023-05-22', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P007', '67890123456789', 7, 'Backup e formatação do sistema', TO_DATE('2023-07-26', 'YYYY-MM-DD'), TO_DATE('2023-07-27', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P008', '78901234567890', 8, 'Limpeza e restauração para padrões de fábrica', TO_DATE('2023-07-27', 'YYYY-MM-DD'), TO_DATE('2023-07-28', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P009', '89012345678901', 9, 'Substituição de teclas quebradas', TO_DATE('2023-07-28', 'YYYY-MM-DD'), TO_DATE('2023-07-29', 'YYYY-MM-DD'));

INSERT INTO Protocolo_de_Atendimento (Codigo_Protocolo, Cnpj, Desc_Pro, Acoes_Tomadas, Data_Inicio, Data_Conclusao)
VALUES ('P010', '90123456789012', 10, 'Correção do problema de clique duplo, sensor trocado', TO_DATE('2023-07-29', 'YYYY-MM-DD'), TO_DATE('2023-07-30', 'YYYY-MM-DD'));