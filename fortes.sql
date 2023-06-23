
CREATE TABLE professores (
                cpf_professor                                VARCHAR(11)    NOT NULL    CONSTRAINT check_cpf_professor UNIQUE,
                email_professor                              VARCHAR(100)   NOT NULL,
                nome_professor                               VARCHAR(100)   NOT NULL,
                
                CONSTRAINT professores_cpf PRIMARY KEY (cpf_professor)
);

COMMENT ON TABLE professores                                  IS 'Informações gerais dos professores';
COMMENT ON COLUMN professores.cpf_professor                   IS 'PK armazena o CPF do professor.';
COMMENT ON COLUMN professores.email_professor                 IS 'Coluna armazena o e-mail do professor.';
COMMENT ON COLUMN professores.nome_professor                  IS 'Coluna armazena o nome do professor.';


CREATE TABLE Alunos (
                cpf_aluno                                   VARCHAR(11)   NOT NULL     CONSTRAINT check_cpf_aluno UNIQUE,
                email_aluno                                 VARCHAR(100)  NOT NULL,
                nome_aluno                                  VARCHAR(100)  NOT NULL,
                pontos_total                                NUMERIC(10)                CONSTRAINT check_pontos CHECK (pontos_total >= 0),
                
                CONSTRAINT aluno_id PRIMARY KEY (cpf_aluno)
);

COMMENT ON TABLE Alunos                                      IS 'Informaçoões gerais dos alunos';
COMMENT ON COLUMN Alunos.cpf_aluno                           IS 'PK armazena o CPF do aluno.';
COMMENT ON COLUMN Alunos.email_aluno                         IS 'Coluna armazena o e-mail do aluno.';
COMMENT ON COLUMN Alunos.nome_aluno                          IS 'Coluna armazena o nome do aluno como no RG.';
COMMENT ON COLUMN Alunos.pontos_total                        IS 'Coluna armazena a pontuação do aluno.';


CREATE TABLE Cursos (
                curso_id                                    VARCHAR(3)   NOT NULL     CONSTRAINT check_curso_id UNIQUE,
                nome_curso                                  VARCHAR(256) NOT NULL,
                cpf_aluno                                   VARCHAR(11)  NOT NULL,
                
                CONSTRAINT curso_id PRIMARY KEY (curso_id)
);

COMMENT ON TABLE Cursos                                   IS 'informações gerais dos cursos';
COMMENT ON COLUMN Cursos.curso_id                         IS 'PK armazena o ID do curso.';
COMMENT ON COLUMN Cursos.nome_curso                       IS 'Colua armazena o nome do curso.';
COMMENT ON COLUMN Cursos.cpf_aluno                        IS 'FK armazena o cpf do aluno.
';


CREATE TABLE aulas (
                aula_id                                    VARCHAR(3)       NOT NULL      CONSTRAINT check_aula_id UNIQUE,
                curso_id                                   VARCHAR(3)       NOT NULL      CONSTRAINT check_curso_id UNIQUE,
                cpf_professor                              VARCHAR(11)      NOT NULL      CONSTRAINT check_cpf_professor_2 UNIQUE,
                data                                       DATE             NOT NULL,
                duracao                                    TIME             NOT NULL,
                pontos                                     NUMERIC(10)      NOT NULL,
                tema                                       VARCHAR(256)     NOT NULL,
                cpf_aluno                                  VARCHAR(11)      NOT NULL      CONSTRAINT check_cpf_aluno_2 UNIQUE,
                
                CONSTRAINT aula_id PRIMARY KEY (aula_id, curso_id, cpf_professor)
);
COMMENT ON TABLE aulas                                  IS 'informações gerais das aulas';
COMMENT ON COLUMN aulas.aula_id                         IS 'PK armazena o ID da aula.';
COMMENT ON COLUMN aulas.curso_id                        IS 'PFK armazena o ID do curso.';
COMMENT ON COLUMN aulas.cpf_professor                   IS 'PFK armazena o CPF do professor.';
COMMENT ON COLUMN aulas.data                            IS 'Coluna armazena a data como dia, mês e ano da aula.';
COMMENT ON COLUMN aulas.duracao                         IS 'Coluna armazena a duração da aula.';
COMMENT ON COLUMN aulas.pontos                          IS 'Coluna armazena a pontuação da aula.';
COMMENT ON COLUMN aulas.tema                            IS 'Coluna armazena o tema do conteúdo da aula.';
COMMENT ON COLUMN aulas.cpf_aluno                       IS 'FK armazena o CPF do aluno.';


CREATE TABLE recompensas (
                recompensa_id                          VARCHAR(3)       NOT NULL       CONSTRAINT check_recompensa_id UNIQUE,
                nome_recompensa                        VARCHAR(256)     NOT NULL,
                valor_recompensa                       NUMERIC(10)      NOT NULL,
                cpf_aluno                              VARCHAR(11)      NOT NULL,
                
                CONSTRAINT recompensa_id PRIMARY KEY (recompensa_id)
);

COMMENT ON TABLE recompensas                          IS 'informaçções gearias das recompensas';
COMMENT ON COLUMN recompensas.recompensa_id           IS 'PK armazena o ID da recompensa.';
COMMENT ON COLUMN recompensas.nome_recompensa         IS 'Coluna armazena o nome da recompensa.';
COMMENT ON COLUMN recompensas.valor_recompensa        IS 'Coluna armazena o valor da recompensa.';
COMMENT ON COLUMN recompensas.cpf_aluno               IS 'FK armazena o CPF do aluno.';




ALTER TABLE aulas ADD CONSTRAINT professores_aulas_fk
FOREIGN KEY (cpf_professor)
REFERENCES professores (cpf_professor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE recompensas ADD CONSTRAINT alunos_recompensas_fk
FOREIGN KEY (cpf_aluno)
REFERENCES Alunos (cpf_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Cursos ADD CONSTRAINT alunos_cursos_fk
FOREIGN KEY (cpf_aluno)
REFERENCES Alunos (cpf_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE aulas ADD CONSTRAINT alunos_aulas_fk
FOREIGN KEY (cpf_aluno)
REFERENCES Alunos (cpf_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE aulas ADD CONSTRAINT cursos_aulas_fk
FOREIGN KEY (curso_id)
REFERENCES Cursos (curso_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
