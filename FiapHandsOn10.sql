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


-- SCRIPT PARA POPULAR O BD IMPLANTACAO DE PROJETOS
-- ELIMINA O CONTEUDO DAS TABELAS
/*
DELETE FROM T_SIP_IMPLANTACAO;
DELETE FROM T_SIP_PROJETO;
DELETE FROM T_SIP_DEPENDENTE;
DELETE FROM T_SIP_FUNCIONARIO;
DELETE FROM T_SIP_DEPARTAMENTO;
*/
-- POPULAR A TABELA DEPTO COM 5 DEPARTAMENTOS
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (1, 'FINANCEIRO', 'FIN');
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (2, 'TECNOLOGIA DA INFORMAÇÃO', 'TIN');
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (3, 'CONTAS A PAGAR', 'CPG');
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (4, 'FATURAMENTO', 'FAT');
INSERT INTO T_SIP_DEPARTAMENTO
VALUES (5, 'RECURSOS HUMANOS', 'RHU');
-- POPULAR A TABELA FUNCIONARIO COM 3 FUNCIONARIOS PARA CADA DEPTO
-- DEPTO = 1
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12345, 1, 'JOAO DA SILVA', TO_DATE('10/05/1985', 'DD/MM/YYYY'),
        TO_DATE('15/09/2012', 'DD/MM/YYYY'), 'RUA X, 49', 5684.66);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12346, 1, 'MANUEL DA SILVA', TO_DATE('05/10/1998', 'DD/MM/YYYY'),
        TO_DATE('10/11/2015', 'DD/MM/YYYY'), 'RUA X, 31', 3542.11);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12347, 1, 'JANDIRA DA SILVA', TO_DATE('10/12/2000', 'DD/MM/YYYY'),
        TO_DATE('15/09/2018', 'DD/MM/YYYY'), 'RUA X, 25', 1875.96);

-- DEPTO = 2
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12348, 2, 'KATIA REGINA SOUZA', TO_DATE('15/01/1995', 'DD/MM/YYYY'),
        TO_DATE('03/10/2015', 'DD/MM/YYYY'), 'RUA Y, 49', 3894.63);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12349, 2, 'MARIA DAS DORES SOUZA', TO_DATE('18/08/1983', 'DD/MM/YYYY'),
        TO_DATE('23/10/2017', 'DD/MM/YYYY'), 'RUA Y, 35', 1542.55);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12350, 2, 'ALFREDO DE SOUZA', TO_DATE('04/05/1999', 'DD/MM/YYYY'),
        TO_DATE('05/06/2014', 'DD/MM/YYYY'), 'RUA Y, 27', 5874.52);

-- DEPTO = 3
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12351, 3, 'GISELE DE JESUS', TO_DATE('15/04/1999', 'DD/MM/YYYY'),
        TO_DATE('20/03/2017', 'DD/MM/YYYY'), 'RUA Z, 49', 1360.66);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12352, 3, 'RAFAEL DE JESUS', TO_DATE('10/08/1998', 'DD/MM/YYYY'),
        TO_DATE('10/08/2012', 'DD/MM/YYYY'), 'RUA Z, 55', 2563.44);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12353, 3, 'ROSANA DE JESUS', TO_DATE('14/03/1987', 'DD/MM/YYYY'),
        TO_DATE('15/08/2019', 'DD/MM/YYYY'), 'RUA Z, 79', 4879.55);

-- DEPTO = 4
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12354, 4, 'JOSEFINA DE ALMEIDA', TO_DATE('16/10/1997', 'DD/MM/YYYY'),
        TO_DATE('25/03/2013', 'DD/MM/YYYY'), 'RUA Y, 33', 4561.88);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12355, 4, 'LUCIANA DE ALMEIDA', TO_DATE('10/02/1984', 'DD/MM/YYYY'),
        TO_DATE('28/09/2011', 'DD/MM/YYYY'), 'RUA Y, 44', 2345.52);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12356, 4, 'THIAGO DE ALMEIDA', TO_DATE('10/03/1998', 'DD/MM/YYYY'),
        TO_DATE('24/10/2018', 'DD/MM/YYYY'), 'RUA Y, 55', 1254.22);

-- DEPTO = 5
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12357, 5, 'LARISSSA DE CAMARGO', TO_DATE('14/02/1997', 'DD/MM/YYYY'),
        TO_DATE('04/08/2015', 'DD/MM/YYYY'), 'RUA V, 22', 1245.55);

INSERT INTO T_SIP_FUNCIONARIO
VALUES (12358, 5, 'ANTONIO DE CAMARGO', TO_DATE('25/01/1985', 'DD/MM/YYYY'),
        TO_DATE('12/08/2016', 'DD/MM/YYYY'), 'RUA V, 44', 2451.33);
INSERT INTO T_SIP_FUNCIONARIO
VALUES (12359, 5, 'JOSE DE CAMARGO', TO_DATE('23/10/1998', 'DD/MM/YYYY'),
        TO_DATE('20/04/2017', 'DD/MM/YYYY'), 'RUA V, 88', 6541.22);
-- POPULAR A TABELA DEPENDENTE. ESCOLHER 3 FUNCIONARIOS E CADASTRAR 3 DEPENDENTES
-- PARA CADA FUNCIONARIO ESCOLHIDO
-- FUNCIONARIO = 12345
INSERT INTO T_SIP_DEPENDENTE
VALUES (12345, 1, 'JOANINHA', TO_DATE('12/10/2010', 'DD/MM/YYYY'));
INSERT INTO T_SIP_DEPENDENTE
VALUES (12345, 2, 'JULINHA', TO_DATE('15/10/2012', 'DD/MM/YYYY'));
INSERT INTO T_SIP_DEPENDENTE
VALUES (12345, 3, 'TONINHO', TO_DATE('22/10/2014', 'DD/MM/YYYY'));
-- FUNCIONARIO = 12356
INSERT INTO T_SIP_DEPENDENTE
VALUES (12356, 1, 'JUNINHO', TO_DATE('02/10/2011', 'DD/MM/YYYY'));
INSERT INTO T_SIP_DEPENDENTE
VALUES (12356, 2, 'ZEZINHO', TO_DATE('15/10/2013', 'DD/MM/YYYY'));
INSERT INTO T_SIP_DEPENDENTE
VALUES (12356, 3, 'MARCELINHO', TO_DATE('17/10/2015', 'DD/MM/YYYY'));
-- FUNCIONARIO = 12359
INSERT INTO T_SIP_DEPENDENTE
VALUES (12359, 1, 'MARIAZINHA', TO_DATE('11/06/2014', 'DD/MM/YYYY'));
INSERT INTO T_SIP_DEPENDENTE
VALUES (12359, 2, 'LUIZINHA', TO_DATE('21/06/2016', 'DD/MM/YYYY'));
INSERT INTO T_SIP_DEPENDENTE
VALUES (12359, 3, 'CARMINHA', TO_DATE('18/06/2018', 'DD/MM/YYYY'));
-- POPULAR A TABELA PROJETO COM 5 PROJETOS
-- 3 PROJETOS SEM A DATA TÉRMINO
INSERT INTO T_SIP_PROJETO
VALUES (10001, 'PROJETO 1', TO_DATE('11/10/2016', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_PROJETO
VALUES (10002, 'PROJETO 2', TO_DATE('25/10/2013', 'DD/MM/YYYY'), TO_DATE('15/04/2015', 'DD/MM/YYYY'));
INSERT INTO T_SIP_PROJETO
VALUES (10003, 'PROJETO 3', TO_DATE('28/04/2012', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_PROJETO
VALUES (10004, 'PROJETO 4', TO_DATE('25/03/2017', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_PROJETO
VALUES (10005, 'PROJETO 5', TO_DATE('28/09/2014', 'DD/MM/YYYY'), TO_DATE('15/09/2018', 'DD/MM/YYYY'));
-- POPULAR A TABELA IMPLANTACAO
-- PROJETO 1
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10001, 1, 12345, TO_DATE('11/10/2016', 'DD/MM/YYYY'), TO_DATE('15/09/2017', 'DD/MM/YYYY'));
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10001, 2, 12346, TO_DATE('11/10/2016', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10001, 3, 12348, TO_DATE('11/10/2016', 'DD/MM/YYYY'), TO_DATE('25/06/2018', 'DD/MM/YYYY'));
-- PROJETO 2
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10002, 1, 12345, TO_DATE('25/10/2013', 'DD/MM/YYYY'), TO_DATE('15/04/2014', 'DD/MM/YYYY'));
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10002, 2, 12352, TO_DATE('25/10/2013', 'DD/MM/YYYY'), TO_DATE('25/07/2014', 'DD/MM/YYYY'));
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10002, 3, 12355, TO_DATE('25/10/2013', 'DD/MM/YYYY'), TO_DATE('15/04/2015', 'DD/MM/YYYY'));
-- PROJETO 3
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10003, 1, 12354, TO_DATE('28/04/2013', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10003, 2, 12355, TO_DATE('28/04/2013', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10003, 3, 12345, TO_DATE('28/04/2013', 'DD/MM/YYYY'), NULL);
-- PROJETO 4
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10004, 1, 12357, TO_DATE('25/03/2017', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10004, 2, 12358, TO_DATE('25/03/2017', 'DD/MM/YYYY'), NULL);
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10004, 3, 12354, TO_DATE('25/03/2017', 'DD/MM/YYYY'), TO_DATE('15/08/2018', 'DD/MM/YYYY'));
-- PROJETO 5
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10005, 1, 12345, TO_DATE('28/09/2014', 'DD/MM/YYYY'), TO_DATE('15/09/2018', 'DD/MM/YYYY'));
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10005, 2, 12350, TO_DATE('28/09/2014', 'DD/MM/YYYY'), TO_DATE('15/09/2018', 'DD/MM/YYYY'));
INSERT INTO T_SIP_IMPLANTACAO
VALUES (10005, 3, 12354, TO_DATE('28/09/2014', 'DD/MM/YYYY'), TO_DATE('15/09/2018', 'DD/MM/YYYY'));
-- CONSULTAR TABELAS
SELECT *
FROM T_SIP_DEPARTAMENTO;
SELECT *
FROM T_SIP_FUNCIONARIO;
SELECT *
FROM T_SIP_DEPENDENTE;
SELECT *
FROM T_SIP_PROJETO;
SELECT *
FROM T_SIP_IMPLANTACAO;
--EFETIVAR AS TRANSAÇÕES PENDENTES
COMMIT;

-- CONSULTANDO TODAS AS LINHAS E COLUNAS DA TABELA FUNCIONARIO
SELECT *
FROM T_SIP_FUNCIONARIO;

-- Especificando as colunas que deseja consultar e recuperando -- todas as linhas da tabela FUNCIONARIO
SELECT NR_MATRICULA, NM_FUNCIONARIO, VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO;

-- Especificando as colunas que deseja consultar e filtrando --- as linhas da tabela FUNCIONARIO.
SELECT NR_MATRICULA,
       CD_DEPTO,
       NM_FUNCIONARIO,
       VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO
WHERE CD_DEPTO = 3;

-- RECUPERANDO OS DEPARTAMENTOS (SEM REPETIÇÃO) QUE POSSUEM
-- FUNCIONARIOS
SELECT DISTINCT CD_DEPTO
FROM T_SIP_FUNCIONARIO;
-- OU
SELECT UNIQUE CD_DEPTO
FROM T_SIP_FUNCIONARIO;

-- EXEMPLO DE CONSULTA UTILIZANDO OPERADORES ARITMÉTICOS
SELECT NR_MATRICULA,
       NM_FUNCIONARIO,
       VL_SALARIO_MENSAL,
       VL_SALARIO_MENSAL * 1.05
FROM T_SIP_FUNCIONARIO;

-- EXEMPLOS DE APELIDOS DE COLUNAS
SELECT NR_MATRICULA,
       NM_FUNCIONARIO              FUNCIONARIO,
       VL_SALARIO_MENSAL           "SALÁRIO MENSAL",
       VL_SALARIO_MENSAL * 1.05 AS "SALÁRIO REAJUSTADO"
FROM T_SIP_FUNCIONARIO;

-- APRESENTANDO RESULTADOS DE FORMA ORDENADA
-- ORDER BY ASC
SELECT CD_DEPTO, NM_DEPTO
FROM T_SIP_DEPARTAMENTO
ORDER BY NM_DEPTO;

-- APRESENTANDO RESULTADOS DE FORMA ORDENADA
-- ORDER BY DESC
SELECT CD_DEPTO, NM_DEPTO
FROM T_SIP_DEPARTAMENTO
ORDER BY NM_DEPTO DESC;

-- APRESENTANDO RESULTADOS DE FORMA ORDENADA
-- ORDER BY UTILIZANDO NÚMEROS QUE REPRESENTAM
-- A POSIÇÃO DAS COLUNAS NO SELECT
SELECT NR_MATRICULA,
       CD_DEPTO,
       NM_FUNCIONARIO,
       VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO
ORDER BY 2 ASC, 4 DESC;

-- APRESENTANDO RESULTADOS DE FORMA ORDENADA
-- ORDER BY UTILIZANDO O APELIDO DAS COLUNAS
SELECT NR_MATRICULA             "MATRICULA",
       NM_FUNCIONARIO           "NOME ",
       VL_SALARIO_MENSAL        "SALÁRIO MENSAL",
       VL_SALARIO_MENSAL * 1.05 "SALÁRIO REAJUSTADO"
FROM T_SIP_FUNCIONARIO
ORDER BY "SALÁRIO REAJUSTADO" DESC;

-- FILTRANDO POR NÚMEROS
SELECT NR_MATRICULA, NM_FUNCIONARIO, VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO
WHERE VL_SALARIO_MENSAL > 1500.50;

-- FILTRANTO POR TEXTO (CADEIA DE CARACTERES)
SELECT NR_MATRICULA, NM_FUNCIONARIO
FROM T_SIP_FUNCIONARIO
WHERE NM_FUNCIONARIO = 'JOAO DA SILVA';

-- UTILIZANDO A CONVERSÃO DE TEXTO
SELECT NR_MATRICULA, NM_FUNCIONARIO
FROM T_SIP_FUNCIONARIO
WHERE UPPER(NM_FUNCIONARIO) = 'JOAO DA SILVA';
-- OU
SELECT NR_MATRICULA, NM_FUNCIONARIO
FROM T_SIP_FUNCIONARIO
WHERE LOWER(NM_FUNCIONARIO) = 'joao da silva';

-- OPERADOR LOGICO AND -> PRECISA ATENDER AS DUAS CONDIÇÕES
-- PARA RECUPERAR OS VALORES
SELECT NR_MATRICULA, NM_FUNCIONARIO, CD_DEPTO, DT_ADMISSAO
FROM T_SIP_FUNCIONARIO
WHERE DT_ADMISSAO >= TO_DATE('01/08/2015','DD/MM/YYYY')
  AND CD_DEPTO = 3;

-- OPERADOR LOGICO OR -> PRECISA ANTENDER QUALQUER UMA
-- DAS CONDIÇÕES PARA RECUPERAR OS VALORES
SELECT NR_MATRICULA, NM_FUNCIONARIO,
       CD_DEPTO, VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO
WHERE CD_DEPTO = 4
   OR VL_SALARIO_MENSAL > 3000;

-- OPERADOR NOT
SELECT NR_MATRICULA, NM_FUNCIONARIO,
       CD_DEPTO, VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO
WHERE NOT CD_DEPTO = 4;

-- OPERADOR BETWEEN
SELECT NR_MATRICULA, NM_FUNCIONARIO,
       CD_DEPTO, VL_SALARIO_MENSAL
FROM   T_SIP_FUNCIONARIO
WHERE  VL_SALARIO_MENSAL BETWEEN 1000 AND 2500;

-- OPERADOR BETWEEN
SELECT NR_MATRICULA, NM_FUNCIONARIO,
       CD_DEPTO, DT_ADMISSAO
FROM   T_SIP_FUNCIONARIO
WHERE  DT_ADMISSAO BETWEEN TO_DATE('01/01/2013','DD/MM/YYYY')
           AND  TO_DATE('30/12/2015','DD/MM/YYYY');

-- OPERADOR IN
SELECT NR_MATRICULA, NM_FUNCIONARIO, CD_DEPTO
FROM   T_SIP_FUNCIONARIO
WHERE  CD_DEPTO IN (1,2,3);

-- OPERADOR NOT IN
SELECT NR_MATRICULA, NM_FUNCIONARIO, CD_DEPTO
FROM   T_SIP_FUNCIONARIO
WHERE  CD_DEPTO NOT IN (1,2,3);

-- OPERADOR IN
SELECT  NR_MATRICULA ,
        DT_ADMISSAO ,
        VL_SALARIO_MENSAL
FROM    T_SIP_FUNCIONARIO
WHERE   TO_CHAR(DT_ADMISSAO,'YYYY') IN ('2012','2014');

-- OPERADOR IS NOT NULL
SELECT CD_PROJETO, NM_PROJETO, DT_INICIO, DT_TERMINO
FROM T_SIP_PROJETO
WHERE DT_TERMINO IS NOT NULL;

-- OPERADOR IS NULL
SELECT CD_PROJETO, NM_PROJETO, DT_INICIO, DT_TERMINO
FROM T_SIP_PROJETO
WHERE DT_TERMINO IS NULL;

-- OPERADOR LIKE
SELECT CD_DEPTO, NM_DEPTO
FROM T_SIP_DEPARTAMENTO
WHERE NM_DEPTO LIKE 'FINA%';

-- OPERADOR LIKE
SELECT CD_DEPTO, NM_DEPTO
FROM   T_SIP_DEPARTAMENTO
WHERE  NM_DEPTO LIKE '_A%';

-- OPERADOR LIKE
SELECT CD_DEPTO, NM_DEPTO
FROM   T_SIP_DEPARTAMENTO
WHERE  NM_DEPTO LIKE '___UR%';

-- Exemplo utilizando vários operadores
SELECT 	NR_MATRICULA   ,
          CD_DEPTO       ,
          NM_FUNCIONARIO ,
          DT_NASCIMENTO  ,
          DT_ADMISSAO    ,
          VL_SALARIO_MENSAL
FROM 	T_SIP_FUNCIONARIO
WHERE   DT_NASCIMENTO
    BETWEEN
    TO_DATE('01/01/1980','DD/MM/YYYY')
    AND
    TO_DATE('30/12/2010','DD/MM/YYYY')
  AND
    DT_ADMISSAO > TO_DATE('01/01/2013','DD/MM/YYYY')
  AND VL_SALARIO_MENSAL < 2300
  AND NOT CD_DEPTO = 3 ;