import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
export async function GET() {
  const s=await sql`SELECT * FROM secciones ORDER BY nombre`
  return NextResponse.json(s)
}
export async function POST(req: NextRequest) {
  try{
    const {nombre,capacidad_max}=await req.json()
    if(!nombre?.trim()) return NextResponse.json({error:'Nombre requerido'},{status:400})
    const [r]=await sql`INSERT INTO secciones (nombre,capacidad_max) VALUES (${nombre.trim()},${capacidad_max??30}) RETURNING id`
    return NextResponse.json({id:r.id},{status:201})
  }catch(e){console.error(e);return NextResponse.json({error:'Error'},{status:500})}
}
