import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
import { cookies } from 'next/headers'

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const { usuario, password } = body

    // Validación
    if (!usuario || !password) {
      return NextResponse.json(
        { error: 'Faltan campos' },
        { status: 400 }
      )
    }

    // Buscar usuario
    const result = await sql`
      SELECT id, usuario, password_hash, nombre, activo
      FROM usuarios
      WHERE usuario = ${usuario}
      LIMIT 1
    `

    const u = result[0]

    if (!u) {
      return NextResponse.json(
        { error: 'Credenciales incorrectas' },
        { status: 401 }
      )
    }

    if (!u.activo) {
      return NextResponse.json(
        { error: 'Usuario desactivado' },
        { status: 403 }
      )
    }

    // Validar contraseña
    const passCheck = await sql`
      SELECT crypt(${password}, ${u.password_hash}) = ${u.password_hash} AS ok
    `

    if (!passCheck[0]?.ok) {
      return NextResponse.json(
        { error: 'Credenciales incorrectas' },
        { status: 401 }
      )
    }

    // Actualizar último acceso
    await sql`
      UPDATE usuarios
      SET ultimo_acceso = NOW()
      WHERE id = ${u.id}
    `

    // Crear sesión
    const store = cookies()

    store.set(
      'session',
      JSON.stringify({
        id: u.id,
        usuario: u.usuario,
        nombre: u.nombre
      }),
      {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax',
        maxAge: 60 * 60 * 8,
        path: '/'
      }
    )

    return NextResponse.json({
      ok: true,
      nombre: u.nombre
    })

  } catch (e) {
    console.error('LOGIN ERROR:', e)

    return NextResponse.json(
      { error: 'Error interno del servidor' },
      { status: 500 }
    )
  }
}