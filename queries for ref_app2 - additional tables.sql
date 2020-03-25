CREATE TABLE mod_uch_cpravka.departments_of_bsu (
  id         serial PRIMARY KEY,
  department VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.departments_of_bsu (department)
VALUES ('Институт истории и государственного управления'),
       ('Институт права'),
       ('Институт экономики, финансов и бизнеса'),
       ('Институт непрерывного образования'),
       ('Физико-технический институт'),
       ('Биологический факультет'),
       ('Географический факультет'),
       ('Инженерный факультет'),
       ('Факультет башкирской филологии, востоковедения и журналистики'),
       ('Факультет математики и информационных технологий'),
       ('Факультет психологии'),
       ('Факультет романо-германской филологии'),
       ('Факультет философии и социологии'),
       ('Филологический факультет'),
       ('Химический факультет'),
       ('Малая академия государственного управления'),
       ('Колледж БашГУ');


CREATE TABLE mod_uch_cpravka.former_education_doc (
  id       serial PRIMARY KEY,
  document VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.former_education_doc (document)
VALUES ('Аттестат об основном общем образовании'),
       ('Аттестат об основном общем образовании с отличием'),
       ('Аттестат о среднем общем образовании'),
       ('Аттестат о среднем общем образовании с отличием'),
       ('Диплом о среднем профессиональном образовании'),
       ('Диплом о среднем профессиональном образовании с отличием'),
       ('Диплом о высшем профессиональном образовании'),
       ('Диплом бакалавра'),
       ('Диплом бакалавра с отличием'),
       ('Диплом специалиста'),
       ('Диплом специалиста с отличием'),
       ('Диплом магистра'),
       ('Диплом магистра с отличием'),
       ('Диплом об окончании аспирантуры');


CREATE TABLE mod_uch_cpravka.student_status (
  id     serial PRIMARY KEY,
  status VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.student_status (status)
VALUES ('обучающийся'),
       ('отчислен');


CREATE TABLE mod_uch_cpravka.branch_of_bsu (
  id     serial PRIMARY KEY,
  branch VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.branch_of_bsu (branch)
VALUES ('Стерлитамакский филиал БашГУ'),
       ('Бирский филиал БашГУ'),
       ('Сибайский институт (филиал) БашГУ'),
       ('Нефтекамский филиал БашГУ'),
       ('X');

CREATE TABLE mod_uch_cpravka.type_of_education (
  id   serial PRIMARY KEY,
  type VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.type_of_education (type)
VALUES ('профессиональное образование'),
       ('дополнительное профессиональное образование');

CREATE TABLE mod_uch_cpravka.level_of_education (
  id    serial PRIMARY KEY,
  level VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.level_of_education (level)
VALUES ('среднее профессиональное образование'),
       ('высшее образование – бакалавриат'),
       ('высшее образование – специалитет, магистратура'),
       ('высшее образование – подготовка кадров высшей квалификации'),
       ('X (ДПО)');


CREATE TABLE mod_uch_cpravka.education_program (
  id      serial PRIMARY KEY,
  program VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.education_program (program)
VALUES ('образовательная программа среднего профессионального образования – программа подготовки квалифицированных рабочих, служащих'),
       ('образовательная программа среднего профессионального образования – программа подготовки специалистов среднего звена'),
       ('образовательная программа высшего образования – программа бакалавриата'),
       ('образовательная программа высшего образования – программа специалитета'),
       ('образовательная программа высшего образования – программа магистратуры'),
       ('образовательная программа высшего образования – программа подготовки научно-педагогических кадров в аспирантуре'),
       ('дополнительная профессиональная программа – программа профессиональной переподготовки'),
       ('дополнительная профессиональная программа – программа повышения квалификации');


CREATE TABLE mod_uch_cpravka.duration_of_education (
  id       serial PRIMARY KEY,
  duration VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.duration_of_education (duration)
VALUES ('1 год 10 месяцев (СПО)'),
       ('2 года 10 месяцев (СПО)'),
       ('4 года (бакалавриат)'),
       ('5 лет (специалитет)'),
       ('2 года (магистратура)'),
       ('3 года (аспирантура)'),
       ('X (ДПО)');


CREATE TABLE mod_uch_cpravka.form_of_study (
  id   serial PRIMARY KEY,
  form VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.form_of_study (form)
VALUES ('очная'),
       ('заочная'),
       ('очно-заочная');


CREATE TABLE mod_uch_cpravka.fast_education_or_not (
  id          serial PRIMARY KEY,
  fast_or_not VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.fast_education_or_not (fast_or_not)
VALUES ('да'),
       ('нет');


CREATE TABLE mod_uch_cpravka.base_of_study (
  id   serial PRIMARY KEY,
  base VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.base_of_study (base)
VALUES ('за счет бюджетных ассигнований федерального бюджета'),
       ('за счет средств физических и (или) юридических лиц по договорам об образовании');


CREATE TABLE mod_uch_cpravka.type_of_order_of_completion (
  id   serial PRIMARY KEY,
  type VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.type_of_order_of_completion (type)
VALUES ('в соответствии с приказом БашГУ'),
       ('в соответствии с приказом БашГУ (в порядке перевода)');








CREATE TABLE mod_uch_cpravka.type_of_order_of_beginning (
  id   serial PRIMARY KEY,
  type VARCHAR(355) NOT NULL
);
INSERT INTO mod_uch_cpravka.type_of_order_of_beginning (type)
VALUES ('в порядке приема, приказ БашГУ'),
       ('в порядке перевода из');




-- CREATE TABLE mod_uch_cpravka.accepted_to_bsu (
--   id   serial PRIMARY KEY,
--   item VARCHAR(355) NOT NULL
-- );
-- INSERT INTO mod_uch_cpravka.accepted_to_bsu (item)
-- VALUES ('в порядке приема, приказ БашГУ'),
--        ('в порядке перевода из');