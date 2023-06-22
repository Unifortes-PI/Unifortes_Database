-- Remoção do usuário, role, schema e database caso existam.

drop database                                 if exists unifortes;
drop schema                                   if exists fortes cascade;
drop role                                     if exists grupo;

-- Criação do usuário.


CREATE USER  grupo
     with
     LOGIN
     SUPERUSER
     INHERIT
     CREATEDB
     CREATEROLE
     REPLICATION
     PASSWORD '123456';
 
-- Utilizar meu usuário  
    
 SET ROLE grupo;

    
-- Criação do database. 

CREATE DATABASE unifortes     with
    OWNER  =             grupo
    ENCODING =          'UTF8'
    LC_COLLATE =        'pt_BR.UTF-8'
    LC_CTYPE =          'pt_BR.UTF-8'
    ALLOW_CONNECTIONS =  'TRUE'
    TEMPLATE = 'template0';

   
COMMENT ON DATABASE unifortes                        IS 'Banco de dados UniFortes com o usuário Grupo.';
GRANT ALL ON DATABASE unifortes                      TO  grupo;

-- Conexão BD

\setenv PGPASSWORD 123456
\c unifortes grupo;

-- Criação do schema e setagem.

CREATE SCHEMA fortes
AUTHORIZATION grupo;
ALTER SCHEMA  fortes  OWNER TO grupo;
ALTER USER                   grupo
SET SEARCH_PATH TO fortes, "$user", public;

CREATE TABLE fortes.professores (
                cpf_professor VARCHAR(11) NOT NULL,
                email_professor VARCHAR(100) NOT NULL,
                usuario_professor VARCHAR(100) NOT NULL,
                nome_professor VARCHAR(100) NOT NULL,
                CONSTRAINT professores_cpf PRIMARY KEY (cpf_professor)
);
COMMENT ON TABLE fortes.professores IS 'Informações gerais dos professores';


CREATE TABLE fortes.Alunos (
                cpf_aluno VARCHAR(11) NOT NULL,
                email_aluno VARCHAR(100) NOT NULL,
                usuario_aluno VARCHAR(100) NOT NULL,
                nome_aluno VARCHAR(100) NOT NULL,
                pontos_total NUMERIC(10),
                CONSTRAINT aluno_id PRIMARY KEY (cpf_aluno)
);
COMMENT ON TABLE fortes.Alunos IS 'Informaçoões gerais dos alunos';
COMMENT ON COLUMN fortes.Alunos.cpf_aluno IS 'cpf do aluno';


CREATE TABLE fortes.Cursos (
                curso_id VARCHAR(3) NOT NULL,
                nome_curso VARCHAR(256) NOT NULL,
                cpf_aluno VARCHAR(11) NOT NULL,
                CONSTRAINT curso_id PRIMARY KEY (curso_id)
);
COMMENT ON TABLE fortes.Cursos IS 'informações gerais dos cursos';
COMMENT ON COLUMN fortes.Cursos.cpf_aluno IS 'cpf do aluno';


CREATE TABLE fortes.aulas (
                aula_id VARCHAR(3) NOT NULL,
                curso_id VARCHAR(3) NOT NULL,
                cpf_professor VARCHAR(11) NOT NULL,
                data DATE NOT NULL,
                duracao TIME NOT NULL,
                pontos NUMERIC(10) NOT NULL,
                tema VARCHAR(256) NOT NULL,
                cpf_aluno VARCHAR(11) NOT NULL,
                CONSTRAINT aula_id PRIMARY KEY (aula_id, curso_id, cpf_professor)
);
COMMENT ON TABLE fortes.aulas IS 'informações gerais das aulas';
COMMENT ON COLUMN fortes.aulas.cpf_aluno IS 'cpf do aluno';


CREATE TABLE fortes.recompensas (
                recompensa_id VARCHAR(3) NOT NULL,
                nome_recompensa VARCHAR(256) NOT NULL,
                valor_recompensa NUMERIC(10) NOT NULL,
                cpf_aluno VARCHAR(11) NOT NULL,
                CONSTRAINT recompensa_id PRIMARY KEY (recompensa_id)
);
COMMENT ON TABLE fortes.recompensas IS 'informaçções gearias das recompensas';
COMMENT ON COLUMN fortes.recompensas.cpf_aluno IS 'cpf do aluno';


ALTER TABLE fortes.aulas ADD CONSTRAINT professores_aulas_fk
FOREIGN KEY (cpf_professor)
REFERENCES fortes.professores (cpf_professor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fortes.recompensas ADD CONSTRAINT alunos_recompensas_fk
FOREIGN KEY (cpf_aluno)
REFERENCES fortes.Alunos (cpf_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fortes.Cursos ADD CONSTRAINT alunos_cursos_fk
FOREIGN KEY (cpf_aluno)
REFERENCES fortes.Alunos (cpf_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fortes.aulas ADD CONSTRAINT alunos_aulas_fk
FOREIGN KEY (cpf_aluno)
REFERENCES fortes.Alunos (cpf_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fortes.aulas ADD CONSTRAINT cursos_aulas_fk
FOREIGN KEY (curso_id)
REFERENCES fortes.Cursos (curso_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
