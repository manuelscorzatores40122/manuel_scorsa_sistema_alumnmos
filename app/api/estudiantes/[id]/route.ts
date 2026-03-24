import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'

export async function GET(
  _req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id)

    const [e] = await sql`
      SELECT
        e.*,
        m.grado_id,
        m.seccion_id,
        m.anio AS anio_matricula,
        g.nivel
      FROM estudiantes e
      LEFT JOIN matriculas m 
        ON m.estudiante_id = e.id 
        AND m.anio = DATE_PART('year', CURRENT_DATE)
      LEFT JOIN grados g ON g.id = m.grado_id
      WHERE e.id = ${id}
    `

    if (!e) {
      return NextResponse.json({ error: 'No encontrado' }, { status: 404 })
    }

    return NextResponse.json(e)

  } catch (e) {
    console.error(e)
    return NextResponse.json({ error: 'Error' }, { status: 500 })
  }
}

export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id)
    const b = await req.json()

    await sql`
      UPDATE estudiantes SET
        apellido_paterno = ${b.apellido_paterno},
        apellido_materno = ${b.apellido_materno || null},
        nombres = ${b.nombres},
        dni = ${b.dni},
        sexo = ${b.sexo},
        fecha_nacimiento = ${b.fecha_nacimiento},
        celular = ${b.celular || null},
        email = ${b.email || null},
        departamento_nacimiento = ${b.departamento_nacimiento || null},
        provincia_nacimiento = ${b.provincia_nacimiento || null},
        distrito_nacimiento = ${b.distrito_nacimiento || null},
        domicilio = ${b.domicilio || null},
        asegurado = ${b.asegurado ?? false},
        tipo_seguro = ${b.tipo_seguro || null},
        enfermedades_cronicas = ${b.enfermedades_cronicas || null},
        alergico = ${b.alergico ?? false},
        alergias_detalle = ${b.alergias_detalle || null},
        estado_nutricional = ${b.estado_nutricional || null},
        vacuna_covid = ${b.vacuna_covid ?? false},
        hermanos_en_ie = ${b.hermanos_en_ie ?? false},
        estado = ${b.estado || 'activo'}
      WHERE id = ${id}
    `

    if (b.grado_id && b.seccion_id && b.anio) {
      await sql`
        INSERT INTO matriculas (estudiante_id, grado_id, seccion_id, anio)
        VALUES (${id}, ${b.grado_id}, ${b.seccion_id}, ${b.anio})
        ON CONFLICT (estudiante_id, anio)
        DO UPDATE SET
          grado_id = EXCLUDED.grado_id,
          seccion_id = EXCLUDED.seccion_id
      `
    }

    return NextResponse.json({ ok: true })

  } catch (e) {
    console.error('ERROR PUT:', e)
    return NextResponse.json({ error: 'Error al actualizar' }, { status: 500 })
  }
}