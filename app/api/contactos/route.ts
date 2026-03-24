import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'

export async function POST(req: NextRequest) {
  try {
    const b = await req.json()

    //  Validaciones
    if (!b.estudiante_id || !b.nombre || !b.telefono) {
      return NextResponse.json(
        { error: 'Faltan campos obligatorios' },
        { status: 400 }
      )
    }

    const estudiante_id = parseInt(b.estudiante_id)

    if (isNaN(estudiante_id)) {
      return NextResponse.json(
        { error: 'ID de estudiante inválido' },
        { status: 400 }
      )
    }

    //  Verificar que el estudiante existe
    const [existe] = await sql`
      SELECT id FROM estudiantes WHERE id = ${estudiante_id}
    `

    if (!existe) {
      return NextResponse.json(
        { error: 'El estudiante no existe' },
        { status: 404 }
      )
    }

    //  Insertar contacto
    const [r] = await sql`
      INSERT INTO contactos_emergencia (
        estudiante_id,
        nombre,
        telefono,
        relacion,
        prioridad
      )
      VALUES (
        ${estudiante_id},
        ${b.nombre},
        ${b.telefono},
        ${b.relacion || null},
        ${b.prioridad ?? 1}
      )
      RETURNING id
    `

    return NextResponse.json({ id: r.id }, { status: 201 })

  } catch (e) {
    console.error(e)
    return NextResponse.json(
      { error: 'Error al crear contacto' },
      { status: 500 }
    )
  }
}