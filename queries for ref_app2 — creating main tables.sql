-----------------------------------------------------------------------------------------------------------------------
---------------------------- Создание основных таблиц для проекта ref_app2 --------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

--  создаем таблицу для приказов с сохранением названий файлов
CREATE TABLE mod_uch_cpravka.orders (
  id                   serial PRIMARY KEY,
  number_of_order      VARCHAR(100) NOT NULL,
  date_of_order        Date         NOT NULL,
  original_file_name   VARCHAR(355) NOT NULL,
  quantity_of_students INTEGER      not NULL,
  quantity_of_requests INTEGER      NOT NULL,
  send_to_umu          Boolean      NOT NULL,  ------
  verified             Boolean      NOT NULL
);
--   reference_id       INTEGER REFERENCES mod_students.references (id) default Null


INSERT INTO mod_students.orders (number_of_order, date_of_order, original_file_name, verified)
VALUES ('121221121212', '12-12-2012', 'hz.txt', true, NULL);

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
  education_program                VARCHAR(355) NULL,
  name_of_additional_education     VARCHAR(355) NULL,
  duration_of_additional_education VARCHAR(355) NULL,

  order_id                         INTEGER REFERENCES mod_uch_cpravka.orders (id) ON DELETE CASCADE,

  series_of_ref                    VARCHAR(355) NULL,
  num_of_ref                       VARCHAR(355) NULL,
  date_of_issue_of_ref             Date NULL

);

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
  reference_id INTEGER REFERENCES mod_uch_cpravka.references (id)
);

CREATE TABLE mod_uch_cpravka.bosses (
  id                     serial PRIMARY KEY,
  provost                VARCHAR(355) NOT NULL, -- проректор
  director_of_the_branch VARCHAR(355) NOT NULL,
  dean                   VARCHAR(355) NOT NULL,
  secretary              VARCHAR(355) NOT NULL,
  author_id              INTEGER REFERENCES mod_uch_cpravka.auth_user (id)
  -- something to be added
);

CREATE TABLE mod_uch_cpravka.student_queries(
    id            serial PRIMARY KEY,
    name          VARCHAR(355) NOT NULL,
    branch_of_bsu VARCHAR(355) NOT NULL,
    faculty       VARCHAR(355) NOT NULL,
    level         VARCHAR(355) NOT NULL,
    speciality    VARCHAR(355) NOT NULL,
    profile       VARCHAR(355) NOT NULL
);

INSERT INTO mod_students.student_queries (name, faculty_id, speciality, subspecialty,branch_of_bsu_id,education_program_id)
VALUES ('Рафюлин Ринад Тольбютряевич', 1, 'Урановая добыча', 'Something1132', 1, 1);

Select
sq.faculty,
dep.department
from
 mod_students.student_queries as sq,
 mod_students.departments_of_bsu as dep
where dep.id = sq.faculty;


--  Таблица для справки с места  --------------------------------------------------------------------------------------
CREATE TABLE mod_uch_cpravka.references2 (
  id                 serial PRIMARY KEY,
  first_name         VARCHAR(355) NOT NULL,
  name               VARCHAR(355) NOT NULL,
  last_name          VARCHAR(355) NOT NULL,
  course             INTEGER      NOT NULL,
  faculty_id         INTEGER REFERENCES mod_uch_cpravka.departments_of_bsu (id),
  date_of_order      Date         NULL,
  number_of_order    VARCHAR(355) NULL,
  start_date         Date         NULL,
  end_date           Date         NULL,
  quantity           INTEGER      NOT NULL,
  type_id            INTEGER REFERENCES mod_uch_cpravka.type_of_ref2 (id)
);




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

CREATE table mod_uch_cpravka.faculty_for_user(
  id serial PRIMARY KEY,
  auth_user INTEGER REFERENCES mod_uch_cpravka.auth_user (id),
  faculty INTEGER REFERENCES mod_uch_cpravka.departments_of_bsu (id)
);