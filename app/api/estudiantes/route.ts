import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'

export async function GET(req: NextRequest) {
  const p       = new URL(req.url).searchParams
  const q       = p.get('q')       || ''
  const nivel   = p.get('nivel')   || ''
  const grado   = p.get('grado')   || ''
  const seccion = p.get('seccion') || ''
  const estado  = p.get('estado')  || ''
  const sexo    = p.get('sexo')    || ''
  const pagina  = parseInt(p.get('pagina') || '1')
  const limite  = parseInt(p.get('limite') || '20')
  const offset  = (pagina - 1) * limite
  const anio    = new Date().getFullYear()

  try {
    // Traer todos y filtrar en JS — compatible con neon() sin .unsafe()
    const todos = await sql`
      SELECT
        e.id, e.dni, e.apellido_paterno, e.apellido_materno, e.nombres,
        e.sexo,
        DATE_PART('year', AGE(e.fecha_nacimiento))::integer AS edad,
        e.celular, e.estado,
        g.nivel,
        g.nombre  AS grado,
        s.nombre  AS seccion,
        e.foto_url
      FROM estudiantes e
      LEFT JOIN matriculas m ON m.estudiante_id = e.id AND m.anio = ${anio}
      LEFT JOIN grados     g ON g.id = m.grado_id
      LEFT JOIN secciones  s ON s.id = m.seccion_id
      ORDER BY e.apellido_paterno, e.apellido_materno, e.nombres
    `

    // Filtrar en JavaScript
    let filtrados = todos as Record<string, unknown>[]

    if (q) {
      const qLower = q.toLowerCase()
      filtrados = filtrados.filter(e =>
        String(e.apellido_paterno || '').toLowerCase().includes(qLower) ||
        String(e.apellido_materno || '').toLowerCase().includes(qLower) ||
        String(e.nombres          || '').toLowerCase().includes(qLower) ||
        String(e.dni              || '').includes(q)
      )
    }
    if (estado)  filtrados = filtrados.filter(e => e.estado  === estado)
    if (sexo)    filtrados = filtrados.filter(e => e.sexo    === sexo)
    if (nivel)   filtrados = filtrados.filter(e => e.nivel   === nivel)
    if (grado)   filtrados = filtrados.filter(e => e.grado   === grado)
    if (seccion) filtrados = filtrados.filter(e => e.seccion === seccion)

    const total       = filtrados.length
    const estudiantes = filtrados.slice(offset, offset + limite)

    return NextResponse.json({ estudiantes, total })
  } catch (e) {
    console.error('ERROR API:', e)
    return NextResponse.json({ error: 'Error al obtener estudiantes' }, { status: 500 })
  }
}

export async function POST(req: NextRequest) {
  try {
    const b = await req.json()
    const {
      apellido_paterno, apellido_materno, nombres, dni, sexo,
      fecha_nacimiento, celular, email,
      departamento_nacimiento, provincia_nacimiento, distrito_nacimiento,
      domicilio, asegurado, tipo_seguro, enfermedades_cronicas,
      alergico, alergias_detalle, estado_nutricional, vacuna_covid,
      hermanos_en_ie, estado, foto_url,
      grado_id, seccion_id, anio, apoderado
    } = b

    if (!apellido_paterno || !nombres || !dni || !sexo || !fecha_nacimiento)
      return NextResponse.json({ error: 'Faltan campos obligatorios' }, { status: 400 })

    const [ex] = await sql`SELECT id FROM estudiantes WHERE dni = ${dni}`
    if (ex) return NextResponse.json({ error: 'Ya existe un estudiante con ese DNI' }, { status: 409 })

    const [est] = await sql`
      INSERT INTO estudiantes (
        apellido_paterno, apellido_materno, nombres, dni, sexo,
        fecha_nacimiento, celular, email,
        departamento_nacimiento, provincia_nacimiento, distrito_nacimiento,
        domicilio, asegurado, tipo_seguro, enfermedades_cronicas,
        alergico, alergias_detalle, estado_nutricional, vacuna_covid,
        hermanos_en_ie, estado, foto_url
      ) VALUES (
        ${apellido_paterno}, ${apellido_materno || null}, ${nombres},
        ${dni}, ${sexo}, ${fecha_nacimiento},
        ${celular || null}, ${email || null},
        ${departamento_nacimiento || null}, ${provincia_nacimiento || null},
        ${distrito_nacimiento || null}, ${domicilio || null},
        ${asegurado ?? false}, ${tipo_seguro || null},
        ${enfermedades_cronicas || null}, ${alergico ?? false},
        ${alergias_detalle || null}, ${estado_nutricional || null},
        ${vacuna_covid ?? false}, ${hermanos_en_ie ?? false},
        ${estado || 'activo'}, ${foto_url || null}
      ) RETURNING id
    `

    if (grado_id && seccion_id && anio)
      await sql`
        INSERT INTO matriculas (estudiante_id, grado_id, seccion_id, anio)
        VALUES (${est.id}, ${grado_id}, ${seccion_id}, ${anio})
        ON CONFLICT (estudiante_id, anio) DO NOTHING
      `

    if (apoderado?.nombres && apoderado?.celular)
      await sql`
        INSERT INTO apoderados (
          estudiante_id, tipo, apellido_paterno, apellido_materno,
          nombres, dni, celular, email, es_principal, vive_con_estudiante
        ) VALUES (
          ${est.id}, ${apoderado.tipo || 'madre'},
          ${apoderado.apellido_paterno || ''}, ${apoderado.apellido_materno || null},
          ${apoderado.nombres}, ${apoderado.dni || null}, ${apoderado.celular},
          ${apoderado.email || null}, true, ${apoderado.vive_con_estudiante ?? false}
        )
      `

    return NextResponse.json({ id: est.id }, { status: 201 })
  } catch (e) {
    console.error('ERROR POST:', e)
    return NextResponse.json({ error: 'Error al registrar' }, { status: 500 })
  }
}
