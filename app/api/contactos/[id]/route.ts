import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'

export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id)

    if (isNaN(id)) {
      return NextResponse.json({ error: 'ID inválido' }, { status: 400 })
    }

    const b = await req.json()

    // Validación básica
    if (!b.nombre || !b.telefono) {
      return NextResponse.json(
        { error: 'Nombre y teléfono son obligatorios' },
        { status: 400 }
      )
    }

    await sql`
      UPDATE contactos_emergencia
      SET
        nombre = ${b.nombre},
        telefono = ${b.telefono},
        relacion = ${b.relacion || null},
        prioridad = ${b.prioridad ?? 1}
      WHERE id = ${id}
    `

    return NextResponse.json({ ok: true })

  } catch (e) {
    console.error(e)
    return NextResponse.json({ error: 'Error al actualizar' }, { status: 500 })
  }
}

export async function DELETE(
  _req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id)

    if (isNaN(id)) {
      return NextResponse.json({ error: 'ID inválido' }, { status: 400 })
    }

    await sql`
      DELETE FROM contactos_emergencia
      WHERE id = ${id}
    `

    return NextResponse.json({ ok: true })

  } catch (e) {
    console.error(e)
    return NextResponse.json({ error: 'Error al eliminar' }, { status: 500 })
  }
}