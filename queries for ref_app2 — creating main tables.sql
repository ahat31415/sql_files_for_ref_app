-----------------------------------------------------------------------------------------------------------------------
---------------------------- Создание основных таблиц для проекта ref_app2 --------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

--  создаем таблицу для приказов с сохранением названий файлов
CREATE TABLE mod_uch_cpravka.orders (
  id                   serial PRIMARY KEY,
  number_of_order      VARCHAR(100) NOT NULL,
  date_of_order        Date         NOT NULL,
  original_file_name   VARCHAR(355) NOT NULL,
--   quantity_of_students INTEGER      not NULL,
  quantity_of_requests INTEGER      NOT NULL,
  send_to_umu          Boolean      NOT NULL,  ------
  verified             Boolean      NOT NULL,
  info                 VARCHAR(355) NULL,
  faculty              varchar(38) REFERENCES mod_uch_cpravka.spr_faculty (id),
  is_checking boolean default false

);
ALTER table  mod_uch_cpravka.orders
    add column is_postgraduate_order  boolean not null default false;

CREATE TABLE mod_uch_cpravka.project_parameters(
    id                              serial PRIMARY KEY,
    param_name                      VARCHAR(355) not NULL,
    param_value                     VARCHAR(1000) not NULL
);
-- создаем таблицы для содержимого справок, предметов, оценок и барахла
CREATE TABLE mod_uch_cpravka.references (
  id                               serial PRIMARY KEY,
  student                          VARCHAR(355) NULL,
  birthday                         Date         NULL,
  former_education_doc             VARCHAR(355) NULL,
  year_of_former_education_doc     INTEGER      NULL,

  type_of_order_of_beginning       VARCHAR(355) NULL,
  date_of_order_of_beginning       Date         NULL,
  number_of_order_of_beginning     VARCHAR(355) NULL,
  accepted_from_university         VARCHAR(355) NOT NULL DEFAULT 'X',

  type_of_order_of_completion      VARCHAR(355) NULL,
  date_of_order_of_completion      Date         NULL,
  number_of_order_of_completion    VARCHAR(355) NULL,

  duration_of_education            VARCHAR(355) NULL,
  speciality                       VARCHAR(355) NULL,
  subspecialty                     VARCHAR(355) NULL,
  base_of_study                    VARCHAR(355) NULL,
  status_of_student                VARCHAR(355) NULL,
  form_of_study                    VARCHAR(355) NULL,
  faculty                          VARCHAR(355) NULL,
  base_university                  VARCHAR(355) NULL,

  fast_or_not                      VARCHAR(355) NULL,
  type_of_education                VARCHAR(355) NULL,
  level_of_education               VARCHAR(355) NULL,
--   education_program                VARCHAR(355) NULL,
  name_of_additional_education     VARCHAR(355) NULL,
  duration_of_additional_education VARCHAR(355) NULL,

  order_id                         INTEGER REFERENCES mod_uch_cpravka.orders (id) ON DELETE CASCADE,

  reg_number                       VARCHAR(355) NULL,
  series                           VARCHAR(355) NULL,

  is_deactivated BOOLEAN default false,
  deactivation_cause varchar(355) NULL,

  faculty_id varchar(38) REFERENCES mod_uch_cpravka.spr_faculty NULL,
  date_of_verifying date NULL,
  uuid  varchar(38) default public.uuid_generate_v1() not null UNIQUE,
  faculty_declension  VARCHAR(1355) NULL,

  printing_font integer not null default 7
);
------------------------------------------------------------------------------------------------------------------------
----- Справка номер 3 о периоде обучения -------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE mod_uch_cpravka.period_of_study_references (
  id                               serial PRIMARY KEY,
  student                          VARCHAR(355) NULL,
  birthday                         Date         NULL,
  former_education_doc             VARCHAR(355) NULL,
  year_of_former_education_doc     INTEGER      NULL,

  type_of_order_of_beginning       VARCHAR(355) NULL,
  date_of_order_of_beginning       Date         NULL,
  number_of_order_of_beginning     VARCHAR(355) NULL,
  accepted_from_university         VARCHAR(355) NOT NULL DEFAULT 'X',

  type_of_order_of_completion      VARCHAR(355) NULL,
  date_of_order_of_completion      Date         NULL,
  number_of_order_of_completion    VARCHAR(355) NULL,

  duration_of_education            VARCHAR(355) NULL,
  speciality                       VARCHAR(355) NULL,
  subspecialty                     VARCHAR(355) NULL,
  base_of_study                    VARCHAR(355) NULL,
  status_of_student                VARCHAR(355) NULL,
  form_of_study                    VARCHAR(355) NULL,
  faculty                          VARCHAR(355) NULL,
  base_university                  VARCHAR(355) NULL,

  fast_or_not                      VARCHAR(355) NULL,
  type_of_education                VARCHAR(355) NULL,
  level_of_education               VARCHAR(355) NULL,
  name_of_additional_education     VARCHAR(355) NULL,
  duration_of_additional_education VARCHAR(355) NULL,

  reg_number                       VARCHAR(355) NULL,
  series                           VARCHAR(355) NULL,

  is_deactivated BOOLEAN default false,
  deactivation_cause varchar(355) NULL,

  faculty_id varchar(38) REFERENCES mod_uch_cpravka.spr_faculty NULL,
  date_of_verifying date NULL,
  uuid  varchar(38) default public.uuid_generate_v1() not null UNIQUE,

   faculty_declension  VARCHAR(1355) NULL
);
alter table mod_uch_cpravka.period_of_study_references add column is_postgraduate_reference boolean default false;

CREATE table mod_uch_cpravka.reg_numbers_for_period_of_study_references(
    id serial PRIMARY KEY ,
    reference_id INTEGER REFERENCES mod_uch_cpravka.period_of_study_references
);
CREATE TABLE mod_uch_cpravka.exams_essays_practices_for_period_of_study_references (
  id           serial PRIMARY KEY,
  data         VARCHAR(355) NOT NULL,
  ind          VARCHAR(355) NOT NULL,
  reference_id INTEGER REFERENCES mod_uch_cpravka.period_of_study_references (id),
  hours varchar(35) default '',
  mark varchar(35) default ''
);
CREATE TABLE mod_uch_cpravka.disciplines_for_period_of_study_references (
  id           serial PRIMARY KEY,
  name         VARCHAR(355) NOT NULL,
  hours        VARCHAR(355) NOT NULL,
  mark         VARCHAR(355) NOT NULL,
  course       VARCHAR(355) NOT NULL,
  reference_id INTEGER REFERENCES mod_uch_cpravka.period_of_study_references (id)
);

alter sequence reg_numbers_for_period_of_study_references_id_seq RESTART WITH 1;
select pg_get_serial_sequence('reg_numbers_for_period_of_study_references', 'id');
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

CREATE TABLE mod_uch_cpravka.disciplines (
  id           serial PRIMARY KEY,
  name         VARCHAR(355) NOT NULL,
  hours        VARCHAR(355) NOT NULL,
  mark         VARCHAR(355) NOT NULL,
  course       VARCHAR(355) NOT NULL,
  reference_id INTEGER REFERENCES mod_uch_cpravka.references (id)

);

CREATE TABLE mod_uch_cpravka.exams_essays_practices (
  id           serial PRIMARY KEY,
  data         VARCHAR(355) NOT NULL,
  ind          VARCHAR(355) NOT NULL,
  reference_id INTEGER REFERENCES mod_uch_cpravka.references (id),
  hours varchar(35) default '',  -- добавили позже - 20 10 2020
  mark varchar(35) default ''  -- добавили позже - 20 10 2020
);

CREATE TABLE mod_uch_cpravka.bosses (
  id                     serial PRIMARY KEY,
  provost                VARCHAR(355) NOT NULL, -- проректор
  director_of_the_branch VARCHAR(355) NOT NULL,
  dean                   VARCHAR(355) NOT NULL,
  secretary              VARCHAR(355) NOT NULL,
  author_id              INTEGER REFERENCES mod_uch_cpravka.auth_user (id),

  provost_initials                varchar(38) NULL,
  director_of_the_branch_initials varchar(38) NULL,
  dean_initials                   varchar(38) NULL,
  secretary_initials              varchar(38) NULL,

  io_dean  boolean default false,
  io_director boolean default false,
  io_provost boolean default false
);

CREATE TABLE mod_uch_cpravka.bosses_for_every_ref (
  id                     serial PRIMARY KEY,
  provost                VARCHAR(355) NOT NULL, -- проректор
  director_of_the_branch VARCHAR(355) NOT NULL,
  dean                   VARCHAR(355) NOT NULL,
  secretary              VARCHAR(355) NOT NULL,
  references_id          INTEGER REFERENCES mod_uch_cpravka.references (id),

  provost_initials                varchar(38) NULL,
  director_of_the_branch_initials varchar(38) NULL,
  dean_initials                   varchar(38) NULL,
  secretary_initials              varchar(38) NULL,

  io_dean  boolean default false,
  io_director boolean default false,
  io_provost boolean default false
);

CREATE TABLE mod_uch_cpravka.user_info(
    id        serial PRIMARY KEY,
    author_id INTEGER REFERENCES mod_uch_cpravka.auth_user (id),
    branch    INTEGER REFERENCES mod_uch_cpravka.branch_of_bsu (id),
    faculty   varchar(38) REFERENCES mod_uch_cpravka.spr_faculty (id)
);

CREATE TABLE mod_uch_cpravka.student_queries(
    id            serial PRIMARY KEY,
    name          VARCHAR(355) NOT NULL,
    branch_of_bsu VARCHAR(355) NOT NULL,
    faculty       VARCHAR(355) NOT NULL,
    level         VARCHAR(355) NOT NULL,
    speciality    VARCHAR(355) NOT NULL,
    profile       VARCHAR(355) NULL,
    is_done       Boolean      NULL,
    date_of_query Date         NULL,
    is_denied     boolean default false
);

CREATE TABLE mod_uch_cpravka.student_queries_for_period_of_study_reference(
    id            serial PRIMARY KEY,
    name          VARCHAR(355) NOT NULL,
    branch_of_bsu VARCHAR(355) NOT NULL,
    faculty       VARCHAR(355) NOT NULL,
    level         VARCHAR(355) NOT NULL,
    speciality    VARCHAR(355) NOT NULL,
    profile       VARCHAR(355) NULL,
    is_done       Boolean      NULL,
    date_of_query Date         NULL,
    is_denied     boolean default false
);
ALTER TABLE mod_uch_cpravka.student_queries
ADD COLUMN date_of_query Date NULL;

INSERT INTO mod_students.student_queries (name, faculty_id, speciality, subspecialty,branch_of_bsu_id,education_program_id)
VALUES ('Рафюлин Ринад Тольбютряевич', 1, 'Урановая добыча', 'Something1132', 1, 1);

Select
sq.faculty,
dep.department
from
 mod_students.student_queries as sq,
 mod_students.departments_of_bsu as dep
where dep.id = sq.faculty;

------------------------------------------------------------------------------------------------------------------------
--  Таблица для справки с места  ---------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

CREATE TABLE mod_uch_cpravka.references2 (
  id                 serial PRIMARY KEY,
  first_name         VARCHAR(355) NOT NULL,
  name               VARCHAR(355) NOT NULL,
  last_name          VARCHAR(355) NOT NULL,
  course             INTEGER      NOT NULL,
--   faculty_id         INTEGER REFERENCES mod_uch_cpravka.departments_of_bsu (id),
  faculty_id         varchar(38) REFERENCES mod_uch_cpravka.spr_faculty (id),
  date_of_order      Date         NULL,
  number_of_order    VARCHAR(355) NULL,
  start_date         Date         NULL,
  end_date           Date         NULL,
  quantity           INTEGER      NOT NULL,
  date_of_adding     Date NULL,
  type_id            INTEGER REFERENCES mod_uch_cpravka.type_of_ref2 (id),
  is_printed         Boolean NULL,
  additional_orders varchar(1355) default '',

  form_of_study VARCHAR(355) NULL,
  level_of_education VARCHAR(355) NULL,
  speciality VARCHAR(355) NULL
);
alter table mod_uch_cpravka.references2 add column is_postgraduate_student boolean not null default false;

insert into mod_uch_cpravka.references2(first_name, name, last_name, course, faculty_id,quantity)
values ('a','as','ass',1,1,1);
-- тип справки с места учебы
CREATE table mod_uch_cpravka.type_of_ref2(
  id serial PRIMARY KEY,
  type VARCHAR(355) NOT NULL
);
  INSERT INTO mod_uch_cpravka.type_of_ref2(type)
  values ('Обычная'),('С гербовой печатью (для пенсионного фонда)');
-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- есть другая таблица которая выполняет эту функцию user_info
-- CREATE table mod_uch_cpravka.faculty_for_user(
--   id serial PRIMARY KEY,
--   auth_user INTEGER REFERENCES mod_uch_cpravka.auth_user (id),
--   faculty INTEGER REFERENCES mod_uch_cpravka.departments_of_bsu (id)
-- );

ALTER TABLE mod_uch_cpravka.spr_faculty
ADD COLUMN series VARCHAR(355) NULL,
ADD COLUMN declension  VARCHAR(1355) NULL,
ADD COLUMN branch_id integer references mod_uch_cpravka.branch_of_bsu;

ALTER TABLE mod_uch_cpravka.spr_faculty
ADD COLUMN is_college BOOLEAN default FALSE;

ALTER TABLE mod_uch_cpravka.orders
DROP COLUMN  quantity_of_students;


CREATE table mod_uch_cpravka.reg_numbers_for_references(
    id serial PRIMARY KEY ,
    reference_id INTEGER REFERENCES mod_uch_cpravka.references
);
-- CREATE table mod_uch_cpravka.reg_numbers_for_references(
--     id INTEGER REFERENCES mod_uch_cpravka.references,
--     reg_number serial
-- )

SELECT version(); -- Версия PostgreSQL




ALTER TABLE mod_uch_cpravka.bosses
ADD COLUMN provost_initials varchar(38) NULL,
ADD COLUMN director_of_the_branch_initials varchar(38) NULL,
ADD COLUMN dean_initials varchar(38) NULL,
ADD COLUMN secretary_initials varchar(38) NULL;

