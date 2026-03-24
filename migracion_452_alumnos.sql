-- ============================================================
-- MIGRACIÓN: Importar estudiantes reales desde Excel
-- Primaria: 209 alumnos | Secundaria: 243 alumnos | Total: 452
-- ============================================================

-- PASO 1: Arreglar tabla grados para soportar Primaria Y Secundaria
ALTER TABLE grados DROP CONSTRAINT IF EXISTS grados_nombre_key;
ALTER TABLE grados ADD CONSTRAINT IF NOT EXISTS grados_nombre_nivel_key UNIQUE (nombre, nivel);

-- Insertar grados de secundaria (1° a 5°)
INSERT INTO grados (nombre, nivel, orden) VALUES
  ('1°', 'Secundaria', 7),
  ('2°', 'Secundaria', 8),
  ('3°', 'Secundaria', 9),
  ('4°', 'Secundaria', 10),
  ('5°', 'Secundaria', 11)
ON CONFLICT (nombre, nivel) DO NOTHING;

-- PASO 2: Agregar campo código MINEDU a estudiantes
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS codigo_minedu VARCHAR(20);
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS observacion TEXT;

-- PASO 3: Agregar campos de matrícula que vienen del Excel
ALTER TABLE matriculas ADD COLUMN IF NOT EXISTS estado_matricula VARCHAR(30) DEFAULT 'DEFINITIVA';
ALTER TABLE matriculas ADD COLUMN IF NOT EXISTS tipo_vacante VARCHAR(30);

-- PASO 4: Insertar los 452 estudiantes
-- Usamos DO $$ para manejar duplicados de DNI
DO $$
DECLARE v_est_id INTEGER; v_grado_id INTEGER; v_sec_id INTEGER;
BEGIN

  -- APAZA HUACO, EMILY ROMINA (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('APAZA','HUACO','EMILY ROMINA','91263829','F','2019-04-01','00000091263829',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CALLA HUANCA, ARELY RUTH (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CALLA','HUANCA','ARELY RUTH','91410015','F','2019-07-12','23022510200020',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CARDOSO ARNICA, CHRISTOPHER ALAN (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CARDOSO','ARNICA','CHRISTOPHER ALAN','91538470','M','2019-10-09','23022575500150',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CASTRO APAZA, ALEJANDRA ESTHER ANGELA (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CASTRO','APAZA','ALEJANDRA ESTHER ANGELA','91748426','F','2020-02-27','24145554200100',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCANRE CONDORI, ANYELIS MELANY (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCANRE','CONDORI','ANYELIS MELANY','91476018','F','2019-08-29','23175298900010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAIÑA SILVA, GERALD SMITH (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAIÑA','SILVA','GERALD SMITH','91692770','M','2020-01-22','23022508600250',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CORNEJO HUILLCA, JHOE SAMUEL (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CORNEJO','HUILLCA','JHOE SAMUEL','92947110','M','2019-09-08','23175483700040',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HEREDIA MONTESINOS, EZEQUIEL ALFREDO (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HEREDIA','MONTESINOS','EZEQUIEL ALFREDO','91305222','M','2019-04-24','23089286900180',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- JIMENEZ QUISPE, YOHANNYZ ALESSIA (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('JIMENEZ','QUISPE','YOHANNYZ ALESSIA','91571364','F','2019-11-01','23022551600180',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPE QUISPE, THAISA MASHIELL (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPE','QUISPE','THAISA MASHIELL','91458350','F','2019-08-14','23022575500160',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPE VERA, KAROLAYND (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPE','VERA','KAROLAYND','91353360','F','2019-06-02','23075400200030',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MALLCOHUACCHA CUTIRE, XIOMARA ARLET (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MALLCOHUACCHA','CUTIRE','XIOMARA ARLET','91309723','F','2019-05-05','20242019133905',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDOZA DIAZ, JENKO RAFAEL (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDOZA','DIAZ','JENKO RAFAEL','91717567','M','2020-02-07','23145554200070',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PANCCA QUISPE, CÉSAR AUGUSTO (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PANCCA','QUISPE','CÉSAR AUGUSTO','91744485','M','2020-02-24','23022551600070',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PARIAPAZA MAMANI, YEIKO THAYLOR (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PARIAPAZA','MAMANI','YEIKO THAYLOR','91806486','M','2020-03-21','23161432000010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RODRIGUEZ QUISPE, LUIS SANTIAGO GIUSSEPE (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RODRIGUEZ','QUISPE','LUIS SANTIAGO GIUSSEPE','91693404','M','2020-01-22','23022575500080',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROSAS LIZANA, MELODY IVANNA (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROSAS','LIZANA','MELODY IVANNA','91532743','F','2019-10-03','23022508600290',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SOTO MOSCOSO, THAIZA ASTRID (Primaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SOTO','MOSCOSO','THAIZA ASTRID','91342870','F','2019-05-27','23022575500090',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CAYRO MAQUERA, DANJHEL OSCAR (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CAYRO','MAQUERA','DANJHEL OSCAR','91513516','M','2019-09-01','24022573000050',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHISI GOMEZ, MARIA JESUS (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHISI','GOMEZ','MARIA JESUS','91571665','F','2019-11-01','23022575500070',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHOCCATA HOLGUIN, CAMILA HAILEY (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHOCCATA','HOLGUIN','CAMILA HAILEY','91292504','F','2019-04-24','23133881300010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CUSILAIME APAZA, ELIEL SAID (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CUSILAIME','APAZA','ELIEL SAID','91326990','M','2019-05-14','23022575500200',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- DAHUA CCORAHUA, EDUARDO MATEO ERIC (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('DAHUA','CCORAHUA','EDUARDO MATEO ERIC','91712232','M','2020-02-04','23145554200120',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUILLCA ARAGOTE, JHEYSON GABRIEL (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUILLCA','ARAGOTE','JHEYSON GABRIEL','91493128','M','2019-09-09','23176826600010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ILASACA PAMPA, ADISSON ISAÍ (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ILASACA','PAMPA','ADISSON ISAÍ','91315097','M','2019-05-01','20242019131444',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MADARIAGA YDME, THIAGO VALENTIN (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MADARIAGA','YDME','THIAGO VALENTIN','91624993','M','2019-12-07','23022575500030',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACCO QUISPE, ALICE DÁNAE (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACCO','QUISPE','ALICE DÁNAE','91347607','F','2019-05-28','23022551600240',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PIZARRO VILCAPAZA, JOSHUA EMANUEL (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PIZARRO','VILCAPAZA','JOSHUA EMANUEL','91657607','M','2019-12-30','23022575500060',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUEA BEDOYA, SEGUNDO VALENTINO (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUEA','BEDOYA','SEGUNDO VALENTINO','91666694','M','2020-01-05','23022551600110',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE MAMANI, BRIGUITTE DIANA (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','MAMANI','BRIGUITTE DIANA','91641038','F','2019-12-06','23022568000990',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RAMOS CCOTO, CAMILA NAISHA (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RAMOS','CCOTO','CAMILA NAISHA','91373231','F','2019-06-09','23022575500050',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RIVERA CALCINA, THIAGO JEYKO (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RIVERA','CALCINA','THIAGO JEYKO','91686664','M','2020-01-18','23052398500020',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROA SUCASAIRE, DYLAN ADRIANO (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROA','SUCASAIRE','DYLAN ADRIANO','91774681','M','2020-03-14','24123947400010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RUIZ BRACAMONTE, ENRIQUE RAFAEL (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RUIZ','BRACAMONTE','ENRIQUE RAFAEL','91757364','M','2020-03-04','24022508600190',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEDANO QUISPE, JHON ANDERZON (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEDANO','QUISPE','JHON ANDERZON','80790672','M','2019-07-13','00000080790672',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TIPO PACHA, FABIANA ALESSIA (Primaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TIPO','PACHA','FABIANA ALESSIA','91434130','F','2019-07-30','23089348700180',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALARCON VARGAS, HELIO ZAID (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALARCON','VARGAS','HELIO ZAID','91189284','M','2019-02-17','00000091189284',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- AUQUILLA FONSECA, LUANA CRISTAL (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('AUQUILLA','FONSECA','LUANA CRISTAL','90829887','F','2018-06-12','22072323900198',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- AVILA USKA, LIAM MAEL (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('AVILA','USKA','LIAM MAEL','91042025','M','2018-10-15','00000091042025',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CAMACHO QQUECCAÑO, AILÉN KIMBERLY (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CAMACHO','QQUECCAÑO','AILÉN KIMBERLY','91099470','F','2018-12-14','23123948200010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CANALES ORMACHEA, EMILIA BETSABÉ (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CANALES','ORMACHEA','EMILIA BETSABÉ','90971291','F','2018-08-24','00000090971291',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- COLQUE TUNQUI, VALERIA NATHALY (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('COLQUE','TUNQUI','VALERIA NATHALY','91114071','F','2018-12-27','23022573000050',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CUNO PALOMINO, SUHAIL YEONGSU (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CUNO','PALOMINO','SUHAIL YEONGSU','91245826','F','2019-03-23','00000091245826',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FRISANCHO MEDINA, LUANA KALIESCA (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FRISANCHO','MEDINA','LUANA KALIESCA','90243966','F','2017-05-28','00000090243966',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPEZ MAMANI, MILAN GAEL (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPEZ','MAMANI','MILAN GAEL','91564605','M','2019-01-28','23145554200150',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MACHACA COTRADO, LIZ DANA (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MACHACA','COTRADO','LIZ DANA','91248050','F','2019-03-24','00000091248050',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAQQUERA APAZA, MEREDITH APRIL (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAQQUERA','APAZA','MEREDITH APRIL','90714928','F','2018-04-04','22132783200030',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RIVERA CALCINA, JOSHUA GUSTAVO (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RIVERA','CALCINA','JOSHUA GUSTAVO','90656744','M','2018-02-21','00000090656744',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEDANO QUISPE, YHONIOR (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEDANO','QUISPE','YHONIOR','80790667','M','2017-07-26','21165543000028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TORRES CADENAS, FABIANA NOHELEE (Primaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TORRES','CADENAS','FABIANA NOHELEE','90887365','F','2018-07-29','00000090887365',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ANCCORI CCOLQUE, THAIS ELIETH (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ANCCORI','CCOLQUE','THAIS ELIETH','90884751','F','2018-07-24','20242018132500',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCANSAYA HOLGUIN, FREDY EVERT (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCANSAYA','HOLGUIN','FREDY EVERT','90949615','M','2018-09-05','00000090949615',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- COAQUIRA GUTIERREZ, BRAND EZIO (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('COAQUIRA','GUTIERREZ','BRAND EZIO','90835578','M','2018-06-19','22022575500028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI PUMA, REY DAVID (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','PUMA','REY DAVID','91191726','M','2019-02-15','23145554200020',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HERRERA VENTURA, TAISSA CHRISTHELL (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HERRERA','VENTURA','TAISSA CHRISTHELL','90956976','F','2018-08-23','00000090956976',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN AMANQUI, THIAGO DONATITO (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','AMANQUI','THIAGO DONATITO','90928484','M','2018-08-23','22022575500108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- JARA ZAPATA, LEE JANG DAYIRO (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('JARA','ZAPATA','LEE JANG DAYIRO','90742174','M','2018-04-24','23048661300100',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDOZA LAZARO, JOSHUÉ MANUEL (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDOZA','LAZARO','JOSHUÉ MANUEL','90212355','M','2017-05-09','00000090212355',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RIOS VILCA, ANTONIO THIAGO (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RIOS','VILCA','ANTONIO THIAGO','90874795','M','2018-07-13','00000090874795',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TICAHUANCA MERLIN, MESLY AYDE (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TICAHUANCA','MERLIN','MESLY AYDE','90984544','F','2018-10-01','00000090984544',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VENTURA MACHACA, LIAM ULISES (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VENTURA','MACHACA','LIAM ULISES','90799634','M','2018-05-26','23133881300070',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUCRA HUALLPA, LIZBETH DIANA (Primaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUCRA','HUALLPA','LIZBETH DIANA','91026479','F','2018-10-28','23022575500230',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BARRIENTOS MACHACCA, BRIANA XIOMARA (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BARRIENTOS','MACHACCA','BRIANA XIOMARA','90416988','F','2017-09-08','00000090416988',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CARLOS QUISPE, SEBASTIAN SAUL (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CARLOS','QUISPE','SEBASTIAN SAUL','90207203','M','2017-04-23','00000090207203',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHURA BELIZARIO, ALLISON ARIANA (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHURA','BELIZARIO','ALLISON ARIANA','90704175','F','2018-03-31','22022575500218',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI PACHECO, GAEL SANTOS (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','PACHECO','GAEL SANTOS','90704915','M','2018-03-31','23152885000020',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CORDOVA ALARCON, JAZMIN ALEXSIA (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CORDOVA','ALARCON','JAZMIN ALEXSIA','90697250','F','2018-03-24','21022575500048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- DAVILA HUMPIRI, SERGIO MATEO (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('DAVILA','HUMPIRI','SERGIO MATEO','90429059','M','2017-06-21','00000090429059',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GOMEZ QUISPE, SANTIAGO ALONSO (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GOMEZ','QUISPE','SANTIAGO ALONSO','90453369','M','2017-08-10','21391403700608',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GONZALES APAZA, LUIS FERNANDO (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GONZALES','APAZA','LUIS FERNANDO','90478120','M','2017-11-03','19395687000048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MALLMA MAZA, ANGELA ROMINA (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MALLMA','MAZA','ANGELA ROMINA','90525485','F','2017-11-30','00000090525485',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI ARAPA, ALEXIS DAVID (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','ARAPA','ALEXIS DAVID','90260838','M','2017-06-07','00000090260838',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI JARA, EDMIT MOISES (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','JARA','EDMIT MOISES','90243932','M','2017-05-28','21170577100028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI MACEDO, ERICK ENRIQUE (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','MACEDO','ERICK ENRIQUE','90584697','M','2018-01-14','00000090584697',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ORDOÑEZ CALDERON, BRIDNY ANYELY (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ORDOÑEZ','CALDERON','BRIDNY ANYELY','90294284','F','2017-07-01','21169409000018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PIZANGO GEMAN, LUCIA KATTANIA (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PIZANGO','GEMAN','LUCIA KATTANIA','90241540','F','2017-05-29','21115237000018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE BELIZARIO, DYLAN RODRIGO (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','BELIZARIO','DYLAN RODRIGO','90649467','M','2018-02-06','21103159000258',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROJAS LOPEZ, KENETH YHAMIR (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROJAS','LOPEZ','KENETH YHAMIR','90196369','M','2017-05-01','00000090196369',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VILCA CONDORI, SANTIAGO PATRICIO (Primaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VILCA','CONDORI','SANTIAGO PATRICIO','90561391','M','2017-12-26','00000090561391',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALFERES TOROCAHUA, MATEO RUBEN (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALFERES','TOROCAHUA','MATEO RUBEN','90418476','M','2017-09-14','21022575500018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BERNAL ESPINOZA, ABIGAIL MILENA (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BERNAL','ESPINOZA','ABIGAIL MILENA','90457889','F','2017-10-20','00000090457889',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCACCASACA FOLLANO, LUZ MASHIEL (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCACCASACA','FOLLANO','LUZ MASHIEL','90562326','F','2018-01-02','00000090562326',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CISNEROS ARANDA, FERNANDA ELIZABETH (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CISNEROS','ARANDA','FERNANDA ELIZABETH','90221665','F','2017-05-14','00000090221665',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CRISPIN SULLCARAY, JHOANNA LIZ (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CRISPIN','SULLCARAY','JHOANNA LIZ','81386087','F','2017-09-07','00000081386087',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- DELGADO FLORES, LENA CRISTINE (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('DELGADO','FLORES','LENA CRISTINE','90487864','F','2017-11-05','00000090487864',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAYLLAPUMA BUSTINCIO, DOMINIC LIONEL (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAYLLAPUMA','BUSTINCIO','DOMINIC LIONEL','90207555','M','2017-05-04','00000090207555',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUILLCA VILCA, SALOMON ISAI (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUILLCA','VILCA','SALOMON ISAI','90389917','M','2017-08-16','21022575500078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI JILAJA, CRISTIAN LIONEL (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','JILAJA','CRISTIAN LIONEL','90479331','M','2017-10-11','22170056600030',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI PACCO, DYLAN BENJAMIN (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','PACCO','DYLAN BENJAMIN','90391809','M','2017-08-28','23133859900250',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MIRANDA FERNANDEZ, ZULLY NOEMI (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MIRANDA','FERNANDEZ','ZULLY NOEMI','92572417','F','2017-08-15','22089306500068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACCO LLAMOCA, THAIS SHARUMY (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACCO','LLAMOCA','THAIS SHARUMY','90544034','F','2017-12-15','00000090544034',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE QUISPE, OLIVER LIAN (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','QUISPE','OLIVER LIAN','90213210','M','2017-05-02','00000090213210',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEVILLANOS RODRIGO, ZULEMA THAYSA (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEVILLANOS','RODRIGO','ZULEMA THAYSA','90298627','F','2017-07-05','00000090298627',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SULLCARAY TAIPE, SHEYLA ROSMERI (Primaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SULLCARAY','TAIPE','SHEYLA ROSMERI','81386086','F','2017-07-21','00000081386086',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ANCULLE CAMARGO, MARIA FERNANDA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ANCULLE','CAMARGO','MARIA FERNANDA','79881852','F','2016-09-04','00000079881852',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- APAZA HUACO, ALONDRA SAMIRA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('APAZA','HUACO','ALONDRA SAMIRA','79996790','F','2016-12-24','00000079996790',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CANALES ORMACHEA, DANIELA SOFIA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CANALES','ORMACHEA','DANIELA SOFIA','79562178','F','2016-02-17','00000079562178',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAMBI HUAMAN, EIMY MADELEYNE (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAMBI','HUAMAN','EIMY MADELEYNE','79854920','F','2016-09-14','00000079854920',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHIPA HUAMANI, LUIS DANIEL (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHIPA','HUAMANI','LUIS DANIEL','79734408','M','2016-06-18','21022575500208',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI CARY, ARJEN NALDO (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','CARY','ARJEN NALDO','79816357','M','2016-08-20','20022575500038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI DIAZ, ELIZABETH RIHANA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','DIAZ','ELIZABETH RIHANA','79850175','F','2016-09-13','00000079850175',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CUTI HUILLCA, THIAGO JEAN PIERRE (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CUTI','HUILLCA','THIAGO JEAN PIERRE','79751714','M','2016-06-10','20022575500058',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDOZA LAZARO, JOSHUA CALEB (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDOZA','LAZARO','JOSHUA CALEB','81630580','M','2015-09-01','00000081630580',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACCO CCANCHILLO, ASHLY ANDREA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACCO','CCANCHILLO','ASHLY ANDREA','79979480','F','2016-12-04','00000079979480',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PEÑA VALVERDE, ANAHI AMANDA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PEÑA','VALVERDE','ANAHI AMANDA','79836890','F','2016-09-03','00000079836890',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PONCE BEDOYA, MARIA DEL PILAR ROSANGELA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PONCE','BEDOYA','MARIA DEL PILAR ROSANGELA','79745967','F','2016-07-04','20022575500148',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE VALENCIA, ADRIANA ABIGAIL (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','VALENCIA','ADRIANA ABIGAIL','79710259','F','2016-06-11','00000079710259',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RODRIGUEZ ANCO, KALEB YEREMY JUNIOR (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RODRIGUEZ','ANCO','KALEB YEREMY JUNIOR','79973041','M','2016-11-20','20157567900038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEDANO REGINALDO, JINIA ZOLYMAR (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEDANO','REGINALDO','JINIA ZOLYMAR','79994340','F','2016-12-23','00000079994340',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SULLCA HANCCO, CHRISTIAN SAUL (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SULLCA','HANCCO','CHRISTIAN SAUL','90058648','M','2017-02-03','00000090058648',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- UGARTE SUNE, MILETT LUANA (Primaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('UGARTE','SUNE','MILETT LUANA','90128319','F','2017-03-17','00000090128319',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ACHULLI RODRIGO, VALENTINA CRISTEL (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ACHULLI','RODRIGO','VALENTINA CRISTEL','79705436','F','2016-05-11','21137337200028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ANCCORI CCOLQUE, DAIRA SHANTALE (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ANCCORI','CCOLQUE','DAIRA SHANTALE','79898105','F','2016-10-12','00000079898105',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHOQUEHUANCA SUMIRE, JHOSEP ALEXANDER (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHOQUEHUANCA','SUMIRE','JHOSEP ALEXANDER','79864145','M','2016-09-20','00000079864145',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHUMBES SERRANO, YAIR JUNIOR (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHUMBES','SERRANO','YAIR JUNIOR','90981845','M','2017-03-28','00000090981845',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONTRERAS SANTILLANA, BRIANNA VALERIA (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONTRERAS','SANTILLANA','BRIANNA VALERIA','90069728','F','2017-02-02','21072301500078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FAIJO OVANDO, ADELIZ (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FAIJO','OVANDO','ADELIZ','79647699','F','2016-04-26','00000079647699',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GÜERE HUARCA, BERNHARD NEYTAN (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GÜERE','HUARCA','BERNHARD NEYTAN','79884929','M','2016-10-01','00000079884929',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUALLPA MALLMA, THIAGO MATHIAS (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUALLPA','MALLMA','THIAGO MATHIAS','79878370','M','2016-09-28','20244460800078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUANACUNI HUAMAN, ARIANA ASENET (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUANACUNI','HUAMAN','ARIANA ASENET','90058572','F','2017-01-26','21089411300018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MACHACA MAMANI, HABBIE LUANA (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MACHACA','MAMANI','HABBIE LUANA','90059387','F','2017-01-17','00000090059387',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI AGUIRRE, JHON PATRICIO (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','AGUIRRE','JHON PATRICIO','90032168','M','2017-01-10','20022575500108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MIRANDA RODRIGUEZ, IAN ADRIEL KEFREN (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MIRANDA','RODRIGUEZ','IAN ADRIEL KEFREN','90002899','M','2016-12-28','00000090002899',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACHECO RANGEL, JORGE (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACHECO','RANGEL','JORGE','002510532','M','2016-04-07','23055635700050',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PANDIA PARICAHUA, BRYSSNEY MERLYN (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PANDIA','PARICAHUA','BRYSSNEY MERLYN','79648436','F','2016-04-29','00000079648436',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PROVINCIA CHUQUIMAMANI, ESTEBAN GAEL (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PROVINCIA','CHUQUIMAMANI','ESTEBAN GAEL','90001791','M','2016-12-27','00000090001791',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE HOLGUIN, DIEGO JAEL (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','HOLGUIN','DIEGO JAEL','90050322','M','2017-01-28','00000090050322',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUJRA INCACUTIPA, LUIS ANTHONY (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUJRA','INCACUTIPA','LUIS ANTHONY','79783432','M','2016-08-01','21177297900038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ZAMATA LAGOS, ESTEFANY YAMILETT (Primaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ZAMATA','LAGOS','ESTEFANY YAMILETT','79977015','F','2016-11-30','00000079977015',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARCE QUISPE, MIGUEL ANGEL MATEO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARCE','QUISPE','MIGUEL ANGEL MATEO','79487332','M','2016-01-22','00000079487332',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BALBIN AGÜERO, ALIZZ STHEFANI (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BALBIN','AGÜERO','ALIZZ STHEFANI','79252941','F','2015-08-17','00000079252941',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAVEZ CONDORI, CARLOS NARCISO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAVEZ','CONDORI','CARLOS NARCISO','79677980','M','2015-08-13','00000079677980',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI PUMA, NEYMAR WILLIAN (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','PUMA','NEYMAR WILLIAN','79436436','M','2015-12-06','00000079436436',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CORDOVA ALARCON, DALESKA FERNANDA (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CORDOVA','ALARCON','DALESKA FERNANDA','79192119','F','2015-06-22','19022575500048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CORNEJO HUILLCA, SILA DAYANA (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CORNEJO','HUILLCA','SILA DAYANA','90223138','F','2015-09-19','00000090223138',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FIGUEROA GOMEZ, ALEJANDRO SEBASTIAN (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FIGUEROA','GOMEZ','ALEJANDRO SEBASTIAN','81629452','M','2015-05-27','19022575500078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FRISANCHO MEDINA, PABLO ESTEFANO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FRISANCHO','MEDINA','PABLO ESTEFANO','79417320','M','2015-11-26','00000079417320',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HEREDIA MONTESINOS, EDUARDO PAOLO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HEREDIA','MONTESINOS','EDUARDO PAOLO','79426747','M','2015-10-30','00000079426747',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN SILUPU, JOAQUIN ALADINO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','SILUPU','JOAQUIN ALADINO','79141369','M','2015-05-28','00000079141369',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAYHUA CCORAHUA, LIONO ANDRIW SANTIAGO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAYHUA','CCORAHUA','LIONO ANDRIW SANTIAGO','81629231','M','2015-05-17','00000081629231',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDOZA SERRANO, EDDY GABRIEL (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDOZA','SERRANO','EDDY GABRIEL','81648405','M','2014-08-13','18164204000058',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MIRANDA CONDORI, KARELY ROSABEL (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MIRANDA','CONDORI','KARELY ROSABEL','79579451','F','2016-03-20','00000079579451',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PARI CONDORI, JEREMY ALDAIR (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PARI','CONDORI','JEREMY ALDAIR','79336795','M','2015-10-05','19022575500148',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PAZ PERALTA, GINEBRA BRIHANNA (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PAZ','PERALTA','GINEBRA BRIHANNA','79198111','F','2015-06-25','00000079198111',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PONCE BEDOYA, BRIELLA PIERINA (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PONCE','BEDOYA','BRIELLA PIERINA','79085525','F','2015-04-24','19022575500168',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PORTUGAL OVIEDO, ADRIANO FACUNDO (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PORTUGAL','OVIEDO','ADRIANO FACUNDO','79167128','M','2015-06-16','19022575500158',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- POVIS PACCO, LISHA ISABEL (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('POVIS','PACCO','LISHA ISABEL','79275315','F','2015-08-07','19022575500178',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE BELIZARIO, MAYTE ADRIANA (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','BELIZARIO','MAYTE ADRIANA','79550987','F','2016-02-11','19089242200078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE CCALLO, ALIZ ANYELA (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','CCALLO','ALIZ ANYELA','79205443','F','2015-06-02','00000079205443',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TULA SONCCO, ANDREA YHOSELYN (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TULA','SONCCO','ANDREA YHOSELYN','79219530','F','2015-07-24','00000079219530',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VERA HANCCO, MERCEDES KATHERINE (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VERA','HANCCO','MERCEDES KATHERINE','79553072','F','2016-03-03','19022575500218',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUPA QUISPE, ANTHONY FRANCISCO ALEXANDER (Primaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUPA','QUISPE','ANTHONY FRANCISCO ALEXANDER','79489610','M','2016-01-23','00000079489610',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALARCON MATUTE, GABRIEL ANDRE (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALARCON','MATUTE','GABRIEL ANDRE','79094828','M','2015-04-27','19126348200018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARAPA LLAVE, EVELYN KATALEYA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARAPA','LLAVE','EVELYN KATALEYA','81629051','F','2015-05-05','00000081629051',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CABANA PUMA, SILVANA ANDREA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CABANA','PUMA','SILVANA ANDREA','79533533','F','2016-02-11','19161561600018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHIPANA QUISPE, XHAVI ELISON (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHIPANA','QUISPE','XHAVI ELISON','81376057','M','2016-02-18','00000081376057',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI BEJARANO, ADRIANO ANGEL (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','BEJARANO','ADRIANO ANGEL','79505173','M','2016-02-03','00000079505173',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GROVAS PACCO, ABIGAIL MELANY (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GROVAS','PACCO','ABIGAIL MELANY','79458372','F','2016-01-03','00000079458372',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HANCCO APAZA, ANDREE ORLANDO (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HANCCO','APAZA','ANDREE ORLANDO','79087574','M','2015-04-23','19148851900028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUANACUNI HUAMAN, LIAN BENJAMIN (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUANACUNI','HUAMAN','LIAN BENJAMIN','79141962','M','2015-05-29','18144470300068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPE QUISPE, STELLA RISU (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPE','QUISPE','STELLA RISU','79570234','F','2016-03-11','00000079570234',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MORALES AVILES, GINO JHOSMANI (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MORALES','AVILES','GINO JHOSMANI','79131814','M','2015-05-10','21327381600068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MOTTOCCANCHI AYAMAMANI, AXEL GAEL (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MOTTOCCANCHI','AYAMAMANI','AXEL GAEL','79099592','M','2015-05-09','19126348200098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- NAHUE YALLERCCO, BRUNELLA ARLETH (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('NAHUE','YALLERCCO','BRUNELLA ARLETH','81523912','F','2016-02-11','00000081523912',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- OJEDA SALAS, NIKOLAS EZEL (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('OJEDA','SALAS','NIKOLAS EZEL','79312956','M','2015-09-26','00000079312956',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACCO LLAMOCA, FABIAN GADIEL (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACCO','LLAMOCA','FABIAN GADIEL','79599655','M','2016-03-24','00000079599655',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACHECO SANCHEZ, BRYANA MERLYA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACHECO','SANCHEZ','BRYANA MERLYA','79270295','F','2015-08-09','00000079270295',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PERALTA MAMANI, KIARA MILAGROS (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PERALTA','MAMANI','KIARA MILAGROS','79392791','F','2015-11-19','00000079392791',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROQUE TOROCAHUA, MARIANNE FRANCHESCA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROQUE','TOROCAHUA','MARIANNE FRANCHESCA','79243694','F','2015-08-12','21156281800218',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROSAS AGUILAR, YOSELIN CAMILA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROSAS','AGUILAR','YOSELIN CAMILA','79565066','F','2016-03-04','00000079565066',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SALAS BARRIOS, CATHALEYA VALENTINA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SALAS','BARRIOS','CATHALEYA VALENTINA','79537794','F','2016-02-03','20022575500208',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEDANO QUISPE, YOLANDA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEDANO','QUISPE','YOLANDA','80790662','F','2015-08-13','00000080790662',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SONCCO COLQUE, TRISTAN MILAN (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SONCCO','COLQUE','TRISTAN MILAN','79440332','M','2015-12-17','00000079440332',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SOTO LUICHO, THIAGO ANDREII (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SOTO','LUICHO','THIAGO ANDREII','79130726','M','2015-05-01','18208680300018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SULLCARAY TAIPE, DIANA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SULLCARAY','TAIPE','DIANA','81292026','F','2015-05-13','00000081292026',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TITO ALMONTE, INGRID ARACELY (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TITO','ALMONTE','INGRID ARACELY','81639357','F','2015-06-07','00000081639357',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ZAPANA RIVERA, XIOMARA RAFAELA (Primaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ZAPANA','RIVERA','XIOMARA RAFAELA','79725584','F','2016-03-29','19022575500228',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALEJOS COSAR, LIAM SAYCAR (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALEJOS','COSAR','LIAM SAYCAR','78763866','M','2014-08-03','18132154600188',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BARRIOS MENDEZ, MATHEO IGNACIO (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BARRIOS','MENDEZ','MATHEO IGNACIO','115948927','M','2014-11-13','22021929500010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BETANCUR BERROCAL, ERICK JOHAO (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BETANCUR','BERROCAL','ERICK JOHAO','81592131','M','2014-06-02','00000081592131',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CABANA PUMA, ANGEL ARMANDO (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CABANA','PUMA','ANGEL ARMANDO','81594627','M','2014-09-04','00000081594627',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHIPANE PORTILLO, ANTHONY JEIKO (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHIPANE','PORTILLO','ANTHONY JEIKO','81592940','M','2014-07-19','00000081592940',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHUIMA HUAMAN, MARIA ALEJANDRA (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHUIMA','HUAMAN','MARIA ALEJANDRA','81224009','F','2014-09-11','00000081224009',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HACHA CONDORI, JONATHAN MATÍAZ (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HACHA','CONDORI','JONATHAN MATÍAZ','81194877','M','2013-09-14','00000081194877',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUANCA CCAMA, NORICK SEBASTIAN (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUANCA','CCAMA','NORICK SEBASTIAN','81607687','M','2014-12-06','00000081607687',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI MAMANI, MICHELLE SHARMELY (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','MAMANI','MICHELLE SHARMELY','78739807','F','2014-07-17','00000078739807',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MASCO CEREZO, YAMILA FERNANDA (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MASCO','CEREZO','YAMILA FERNANDA','78733856','F','2014-08-24','18022575500108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACCO MENDOZA, HAFID ERICK (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACCO','MENDOZA','HAFID ERICK','79005661','M','2015-03-03','18022575500138',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACHA MEDINA, LUCIANA GUADALUPE (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACHA','MEDINA','LUCIANA GUADALUPE','81592868','F','2014-07-23','19022508600038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACO ZUÑIGA, DANILO JOSÉ (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACO','ZUÑIGA','DANILO JOSÉ','79024345','M','2015-03-19','00000079024345',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PEÑA VALVERDE, LEYDI YANIRA (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PEÑA','VALVERDE','LEYDI YANIRA','78916158','F','2014-12-18','18126236900048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROQUE CCORAHUA, BRITHANI VALERIA (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROQUE','CCORAHUA','BRITHANI VALERIA','78747362','F','2014-08-30','00000078747362',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TARIFA SURCO, FLOR KARELY (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TARIFA','SURCO','FLOR KARELY','81630667','F','2014-09-27','00000081630667',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VALDIVIA CHUQUITAYPE, DAYRON HENRRY (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VALDIVIA','CHUQUITAYPE','DAYRON HENRRY','78211225','M','2013-07-22','17022575500158',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUPANQUI MAMANI, JUDITH KATIA (Primaria 6°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUPANQUI','MAMANI','JUDITH KATIA','79030875','F','2015-03-21','18022575500208',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- APFATA BUSTINCIO, ROY BENJAMIN (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('APFATA','BUSTINCIO','ROY BENJAMIN','81603582','M','2014-12-01','00000081603582',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BORJA VARGAS, GIOVANNI ELAR (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BORJA','VARGAS','GIOVANNI ELAR','78710269','M','2014-08-08','00000078710269',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAMPI CUTIRE, JHORDAN ALDAIR (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAMPI','CUTIRE','JHORDAN ALDAIR','81594820','M','2014-10-03','00000081594820',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ESPINOZA BETANCUR, MAX JOSUÉ (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ESPINOZA','BETANCUR','MAX JOSUÉ','78985024','M','2015-02-15','18136435500118',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HERRERA VENTURA, VALENTINA JAZMIN (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HERRERA','VENTURA','VALENTINA JAZMIN','78774815','F','2014-08-15','00000078774815',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUARMIYURI SILVA, ALEXIS ADRIANO (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUARMIYURI','SILVA','ALEXIS ADRIANO','79137760','M','2015-01-22','00000079137760',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LAURA ADRIAN, PRISCILA (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LAURA','ADRIAN','PRISCILA','81550127','F','2014-06-13','20022575500218',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPEZ MAMANI, ANGEL URIEL (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPEZ','MAMANI','ANGEL URIEL','78862650','M','2013-08-05','00000078862650',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI CCANSAYA, GARET NEYMAR (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','CCANSAYA','GARET NEYMAR','78601988','M','2014-05-20','19175298900098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAYTA MACHACCA, SOELENG GEORGHET (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAYTA','MACHACCA','SOELENG GEORGHET','81594240','F','2014-07-24','00000081594240',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SOLORZANO SAMATA, LEYDI YOELINA (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SOLORZANO','SAMATA','LEYDI YOELINA','78586368','F','2014-04-29','00000078586368',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TINOCO CALCINA, MIGUEL ALBERTO (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TINOCO','CALCINA','MIGUEL ALBERTO','81594436','M','2014-06-26','00000081594436',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- UTURUNCO INQUILLAY, ROGER (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('UTURUNCO','INQUILLAY','ROGER','79063886','M','2014-04-30','00000079063886',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VALENCIA MALLMA, LIAM RAFAEL (Primaria 6°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VALENCIA','MALLMA','LIAM RAFAEL','78731961','M','2014-08-25','00000078731961',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='6°' AND nivel='Primaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALANIA VICHATA, DAYIRO ALEXIS (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALANIA','VICHATA','DAYIRO ALEXIS','63153927','M','2013-07-21','00000063153927',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- AVILA USKA, ARIANA GUADALUPE (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('AVILA','USKA','ARIANA GUADALUPE','81228111','F','2013-08-19','00000081228111',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BORDA CALSINA, RAFAEL YASMANI (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BORDA','CALSINA','RAFAEL YASMANI','78478089','M','2014-03-04','16011434400028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CALCINA NOA, KIARA MAYTE (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CALCINA','NOA','KIARA MAYTE','78081538','F','2013-04-11','00000078081538',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAVEZ MAMANI, ABAD ALAIN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAVEZ','MAMANI','ABAD ALAIN','78292861','M','2013-08-20','00000078292861',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHILE QUISPE, WILLY RODRIGO (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHILE','QUISPE','WILLY RODRIGO','78352131','M','2013-12-03','00000078352131',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHOQUEMAQUE COLQUE, EBANDRO YONATHAN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHOQUEMAQUE','COLQUE','EBANDRO YONATHAN','78329575','M','2013-10-25','00000078329575',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHUMBES DEVERA, ANDY JOSHUA (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHUMBES','DEVERA','ANDY JOSHUA','63073431','M','2013-06-22','00000063073431',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI DIAZ, THIAGO MYLAN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','DIAZ','THIAGO MYLAN','81196156','M','2013-10-03','00000081196156',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GÜERE HUARCA, ANGELO EMANUEL (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GÜERE','HUARCA','ANGELO EMANUEL','78435507','M','2014-01-29','00000078435507',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN AGUIRRE, JORGE ERASMO (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','AGUIRRE','JORGE ERASMO','81228357','M','2013-07-26','17022575500058',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN MENDEZ, ROYER YENKO (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','MENDEZ','ROYER YENKO','78211766','M','2013-06-19','18171288400018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAYCANI CALISAYA, GUSTAVO ALEJANDRO (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAYCANI','CALISAYA','GUSTAVO ALEJANDRO','78511532','M','2014-03-24','18074425000158',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ILASACA PAMPA, MILAGROS ESPERANZA (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ILASACA','PAMPA','MILAGROS ESPERANZA','78305980','F','2013-06-02','00000078305980',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MUÑA TOROCAHUA, DILAND ANDREE (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MUÑA','TOROCAHUA','DILAND ANDREE','81118551','M','2013-04-26','00000081118551',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- OVIEDO CASAZOLA, FABIANA DAYNÉ (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('OVIEDO','CASAZOLA','FABIANA DAYNÉ','81197024','F','2013-10-11','00000081197024',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PANDIA QUISPE, AMY (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PANDIA','QUISPE','AMY','78440075','F','2014-01-16','00000078440075',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PIZARRO VILCAPAZA, ADRIANO JOAQUIN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PIZARRO','VILCAPAZA','ADRIANO JOAQUIN','78263838','M','2013-09-10','17126348200098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SALHUA CCOROPUNA, DIEGO SEBASTIAN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SALHUA','CCOROPUNA','DIEGO SEBASTIAN','78235058','M','2013-07-07','00000078235058',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEDANO QUISPE, WILIAN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEDANO','QUISPE','WILIAN','78392718','M','2013-12-22','00000078392718',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SONCCO CALCINA, FLOR MARILY (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SONCCO','CALCINA','FLOR MARILY','78153451','F','2013-05-27','00000078153451',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TAIPE DIAZ, ALANIS DASHA (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TAIPE','DIAZ','ALANIS DASHA','81228148','F','2013-09-01','17022575500138',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TORRES LUQUE, FIORELA YESENIA (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TORRES','LUQUE','FIORELA YESENIA','78420925','F','2014-01-22','00000078420925',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TULA MAMANI, FRANCO AARON (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TULA','MAMANI','FRANCO AARON','81539952','M','2014-01-27','00000081539952',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VERA HANCCO, NAYELI MISHELL (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VERA','HANCCO','NAYELI MISHELL','81539445','F','2014-01-22','17022575500188',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YANA RODRIGUEZ, MARIA BELEN (Secundaria 1°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YANA','RODRIGUEZ','MARIA BELEN','78646536','F','2014-02-25','18022575500248',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALEJO GAMARRA, RUTH AYUMI (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALEJO','GAMARRA','RUTH AYUMI','78132929','F','2013-05-18','00000078132929',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- AMANCA TTITO, EDUARDO EFRAIN (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('AMANCA','TTITO','EDUARDO EFRAIN','81560158','M','2013-05-25','17089286900018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BUENDIA MENDOZA, LUCAS JANO (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BUENDIA','MENDOZA','LUCAS JANO','78218966','M','2013-08-10','00000078218966',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCALLO CHINCHERCOMA, JOEL VICTOR (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCALLO','CHINCHERCOMA','JOEL VICTOR','81169449','M','2013-08-17','00000081169449',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHACO BARANDIARAN, YHERIK AUGUSTO YSBAIL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHACO','BARANDIARAN','YHERIK AUGUSTO YSBAIL','78722246','M','2013-02-28','00000078722246',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHIPANA QUISPE, AARON CRHISTIAN ABIERY (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHIPANA','QUISPE','AARON CRHISTIAN ABIERY','80931057','M','2014-01-26','00000080931057',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHOQUECABANA CALLOHUANCA, MILLET IVANA (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHOQUECABANA','CALLOHUANCA','MILLET IVANA','78268274','F','2013-09-03','17022575500028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHUMBES SERRANO, JACK NEYMAR (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHUMBES','SERRANO','JACK NEYMAR','79208199','M','2013-04-14','00000079208199',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- COPARA HUAYNA, NEVENKA JAKELINE (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('COPARA','HUAYNA','NEVENKA JAKELINE','78051687','F','2013-04-04','00000078051687',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- DIAZ TICONA, LUHANA KEYLA (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('DIAZ','TICONA','LUHANA KEYLA','81114430','F','2013-05-05','00000081114430',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUACHO AGUILAR, KELY MARINA (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUACHO','AGUILAR','KELY MARINA','78838410','F','2014-01-21','00000078838410',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- JAEN CUTIPA, CARLOS DANIEL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('JAEN','CUTIPA','CARLOS DANIEL','81539484','M','2014-01-23','00000081539484',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LEON BEDOYA, KENYA KELEEN (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LEON','BEDOYA','KENYA KELEEN','78096942','F','2013-04-02','17022575500078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LUQUE PALOMINO, HANSEL ISMAEL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LUQUE','PALOMINO','HANSEL ISMAEL','81190234','M','2013-12-17','00000081190234',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MARURE MAMANI, ASHLY JAHAIRA (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MARURE','MAMANI','ASHLY JAHAIRA','78492780','F','2014-03-06','18133881300048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDEZ RIVAS, JEANPIERE MAYCOL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDEZ','RIVAS','JEANPIERE MAYCOL','81558691','M','2014-02-28','17126348200058',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACCO CALCINA, NEYMAR RODRIGO (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACCO','CALCINA','NEYMAR RODRIGO','78221020','M','2013-07-27','00000078221020',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PANCCA QUISPE, ORLANDO JESUS (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PANCCA','QUISPE','ORLANDO JESUS','81558783','M','2014-03-02','00000081558783',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PORTUGAL OVIEDO, ARANTZA KEISHLA (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PORTUGAL','OVIEDO','ARANTZA KEISHLA','81194454','F','2013-09-21','17022575500108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE PALACIOS, MIRIAM FERNANDA (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','PALACIOS','MIRIAM FERNANDA','78133506','F','2013-05-24','00000078133506',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RAMOS CUTIRE, DIEGO ARNULFO (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RAMOS','CUTIRE','DIEGO ARNULFO','81540347','M','2014-02-23','00000081540347',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROJO QUISPE, BRITTANY NIKOLE (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROJO','QUISPE','BRITTANY NIKOLE','90187002','F','2013-07-04','00000090187002',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SALAS BARRIOS, BENJAMIN EMANUEL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SALAS','BARRIOS','BENJAMIN EMANUEL','81539239','M','2014-01-14','17089286900098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SANDI BALTA, LUCIANA ANABEL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SANDI','BALTA','LUCIANA ANABEL','78161153','F','2013-06-17','00000078161153',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SEVILLANOS RODRIGO, ADRIANO JOEL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SEVILLANOS','RODRIGO','ADRIANO JOEL','81558831','M','2014-03-05','00000081558831',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TIPULA DIAZ, EMANUEL JORGE (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TIPULA','DIAZ','EMANUEL JORGE','78176027','M','2013-07-12','00000078176027',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VELASQUEZ TULA, FREDY ANGEL (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VELASQUEZ','TULA','FREDY ANGEL','81444212','M','2013-11-04','00000081444212',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VILLAFUERTE POVEA, LIAM NEYMAR (Secundaria 1°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VILLAFUERTE','POVEA','LIAM NEYMAR','90276763','M','2014-02-01','00000090276763',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='1°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ASCENCIOS CCAHUA, DANIEL ELIAS (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ASCENCIOS','CCAHUA','DANIEL ELIAS','81195564','M','2012-10-04','00000081195564',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ASCENCIOS GARCIA, LUIS CARLOS (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ASCENCIOS','GARCIA','LUIS CARLOS','81377787','M','2012-06-10','00000081377787',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BERNAL ESPINOZA, MELANI JULIETA (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BERNAL','ESPINOZA','MELANI JULIETA','62146335','F','2012-09-22','00000062146335',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CARCAUSTO YARICE, NHILA ABIGAIL (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CARCAUSTO','YARICE','NHILA ABIGAIL','63244994','F','2012-05-04','00000063244994',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCOSCCO CEREZO, ANGIE YUDELY (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCOSCCO','CEREZO','ANGIE YUDELY','63533332','F','2012-10-19','00000063533332',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAISA VILCA, YANDY ALICIA (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAISA','VILCA','YANDY ALICIA','81052155','F','2012-11-11','00000081052155',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHIPANE PORTILLO, ANA GRAYLIN (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHIPANE','PORTILLO','ANA GRAYLIN','62819420','F','2011-04-17','15145554200018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CORNEJO HUILLCA, JUAN GABRIEL (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CORNEJO','HUILLCA','JUAN GABRIEL','63535664','M','2012-06-13','16133750000018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FLORES MAMANI, SULLY NAOMI (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FLORES','MAMANI','SULLY NAOMI','81113858','F','2013-03-27','00000081113858',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GARCIA ILLACUTIPA, ARIANA ZAHORY (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GARCIA','ILLACUTIPA','ARIANA ZAHORY','77875829','F','2012-11-13','00000077875829',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GOMEZ QUISPE, FABRIZIO JEDAM (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GOMEZ','QUISPE','FABRIZIO JEDAM','81112330','M','2013-02-09','00000081112330',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMANI CHURATA, ALEXANDRO YEFERSSON (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMANI','CHURATA','ALEXANDRO YEFERSSON','62958658','M','2011-10-03','00000062958658',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- NAHUE LEON, PAMELA MASIEL (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('NAHUE','LEON','PAMELA MASIEL','81093756','F','2012-12-14','16137323200198',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PARI CONDORI, THAYZ KEYRA (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PARI','CONDORI','THAYZ KEYRA','63735811','F','2013-01-02','00000063735811',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PUMA YUPANQUI, CINTIA ANABEL (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PUMA','YUPANQUI','CINTIA ANABEL','81078343','F','2012-10-20','16022575500128',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PUSACLLA VELA, MICAELA (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PUSACLLA','VELA','MICAELA','63429546','F','2012-11-20','00000063429546',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RUIZ ZEVALLOS, ERICK GHAEL (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RUIZ','ZEVALLOS','ERICK GHAEL','63735801','M','2012-12-07','16022575500148',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SALAS MEDINA, GABRIEL MATEO (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SALAS','MEDINA','GABRIEL MATEO','77862645','M','2012-06-25','00000077862645',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SANCHEZ BELTRAN, BRITNEY MELANY (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SANCHEZ','BELTRAN','BRITNEY MELANY','63727904','F','2012-04-11','00000063727904',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SANCHEZ BELTRAN, DANY JHOSHIMAR (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SANCHEZ','BELTRAN','DANY JHOSHIMAR','63727905','M','2012-04-11','00000063727905',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SARMIENTO SARMIENTO, DANIEL STHIPF (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SARMIENTO','SARMIENTO','DANIEL STHIPF','81132770','M','2013-01-05','17089286900148',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SONCCO APAZA, YEAN CARLOS HUBER (Secundaria 2°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SONCCO','APAZA','YEAN CARLOS HUBER','78032709','M','2013-02-23','16022575500168',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BELIZARIO CCALLO, KELLY MASHIEL (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BELIZARIO','CCALLO','KELLY MASHIEL','77653181','F','2012-05-18','16022575500038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'EN PROCESO',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BOZA PORTILLA, DAYIRO BENJAMIN (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BOZA','PORTILLA','DAYIRO BENJAMIN','81063789','M','2012-10-31','00000081063789',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CALLA HUANCA, SERGIO ADOLFO (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CALLA','HUANCA','SERGIO ADOLFO','81047810','M','2012-07-13','00000081047810',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCORAHUA DIAZ, LUIS GABRIEL (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCORAHUA','DIAZ','LUIS GABRIEL','80857111','M','2012-08-24','00000080857111',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCORPUNA TURPO, TANIA NICOL (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCORPUNA','TURPO','TANIA NICOL','80868132','F','2013-03-23','00000080868132',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCOTO CAYANI, MATHIAS JULIAN (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCOTO','CAYANI','MATHIAS JULIAN','80985895','M','2012-10-29','00000080985895',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CENTENO IQUIAPAZA, ZULLY BELLA DULZE (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CENTENO','IQUIAPAZA','ZULLY BELLA DULZE','77824702','F','2012-09-12','00000077824702',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- JAYO HUAHUACONDORI, LUIS FERNANDO (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('JAYO','HUAHUACONDORI','LUIS FERNANDO','77724737','M','2012-06-18','00000077724737',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- KAIRA HUAYTA, LUIS FERNANDO (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('KAIRA','HUAYTA','LUIS FERNANDO','81093190','M','2012-08-13','00000081093190',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPEZ ZUÑIGA, ENDERSON ALEXANDER (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPEZ','ZUÑIGA','ENDERSON ALEXANDER','77886247','M','2012-10-29','00000077886247',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI JARA, ARTUR JHENRRY (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','JARA','ARTUR JHENRRY','77879158','M','2012-11-13','00000077879158',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MEDINA DIAZ, ANGELA GABRIELA (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MEDINA','DIAZ','ANGELA GABRIELA','81093307','F','2012-11-30','00000081093307',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MELO CHILO, LEONEL YORDY (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MELO','CHILO','LEONEL YORDY','81156174','M','2013-02-10','00000081156174',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- OVIEDO CASAZOLA, TATIANA ANDREA (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('OVIEDO','CASAZOLA','TATIANA ANDREA','77728816','F','2012-05-22','16153697800048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'EN PROCESO',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACHA GONZALES, ADRIANO ALBERT YOSIMAR (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACHA','GONZALES','ADRIANO ALBERT YOSIMAR','63232353','M','2012-05-10','00000063232353',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PAPEL HOLGUIN, ABRYL JAMYLET (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PAPEL','HOLGUIN','ABRYL JAMYLET','63244987','F','2012-05-13','00000063244987',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PASTOR MATUTE, JHARETH ANTONELA (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PASTOR','MATUTE','JHARETH ANTONELA','63762206','F','2012-07-24','00000063762206',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE HUAMANI, YEISON HEYNER (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','HUAMANI','YEISON HEYNER','63423127','M','2012-08-08','00000063423127',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RIOS VILCA, ADRIANA BELEN ESTRELLA (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RIOS','VILCA','ADRIANA BELEN ESTRELLA','81094308','F','2013-01-06','00000081094308',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TAMO COAGUILA, LUIS FERNANDO (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TAMO','COAGUILA','LUIS FERNANDO','77759868','M','2012-07-26','00000077759868',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TRUJILLO CORREA, THIAGO LINCOL (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TRUJILLO','CORREA','THIAGO LINCOL','62832079','M','2013-01-19','00000062832079',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- URBINA MAMANI, ESTER ANTONELA (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('URBINA','MAMANI','ESTER ANTONELA','77980612','F','2013-01-28','00000077980612',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'EN PROCESO',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ZAPANA RIVERA, DAYIRO JOSUE (Secundaria 2°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ZAPANA','RIVERA','DAYIRO JOSUE','81094442','M','2012-11-16','16022575500208',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='2°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- AYALA MEZA, BELTSASAR (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('AYALA','MEZA','BELTSASAR','62222818','M','2010-10-05','00000062222818',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCACCASACA FOLLANO, RUTH KAREN (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCACCASACA','FOLLANO','RUTH KAREN','63114715','F','2012-03-16','00000063114715',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAMBI CALDERON, LEYDY MILAGROS (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAMBI','CALDERON','LEYDY MILAGROS','62939917','F','2011-12-01','14221721500018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHIPA HUAMANI, PAOLA ALEXANDRA (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHIPA','HUAMANI','PAOLA ALEXANDRA','63093662','F','2012-02-17','00000063093662',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHUMBES SERRANO, FELIPE ARMANDO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHUMBES','SERRANO','FELIPE ARMANDO','63084913','M','2011-11-26','00000063084913',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- COA CAMPERO, RICGIAN DANIEL (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('COA','CAMPERO','RICGIAN DANIEL','34292571','M','2011-01-30','25125938100010',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- DIAZ PACCI, BRAYAN ALONSO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('DIAZ','PACCI','BRAYAN ALONSO','63084451','M','2011-12-08','00000063084451',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FERNANDEZ HANCCO, MIGUEL ANGEL (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FERNANDEZ','HANCCO','MIGUEL ANGEL','62701495','M','2010-10-18','00000062701495',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FLORES MAMANI, LUANA KONY NANCY (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FLORES','MAMANI','LUANA KONY NANCY','62818924','F','2011-04-04','00000062818924',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GARATE YLLANES, CARLOS FRANCISCO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GARATE','YLLANES','CARLOS FRANCISCO','62960498','M','2011-10-11','15022508600248',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUIRMA VALENCIA, JHON RONALDO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUIRMA','VALENCIA','JHON RONALDO','62819999','M','2011-04-24','00000062819999',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LAURA QUISPE, JOSELITO SEBASTIAN (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LAURA','QUISPE','JOSELITO SEBASTIAN','62888790','M','2011-09-03','00000062888790',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPEZ ZUÑIGA, JENNIFER BRIGITH DE LOS ANGELES (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPEZ','ZUÑIGA','JENNIFER BRIGITH DE LOS ANGELES','77109365','F','2011-05-23','13270560100018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI JILAJA, FIORELLA MILAGROS (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','JILAJA','FIORELLA MILAGROS','62831191','F','2011-07-11','00000062831191',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI ZAMATA, LIZBETH MARYORI (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','ZAMATA','LIZBETH MARYORI','63693766','F','2012-02-26','00000063693766',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MASCO CEREZO, KAREN MILAGROS (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MASCO','CEREZO','KAREN MILAGROS','62702152','F','2010-12-09','14022575500088',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACHECO RAMOS, BETSY YAMILA (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACHECO','RAMOS','BETSY YAMILA','62886488','F','2011-06-28','00000062886488',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PALLI ENRIQUEZ, JAMES OXFORD (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PALLI','ENRIQUEZ','JAMES OXFORD','62858901','M','2011-07-03','00000062858901',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PUMA CONDORI, PATRIK DASHYRO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PUMA','CONDORI','PATRIK DASHYRO','62254243','M','2011-06-02','00000062254243',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE REAÑO, ANGELO HAIR (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','REAÑO','ANGELO HAIR','62888332','M','2011-08-08','15022575500118',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE URURI, ALVARO JHAIR (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','URURI','ALVARO JHAIR','63174354','M','2012-01-03','00000063174354',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RAMOS CUTIRE, NAYELI (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RAMOS','CUTIRE','NAYELI','62259227','F','2011-08-13','15145554200108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RIVAS BENITES, LUCERO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RIVAS','BENITES','LUCERO','63293139','F','2011-07-11','15131489700118',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SUAREZ MANGO, RICARDO GEANFRANCO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SUAREZ','MANGO','RICARDO GEANFRANCO','62958754','M','2011-08-27','00000062958754',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TALAVERA ZEVALLOS, ANDRE YAREL (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TALAVERA','ZEVALLOS','ANDRE YAREL','63093666','M','2012-03-06','15022575500148',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TORRES AGUIRRE, LUIS JAVIER (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TORRES','AGUIRRE','LUIS JAVIER','62810398','M','2011-04-24','15203581500068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- UTURUNCO INQUILLAY, ROSYLINDA (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('UTURUNCO','INQUILLAY','ROSYLINDA','63047429','F','2012-01-10','16089291900088',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VILCA PACHA, MATEO ALEXANDER (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VILCA','PACHA','MATEO ALEXANDER','63083855','M','2011-12-05','15145554200028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VILLEGAS CHAVEZ, HUGO DANIEL ALEJANDRO (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VILLEGAS','CHAVEZ','HUGO DANIEL ALEJANDRO','77598280','M','2012-03-18','00000077598280',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUJRA INCACUTIPA, LIZ KATHERIN (Secundaria 3°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUJRA','INCACUTIPA','LIZ KATHERIN','62231011','F','2011-04-01','00000062231011',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALANIA VICHATA, KATERIN SARA (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALANIA','VICHATA','KATERIN SARA','62083883','F','2011-04-04','00000062083883',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ANCCO CAHUANA, BRENDA IVET (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ANCCO','CAHUANA','BRENDA IVET','63230264','F','2012-02-19','00000063230264',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARAPA TUPAC, ALDANA KARELI (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARAPA','TUPAC','ALDANA KARELI','63084478','F','2011-12-21','15022575500028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARREDONDO BORDA, DAYANA MARIBEL (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARREDONDO','BORDA','DAYANA MARIBEL','63084979','F','2012-01-01','15148611600018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BOLIVAR MARIN, VICTOR EDUARDO (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BOLIVAR','MARIN','VICTOR EDUARDO','V33870371','M','2011-05-22','22021929500070',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CALLA CCAYAVILCA, KRIS ANGELA (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CALLA','CCAYAVILCA','KRIS ANGELA','62985471','F','2011-12-01','15022575500038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CATACORA ASTO, ANYELI DANIELA (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CATACORA','ASTO','ANYELI DANIELA','62959570','F','2011-10-12','15145554200138',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CEVALLOS ALVAREZ, NAOMY CLARIBET (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CEVALLOS','ALVAREZ','NAOMY CLARIBET','62887421','F','2011-07-23','00000062887421',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI VALLEJOS, SOFIA BELEN (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','VALLEJOS','SOFIA BELEN','81195532','F','2011-06-22','15133881300028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FLORES MAMANI, MARK JUDA (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FLORES','MAMANI','MARK JUDA','63795128','M','2011-07-05','15089286900168',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GOMEZ CCORIMANYA, NADIA PATRICIA (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GOMEZ','CCORIMANYA','NADIA PATRICIA','77621858','F','2012-02-28','00000077621858',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN CHINO, JEFFERSON (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','CHINO','JEFFERSON','62702567','M','2010-12-21','00000062702567',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LOPEZ TACO, IAN FRANCO (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LOPEZ','TACO','IAN FRANCO','62959817','M','2011-10-02','15089286900068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'EN PROCESO',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MADALENA HERNANDEZ, VICTORIA SARAI (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MADALENA','HERNANDEZ','VICTORIA SARAI','058691605','F','2011-01-07','19021929500058',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MURO LOPEZ, VALERIA SOLANGE MILAGROS (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MURO','LOPEZ','VALERIA SOLANGE MILAGROS','74792828','F','2010-10-11','00000074792828',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACO ZUÑIGA, SEBASTIAN JOSUE (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACO','ZUÑIGA','SEBASTIAN JOSUE','62886247','M','2011-07-11','00000062886247',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PEÑARANDA VILCA, FABIAN ALONSO (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PEÑARANDA','VILCA','FABIAN ALONSO','62886066','M','2011-05-30','00000062886066',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUIRITA UMASI, RODRIGO ALDAIR (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUIRITA','UMASI','RODRIGO ALDAIR','63414442','M','2011-10-10','00000063414442',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE QUISPE, DAYANA MAYLY (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','QUISPE','DAYANA MAYLY','62834588','F','2012-01-20','00000062834588',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROJAS CRUZ, LUCIANA ANDREA (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROJAS','CRUZ','LUCIANA ANDREA','63135837','F','2012-01-19','00000063135837',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROJAS RODRIGO, MAYFER CLARET (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROJAS','RODRIGO','MAYFER CLARET','63535863','F','2011-09-20','00000063535863',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SILVANO HUALINGA, CINTIA ALEXIS (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SILVANO','HUALINGA','CINTIA ALEXIS','77625615','F','2012-03-25','00000077625615',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TAIPE DIAZ, HARVEY FABIAN (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TAIPE','DIAZ','HARVEY FABIAN','62886988','M','2011-08-02','15022575500138',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TEJADA FLORES, JAIRO RAMIRO (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TEJADA','FLORES','JAIRO RAMIRO','78359951','M','2010-08-15','14022575500158',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TULA MAMANI, XAVIER DARONY (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TULA','MAMANI','XAVIER DARONY','63170608','M','2012-01-09','15133814400028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TULA SONCCO, CARLOS RODRIGO (Secundaria 3°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TULA','SONCCO','CARLOS RODRIGO','63093682','M','2012-03-24','15126348200068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='3°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CALACHUA NUÑEZ, MARGARET BALERY (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CALACHUA','NUÑEZ','MARGARET BALERY','62594545','F','2010-04-22','00000062594545',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CASTRO VALDERRAMA, KASSANDRA SOLANGE (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CASTRO','VALDERRAMA','KASSANDRA SOLANGE','62701576','F','2010-11-25','14022575500048',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHAMBILLA CHOQUEMAMANI, JOSUE MANUEL (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHAMBILLA','CHOQUEMAMANI','JOSUE MANUEL','62678747','M','2010-11-16','12145310700018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CORNEJO MARIN, RODRIGO JAIR (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CORNEJO','MARIN','RODRIGO JAIR','62583534','M','2010-04-03','00000062583534',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FERNANDEZ CCAMO, RUTH ZUNILDA (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FERNANDEZ','CCAMO','RUTH ZUNILDA','62473332','F','2011-01-21','00000062473332',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN CCOTO, JOSE MANUEL (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','CCOTO','JOSE MANUEL','62652295','M','2010-05-31','14022575500068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- JACINTO RAMOS, JACOB (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('JACINTO','RAMOS','JACOB','62113144','M','2010-05-12','00000062113144',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MACHACA MINGA, ANDREA LUZMIEL (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MACHACA','MINGA','ANDREA LUZMIEL','62551783','F','2010-04-10','13147703100098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI CHOQUE, MELISSA FERNANDA (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','CHOQUE','MELISSA FERNANDA','61991528','F','2010-11-06','00000061991528',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI CHUCTAYA, JIMENA NICOLL (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','CHUCTAYA','JIMENA NICOLL','62171699','F','2010-04-22','15152885000018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI MACEDO, SHAMIR ENRIQUE (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','MACEDO','SHAMIR ENRIQUE','62457907','M','2010-07-16','15089302400158',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI MAMANI, LEONEL (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','MAMANI','LEONEL','61816540','M','2009-07-28','00000061816540',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDEZ RIVAS, ANGEL PIERO (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDEZ','RIVAS','ANGEL PIERO','62677663','M','2010-10-06','00000062677663',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PARI QUISPE, CARLOS EDUARDO (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PARI','QUISPE','CARLOS EDUARDO','62385734','M','2010-05-27','00000062385734',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RODRIGO PORTUGAL, MARIA VALENTINA (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RODRIGO','PORTUGAL','MARIA VALENTINA','62137341','F','2010-11-03','00000062137341',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RODRIGUEZ MAMANI, JUAN DIEGO (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RODRIGUEZ','MAMANI','JUAN DIEGO','62702395','M','2010-11-26','14022575500098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SURCO FLORES, ALEXANDER WILLY (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SURCO','FLORES','ALEXANDER WILLY','62638235','M','2010-05-10','13145310700098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- URBINA MAMANI, ERICK ANTONNY (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('URBINA','MAMANI','ERICK ANTONNY','62508870','M','2010-08-19','00000062508870',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'EN PROCESO',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VILCA HUACO, GIMENA DARIANA (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VILCA','HUACO','GIMENA DARIANA','62678773','F','2010-11-05','00000062678773',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YANA RODRIGUEZ, LETICIA DANUZKA (Secundaria 4°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YANA','RODRIGUEZ','LETICIA DANUZKA','62740840','F','2010-12-28','00000062740840',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- AGUILAR CCAPA, JANETH MARELY (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('AGUILAR','CCAPA','JANETH MARELY','62732730','F','2011-01-09','00000062732730',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALVAREZ CHOQUE, DANIELA BRIYIT (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALVAREZ','CHOQUE','DANIELA BRIYIT','61991545','F','2011-03-30','00000061991545',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARREDONDO BORDA, NEYELY ANGELICA (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARREDONDO','BORDA','NEYELY ANGELICA','81093200','F','2010-10-25','00000081093200',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BALBIN AGÜERO, ANYELI PAMELA (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BALBIN','AGÜERO','ANYELI PAMELA','60661685','F','2008-06-10','00000060661685',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BALBIN AGÜERO, CARLOS THAYLOR (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BALBIN','AGÜERO','CARLOS THAYLOR','63188702','M','2010-04-11','00000063188702',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CACERES TULA, CARLOS JOSHUE (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CACERES','TULA','CARLOS JOSHUE','62516332','M','2010-12-31','13147703100108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHILE QUISPE, JONATAN JUVER (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHILE','QUISPE','JONATAN JUVER','77987002','M','2010-06-06','00000077987002',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI DIAZ, ANGELA YUREMY (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','DIAZ','ANGELA YUREMY','62457644','F','2010-06-24','14145554200078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FLORES GONZALES, TELMA VALENTINA (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FLORES','GONZALES','TELMA VALENTINA','62741619','F','2011-03-01','14126348200028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUALLPA MALLMA, ALEXIS GUDIEL (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUALLPA','MALLMA','ALEXIS GUDIEL','74785420','M','2010-09-28','00000074785420',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- JANAMPA SERRANO, LEONARD (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('JANAMPA','SERRANO','LEONARD','62458461','M','2010-08-10','13147703100078',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- LUQUE GUZMAN, ARACELY DAYANA (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('LUQUE','GUZMAN','ARACELY DAYANA','62756624','F','2011-03-09','14126348200038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MORA QUISPE, LUNA URPI (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MORA','QUISPE','LUNA URPI','62436895','F','2010-07-05','00000062436895',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PASTOR MATUTE, ENITH ANEL (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PASTOR','MATUTE','ENITH ANEL','62454839','F','2010-08-15','14174433000038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PEREZ PAYE, YADHIRA MIRELLA (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PEREZ','PAYE','YADHIRA MIRELLA','62446091','F','2010-08-07','14145894200188',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE HUAMANI, LUZ BRISAYDA (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','HUAMANI','LUZ BRISAYDA','62361178','F','2011-01-20','00000062361178',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SULLCA HANCCO, ABRAHAN EDU (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SULLCA','HANCCO','ABRAHAN EDU','62784002','M','2011-03-28','15241592100018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TARIFA SURCO, YAHIR (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TARIFA','SURCO','YAHIR','61824998','M','2009-06-16','00000061824998',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VILCAPE MAMANI, FRANK DIEGO (Secundaria 4°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VILCAPE','MAMANI','FRANK DIEGO','61825862','M','2009-06-03','13126348200088',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='4°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ANAHUA QUISPE, EHIDAN VICTOR (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ANAHUA','QUISPE','EHIDAN VICTOR','61414103','M','2008-07-26','12145554200028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- APAZA YANARICO, FIORELA BRIGGITTE (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('APAZA','YANARICO','FIORELA BRIGGITTE','62593600','F','2010-02-20','13022508600068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CABRERA MARTINEZ, LUJAN DEL ROCIO (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CABRERA','MARTINEZ','LUJAN DEL ROCIO','61826064','F','2009-06-22','13163108400138',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHOQUE CASA, JUAN GABRIEL (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHOQUE','CASA','JUAN GABRIEL','63535839','M','2010-03-27','00000063535839',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CHOQUEMAQUE COLQUE, MELISSA NIKOL (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CHOQUEMAQUE','COLQUE','MELISSA NIKOL','61921783','F','2010-03-13','00000061921783',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- DAVILA HUMPIRI, MARIANA LIZETH (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('DAVILA','HUMPIRI','MARIANA LIZETH','78592709','F','2009-07-18','14022553200288',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- GUILLEN CCORAHUA, JULIO RODRIGO (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('GUILLEN','CCORAHUA','JULIO RODRIGO','61800695','M','2009-05-22','00000061800695',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUIRMA VALENCIA, HUGO ARMANDO (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUIRMA','VALENCIA','HUGO ARMANDO','61824969','M','2009-06-03','00000061824969',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'EN PROCESO',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI TITO, AVRIL ANYELI (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','TITO','AVRIL ANYELI','61800493','F','2009-04-22','00000061800493',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MENDOZA FIGUEROA, VALERI ALESSANDRA (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MENDOZA','FIGUEROA','VALERI ALESSANDRA','61054171','F','2007-07-16','14120202700018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- OCHOA FERNANDEZ, JOSE MANUEL (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('OCHOA','FERNANDEZ','JOSE MANUEL','61928865','M','2009-12-17','00000061928865',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ORDOÑEZ LABAN, TONNY AXEL (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ORDOÑEZ','LABAN','TONNY AXEL','61802117','M','2009-06-30','00000061802117',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ORTIZ TAIPE, YEIKO ANYELO (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ORTIZ','TAIPE','YEIKO ANYELO','61883814','M','2010-02-01','00000061883814',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PACHA OBANDO, ESTEFANY KASANDRA (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PACHA','OBANDO','ESTEFANY KASANDRA','61892497','F','2009-08-28','00000061892497',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- QUISPE SULLO, JULIO CESAR (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('QUISPE','SULLO','JULIO CESAR','61574960','M','2009-08-30','13245632100028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- RAYME AGUILAR, RONY (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('RAYME','AGUILAR','RONY','61708669','M','2009-09-01','13147851000018',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ROQUE CCORAHUA, GABRIEL ALEXANDER (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ROQUE','CCORAHUA','GABRIEL ALEXANDER','62562461','M','2010-01-17','13075005900198',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SALAS MEDINA, JOAN JOSUE (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SALAS','MEDINA','JOAN JOSUE','61894606','M','2009-11-29','00000061894606',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SIFUENTES QUISPE, NICOLAS AUGUSTO (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SIFUENTES','QUISPE','NICOLAS AUGUSTO','62347602','M','2009-12-04','00000062347602',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TORRES HANCCO, DANIELA MICHELL (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TORRES','HANCCO','DANIELA MICHELL','62818330','F','2010-02-27','13145554200068',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- UNSUETA SERRANO, FRANK DEIVIS (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('UNSUETA','SERRANO','FRANK DEIVIS','62765923','M','2009-10-07','00000062765923',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VALLEJO CCOYLLULLI, FLOR ARELI (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VALLEJO','CCOYLLULLI','FLOR ARELI','61630787','F','2009-12-16','00000061630787',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- VERA CONDORI, LI CAROLINA (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('VERA','CONDORI','LI CAROLINA','61938187','F','2009-05-01','14145554200238',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUPA QUISPE, DAVID RICARDO JUNIOR (Secundaria 5°-A)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUPA','QUISPE','DAVID RICARDO JUNIOR','61897571','M','2009-10-06','14133814400028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='A';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ALDUDE CENTENO, JHOSEP FERNANDO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ALDUDE','CENTENO','JHOSEP FERNANDO','61758827','M','2009-05-19','13161029400038',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ANQUISE YANA, MIGUEL ANGEL RAUL (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ANQUISE','YANA','MIGUEL ANGEL RAUL','62562842','M','2010-02-23','12133296400530',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARAPA TUPAC, ANTHONY BERNY (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARAPA','TUPAC','ANTHONY BERNY','61799346','M','2009-05-09','00000061799346',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARMA CCALLUCHE, YALU ARACELY (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARMA','CCALLUCHE','YALU ARACELY','61893790','F','2009-10-11','00000061893790',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- ARREDONDO BORDA, MARIA FERNANDA (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('ARREDONDO','BORDA','MARIA FERNANDA','62469641','F','2009-11-24','00000062469641',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- BEDOYA QUISPE, ANGEL YEYSON (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('BEDOYA','QUISPE','ANGEL YEYSON','61459634','M','2008-12-25','13126348200108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCANCHILLO GUZMAN, ROBINHO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCANCHILLO','GUZMAN','ROBINHO','61455977','M','2008-09-15','13145554200098',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CCOTO CAYANI, NIKOL TAYRA (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CCOTO','CAYANI','NIKOL TAYRA','61968741','F','2009-07-14','00000061968741',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CONDORI MAMANI, CARLOS DANIEL (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CONDORI','MAMANI','CARLOS DANIEL','61893892','M','2009-11-13','00000061893892',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- CUTIPA CHISE, RICARDO MAXIMO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('CUTIPA','CHISE','RICARDO MAXIMO','62820387','M','2009-05-15','13126348200028',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FARFAN PUMA, MIGUEL BRANDO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FARFAN','PUMA','MIGUEL BRANDO','61847829','M','2009-08-05','00000061847829',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- FLORES SOTO, MENLY JHONSO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('FLORES','SOTO','MENLY JHONSO','60330186','M','2009-11-30','00000060330186',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- HUAMAN AMANQUI, TANIA CAMILA (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('HUAMAN','AMANQUI','TANIA CAMILA','61800319','F','2009-05-07','00000061800319',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- IDME IDME, ERICK SALVADOR (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('IDME','IDME','ERICK SALVADOR','62516300','M','2009-08-02','13133881300118',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MAMANI ARAPA, DAISY (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MAMANI','ARAPA','DAISY','61635477','F','2009-07-22','12145311000070',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MASCO AYVAR, EVO ESTANISLAO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MASCO','AYVAR','EVO ESTANISLAO','61974414','M','2009-11-27','00000061974414',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- MOTTOCCANCHI AYAMAMANI, PIERINA MIZU (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('MOTTOCCANCHI','AYAMAMANI','PIERINA MIZU','61938176','F','2009-04-10','13151760200108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- NUÑONCA FLORES, ROBERT ALEXANDER (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('NUÑONCA','FLORES','ROBERT ALEXANDER','61461252','M','2009-02-05','00000061461252',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PALLI ENRIQUEZ, GEORGE RICARDO (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PALLI','ENRIQUEZ','GEORGE RICARDO','62352132','M','2009-12-20','13147702800108',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PARI CONDORI, IAN FLAVIO CESAR (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PARI','CONDORI','IAN FLAVIO CESAR','62313012','M','2009-11-02','00000062313012',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PILA QUISPE, MISHEYDA (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PILA','QUISPE','MISHEYDA','62372440','F','2010-03-09','00000062372440',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- PUMA YUPANQUI, YOSELIN KEILA (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('PUMA','YUPANQUI','YOSELIN KEILA','61825377','F','2009-07-06','00000061825377',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- SARMIENTO SARMIENTO, SEBASTIAN OLMAR (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('SARMIENTO','SARMIENTO','SEBASTIAN OLMAR','61730564','M','2009-07-05','00000061730564',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- TUFIÑO HURTADO, NOEMI ESTHER (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('TUFIÑO','HURTADO','NOEMI ESTHER','73556401','F','2009-07-19','00000073556401',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

  -- YUCRA VALENCIA, NAYSHEL CLARIBEHT (Secundaria 5°-B)
  INSERT INTO estudiantes (apellido_paterno,apellido_materno,nombres,dni,sexo,fecha_nacimiento,codigo_minedu,observacion,estado)
  VALUES ('YUCRA','VALENCIA','NAYSHEL CLARIBEHT','62557422','F','2010-02-22','00000062557422',NULL,'activo')
  ON CONFLICT (dni) DO UPDATE SET codigo_minedu=EXCLUDED.codigo_minedu RETURNING id INTO v_est_id;

  SELECT id INTO v_grado_id FROM grados WHERE nombre='5°' AND nivel='Secundaria';
  SELECT id INTO v_sec_id   FROM secciones WHERE nombre='B';

  INSERT INTO matriculas (estudiante_id,grado_id,seccion_id,anio,estado_matricula,tipo_vacante)
  VALUES (v_est_id,v_grado_id,v_sec_id,2026,'DEFINITIVA',NULL)
  ON CONFLICT (estudiante_id,anio) DO NOTHING;

END $$;

-- PASO 5: Verificar importación
SELECT nivel, g.nombre AS grado, s.nombre AS seccion, COUNT(*) AS total
FROM matriculas m
JOIN grados g ON g.id = m.grado_id
JOIN secciones s ON s.id = m.seccion_id
WHERE m.anio = 2026
GROUP BY nivel, g.orden, g.nombre, s.nombre
ORDER BY nivel DESC, g.orden, s.nombre;