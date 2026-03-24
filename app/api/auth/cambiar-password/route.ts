import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
import bcrypt from 'bcryptjs'
import { cookies } from 'next/headers'
export async function POST(req: NextRequest) {
  try {
    const store = await cookies()
    const sc = store.get('session')
    if (!sc) return NextResponse.json({ error: 'No autenticado' }, { status: 401 })
    const session = JSON.parse(sc.value)
    const { passwordActual, passwordNueva } = await req.json()
    if (!passwordActual || !passwordNueva) return NextResponse.json({ error: 'Faltan campos' }, { status: 400 })
    if (passwordNueva.length < 8) return NextResponse.json({ error: 'Mínimo 8 caracteres' }, { status: 400 })
    const [u] = await sql`SELECT password_hash FROM usuarios WHERE id=${session.id}`
    if (!u) return NextResponse.json({ error: 'Usuario no encontrado' }, { status: 404 })
    const ok = await bcrypt.compare(passwordActual, u.password_hash)
    if (!ok) return NextResponse.json({ error: 'Contraseña actual incorrecta' }, { status: 401 })
    const hash = await bcrypt.hash(passwordNueva, 12)
    await sql`UPDATE usuarios SET password_hash=${hash} WHERE id=${session.id}`
    return NextResponse.json({ ok: true })
  } catch(e) { console.error(e); return NextResponse.json({ error: 'Error interno' }, { status:500 }) }
}
