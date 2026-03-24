import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
export async function GET() {
  const g=await sql`SELECT * FROM grados ORDER BY nivel DESC,orden`
  return NextResponse.json(g)
}
export async function POST(req: NextRequest) {
  try{
    const {nombre,nivel}=await req.json()
    if(!nombre?.trim()) return NextResponse.json({error:'Nombre requerido'},{status:400})
    const [mx]=await sql`SELECT COALESCE(MAX(orden),0) AS m FROM grados`
    const [r]=await sql`INSERT INTO grados (nombre,nivel,orden) VALUES (${nombre.trim()},${nivel||'Primaria'},${mx.m+1}) RETURNING id`
    return NextResponse.json({id:r.id},{status:201})
  }catch(e:unknown){
    const msg=e instanceof Error?e.message:''
    if(msg.includes('unique')) return NextResponse.json({error:'Ese grado ya existe'},{status:409})
    return NextResponse.json({error:'Error'},{status:500})
  }
}
