SELECT DISTINCT st.gid                                              as id,
                st.name ||' '|| st.secondname ||' '|| st.fathername as Student,
                st.birth_date                                       as Birthday,
                ed.document_name                                    as Former_education_doc,
                stud.zachislen_date                                 as Beginning_date_of_education,
                stud.otchislen_date                                 as Date_of_completion_of_education,
                vex.srok_year_id                                    as Duration_of_education,
                spec.speciality                                     as Speciality,
                prof.name                                           as Subspecialty,
--
                form.sname                                          as base_of_study,
                status.name                                         as status_of_student,
                uch_fromstudy.name                                  as form_of_study,
                pure.name                                           as faculty,
                pure2.name                                          as base_university,
                qualification.education_level_name                  as qualification


from mod_students.student st,
     mod_students.study stud,
     mod_students.education_document ed,
     mod_students.vext_facultet_qualification_speciality_profile vex,
     mod_uch_plan.profile prof,
     mod_uch_plan.speciality spec,
     mod_students.form_funding form,
     mod_students.stud_status status,
     mod_uch_plan.formstady uch_fromstudy,
     mod_students.vext_org_structure_pure pure,
     mod_students.vext_org_structure_pure pure2,
     mod_students.vext_qualification qualification

where st.gid = stud.student_gid
  and ed.student_gid = st.gid
  and vex.profile_gid = stud.profile_gid
  and vex.specialty_guid = stud.speciality_gid
  and vex.qualification_id = stud.qualification_id
  and vex.formstudy_guid = stud.form_study
  and vex.facultet_guid = stud.facultet_gid
  and stud.speciality_gid = spec.guid
  and prof.gid = stud.profile_gid
  and spec.guid = stud.speciality_gid
  and stud.forma_finansirovaniya = form.code
  and stud.status = status.code
  and stud.form_study = uch_fromstudy.guid
  and stud.facultet_gid = pure.gid
  and pure.parent_gid = pure2.gid
  and qualification.id = stud.qualification_id;

-- запрос для 2й таблицы references

SELECT st.gid                                              as id,
       st.name ||' '|| st.secondname ||' '|| st.fathername as Student,
       prac.name                                           as data,
       'practice'                                          as Ind
from mod_students.student st,
     mod_students.study stud,
     mod_students.uch_control_uspevaemosti_tema_cursovoi essay,
     mod_students.praktiki prac
where st.gid = stud.student_gid
  and essay.study_gid = stud.gid
  and prac.profile_gid = stud.profile_gid
UNION
SELECT st.gid                                              as id,
       st.name ||' '|| st.secondname ||' '|| st.fathername as Student,
       essay.tema_cursovoi                                 as data,
       'essay'                                             as Ind
from mod_students.student st,
     mod_students.study stud,
     mod_students.uch_control_uspevaemosti_tema_cursovoi essay
where st.gid = stud.student_gid
  and essay.study_gid = stud.gid
UNION
SELECT st.gid                                              as id,
       st.name ||' '|| st.secondname ||' '|| st.fathername as Student,
       gg.name                                             as data,
       'state exam'                                        as Ind
from mod_students.student st,
     mod_students.study stud,
     mod_students.gek_and_gak gg,
     mod_students.type_gek_and_gak type_gg,
     mod_students.zachetka_ocenki ocenki,
     mod_students.uch_control_uspevaemosti_discipline tutu
where st.gid = stud.student_gid
  and stud.gid = ocenki.study_gid
  and ocenki.uch_control_uspevaemosti_discipline_gid = tutu.gid
  and tutu.discipline_gid = gg.gid
  and gg.type = type_gg.gid
  and type_gg.gid = '587cafac-b9dc-11e1-872a-e3ec68149dfb';

-- поиск оценок

SELECT st.gid                                               as id,
       st.name ||' '|| st.secondname ||' '|| st.fathername  as Student,
       rat.name                                             as mark,
       dis.name                                             as name,
       course.c                                             as course,
       control.uch_control_uspevaemosti_type_code           as semester,
       control_dis.cnt_hour                                 as hours,
       ROUND(cast(control_dis.cnt_hour / 36 as numeric), 2) as credit

from mod_students.student st,
     mod_students.study stud,
     mod_students.zachetka_ocenki marks,
     mod_students.uch_control_uspevaemosti_discipline control_dis,
     mod_students.uch_control_uspevaemosti control,
     mod_students.rating rat,
     mod_students.vext_discipline dis,
     mod_students.tmp_course course

where st.gid = stud.student_gid
  and stud.gid = marks.study_gid
  and marks.uch_control_uspevaemosti_discipline_gid = control_dis.gid
  and marks.rating_code = rat.code
  and control_dis.discipline_gid = dis.gid
  and course.gid = control_dis.course_gid
  and control.gid = control_dis.uch_control_uspevaemosti_gid
  and rat.name != 'Неявка'
  and rat.name != 'Недопуск'
  and rat.name != 'Академический отпуск'
  and rat.name != 'Имеет отсрочку';

-----------------------------------------------------------------------------------------------------------------------
--------- Далее идет реализация представлений -------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

DROP VIEW mod_students.dismissed_students;
CREATE OR REPLACE VIEW mod_students.dismissed_students(
    id,
    Student,
    Birthday,
    Former_education_doc,
    Beginning_date_of_education,
    Date_of_completion_of_education,
    Duration_of_education,
    Speciality,
    Subspecialty,

    base_of_study,
    status_of_student,
    form_of_study,
    faculty,
    base_university,
    level_of_education,
    education_program,

    type_of_order_of_beginning,
    date_of_order_of_beginning,
    number_of_order_of_beginning


)
AS
SELECT DISTINCT st.gid                                                  as id,
                st.secondname || ' ' || st.name || ' ' || st.fathername as Student,
                st.birth_date                                           as Birthday,
                ed.document_name                                        as Former_education_doc,
                stud.zachislen_date                                     as Beginning_date_of_education,
                stud.otchislen_date                                     as Date_of_completion_of_education,
                    CASE qualification.education_level_name
                      When 'Аспирантура' THEN '4 года (аспирантура)'
                      When 'Бакалавриат' THEN '4 года (бакалавриат)'
                      When 'Бакалавриат (прикл.)' THEN '4 года (бакалавриат)'
                      When 'Магистратура' THEN '2 года (магистратура)'
                      When 'Специалитет' THEN '5 лет (специалитет)'
                      else ''
                        END                                             as Duration_of_education,
--                     vex.srok_year_id                                    as Duration_of_education,

--                     '[' || spec.code_speciality::varchar || '] - ' || spec.speciality::varchar as Speciality,
                    '[' || spec.code_speciality::varchar || '] - ' || spec.speciality as Speciality,
--                     '[' || spec.code_speciality::varchar || ']-' || spec.meta_pokolenie::varchar || ' - ' || spec.speciality as Speciality,  до исправления - с номером
                    prof.name                                           as Subspecialty,
--
                    CASE form.sname
                      WHEN 'Договор' then 'за счет средств физических и (или) юридических лиц по договорам об образовании'
                      WHEN 'Бюджет' then 'за счет бюджетных ассигнований федерального бюджета'
                      ELSE ''
                        END                                             as base_of_study,
--                     status.name                                         as status_of_student,
                    status.name                                         as status_of_student,
                    uch_fromstudy.name                                  as form_of_study,
                    pure.name                                           as faculty,
                    CASE pure2.name
                      When 'Башкирский государственный университет' THEN 'X'
                      else pure2.name
                        END                                             as base_university,
                    CASE qualification.education_level_name
                      When 'Аспирантура' THEN 'высшее образование – подготовка кадров высшей квалификации'
                      When 'Бакалавриат' THEN 'высшее образование – бакалавриат'
                      When 'Бакалавриат (прикл.)' THEN 'высшее образование – бакалавриат'
                      When 'Магистратура' THEN 'высшее образование – специалитет, магистратура'
                      When 'Специалитет' THEN 'высшее образование – специалитет, магистратура'
                      When 'СПО' THEN 'среднее профессиональное образование'
                      else 'X (ДПО)'
                        END                                             as level_of_education,
                    CASE qualification.education_level_name
                      When 'Аспирантура'
                              THEN 'образовательная программа высшего образования – программа подготовки научно-педагогических кадров в аспирантуре'
                      When 'Бакалавриат' THEN 'образовательная программа высшего образования – программа бакалавриата'
                      When 'Бакалавриат (прикл.)'
                              THEN 'образовательная программа высшего образования – программа бакалавриата'
                      When 'Магистратура' THEN 'образовательная программа высшего образования – программа магистратуры'
                      When 'Специалитет' THEN 'образовательная программа высшего образования – программа специалитета'
                        --                       When 'СПО' THEN 'среднее профессиональное образование'
                      else ''
                        END                                             as education_program,

                case stud.zachislenie_type
                    when 3 then 'в порядке перевода из'
                        else 'в порядке приема, приказ БашГУ' END as type_of_order_of_beginning,
                stud.zachislen_date as date_of_order_of_beginning,
                stud.prikaz_zachislen as number_of_order_of_beginning



    from mod_students.student st,
         mod_students.study stud,
         mod_students.education_document ed,
         mod_students.vext_facultet_qualification_speciality_profile vex,
         mod_uch_plan.profile prof,
         mod_uch_plan.speciality spec,
         mod_students.form_funding form,
         mod_students.stud_status status,
         mod_uch_plan.formstady uch_fromstudy,
         mod_students.vext_org_structure_pure pure,
         mod_students.vext_org_structure_pure pure2,
         mod_students.vext_qualification qualification
--          mod_students.student left join mod_students.education_document on mod_students.education_document.student_gid = mod_students.student.gid

    where st.gid = stud.student_gid
--       and ed.student_gid is null
      and ed.student_gid = st.gid
--       and (ed.student_gid = st.gid or (ed.student_gid is null))
      and vex.profile_gid = stud.profile_gid -- vex
      and vex.specialty_guid = stud.speciality_gid -- vex
      and vex.qualification_id = stud.qualification_id -- vex
      and vex.formstudy_guid = stud.form_study -- vex
      and vex.facultet_guid = stud.facultet_gid -- vex
      and stud.speciality_gid = spec.guid  -- повтор?
      and prof.gid = stud.profile_gid
      and spec.guid = stud.speciality_gid  -- повтор?
      and stud.forma_finansirovaniya = form.code
      and stud.status = status.code
      and stud.form_study = uch_fromstudy.guid
      and stud.facultet_gid = pure.gid
      and pure.parent_gid = pure2.gid
      and qualification.id = stud.qualification_id;


CREATE OR REPLACE VIEW mod_students.additional_info(
    id,
    Student,
    data,
    Ind,

    mark,
    hours
)

  as

SELECT st.gid                                                  as id,
       st.name || ' ' || st.secondname || ' ' || st.fathername as Student,
       prac.name                                               as data,
       'practice'                                              as Ind,

       'x'                                                     as mark,
       'x'                                                     as hours

    from mod_students.student st,
         mod_students.study stud,
         mod_students.uch_control_uspevaemosti_tema_cursovoi essay,
         mod_students.praktiki prac
    where st.gid = stud.student_gid
      and essay.study_gid = stud.gid
      and prac.profile_gid = stud.profile_gid
    UNION
    SELECT st.gid                                                  as id,
           st.name || ' ' || st.secondname || ' ' || st.fathername as Student,
           essay.tema_cursovoi                                     as data,
           'essay'                                                 as Ind,

           'x'                                                     as mark,
           'x'                                                     as hours

    from mod_students.student st,
         mod_students.study stud,
         mod_students.uch_control_uspevaemosti_tema_cursovoi essay
    where st.gid = stud.student_gid
      and essay.study_gid = stud.gid
    UNION
    SELECT st.gid                                                  as id,
           st.name || ' ' || st.secondname || ' ' || st.fathername as Student,
           gg.name                                                 as data,
           'state exam'                                            as Ind,

           'x'                                                     as mark,
           'x'                                                     as hours
    from mod_students.student st,
         mod_students.study stud,
         mod_students.gek_and_gak gg,
         mod_students.type_gek_and_gak type_gg,
         mod_students.zachetka_ocenki ocenki,
         mod_students.uch_control_uspevaemosti_discipline tutu
    where st.gid = stud.student_gid
      and stud.gid = ocenki.study_gid
      and ocenki.uch_control_uspevaemosti_discipline_gid = tutu.gid
      and tutu.discipline_gid = gg.gid
      and gg.type = type_gg.gid
      and type_gg.gid = '587cafac-b9dc-11e1-872a-e3ec68149dfb';


CREATE OR REPLACE VIEW mod_students.marks (
    id,
    Student,
    mark,
    name,
    course,
    semester,
    hours,
    credit
) as
  SELECT st.gid                                               as id,
         st.name ||' '|| st.secondname ||' '|| st.fathername  as Student,
         rat.name                                             as mark,
         dis.name                                             as name,
         course.c                                             as course,
         control.uch_control_uspevaemosti_type_code           as semester,
         control_dis.cnt_hour                                 as hours,
         ROUND(cast(control_dis.cnt_hour / 36 as numeric), 2) as credit

  from mod_students.student st,
       mod_students.study stud,
       mod_students.zachetka_ocenki marks,
       mod_students.uch_control_uspevaemosti_discipline control_dis,
       mod_students.uch_control_uspevaemosti control,
       mod_students.rating rat,
       mod_students.vext_discipline dis,
       mod_students.tmp_course course

  where st.gid = stud.student_gid
    and stud.gid = marks.study_gid
    and marks.uch_control_uspevaemosti_discipline_gid = control_dis.gid
    and marks.rating_code = rat.code
    and control_dis.discipline_gid = dis.gid
    and course.gid = control_dis.course_gid
    and control.gid = control_dis.uch_control_uspevaemosti_gid
    and rat.name != 'Неявка'
    and rat.name != 'Недопуск'
    and rat.name != 'Академический отпуск'
    and rat.name != 'Имеет отсрочку';

-- конец реализации представлений -------------------------------------------------------------------------------------

