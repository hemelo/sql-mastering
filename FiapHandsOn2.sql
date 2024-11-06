-- SCRIPT DDL PARA IMPLEMENTAR O CADASTRO DE LIVROS
/*
DROP TABLE t_slv_autor          CASCADE CONSTRAINTS;
DROP TABLE t_slv_autor_livro    CASCADE CONSTRAINTS;
DROP TABLE t_slv_categoria      CASCADE CONSTRAINTS;
DROP TABLE t_slv_livro          CASCADE CONSTRAINTS;
*/
-- CRIAÇÃO DA TABELA AUTOR
CREATE TABLE t_slv_autor
(
    cd_autor          NUMBER(3)    NOT NULL,
    nm_primeiro_autor VARCHAR2(20) NOT NULL,
    nm_segundo_autor  VARCHAR2(40) NOT NULL
);
-- ADIÇÃO DA CONSTRAINT CHAVE PRIMARIA
ALTER TABLE t_slv_autor
    ADD CONSTRAINT pk_slv_autor PRIMARY KEY (cd_autor);
-- CRIAÇÃO DA TABELA AUTOR_LIVRO
CREATE TABLE t_slv_autor_livro
(
    nr_isbn            NUMBER(8) NOT NULL,
    cd_autor           NUMBER(3) NOT NULL,
    st_autor_principal NUMBER(1) NOT NULL
);
-- ADIÇÃO DA CONSTRAINT CHECK
ALTER TABLE t_slv_autor_livro
    ADD CONSTRAINT ck_slv_autor_livro_status CHECK ( st_autor_principal IN (1, 2) );
-- ADIÇÃO DA CONSTRAINT CHAVE PRIMARIA (COMPOSTA)
ALTER TABLE t_slv_autor_livro
    ADD CONSTRAINT pk_slv_autor_livro PRIMARY KEY (nr_isbn, cd_autor);
-- CRIAÇÃO DA TABELA CATEGORIA
CREATE TABLE t_slv_categoria
(
    cd_categoria       NUMBER(3)       NOT NULL,
    ds_sigla_categoria CHAR(3) NOT NULL,
    ds_categoria       VARCHAR2(30)    NOT NULL
);
-- ADIÇÃO DA CONSTRAINT CHAVE PRIMARIA
ALTER TABLE t_slv_categoria
    ADD CONSTRAINT pk_slv_categoria PRIMARY KEY (cd_categoria);
-- ADIÇÃO DA CONSTRAINT UNIQUE
ALTER TABLE t_slv_categoria
    ADD CONSTRAINT un_slv_categoria_sigla UNIQUE (ds_sigla_categoria);
-- ADIÇÃO DA CONSTRAINT UNIQUE
ALTER TABLE t_slv_categoria
    ADD CONSTRAINT un_slv_categoria_desc UNIQUE (ds_categoria);
-- CRIAÇÃO DA TABELA LIVRO
CREATE TABLE t_slv_livro
(
    nr_isbn      NUMBER(8)         NOT NULL,
    cd_categoria NUMBER(3)         NOT NULL,
    nm_titulo    VARCHAR2(50)      NOT NULL,
    ds_sinopse   VARCHAR2(200)     NOT NULL,
    nr_edicao    NUMBER(2)         NOT NULL,
    nr_ano       NUMBER(4)         NOT NULL
);
-- ADIÇÃO DA CONSTRAINT CHECK
ALTER TABLE t_slv_livro
    ADD CONSTRAINT ck_slv_livro_edicao CHECK ( nr_edicao > 0 );
-- ADIÇÃO DA CONSTRAINT CHECK
ALTER TABLE t_slv_livro
    ADD CONSTRAINT ck_slv_livro_ano CHECK ( nr_ano > 0 );
-- ADIÇÃO DA CONSTRAINT CHAVE PRIMARIA
ALTER TABLE t_slv_livro
    ADD CONSTRAINT pk_slv_livro PRIMARY KEY (nr_isbn);
-- ADIÇÃO DA CONSTRAINT CHAVE ESTRANGEIRA - RELACIONAMENTOS
-- RELACIONAMENTO ENTRE AUTOR_LIVRO E AUTOR
ALTER TABLE t_slv_autor_livro
    ADD CONSTRAINT fk_slv_autor_livro_autor
        FOREIGN KEY (cd_autor)
            REFERENCES t_slv_autor (cd_autor);
-- RELACIONAMENTO ENTRE AUTOR_LIVRO E LIVRO
ALTER TABLE t_slv_autor_livro
    ADD CONSTRAINT fk_slv_autor_livro_livro
        FOREIGN KEY (nr_isbn)
            REFERENCES t_slv_livro (nr_isbn);
-- RELACIONAMENTO ENTRE LIVRO E CATEGORIA
ALTER TABLE t_slv_livro
    ADD CONSTRAINT fk_slv_livro_categoria
        FOREIGN KEY (cd_categoria)
            REFERENCES t_slv_categoria (cd_categoria);


-- SCRIPT CONTENDO COMANDOS DDL PARA
-- MANUTENÇÃO DO BANCO DE DADOS SLV
/*
Na tabela “T_SLV_CATEGORIA”, crie a instrução SQL, comando DDL para alterar o nome da coluna “ds_sigla_categoria”  para “ds_sigla_categ”.
*/
ALTER TABLE T_SLV_CATEGORIA
    RENAME COLUMN ds_sigla_categoria TO ds_sigla_categ;
/*
Na tabela “T_SLV_CATEGORIA”, crie a instrução SQL, comando DDL  para alterar o nome da UNIQUE constraint “UN_SLV_CATEGORIA_DESC” para “UN_SLV_CATEG_DESC” .
*/
ALTER TABLE T_SLV_CATEGORIA
    RENAME CONSTRAINT UN_SLV_CATEGORIA_DESC TO UN_SLV_CATEG_DESC;
/*
Na tabela “T_SLV_AUTOR”, crie a instrução SQL, comando DDL
para alterar o tamanho da coluna “nm_segundo_autor” para 30 caracteres.
*/
ALTER TABLE T_SLV_AUTOR MODIFY nm_segundo_autor VARCHAR2(30);
/*
Na tabela “T_SLV_AUTOR”, crie a instrução SQL, comando DDL para adicionar coluna “ds_email”, com tipo de dado VARCHAR2, tamanho 40 caracteres e obrigatória.
*/
ALTER TABLE T_SLV_AUTOR
    ADD ds_email VARCHAR2(40) NOT NULL;
/*
Na tabela “T_SLV_AUTOR”, crie a instrução SQL, comando DDL para alterar o tamanho da coluna “ds_email” para 60 caracteres e elimine a constraint NOT NULL da coluna “ds_email”, utilizando uma única instrução.
*/
ALTER TABLE T_SLV_AUTOR MODIFY ds_email VARCHAR2(60) NULL;
/*
Na tabela “T_SLV_AUTOR_LIVRO”, crie a instrução SQL, comando DDL para alterar o tamanho da coluna “nr_isbn” para 13 dígitos.
*/
ALTER TABLE T_SLV_AUTOR_LIVRO MODIFY nr_isbn NUMBER (13);
/*
Na tabela “T_SLV_LIVRO”, crie a instrução SQL, comando DDL para alterar o tamanho da coluna “nr_isbn” para 13 dígitos.
*/
ALTER TABLE T_SLV_LIVRO MODIFY nr_isbn NUMBER (13);
/*
Na tabela “T_SLV_AUTOR”, crie a instrução SQL, comando DDL para alterar e adicionar a coluna “nm_pais_origem” (nome do pais de origem do autor), om tipo de dado VARCHAR2, tamanho 30 caracteres e não obrigatório (opcional).
*/
ALTER TABLE T_SLV_AUTOR
    ADD nm_pais_origem VARCHAR2(30);
/*
Na tabela “T_SLV_LIVRO, crie a instrução SQL, comando DDL para alterar e adicionar a constraint UNIQUE para a coluna “nm_titulo”.
Nomeie a constraint como: “UN_SLV_LIVRTITULO”.
*/
ALTER TABLE T_SLV_LIVRO
    ADD CONSTRAINT UN_LIVRO_TITULO UNIQUE (nm_titulo);
/*
Na tabela “T_SLV_AUTOR_LIVRO”, crie a instrução SQL, comando DDL para eliminar a constraint chave estrangeira “FK_SLV_AUTOR_LIVRO_AUTOR”.
*/
ALTER TABLE T_SLV_AUTOR_LIVRO
    DROP CONSTRAINT FK_SLV_AUTOR_LIVRO_AUTOR;
/*
Na tabela “T_SLV_LIVRO”, crie a instrução SQL, comando DDL para eliminar a constraint chave primária “PK_SLV_LIVRO”, com a opção “CASCADE”, que elimina o relacionamento existente.
*/
ALTER TABLE T_SLV_LIVRO
    DROP CONSTRAINT PK_SLV_LIVRO CASCADE;
/*
Na tabela “T_SLV_CATEGORIA”, crie a instrução SQL, comando DDL para desabilitar a constraint UNIQUE “UN_SLV_CATEGORIA_SIGLA” associada a coluna “ds_sigla_categ”.
*/
ALTER TABLE T_SLV_CATEGORIA
    DISABLE CONSTRAINT UN_SLV_CATEGORIA_SIGLA;