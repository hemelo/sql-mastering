-- SCRIPT PARA CRIAÇÃO DO BANCO DE DADOS
-- DO ESTUDO DE CASO SIP
-- COMANDOS PARA EXCLUIR AS TABELAS
DROP TABLE t_sip_departamento CASCADE CONSTRAINTS;
DROP TABLE t_sip_dependente CASCADE CONSTRAINTS;
DROP TABLE t_sip_funcionario CASCADE CONSTRAINTS;
DROP TABLE t_sip_implantacao CASCADE CONSTRAINTS;
DROP TABLE t_sip_projeto CASCADE CONSTRAINTS;
-- COMANDOS PARA CRIAR AS TABELAS
-- E ADICIONAR CONSTRAINTS: PRIMARY KEY, CHECK E UNIQUE
CREATE TABLE t_sip_departamento
(
    cd_depto NUMBER(3)      NOT NULL,
    nm_depto VARCHAR2(30)   NOT NULL,
    sg_depto CHAR(3) NOT NULL
);
COMMENT
ON COLUMN t_sip_departamento.cd_depto IS
    'Um departamento é identificado por um código numérico de três dígitos.';
ALTER TABLE t_sip_departamento
    ADD CONSTRAINT pk_sip_departamento
        PRIMARY KEY (cd_depto);
ALTER TABLE t_sip_departamento
    ADD CONSTRAINT un_sip_depto_nome
        UNIQUE (nm_depto);
ALTER TABLE t_sip_departamento
    ADD CONSTRAINT un_sip_depto_sigla
        UNIQUE (sg_depto);
CREATE TABLE t_sip_dependente
(
    nr_matricula  NUMBER(5)     NOT NULL,
    cd_dependente NUMBER(2)     NOT NULL,
    nm_dependente VARCHAR2(50)  NOT NULL,
    dt_nascimento DATE NOT NULL
);
ALTER TABLE t_sip_dependente
    ADD CONSTRAINT pk_sip_dependente
        PRIMARY KEY (nr_matricula, cd_dependente);
CREATE TABLE t_sip_funcionario
(
    nr_matricula      NUMBER(5)     NOT NULL,
    cd_depto          NUMBER(3)     NOT NULL,
    nm_funcionario    VARCHAR2(50)  NOT NULL,
    dt_nascimento     DATE NOT NULL,
    dt_admissao       DATE NOT NULL,
    ds_endereco       VARCHAR2(100) NOT NULL,
    vl_salario_mensal NUMBER(7, 2) NOT NULL
);
ALTER TABLE t_sip_funcionario
    ADD CONSTRAINT ck_sip_func_salario
        CHECK ( vl_salario_mensal >= 1212 );
ALTER TABLE t_sip_funcionario
    ADD CONSTRAINT pk_sip_funcionario
        PRIMARY KEY (nr_matricula);
CREATE TABLE t_sip_implantacao
(
    cd_projeto     NUMBER(5) NOT NULL,
    cd_implantacao NUMBER(3) NOT NULL,
    nr_matricula   NUMBER(5) NOT NULL,
    dt_entrada     DATE NOT NULL,
    dt_saida       DATE NULL
);
ALTER TABLE t_sip_implantacao
    ADD CONSTRAINT ck_sip_implant_data
        CHECK ( dt_saida > dt_entrada );
ALTER TABLE t_sip_implantacao
    ADD CONSTRAINT pk_sip_implantacao
        PRIMARY KEY (cd_projeto, cd_implantacao);
CREATE TABLE t_sip_projeto
(
    cd_projeto NUMBER(5)    NOT NULL,
    nm_projeto VARCHAR2(40) NOT NULL,
    dt_inicio  DATE NOT NULL,
    dt_termino DATE
);
-- ADICIONAR CONSTRAINT FOREIGN KEY
ALTER TABLE t_sip_projeto
    ADD CONSTRAINT ck_sip_projeto_data
        CHECK ( dt_termino > dt_inicio );
ALTER TABLE t_sip_projeto
    ADD CONSTRAINT pk_sip_projeto
        PRIMARY KEY (cd_projeto);
ALTER TABLE t_sip_projeto
    ADD CONSTRAINT un_sip_projeto_nome
        UNIQUE (nm_projeto);
ALTER TABLE t_sip_dependente
    ADD CONSTRAINT fk_sip_dependente_func
        FOREIGN KEY (nr_matricula)
            REFERENCES t_sip_funcionario (nr_matricula);
ALTER TABLE t_sip_funcionario
    ADD CONSTRAINT fk_sip_func_depto
        FOREIGN KEY (cd_depto)
            REFERENCES t_sip_departamento (cd_depto);
ALTER TABLE t_sip_implantacao
    ADD CONSTRAINT fk_sip_implant_func
        FOREIGN KEY (nr_matricula)
            REFERENCES t_sip_funcionario (nr_matricula);
ALTER TABLE t_sip_implantacao
    ADD CONSTRAINT fk_sip_implant_projeto
        FOREIGN KEY (cd_projeto)
            REFERENCES t_sip_projeto (cd_projeto);

-- INSERINDO DADOS NA TABELA DEPARTAMENTO INFORMANDO
-- COLUNAS E RESPECTIVO CONTEÚDO
INSERT INTO T_SIP_DEPARTAMENTO (CD_DEPTO, NM_DEPTO, SG_DEPTO)
VALUES (2, 'MARKETING', 'MKT');

-- INSERINDO DADOS NA TABELA DEPARTAMENTO INFORMANDO
-- COLUNAS E RESPECTIVO CONTEÚDO
INSERT INTO T_SIP_DEPARTAMENTO (CD_DEPTO, NM_DEPTO, SG_DEPTO)
VALUES (2, 'MARKETING', 'MKT');

-- INSERÇÃO COM MANIPULAÇÃO DE DATA/HORA
INSERT INTO T_SIP_PROJETO
VALUES (1, 'PROJETO ABC',
        TO_DATE('01/02/2020', 'DD/MM/YYYY'),
        TO_DATE('15/11/2022', 'DD/MM/YYYY'));

-- CONSULTANDO TODAS AS LINHAS DA TABELA PROJETO
SELECT *
FROM T_SIP_PROJETO;

-- INSERÇÃO COM MANIPULAÇÃO DE NÚMEROS DECIMAIS
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12345, 1, 'JOÃO DA SILVA XAVIER',
        TO_DATE('18/03/1985', 'DD/MM/YYYY'),
        TO_DATE('21/07/2012', 'DD/MM/YYYY'),
        'AVENIDA PAULISTA, 1900 - 10o. ANDAR',
        1234.56);
-- UTILIZAMOS O PONTO DECIMAL

-- INSERÇÃO DE VALORES NULOS PARA CAMPOS OPCIONAIS
-- MÉTODO EXPLICITO - ESPECIFIQUE A PALAVRA-CHAVE NULL,
-- NA CLÁUSULA VALUES
INSERT INTO T_SIP_PROJETO
VALUES (3, 'PROJETO GHI',
        TO_DATE('15/08/2021', 'DD/MM/YYYY'),
        NULL);

-- REALIZANDO A CÓPIA DOS DADOS DE UMA TABELA PARA OUTRA
-- UTILIZANDO O COMANDO INSERT E O COMANDO SELECT
-- SUBCONSULTA OU SUBQUERY)
INSERT INTO T_SIP_COPY_PROJETO_FIN
    (CD_PROJETO, NM_PROJETO, DT_INICIO, DT_TERMINO)
    (SELECT CD_PROJETO,
            NM_PROJETO,
            DT_INICIO,
            DT_TERMINO
     FROM T_SIP_PROJETO
     WHERE DT_TERMINO IS NOT NULL);

-- REALIZANDO A CÓPIA DOS DADOS DE UMA TABELA PARA OUTRA
-- UTILIZANDO O COMANDO INSERT E O COMANDO SELECT
-- SUBCONSULTA OU SUBQUERY)
INSERT INTO T_SIP_COPY_PROJETO_FIN
    (SELECT *
     FROM T_SIP_PROJETO
     WHERE DT_TERMINO IS NOT NULL);

-- ATUALIZAR DUAS OU MAIS COLUNAS EM UM COMANDO DE ATUALIZACAO
-- ALTERAR O NOME E A DATA DE NASCIMENTO DE UM
-- FUNCIONARIO ESPECÍFICO
UPDATE T_SIP_FUNCIONARIO
SET NM_FUNCIONARIO = 'JOÃO DA SILVA XAVIER DE CAMARGO',
    DT_NASCIMENTO  = TO_DATE('18/05/1985', 'DD/MM/YYYY')
WHERE NR_MATRICULA = 12345;

-- CONSULTANDO TODAS AS LINHAS DA TABELA FUNCIONÁRIO
SELECT *
FROM T_SIP_FUNCIONARIO
WHERE NR_MATRICULA = 12345;

-- ATUALIZAR O SALÁRIO DOS FUNCIONARIOS
-- TODOS OS FUNCIONARIOS IRÃO RECEBER UM AUMENTO DE 5%
UPDATE T_SIP_FUNCIONARIO
SET VL_SALARIO_MENSAL = VL_SALARIO_MENSAL * 1.05;
-- NÃO TEMOS O WHERE (CONDICAO), POIS O AUMENTO
-- SERÁ APLICADO A TODOS FUNCIONARIOS


-- ATUALIZACAO UTILIZANDO SUBCONSULTA
UPDATE T_SIP_PROJETO
SET DT_TERMINO =
        (SELECT DT_TERMINO
         FROM T_SIP_COPY_PROJETO_FIN
         WHERE CD_PROJETO = 1)
WHERE DT_TERMINO IS NULL;

START TRANSACTION
-- INICIA A TRANSAÇÃO

-- EXCLUSÃO DOS PROJETOS INICIADOS ATÉ 31/12/2020
DELETE
FROM T_SIP_PROJETO
WHERE DT_INICIO <= TO_DATE('31/12/2020', 'DD/MM/YYYY');

-- DELEÇÃO DA TABELA PROJETO INTEIRA,
-- SEM EFETIVAÇÃO DA TRANSAÇÃO
DELETE
FROM T_SIP_PROJETO;

ROLLBACK;
-- DESFAZ TODAS AS OPERAÇÕES REALIZADAS

-- ERRO DE VIOLAÇÃO DE CHAVE PRIMARIA
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (1, 'TESTE', 'TST');
/*
Erro a partir da linha : 145 no comando -
INSERT INTO T_SIP_DEPARTAMENTO VALUES (1, 'TESTE','TST')
Relatório de erros -
ORA-00001: restrição exclusiva (PF0102.PK_T_SIP_DEPARTAMENTO) violada
*/

-- ERRO DE VIOLAÇÃO DE CHAVE ESTRANGEIRA
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12346, 99, 'JOSÉ CLEMENTE',
        TO_DATE('21/03/1987', 'DD/MM/YYYY'),
        TO_DATE('04/05/2020', 'DD/MM/YYYY'),
        'AVENIDA PAULISTA, 1900 - 10o. ANDAR',
        3541.55);
/*
Erro a partir da linha : 163 no comando -
INSERT ...
Relatório de erros -
ORA-02291: restrição de integridade (PF0102.FK_SIP_FUNC_DEPTO) violada - chave mãe não localizada
*/

-- ERRO DE VIOLAÇÃO DE CHECK CONSTRAINT
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12347, 1, 'JOSÉ CLEMENTE',
        TO_DATE('21/03/1987', 'DD/MM/YYYY'),
        TO_DATE('04/05/2020', 'DD/MM/YYYY'),
        'AVENIDA PAULISTA, 1900 - 10o. ANDAR',
        599.99);
/*
Erro a partir da linha : 180 no comando -
INSERT ...
Relatório de erros -
ORA-02290: restrição de verificação (PF0102.CK_SIP_FUNC_SALARIO) violada
*/

-- ERRO REFERENTE A PRECISÃO DO CAMPO
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (12345, 'DEPTO TESTE', 'TST');
/*
Erro a partir da linha : 194 no comando -
INSERT INTO T_SIP_DEPARTAMENTO VALUES (12345, 'DEPTO TESTE', 'TST')
Relatório de erros -
ORA-01438: valor maior que a precisão especificada usado para esta coluna
*/

-- ERRO DE TIPO DE DADOS INVÁLIDO
INSERT INTO T_SIP_DEPARTAMENTO
VALUES ('XXX', 'DEPTO TESTE', 'TST');
/*
Erro a partir da linha : 204 no comando -
INSERT INTO T_SIP_DEPARTAMENTO VALUES ('XXX', 'DEPTO TESTE', 'TST')
Relatório de erros -
ORA-01722: número inválido
*/

-- ERRO DE VALORES INSUFICIENTES PARA A INSERÇÃO
INSERT INTO T_SIP_DEPARTAMENTO VALUES (222, 'DEPTO TESTE');
/*
Erro na Linha de Comandos : 213 Coluna : 13
Relatório de erros -
Erro de SQL: ORA-00947: não há valores suficientes
00947. 00000 -  "not enough values"
*Cause:
*Action:
*/

-- ERRO DE VALORES DEMAIS PARA A INSERÇÃO
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (5, 'DEPTO TESTE', 'TST', 'XXX');
/*
Erro na Linha de Comandos : 225 Coluna : 13
Relatório de erros -
Erro de SQL: ORA-00913: valores demais
00913. 00000 -  "too many values"
*Cause:
*Action:
*/