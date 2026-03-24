-- ============================================================
-- SISTEMA DE GESTIÓN ESCOLAR — SCHEMA v2
-- Adaptado a datos reales: Primaria (1°-6°) + Secundaria (1°-5°)
-- ============================================================

-- EXTENSIONES
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- TABLA: usuarios
-- ============================================================
CREATE TABLE IF NOT EXISTS usuarios (
    id            SERIAL PRIMARY KEY,
    usuario       VARCHAR(50)  UNIQUE NOT NULL,
    password_hash TEXT         NOT NULL,
    nombre        VARCHAR(150) NOT NULL,
    activo        BOOLEAN      DEFAULT TRUE,
    ultimo_acceso TIMESTAMP,
    creado_en     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLA: grados
-- CAMBIO v2: nombre+nivel son únicos (no solo nombre)
--            porque "1°" existe en Primaria Y Secundaria
-- ============================================================
CREATE TABLE IF NOT EXISTS grados (
    id     SERIAL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    nivel  VARCHAR(20) NOT NULL DEFAULT 'Primaria'
                       CHECK (nivel IN ('Primaria','Secundaria')),
    orden  INTEGER     NOT NULL,
    CONSTRAINT grados_nombre_nivel_key UNIQUE (nombre, nivel)
);

INSERT INTO grados (nombre, nivel, orden) VALUES
  ('1°','Primaria',1),('2°','Primaria',2),('3°','Primaria',3),
  ('4°','Primaria',4),('5°','Primaria',5),('6°','Primaria',6),
  ('1°','Secundaria',7),('2°','Secundaria',8),('3°','Secundaria',9),
  ('4°','Secundaria',10),('5°','Secundaria',11)
ON CONFLICT (nombre, nivel) DO NOTHING;

-- ============================================================
-- TABLA: secciones
-- ============================================================
CREATE TABLE IF NOT EXISTS secciones (
    id            SERIAL  PRIMARY KEY,
    nombre        VARCHAR(5) NOT NULL,
    capacidad_max INTEGER    DEFAULT 30
);

INSERT INTO secciones (nombre, capacidad_max) VALUES
  ('A',30),('B',30),('C',30)
ON CONFLICT DO NOTHING;

-- ============================================================
-- TABLA: estudiantes
-- NUEVO v2: codigo_minedu, observacion
-- ============================================================
CREATE TABLE IF NOT EXISTS estudiantes (
    id                      SERIAL PRIMARY KEY,

    -- Identificación
    apellido_paterno        VARCHAR(100) NOT NULL,
    apellido_materno        VARCHAR(100),
    nombres                 VARCHAR(150) NOT NULL,
    dni                     VARCHAR(8)   UNIQUE NOT NULL,
    codigo_minedu           VARCHAR(20),          -- código SIAGIE del MINEDU
    sexo                    CHAR(1)      NOT NULL CHECK (sexo IN ('M','F')),

    -- Nacimiento
    fecha_nacimiento        DATE         NOT NULL,
    departamento_nacimiento VARCHAR(100),
    provincia_nacimiento    VARCHAR(100),
    distrito_nacimiento     VARCHAR(100),

    -- Contacto y domicilio
    celular                 VARCHAR(15),
    email                   VARCHAR(150),
    domicilio               TEXT,

    -- Salud
    asegurado               BOOLEAN      DEFAULT FALSE,
    tipo_seguro             VARCHAR(100),
    enfermedades_cronicas   TEXT,
    alergico                BOOLEAN      DEFAULT FALSE,
    alergias_detalle        TEXT,
    estado_nutricional      VARCHAR(30),
    vacuna_covid            BOOLEAN      DEFAULT FALSE,

    -- Familia
    hermanos_en_ie          BOOLEAN      DEFAULT FALSE,

    -- Estado
    estado                  VARCHAR(20)  DEFAULT 'activo'
                            CHECK (estado IN ('activo','retirado','trasladado','egresado','suspendido')),
    observacion             TEXT,

    -- Foto
    foto_url                TEXT,

    -- Auditoría
    creado_en               TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    actualizado_en          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Trigger actualizado_en
CREATE OR REPLACE FUNCTION actualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN NEW.actualizado_en = CURRENT_TIMESTAMP; RETURN NEW; END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_estudiantes_actualizado ON estudiantes;
CREATE TRIGGER trg_estudiantes_actualizado
    BEFORE UPDATE ON estudiantes
    FOR EACH ROW EXECUTE FUNCTION actualizar_timestamp();

-- ============================================================
-- TABLA: matriculas
-- NUEVO v2: estado_matricula, tipo_vacante (datos del MINEDU)
-- ============================================================
CREATE TABLE IF NOT EXISTS matriculas (
    id              SERIAL PRIMARY KEY,
    estudiante_id   INTEGER NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    grado_id        INTEGER NOT NULL REFERENCES grados(id),
    seccion_id      INTEGER NOT NULL REFERENCES secciones(id),
    anio            INTEGER NOT NULL CHECK (anio >= 2020 AND anio <= 2100),
    fecha_matricula DATE    DEFAULT CURRENT_DATE,
    estado          VARCHAR(20) DEFAULT 'activo'
                    CHECK (estado IN ('activo','anulado','trasladado')),
    estado_matricula VARCHAR(30) DEFAULT 'DEFINITIVA',  -- DEFINITIVA, CONDICIONAL, etc.
    tipo_vacante     VARCHAR(30),                        -- INGRESANTE, RATIFICADO, etc.
    observaciones    TEXT,
    CONSTRAINT uq_matricula_anio UNIQUE (estudiante_id, anio)
);

-- ============================================================
-- TABLA: apoderados
-- ============================================================
CREATE TABLE IF NOT EXISTS apoderados (
    id                  SERIAL PRIMARY KEY,
    estudiante_id       INTEGER NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    tipo                VARCHAR(20) NOT NULL DEFAULT 'madre'
                        CHECK (tipo IN ('madre','padre','apoderado','abuelo','abuela','tio','tutor','otro')),
    apellido_paterno    VARCHAR(100) NOT NULL,
    apellido_materno    VARCHAR(100),
    nombres             VARCHAR(150) NOT NULL,
    dni                 VARCHAR(8),
    celular             VARCHAR(15) NOT NULL,
    email               VARCHAR(150),
    ocupacion           VARCHAR(100),
    es_principal        BOOLEAN DEFAULT FALSE,
    vive_con_estudiante BOOLEAN DEFAULT FALSE
);

-- ============================================================
-- TABLA: contactos_emergencia
-- ============================================================
CREATE TABLE IF NOT EXISTS contactos_emergencia (
    id            SERIAL PRIMARY KEY,
    estudiante_id INTEGER NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    nombre        VARCHAR(150) NOT NULL,
    telefono      VARCHAR(15)  NOT NULL,
    relacion      VARCHAR(50),
    prioridad     INTEGER DEFAULT 1
);

-- ============================================================
-- TABLA: documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS documentos (
    id             SERIAL PRIMARY KEY,
    estudiante_id  INTEGER NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    tipo           VARCHAR(50) NOT NULL
                   CHECK (tipo IN ('partida_nacimiento','dni','foto','ficha_medica',
                                   'constancia','traslado','vacunas','otro')),
    url            TEXT NOT NULL,
    nombre_archivo VARCHAR(255),
    tamano_bytes   BIGINT,
    subido_en      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLA: hermanos
-- ============================================================
CREATE TABLE IF NOT EXISTS hermanos (
    id            SERIAL PRIMARY KEY,
    estudiante_id INTEGER NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    hermano_id    INTEGER NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    CONSTRAINT no_autoref  CHECK (estudiante_id <> hermano_id),
    CONSTRAINT uq_hermanos UNIQUE (estudiante_id, hermano_id)
);

-- ============================================================
-- ÍNDICES
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_estudiante_dni          ON estudiantes(dni);
CREATE INDEX IF NOT EXISTS idx_estudiante_ap_paterno   ON estudiantes(apellido_paterno);
CREATE INDEX IF NOT EXISTS idx_estudiante_ap_materno   ON estudiantes(apellido_materno);
CREATE INDEX IF NOT EXISTS idx_estudiante_nombres      ON estudiantes(nombres);
CREATE INDEX IF NOT EXISTS idx_estudiante_estado       ON estudiantes(estado);
CREATE INDEX IF NOT EXISTS idx_estudiante_codigo       ON estudiantes(codigo_minedu);
CREATE INDEX IF NOT EXISTS idx_matricula_anio          ON matriculas(anio);
CREATE INDEX IF NOT EXISTS idx_matricula_grado_sec     ON matriculas(grado_id, seccion_id, anio);

-- ============================================================
-- VISTAS mejoradas
-- ============================================================
CREATE OR REPLACE VIEW vista_estudiantes_activos AS
SELECT
    e.id, e.dni, e.codigo_minedu,
    CONCAT(e.apellido_paterno,' ',e.apellido_materno,', ',e.nombres) AS nombre_completo,
    e.apellido_paterno, e.apellido_materno, e.nombres,
    e.sexo, e.fecha_nacimiento,
    DATE_PART('year', AGE(e.fecha_nacimiento))::INTEGER AS edad,
    e.celular, e.estado,
    g.nivel    AS nivel,
    g.nombre   AS grado,
    s.nombre   AS seccion,
    m.anio     AS anio_matricula,
    m.estado_matricula,
    e.foto_url
FROM estudiantes e
LEFT JOIN matriculas m ON m.estudiante_id = e.id AND m.anio = DATE_PART('year', CURRENT_DATE)
LEFT JOIN grados     g ON g.id = m.grado_id
LEFT JOIN secciones  s ON s.id = m.seccion_id
WHERE e.estado = 'activo'
ORDER BY g.nivel DESC, g.orden, s.nombre, e.apellido_paterno;

-- Vista estadísticas con desglose por nivel
CREATE OR REPLACE VIEW vista_estadisticas AS
SELECT
    DATE_PART('year', CURRENT_DATE)::INTEGER AS anio_actual,
    COUNT(DISTINCT e.id)                      AS total_estudiantes,
    COUNT(DISTINCT e.id) FILTER (WHERE e.sexo='M')           AS varones,
    COUNT(DISTINCT e.id) FILTER (WHERE e.sexo='F')           AS mujeres,
    COUNT(DISTINCT e.id) FILTER (WHERE e.estado='activo')    AS activos,
    COUNT(DISTINCT e.id) FILTER (WHERE e.estado='retirado')  AS retirados,
    COUNT(DISTINCT e.id) FILTER (WHERE g.nivel='Primaria')   AS total_primaria,
    COUNT(DISTINCT e.id) FILTER (WHERE g.nivel='Secundaria') AS total_secundaria,
    COUNT(DISTINCT m.id)                      AS total_matriculas_anio
FROM estudiantes e
LEFT JOIN matriculas m ON m.estudiante_id=e.id AND m.anio=DATE_PART('year',CURRENT_DATE)
LEFT JOIN grados     g ON g.id=m.grado_id;
