SELECT DISTINCT st.gid                                                  as id,
                st.secondname || ' ' || st.name || ' ' || st.fathername as Student,
                st.birth_date                                           as Birthday,
                ed.document_name                                        as Former_education_doc,
                stud.zachislen_date                                     as Beginning_date_of_education
--                 stud.otchislen_date                                     as Date_of_completion_of_education,
--                     CASE qualification.education_level_name
--                       When 'Аспирантура' THEN '4 года (аспирантура)'
--                       When 'Бакалавриат' THEN '4 года (бакалавриат)'
--                       When 'Бакалавриат (прикл.)' THEN '4 года (бакалавриат)'
--                       When 'Магистратура' THEN '2 года (магистратура)'
--                       When 'Специалитет' THEN '5 лет (специалитет)'
--                       else ''
--                         END                                             as Duration_of_education,
-- --                     vex.srok_year_id                                    as Duration_of_education,
--
-- --                     '[' || spec.code_speciality::varchar || '] - ' || spec.speciality::varchar as Speciality,
--                     '[' || spec.code_speciality::varchar || '] - ' || spec.speciality as Speciality,
-- --                     '[' || spec.code_speciality::varchar || ']-' || spec.meta_pokolenie::varchar || ' - ' || spec.speciality as Speciality,  до исправления - с номером
--                     prof.name                                           as Subspecialty,
-- --
--                     CASE form.sname
--                       WHEN 'Договор' then 'за счет средств физических и (или) юридических лиц по договорам об образовании'
--                       WHEN 'Бюджет' then 'за счет бюджетных ассигнований федерального бюджета'
--                       ELSE ''
--                         END                                             as base_of_study,
-- --                     status.name                                         as status_of_student,
--                     status.name                                         as status_of_student,
--                     uch_fromstudy.name                                  as form_of_study,
--                     pure.name                                           as faculty,
--                     CASE pure2.name
--                       When 'Башкирский государственный университет' THEN 'X'
--                       else pure2.name
--                         END                                             as base_university,
--                     CASE qualification.education_level_name
--                       When 'Аспирантура' THEN 'высшее образование – подготовка кадров высшей квалификации'
--                       When 'Бакалавриат' THEN 'высшее образование – бакалавриат'
--                       When 'Бакалавриат (прикл.)' THEN 'высшее образование – бакалавриат'
--                       When 'Магистратура' THEN 'высшее образование – специалитет, магистратура'
--                       When 'Специалитет' THEN 'высшее образование – специалитет, магистратура'
--                       When 'СПО' THEN 'среднее профессиональное образование'
--                       else 'X (ДПО)'
--                         END                                             as level_of_education,
--                     CASE qualification.education_level_name
--                       When 'Аспирантура'
--                               THEN 'образовательная программа высшего образования – программа подготовки научно-педагогических кадров в аспирантуре'
--                       When 'Бакалавриат' THEN 'образовательная программа высшего образования – программа бакалавриата'
--                       When 'Бакалавриат (прикл.)'
--                               THEN 'образовательная программа высшего образования – программа бакалавриата'
--                       When 'Магистратура' THEN 'образовательная программа высшего образования – программа магистратуры'
--                       When 'Специалитет' THEN 'образовательная программа высшего образования – программа специалитета'
--                         --                       When 'СПО' THEN 'среднее профессиональное образование'
--                       else ''
--                         END                                             as education_program,
--
--                 case stud.zachislenie_type
--                     when 3 then 'в порядке перевода из'
--                         else 'в порядке приема, приказ БашГУ' END as type_of_order_of_beginning,
--                 stud.zachislen_date as date_of_order_of_beginning,
--                 stud.prikaz_zachislen as number_of_order_of_beginning



    from mod_students.student st,
         mod_students.study stud,
         mod_students.education_document ed
--          mod_students.vext_facultet_qualification_speciality_profile vex,
--          mod_uch_plan.profile prof,
--          mod_uch_plan.speciality spec,
--          mod_students.form_funding form,
--          mod_students.stud_status status,
--          mod_uch_plan.formstady uch_fromstudy,
--          mod_students.vext_org_structure_pure pure,
--          mod_students.vext_org_structure_pure pure2,
--          mod_students.vext_qualification qualification

    where st.gid = stud.student_gid
      and ed.student_gid = st.gid
--       and vex.profile_gid = stud.profile_gid
--       and vex.specialty_guid = stud.speciality_gid
--       and vex.qualification_id = stud.qualification_id
--       and vex.formstudy_guid = stud.form_study
--       and vex.facultet_guid = stud.facultet_gid
--       and stud.speciality_gid = spec.guid
--       and prof.gid = stud.profile_gid
--       and spec.guid = stud.speciality_gid
--       and stud.forma_finansirovaniya = form.code
--       and stud.status = status.code
--       and stud.form_study = uch_fromstudy.guid
--       and stud.facultet_gid = pure.gid
--       and pure.parent_gid = pure2.gid
--       and qualification.id = stud.qualification_id
      and st.gid ='{92811234-480F-4C03-92E9-6066B2BA02F8}';