import { NextResponse } from 'next/server'
import { sql } from '@/lib/bd'

export async function GET() {
  try {
    const anio = new Date().getFullYear()

    const [stats] = await sql`
      SELECT
        ${anio}::integer                                              AS anio_actual,
        COUNT(DISTINCT e.id)::integer                                 AS total_estudiantes,
        COUNT(DISTINCT e.id) FILTER (WHERE e.sexo='M')::integer       AS varones,
        COUNT(DISTINCT e.id) FILTER (WHERE e.sexo='F')::integer       AS mujeres,
        COUNT(DISTINCT e.id) FILTER (WHERE e.estado='activo')::integer    AS activos,
        COUNT(DISTINCT e.id) FILTER (WHERE e.estado='retirado')::integer  AS retirados,
        COUNT(DISTINCT e.id) FILTER (WHERE g.nivel='Primaria')::integer   AS total_primaria,
        COUNT(DISTINCT e.id) FILTER (WHERE g.nivel='Secundaria')::integer AS total_secundaria,
        COUNT(DISTINCT m.id)::integer                                 AS total_matriculas_anio
      FROM estudiantes e
      LEFT JOIN matriculas m ON m.estudiante_id = e.id AND m.anio = ${anio}
      LEFT JOIN grados     g ON g.id = m.grado_id
    `

    const porGrado = await sql`
      SELECT
        g.nivel,
        g.nombre  AS grado,
        s.nombre  AS seccion,
        COUNT(*)::integer AS total
      FROM matriculas m
      JOIN grados     g ON g.id = m.grado_id
      JOIN secciones  s ON s.id = m.seccion_id
      WHERE m.anio = ${anio} AND m.estado = 'activo'
      GROUP BY g.nivel, g.orden, g.nombre, s.nombre
      ORDER BY g.nivel DESC, g.orden, s.nombre
    `

    return NextResponse.json({ ...stats, por_grado: porGrado })
  } catch (e) {
    console.error(e)
    return NextResponse.json({ error: 'Error al obtener estadísticas' }, { status: 500 })
  }
}
